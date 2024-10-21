<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Valuation;

use App\Http\Controllers\MailController;
use App\Services\UserService;
use App\Services\ProductService;
use App\Services\SettingService;
use App\Services\ValuationService;
use App\Services\PaymentService;


use Illuminate\Support\Facades\Storage;

use Money\Currencies\ISOCurrencies;
use Money\Currency;
use Money\Formatter\DecimalMoneyFormatter;
use Money\Money;

use Illuminate\Database\QueryException;
use Exception;

class ValuationController extends Controller
{
    
    protected $userService;
    protected $productService;
    protected $settingService;
    protected $valuationService;
    protected $mailController;

    public function __construct (
        UserService         $userService,
        ProductService      $productService,
        SettingService      $settingService,
        ValuationService    $valuationService,
        PaymentService      $paymentService,
        MailController      $mailController,
    ) {
        $this->userService      = $userService;
        $this->productService   = $productService;
        $this->settingService   = $settingService;
        $this->valuationService = $valuationService;
        $this->paymentService   = $paymentService;
        $this->mailController   = $mailController;
    }

    
    // **************************************************
    // *                    AUTH                        *
    // **************************************************
    
    //Obtener todas las valuacines del usuario (comprador/vendedor)
    public function getValuationsFmUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        
        $user = $jwtAuth->checkToken($token, true);

        try {
            $valuations = Valuation::
                with([
                    'valuationProduct',
                    'valuationProduct.productCountry',
                    'valuationProduct.productType',
                    'valuationProduct.productGroup',
                    'valuationProduct.productCategory',
                    'valuationProduct.productStatus',
                    'valuationStatus',
                    'valuationPaymentStatus',
                    // 'valuationUserRequester',
                ])
            ->
                where('val_idUserRequester', $user->usu_idUser)
            ->
                get()
            ;
            // var_dump($valuations);

            // die();
            
            if(!empty($valuations)){
                // $valuations->each(function($valuation) {
                //     $valuation->valuationUserRequester->makeHidden(['usu_username']);
                // });

                $data = array(
                    'valuations' => $valuations,
                );
            }
            else {
                $data = array(
                    'valuations' => [],
                );
            }

        } catch (QueryException $e) {
            $data = array(
                'valuations' => [],
            );
        }
        return response()->json($data);
    }

    // Solicitar valuación
    public function requestValuation(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos usuarios
        $json = $request->input('json', null);
        
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                "amount"            => 'required',
                "valuationCost"     => 'required',
                "idProduct"         => 'required',
                "skuProduct"        => 'required',
                "countryProduct"    => 'required',
                "typeProduct"       => 'required',
                "userProduct"       => 'required',
            ]);

            if ($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al solicitar la valuacion.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // Obtener info del producto y verificar que corresponde
                $productCollection = $this->productService->getProductByID($paramsArray['idProduct']);
                
                if($productCollection->isEmpty()) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error en la solicitud de valuacion.',
                    );
                }
                else {
                    $product = $productCollection->first();
    
                    if(
                        ($paramsArray['skuProduct'] !== $product->prod_sku) &&  
                        ($paramsArray['countryProduct'] !== $product->prod_country) &&
                        ($paramsArray['typeProduct'] !== $product->prod_idType_product)
                    ) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en la solicitud de valuacion. -',
                        );
                    }
                    else {
                        // echo 'son iguales los datos del producto';
                        $idValStatus = $this->valuationService->getValuationStatusID('progreso');
                                    
                        if($idValStatus == 0) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en la solicitud de valuacion.',
                            );
                        }
                        else {
                            $idPayStatus = $this->paymentService->getPaymentStatusID('no pagada');

                            if($idPayStatus == 0) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error en la solicitud de valuacion.',
                                );
                            }
                            else {
                                // Revisar si ya hay una valuacion al mismo producto y mismo usuario requester que ha sido creada
                                $oldValuation = Valuation::
                                    where([
                                        ['val_idUserRequester', '=', $user->usu_idUser],
                                        ['prod_idProducto', '=', $paramsArray['idProduct']],
                                        ['vsta_idStatus', '=', $idValStatus],
                                        ['val_idPaymentStatus', '=', $idPayStatus],
                                    ])
                                ->get();

                                if ($oldValuation->isEmpty()) {
                                    // echo 'No hay resultados, la colección está vacía';
                                    $settingValuation = $this->settingService->getValuationCost();

                                    if(!is_object($settingValuation)) {
                                        $data = array(
                                            'status'    => 'error',
                                            'code'      => 400,
                                            'message'   => 'Ha ocurrido un error al solicitar la valuacion.',
                                        );
                                    }
                                    else {
                                        $valuationCost =  $settingValuation->set_value;
                                        $total = $valuationCost * $paramsArray['amount'];
                                        
                                        try {
                                            $valuation = new Valuation();
                            
                                            $valuation->val_amount          = $paramsArray['amount'];
                                            $valuation->val_total           = $total;
                                            $valuation->prod_idProducto     = $paramsArray['idProduct'];
                                            $valuation->val_idUserRequester = $user->usu_idUser;
                                            $valuation->vsta_idStatus       = $idValStatus;
                                            $valuation->val_idPaymentStatus = $idPayStatus;
                
                                            $valuation->save();

                                            $idValuation = $valuation->val_idValuation;

                                            if(is_null($idValuation) || !isset($idValuation) || empty($idValuation)) {
                                                $data = array(
                                                    'status'    => 'error',
                                                    'code'      => 400,
                                                    'message'   => 'Ha ocurrido un error en la solicitud de valuación s',
                                                );
                                            }
                                            else {
                                                // $data = array(
                                                //     'status' => 'success',
                                                //     'code' => 200,
                                                //     'message' => 'La solicitud de valuación se ha enviado',
                                                // );

                                                $sendMailCode = $this->mailController->requestValuation($valuation, $user, $product);

                                                    // Procesar la respuesta del MailController
                                                if (isset($sendMailCode['error'])) {
                                                    // $data = array(
                                                    //     'status' => 'error',
                                                    //     'code' => 404,
                                                    //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                                    // );
                                                    if(isset($idValuation)) {
                                                        $data = array(
                                                            'status' => 'success',
                                                            'code' => 200,
                                                            'message' => 'La solicitud de valuación se ha enviado, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
                                                        );
                                                    }
                                                    else {
                                                        $data = array(
                                                            'status' => 'error',
                                                            'code' => 400,
                                                            'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                                        );
                                                    }
                                                }
                                                elseif ($sendMailCode['status'] === 'success') {
                                                    $data = array(
                                                        // 'status' => 'success',
                                                        // 'code' => 200,
                                                        // 'message' => 'El usuario se ha creado correctamente y se ha enviado el correo de verificación.',
                                                        'status'    => 'success',
                                                        'code'      => 200,
                                                        'message'   => 'La solicitud de valuación se ha enviado y se ha enviado el correo de verificación.',
                                                    );
                                                    
                                                }
                                                else {
                                                    // $data = array(
                                                    //     'status' => 'error',
                                                    //     'code' => 500,
                                                    //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                                    // );
                                                    
                                                    if(isset($idValuation)) {
                                                        $data = array(
                                                            'status' => 'success',
                                                            'code' => 200,
                                                            'message' => 'La solicitud de valuación se ha enviado, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
                                                        );
                                                    }
                                                    else {
                                                        $data = array(
                                                            'status' => 'error',
                                                            // 'code' => 500,
                                                            'code' => 400,
                                                            'message' => 'Ha ocurrido un error inesperado al enviar el correo con la solicitud.',
                                                        );
                                                    }
                                                }
                                            }
                                        } catch (QueryException $e) {
                                            $errorCode = $e->getCode();
                                            $errorMessage = $e->getMessage();
                                            $data = array(
                                                'status'    => 'error',
                                                'code'      => 400,
                                                'message'   => 'Ha ocurrido un error al solicitar la valuación.',
                                                'description' => 'Code - '. $errorCode .', Mensaje - '.$errorMessage

                                            );
                                        }
                                    }
                                    return response()->json($data, $data['code']);

                                } else {
                                    // echo 'La colección tiene elementos';
                                    $data = array(
                                        'status'    => 'error',
                                        'code'      => 409,
                                        'message'   => 'Existe una valuación a este producto que esta pendiente',
                                    );
                                }
                            }
                        }
                    }
                }
                
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                // 'message'   => 'Petición errónea.',
                'message'   => 'No se encontró el recurso solicitado.',
            );
        }
        return response()->json($data, $data['code']);
    }
}
