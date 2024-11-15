<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Models\Transaction;
use App\Models\TransactionDetail;

use App\Http\Controllers\MailController;
use App\Services\UserService;
use App\Services\ProductService;
use App\Services\TransactionService;
use App\Services\DataService;
use App\Services\PaymentService;
use App\Services\CartService;


use Money\Currencies\ISOCurrencies;
use Money\Currency;
use Money\Formatter\DecimalMoneyFormatter;
use Money\Money;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;


class TransactionController extends Controller
{
    protected $userService;
    protected $productService;
    protected $transactionService;
    protected $dataService;
    protected $mailController;
    protected $paymentService;
    protected $cartService;

    public function __construct (
        UserService         $userService,
        ProductService      $productService,
        TransactionService  $transactionService,
        DataService         $dataService,
        MailController      $mailController,
        PaymentService      $paymentService,
        CartService         $cartService,
    ) {
        $this->userService          = $userService;
        $this->productService       = $productService;
        $this->transactionService   = $transactionService;
        $this->dataService          = $dataService;
        $this->mailController       = $mailController;
        $this->paymentService       = $paymentService;
        $this->cartService          = $cartService;
    }


    // **************************************************
    // *                    AUTH                        *
    // **************************************************

    
    // Obtener transacciones (vendedor)
    public function getSalesFmUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        $sales = $this->transactionService->getSalesFmUser($user);

        if(!is_object($sales)){
            $sales = [];
        }
        
        return response()->json([
            'sales' => $sales
        ]);
    }
    
    // Obtener transacciones (comprador)
    public function getPurchasesFmUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        $purchases = $this->transactionService->getPurchasesFmUser($user);

        if(!is_object($purchases)){
            $purchases = [];
        }
        
        return response()->json([
            'purchases' => $purchases
        ]);
    }

    // Obtener transacciones
    public function getTransactionFmUser2(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        try {
            $transactions = Transaction::
                with([
                    'transactionDetail',
                    'transactionDetail.detailUser',
                    'transactionDetail.detailUser.userRol',
                    'transactionDetail.detailProduct',
                    'transactionDetail.detailProduct.productCountry',
                    'transactionDetail.detailProduct.productType',
                    'transactionDetail.detailProduct.productGroup',
                    'transactionDetail.detailProduct.productCategory',
                    'transactionStatus',
                    'paymentStatus',
                    'paymentType',
                    'paymentCategory',
                    'transactionShippingAddress',
                    'transactionShippingAddress.userShippingCountry',
                    'transactionShippingAddress.userShippingState',
                    'transactionShippingAddress.userShippingCity',
                    'transactionCountry',
                    'transactionState',
                    'transactionCity',
                ])
                ->
                where([
                    ['tran_idUserBuyer', '=', $user->usu_idUser],
                    // ['tran_isActive', '=', 1],
                ])
                ->
                get()
            ;

            if(!empty($transactions)){
                $transactions = $transactions->map(function ($transaction) {
                    // Aplicar makeHidden en cada instancia de detailUser dentro de transactionDetail
                    $transaction->transactionDetail->each(function ($detail) {
                        if ($detail->detailUser) {
                            $detail->detailUser->makeHidden([
                                'usu_identity',
                                // 'usu_email2',
                                'usu_birth_date',
                                'usu_username',
                                'usu_mail_account',
                                'usu_isAuthorized',
                                'usu_created_date',
                                'usu_updated_date',
                                'usts_idStatus',
                                'usu_isVerification',
                                'usu_isVerificated',
                                'usu_isActive',
                            ]);
                        }
                    });
                    return $transaction;
                });

                // $transactions->each(function ($transaction) {
                //     if ($transaction->transactionDetail && $transaction->transactionDetail->detailUser) {
                //         $transaction->transactionDetail->detailUser->makeHidden([
                //             'usu_identity',
                //             // 'usu_email2',
                //             'usu_birth_date',
                //             'usu_username',
                //             'usu_mail_account',
                //             'usu_isAuthorized',
                //             'usu_created_date',
                //             'usu_updated_date',
                //             'usts_idStatus',
                //             'usu_isVerification',
                //             'usu_isVerificated',
                //             'usu_isActive',
                //         ]);
                //     }
                // });

                $data = array(
                    'transactions' => $transactions,
                );
            }
            else {
                $data = array(
                    'transactions' => [],
                );
            }

        } catch (QueryException $e) {
            $data = array(
                'transactions' => [],
            );
        }
        return response()->json($data);
    }

    // Obtener transaccion (comprador)
    public function getTransactionInfoFmUser(Request $request, $id) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        if(isset($id)) {
            $idStrR = str_replace('"', '', $id);

            $orderIdArr = $jwtAuth->checkToken($idStrR, true);

            if($user->usu_idUser === $orderIdArr->idUser ) {
                $transaction = $this->transactionService->getTransactionFmUserByID($orderIdArr->idTransaction, $user);

                if(!is_object($transaction)){
                    $transaction = [];
                }
            }
            else {
                $transaction = [];
            }
        }
        else {
            $transaction = [];
        }
        
        return response()->json([
            'transactions' => $transaction
        ]);
    }

    //Crear una nueva orden de compra
    public function createTransaction(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos usuarios
        $json = $request->input('json', null);

        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        // $paramsItemsArray = $paramsArray['items'];
        $paramsItemsArray = array(
            'items' => $paramsArray['items']
        );
        $paramsDataArray = array_diff_key($paramsArray, array_flip(['items']));
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsDataArray = array_map('trim', $paramsDataArray);   //Limpiar datos del array

            $validateData = \Validator::make($paramsDataArray, [
                "idSession"         => 'required',
                "subtotal"          => 'required',
                // "discount"          => 'required',
                // "coupon"            => 'required',
                "total"             => 'required',
                "addressID"         => 'required',
                "addressCountry"    => 'required',
                "addressState"      => 'required',
                "addressCity"       => 'required',
                "addressAddress"    => 'nullable',
                "addressCp"         => 'nullable',
                "isNewAddress"      => 'nullable',
                "isAddressEdited"   => 'required',
            ]);

            if ($validateData->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al crear la orden.',
                    'errors'    => $validateData->errors()
                );
            }
            else {
                // Limpiar el arreglo de items
                $paramsItemsArray = $this->dataService->trimArray($paramsItemsArray);

                // Validar los datos
                $validateItems = \Validator::make($paramsItemsArray, [
                    "items"                     => 'required|array',
                    "items.*.citm_idItem"       => 'required',
                    "items.*.citm_quantity"     => 'required',
                    "items.*.prod_idProducto"   => 'required',
                    "items.*.prod_sku"          => 'required',
                    "items.*.prod_name"         => 'required',
                    "items.*.subtotal"             => 'required',
                    "items.*.total"             => 'required',
                    "items.*.usu_idUserSeller"  => 'required',
                ]);

                if ($validateItems->fails()) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al crear la orden.',
                        'errors'    => $validateItems->errors()
                    );
                }
                else {
                    // Comprobar el id de session del carrito
                    // paramsDataArray
                    // paramsItemsArray
                    $cartSession = $jwtAuth->checkToken($paramsDataArray['idSession'], true);

                    if(!is_object($cartSession)){
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al crear la orden. ss',
                            'errors'    => $validateItems->errors()
                        );
                    }
                    else {
                        $idUserSession = $cartSession->idUser;
                        $idCartSession = $cartSession->idCart;

                        // Comprobar que el idUser de token e idUser del cartSession sean el mismo
                        if($user->usu_idUser != $idUserSession) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al crear la orden. nu',
                                'errors'    => $validateItems->errors()
                            );
                        }
                        else {
                            // Guardar, actualizar o validar direccion
                            $codeAddress = $paramsDataArray['isNewAddress'].''.$paramsDataArray['isAddressEdited'];
                            // 1er digito -> isNewAddress
                            // 2do digito -> isAddressEdited
                            // 00-> NO es nueva direccion, NI esta editada la dirección
                            // 01-> NO es nueva direccion, es una direccion existente EDITADA
                            // 10-> ES una nueva dirección, no es direccion editada
                            // 11-> Es una nueva dirección, es direccion editada-> regresar error
                            switch ($codeAddress) {
                                case '00':
                                    $address = $this->validateAddress(false, false, $user, $paramsDataArray);
                                    break;
                                case '01':
                                    $address = $this->validateAddress(false, true, $user, $paramsDataArray);
                                    break;
                                case '10':
                                    $address = $this->validateAddress(true, false, $user, $paramsDataArray);
                                    break;
                                case '11':
                                    $address = $this->validateAddress(true, true, $user, $paramsDataArray);
                                    break;
                                default:
                                    $address = $this->validateAddress(true, true, $user, $paramsDataArray);
                                    break;
                            }

                            // Información de dirección
                            if(!is_object($address)) {
                                // echo 'no objeto'
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error al crear la orden. anf',
                                    'errors'    => $validateItems->errors()
                                );
                            }
                            else {
                                // Verificar items
                                $products = array();

                                foreach ($paramsItemsArray['items'] as $index => $value) {
                                    // Comprobar la información de cada producto
                                    $productCollection = $this->productService->getProductByID($value['prod_idProducto']);

                                    if($productCollection->isEmpty()) {
                                        // Si no existe el producto
                                        $data = array(
                                            'status'    => 'error',
                                            'code'      => 400,
                                            'message'   => 'Ha ocurrido un error al crear la orden. pce',
                                        );
                                        break;
                                    }
                                    else {
                                        // SI existe el producto
                                        $productFind = $productCollection->first();
                                        // var_dump($productFind);
                                        // die();

                                        if(
                                            $value['prod_sku'] !== $productFind->prod_sku &&
                                            $value['usu_idUserSeller'] !== $productFind->usu_idUser
                                        ) {
                                            $data = array(
                                                'status'    => 'error',
                                                'code'      => 400,
                                                'message'   => 'Ha ocurrido un error al crear la orden. pnf',
                                            );
                                            break;
                                        }
                                        else {
                                            // Es el mismo
                                            $userProduct = $this->userService->getUserDataByID($value['usu_idUserSeller']);
                                            // var_dump($userProduct);
                                            // die();

                                            if(!is_object($userProduct)) {
                                                $data = array(
                                                    'status'    => 'error',
                                                    'code'      => 400,
                                                    'message'   => 'Ha ocurrido un error al crear la orden. nud',
                                                );
                                                break;
                                            }
                                            else {
                                                // $value['usu_nameUserSeller'] = $userProduct->usu_name;
                                                $paramsItemsArray['items'][$index]['usu_nameUserSeller'] = $userProduct->usu_name;
                                                $paramsItemsArray['items'][$index]['usu_lastnameUserSeller'] = $userProduct->usu_lastname;
                                                $paramsItemsArray['items'][$index]['usu_rfcUserSeller'] = $userProduct->userFiscalData[0]->ufdt_rfc;

                                                // if($userProduct->usu_middle_name){
                                                //     $userProduct->usu_fullname = trim($userProduct->usu_name). ' ' . trim($userProduct->usu_middle_name) . ' ' . trim($userProduct->usu_lastname) . ' '. trim($userProduct->usu_lastname2);
                                                // }
                                                // else {
                                                //     $userProduct->usu_fullname = trim($userProduct->usu_name). ' ' . trim($userProduct->usu_lastname) . ' '. trim($userProduct->usu_lastname2);
                                                // }
                                                
                                                // $paramsItemsArray['items'][$index]['usu_fullnameUserSeller'] = $userProduct->usu_lastname;
                                                // Revisar stock

                                                // // if($productStock >= $paramsArray['quantity']) {
                                                //     if($productStock < $paramsArray['quantity']) {
                                                if($productFind->prod_stock >= $value["citm_quantity"]) {
                                                    // echo 'suficiente stock';
                                                    $productObj = [
                                                        'prod_idProducto'   => $productFind->prod_idProducto,
                                                        'prod_sku'          => $productFind->prod_sku,
                                                        'prod_name'         => $productFind->prod_name,
                                                        'prod_description'  => $productFind->prod_description,
                                                        'prod_country'      => $productFind->prod_country,
                                                        'prod_metal'        => $productFind->prod_metal,
                                                        'prod_diameter'     => $productFind->prod_diameter,
                                                        'prod_condition'    => $productFind->prod_condition,
                                                        'prod_date'         => $productFind->prod_date,
                                                        'prod_weight'       => $productFind->prod_weight,
                                                        'prod_minting'      => $productFind->prod_minting,
                                                        'prod_fineness'     => $productFind->prod_fineness,
                                                        'prod_serie'        => $productFind->prod_serie,
                                                        'prod_denomination' => $productFind->prod_denomination,
                                                        'prod_number'       => $productFind->prod_number,
    
                                                        // 'prod_rating'       => $productFind->prod_rating,
                                                        // 'prod_unit_cost'   => $productFind->prod_unit_cost,
                                                        // 'prod_commission'   => $productFind->prod_commission,
                                                        // 'prod_total'   => $productFind->prod_total,
                                                        // 'prod_stock'   => $productFind->prod_stock,
    
                                                        'prod_image_front'  => $productFind->prod_image_front,
                                                        'prod_image_back'   => $productFind->prod_image_back,
    
                                                        'prod_idType_product'       => $productFind->prod_idType_product,
                                                        'prod_idGroup_product'      => $productFind->prod_idGroup_product,
                                                        'prod_idCategory_product'   => $productFind->prod_idCategory_product,
                                                        // 'prod_isAuthorized'         => $productFind->prod_isAuthorized,
                                                        // 'prod_isTerms'              => $productFind->prod_isTerms,
    
                                                        'product_country' => [
                                                            'coun_iso_alpha2'   => $productFind->productCountry->coun_iso_alpha2,
                                                            'coun_name'         => $productFind->productCountry->coun_name,
                                                            'coun_isActive'     => $productFind->productCountry->coun_isActive,
                                                        ],
                                                        'product_type' => [
                                                            'ptpe_idType'       => $productFind->productType->ptpe_idType,
                                                            'ptpe_name'         => $productFind->productType->ptpe_name,
                                                            'ptpe_description'  => $productFind->productType->ptpe_description,
                                                        ],
                                                        'product_group' => [
                                                            'pgrp_idGroup'      => $productFind->productGroup->pgrp_idGroup,
                                                            'pgrp_name'         => $productFind->productGroup->pgrp_name,
                                                            'pgrp_description'  => $productFind->productGroup->pgrp_description,
                                                            // 'pgrp_isActive'     => $productFind->productGroup->pgrp_isActive,
                                                            'ptpe_idType'       => $productFind->productGroup->ptpe_idType,
                                                        ],
                                                        'product_certifications' => [
                                                            'pcert_idCertification' => $productFind->productCertifications[0]->pcert_idCertification,
                                                            'pcert_name'            => $productFind->productCertifications[0]->pcert_name,
                                                            'pcert_description'     => $productFind->productCertifications[0]->pcert_description,
                                                            'pcert_image'           => $productFind->productCertifications[0]->pcert_image,
                                                            'pcert_created_date'    => $productFind->productCertifications[0]->pcert_created_date,
                                                            'pcert_updated_date'    => $productFind->productCertifications[0]->pcert_updated_date,
                                                        ],
                                                        'product_user' => [
                                                            'urol_idRol'    => $userProduct->urol_idRol,
                                                            'usu_name'      => $userProduct->usu_name,
                                                            'usu_lastname'  => $userProduct->usu_lastname,
                                                            'ufdt_rfc'      => $userProduct->userFiscalData[0]->ufdt_rfc,
                                                        ],
                                                    ];
    
                                                    if(is_null($productFind->productCategory)) {
                                                        // No hay info de subcategoria
                                                        array_push($productObj, [
                                                            'product_category' => null
                                                        ]);
                                                    }
                                                    else {
                                                        array_push($productObj, [
                                                            'product_category' => [
                                                                'pcat_idCategory'   => $productFind->productCategory->pcat_idCategory,
                                                                'pcat_name'         => $productFind->productCategory->pcat_name,
                                                                'pcat_description'  => $productFind->productCategory->pcat_description,
                                                                // 'pcat_isActive'   => $productFind->productCategory->pcat_isActive,
                                                                'pgrp_idGroup'      => $productFind->productCategory->pgrp_idGroup,
                                                            ],
                                                        ]);
                                                    }
                                                }
                                                $productObjToJson = json_encode($productObj);
                                                // $productObjToJson = json_encode($productObj, JSON_PRETTY_PRINT);
                                                // array_push($products, $productObj);
                                                array_push($products, $productObjToJson);

                                                // var_dump($productFind);
                                                // var_dump($productFind->productCountry);
                                            }
                                        }
                                    }
                                }
                                // print_r($products);
                                // print_r($paramsItemsArray);
                                // die();
                                // $productObjToJson = json_encode($products);
                                // // $productObjToJson = json_encode($productObj, JSON_PRETTY_PRINT);
                                // // array_push($products, $productObjToJson);
                                // print_r($productObjToJson);
                                // // die();

                                // var_dump(count($paramsItemsArray['items']));
                                // var_dump(count($products));

                                if(count($products) < count($paramsItemsArray['items'])) {
                                    // echo 'no se encontraron todos los productos';
                                    $data = array(
                                        'status'    => 'error',
                                        'code'      => 409,
                                        'message'   => 'Ha ocurrido un error al crear la orden. pns',
                                    );
                                }
                                else {
                                    // Guardar la transaccion
                                    $transaction = $this->saveTransaction($paramsDataArray, $idCartSession, $address, $user, $products);

                                    if(!is_object($transaction)) {
                                        $data = array(
                                            'status'    => 'error',
                                            'code'      => 400,
                                            'message'   => 'Ha ocurrido un error al crear la orden. ts',
                                        );
                                    }
                                    else {
                                        // $idTransaction = $transaction->tran_solicitud;
                                        $idTransaction = $transaction->tran_idTransaction;

                                        $itemsSaved = 0;
                                        
                                        // Guardar cada uno de los items
                                        foreach ($paramsItemsArray['items'] as $index => $value) {
                                            // var_dump($index);
                                            // die();
                                            // // var_dump($value);
                                            // var_dump($products);
                                            // die();
                                            
                                            $transactionDetail = $this->saveDetailTransaction($idTransaction, $value, $products[$index], $user);
                                            
                                            if(!is_object($transactionDetail)) {
                                                // Si no se guardan los datos de envio borrar los datos de usuario
                                                // $deleted = User::where('usu_idUser', '=', $idUser) -> delete();

                                                $data = array(
                                                    'status'    => 'error',
                                                    'code'      => 400,
                                                    'message'   => 'Ha ocurrido un error al crear la orden. tdns',
                                                );
                                            }
                                            else {
                                                // Eliminar producto del carrito
                                                $oldValue = $value;
                                                
                                                // $reduceStock = $this->productService->reduceStockTransaction($value);

                                                // die();
                                                $deletedCartItem = $this->deleteItemsCartTransaction($idCartSession, $user, $value);

                                                if($deletedCartItem || $deletedCartItem == 1) {
                                                    // Disminuir stock
                                                    $reduceStock = $this->productService->reduceStockTransaction($value);

                                                    if($reduceStock || $reduceStock == 1) {
                                                        // Si se ha actualizado
                                                        $itemsSaved += 1;
                                                    }
                                                    else {
                                                        // Si no se ha actualizado
                                                    }
                                                }
                                                else {

                                                }
                                            }
                                        }

                                        if($itemsSaved < count($paramsItemsArray['items'])) {
                                            // echo 'eliminar info de detalle de transaccion y transaccion';
                                            // Eliminar detalle transaction
                                            $deleteDetail = $this->transactionService->deleteDetailTransaction($idTransaction, $user->usu_idUser);

                                            if($deleteDetail || $deleteDetail == 1) {
                                                // Eliminar transaccion
                                                $deleteTransaction = $this->transactionService->deleteTransaction($idTransaction, $user->usu_idUser);

                                                if($deleteTransaction || $deleteTransaction == 1) {
                                                    $data = array(
                                                        'status'    => 'error',
                                                        'code'      => 400,
                                                        'message'   => 'Ha ocurrido un error al crear la orden. tds',
                                                    );
                                                }
                                                else {
                                                    $data = array(
                                                        'status'    => 'error',
                                                        'code'      => 400,
                                                        'message'   => 'Ha ocurrido un error al crear la orden. td',
                                                    );
                                                }
                                            }
                                            else {
                                                $data = array(
                                                    'status'    => 'error',
                                                    'code'      => 400,
                                                    'message'   => 'Ha ocurrido un error al crear la orden. tdd',
                                                );
                                            }
                                        }
                                        else {
                                            // echo 'continue';
                                            // $data = array(
                                            //     'status' => 'success',
                                            //     'code' => 200,
                                            //     'message' => 'La transacción se ha realizado correctamente.',
                                            // );
                                            // $sendMailCode = $this->mailController->requestValuation($valuation, $user, $product);
                                            $savedTransaction = $this->transactionService->getTransactionFmUserByID($idTransaction, $user);

                                            if(!is_object($savedTransaction)){
                                                $data = array(
                                                    'status'    => 'error',
                                                    'code'      => 400,
                                                    'message'   => 'Ha ocurrido un error al crear la orden. ti',
                                                    'errors'    => $validateItems->errors()
                                                );
                                                return 0;
                                            }
                                            else {
                                                $transactionInfo = $savedTransaction->first();
                                                $idTransaction = $transactionInfo->tran_idTransaction;

                                                $transactionIdArr = array(
                                                    'idUser'        => $user->usu_idUser,
                                                    'idTransaction' => $idTransaction,
                                                );
                                                $sessionTransactionID = $jwtAuth->encode($transactionIdArr);

                                                $sendMailCode = $this->mailController->transactionCreated($transactionInfo, $user);
                                                
                                                // Procesar la respuesta del MailController
                                                if (isset($sendMailCode['error'])) {
                                                    // $data = array(
                                                    //     'status' => 'error',
                                                    //     'code' => 404,
                                                    //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                                    // );
                                                    if(isset($idTransaction)) {
                                                        // $data = array(
                                                        //     'status' => 'success',
                                                        //     'code' => 200,
                                                        //     'message' => 'La orden se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
                                                        // );

                                                        $sendMailSeller = $this->mailController->transactionCreatedNotificationSeller($transactionInfo);

                                                        // Procesar la respuesta del MailController
                                                        if (isset($sendMailSeller['error'])) {
                                                            $data = array(
                                                                'status' => 'error',
                                                                'code' => 400,
                                                                'message' => 'Error al enviar el correo: ' . $sendMail['error'],
                                                            );
                                                        }
                                                        elseif ($sendMailSeller['status'] === 'success') {
                                                            $data = array(
                                                                'status' => 'success',
                                                                'code' => 200,
                                                                'message' => 'La orden se ha creado correctamente, pero ha ocurrido un error al enviar el correo a SL: ' . $sendMailCode['error'],
                                                                'data' => array(
                                                                    'orderId' => $sessionTransactionID
                                                                )
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
                                                    else {
                                                        $data = array(
                                                            'status' => 'error',
                                                            'code' => 400,
                                                            'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                                        );
                                                    }
                                                }
                                                elseif ($sendMailCode['status'] === 'success') {
                                                    // $data = array(
                                                    //     // 'status' => 'success',
                                                    //     // 'code' => 200,
                                                    //     // 'message' => 'El usuario se ha creado correctamente y se ha enviado el correo de verificación.',
                                                    //     'status'    => 'success',
                                                    //     'code'      => 200,
                                                    //     'message'   => 'La orden se ha creado correctamente y se ha enviado el correo de verificación.',
                                                    // );
                                                    $sendMailSeller = $this->mailController->transactionCreatedNotificationSeller($transactionInfo);

                                                    // Procesar la respuesta del MailController
                                                    if (isset($sendMailSeller['error'])) {
                                                        $data = array(
                                                            'status' => 'error',
                                                            'code' => 400,
                                                            'message' => 'Error al enviar el correo: ' . $sendMail['error'],
                                                        );
                                                    }
                                                    elseif ($sendMailSeller['status'] === 'success') {
                                                        $data = array(
                                                            'status' => 'success',
                                                            'code' => 200,
                                                            'message'   => 'La orden se ha creado correctamente y se ha enviado el correo de verificación.',
                                                            'data' => array(
                                                                'orderId' => $sessionTransactionID
                                                            )
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
                                                else {
                                                    // $data = array(
                                                    //     'status' => 'error',
                                                    //     'code' => 500,
                                                    //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                                    // );
                                                    
                                                    if(isset($idTransaction)) {
                                                        // $data = array(
                                                        //     'status' => 'success',
                                                        //     'code' => 200,
                                                        //     'message' => 'La orden se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
                                                        // );
                                                        $sendMailSeller = $this->mailController->transactionCreatedNotificationSeller($transactionInfo);

                                                        // Procesar la respuesta del MailController
                                                        if (isset($sendMailSeller['error'])) {
                                                            $data = array(
                                                                'status' => 'error',
                                                                'code' => 400,
                                                                'message' => 'Error al enviar el correo: ' . $sendMail['error'],
                                                            );
                                                        }
                                                        elseif ($sendMailSeller['status'] === 'success') {
                                                            $data = array(
                                                                'status' => 'success',
                                                                'code' => 200,
                                                                'message'   => 'La orden se ha creado correctamente y se ha enviado el correo de verificación.',
                                                                'data' => array(
                                                                    'orderId' => $sessionTransactionID
                                                                )
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
                                                    else {
                                                        $data = array(
                                                            'status' => 'error',
                                                            // 'code' => 500,
                                                            'code' => 400,
                                                            'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                                        );
                                                    }
                                                }
                                            }
                                        }
                                    }
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
                'message'   => 'No se encontró el recurso solicitado.',
            );
        }
        return response()->json($data, $data['code']);
    }

    // Validar la direccion seleccionada
    public function validateAddress($newAddress, $editedAddress, $user, $data) {
        if(!$newAddress && !$editedAddress) {
            //La dirección es una de las que estan registradas antes
            $addressCollection = $this->userService->getShippingAddressByID($user->usu_idUser, $data['addressID']);

            if($addressCollection->isEmpty()) {
                return 0;
            }
            else {
                $address = $addressCollection->first();

                return $address;
            }
        }
        else if(!$newAddress && $editedAddress) {
            //La dirección es una de las que estan registradas antes pero se ha editado uno o varios de sus campos
            $addressCollection = $this->userService->getShippingAddressByID($user->usu_idUser, $data['addressID']);

            if($addressCollection->isEmpty()) {
                return 0;
            }
            else {
                $address = $addressCollection->first();

                if(
                    ($address['usad_country'] !== $data['addressCountry']) ||
                    ($address['usad_state'] !== $data['addressState']) ||
                    ($address['usad_city'] !== $data['addressCity']) ||
                    ($address['usad_address'] !== $data['addressAddress']) ||
                    ($address['usad_cp'] !== $data['addressCp'])
                ){
                    // echo 'algun dato esta cambiado';
                    // Actualizar la dirección
                    $paramsShippingUpdate = array (
                        "usad_country"  => $data['addressCountry'],
                        "usad_state"    => $data['addressState'],
                        "usad_city"     => $data['addressCity'],
                        "usad_address"  => $data['addressAddress'],
                        "usad_cp"       => $data['addressCp'],
                    );

                    $shippingUpdate = $this->userService->updateShippingAddress($paramsShippingUpdate, $data['addressID']);

                    if(!isset($shippingUpdate) && empty($shippingUpdate)) {
                        return 0;
                    }
                    else {
                        // Conseguir la nueva informacion actualizada
                        $newAddressCollection = $this->userService->getShippingAddressByID($user->usu_idUser, $data['addressID']);

                        if($newAddressCollection->isEmpty()) {
                            return 0;
                        }
                        else {
                            $newAddress = $newAddressCollection->first();

                            return $newAddress;
                        }
                    }
                }
                else {
                    // echo 'ningun dato esta cambiado';
                    $address = $addressCollection->first();

                    return $address;
                }
            }
        }
        else if($newAddress && !$editedAddress) {
            //La dirección es una nueva
            $paramsShipping = array (
                "usad_country"  => $data['addressCountry'],
                "usad_state"    => $data['addressState'],
                "usad_city"     => $data['addressCity'],
                "usad_address"  => $data['addressAddress'],
                "usad_cp"       => $data['addressCp'],
                "usu_idUser"    => $user->usu_idUser,
            );

            $shipping = $this->userService->saveShippingAddress($paramsShipping);

            if(!is_object($shipping)) {
                // Si no se guardan los datos de envio borrar los datos de usuario
                $deleted = User::where('usu_idUser', '=', $idUser) -> delete();

                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en el registro.',
                );
            }
            else {
                return $shipping;
            }

        }
        else if($newAddress && $editedAddress) {
            return 0;
        }
    }

    // Guardar la transaccion
    public function saveTransaction($params, $idCartSession, $address, $user, $products) {
        if(!empty($params) || !empty($idCartSession) || !empty($address) || !empty($user) || !empty($products)) {
            try {
                $transactionNumber = $this->getLastTransaction();

                if($transactionNumber == 0) {
                    return 0;
                }
                else {
                    $idPayStatus = $this->paymentService->getPaymentStatusID('no pagada');
    
                    if($idPayStatus == 0) {
                        return 0;
                    }
                    else {
                        $idTransactionStatus = $this->transactionService->getTransactionStatusID('en proceso');

                        if($idTransactionStatus == 0) {
                            return 0;
                        }
                        else {
                            $idPaymentType = $this->paymentService->getPaymentTypeID('transferencia bancaria');
                            // $idPaymentType = $this->paymentService->getPaymentTypeID('billeteras digitales');
                            
                            if($idPaymentType == 0) {
                                return 0;
                            }
                            else {
                                $idPaymentCategory = $this->paymentService->getPaymentCategoryID(null, $idPaymentType);

                                if($idPaymentCategory === 0) {
                                    return 0;
                                }
                                else {
                                    // if(is_null($idPaymentCategory)) {
                                    //     $idPaymentCategory = null;
                                    // }
                                    $transaction = new Transaction();
                                        
                                    $transaction->tran_solicitud            = $transactionNumber;
                                    $transaction->tran_subtotal             = $params['subtotal'];
                                    // $transaction->tran_iva  = ;
                                    $transaction->tran_total                = $params['total'];
                                    // $transaction->tran_discount = ;
                                    $transaction->tran_idUserBuyer          = $user->usu_idUser;

                                    $transaction->tran_idPaymentStatus      = $idPayStatus;
                                    $transaction->tsta_idStatus             = $idTransactionStatus;
                                    
                                    $transaction->tran_idPaymentType        = $idPaymentType;
                                    $transaction->tran_idPaymentCategory    = $idPaymentCategory;
                                    // $transaction->tran_description  = ;
                                    // $transaction->tran_json = ;
                                    // $transaction->tran_payment_type = ;

                                    $transaction->tran_idShippingAddress    = $address->usad_idAddress;
                                    $transaction->tran_country              = $address->usad_country;
                                    $transaction->tran_state                = $address->usad_state;
                                    $transaction->tran_city                 = $address->usad_city;
                                    $transaction->tran_address              = $address->usad_address;
                                    $transaction->tran_cp                   = $address->usad_cp;

                                    $transaction->save();

                                    return $transaction;
                                }
                            }
                        }
                    }
                }
            } catch (QueryException $e) {
                $errorCode = $e->getCode();
                $errorMessage = $e->getMessage();
                // Log::error("Error on saveTransaction. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                // return response()->json(['error' => 'Ocurrió un error en la consulta.'], 500);
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    public function saveDetailTransaction($idTransaction, $paramsItem, $productJson, $user) {
        if(!empty($idTransaction) || !empty($paramsItem) || !empty($productJson) || !empty($user)) {
            try {
                // var_dump($paramsItem);
                // // var_dump($paramsItem['prod_idProducto']);
                // // // var_dump($productJson);
                // die();

                $userInfo = $this->userService->getUserDataByID($user->usu_idUser);

                if(!is_object($userInfo)) {
                    return 0;
                }
                else {
                    $transactionDetail = new TransactionDetail();

                    $transactionDetail->tdet_prod_idProducto    = $paramsItem['prod_idProducto'];
                    $transactionDetail->tdet_prod_info          = $productJson;
                    $transactionDetail->tdet_quantity           = $paramsItem['citm_quantity'];
                    $transactionDetail->tdet_subtotal           = $paramsItem['subtotal'];
                    // $transactionDetail->tdet_iva                = null;
                    $transactionDetail->tdet_total              = $paramsItem['total'];
                    // $transactionDetail->tdet_discount           = null;
                    $transactionDetail->tdet_buyer_idUser       = $user->usu_idUser;
                    $transactionDetail->tdet_buyer_name         = $user->usu_name;
                    $transactionDetail->tdet_buyer_lastname     = $user->usu_lastname;
                    $transactionDetail->tdet_buyer_rfc          = $userInfo->userFiscalData[0]->ufdt_rfc;
    
                    $transactionDetail->tdet_seller_idUser      = $paramsItem['usu_idUserSeller'];
                    $transactionDetail->tdet_seller_name        = $paramsItem['usu_nameUserSeller'];
                    $transactionDetail->tdet_seller_lastname    = $paramsItem['usu_lastnameUserSeller'];
                    $transactionDetail->tdet_seller_rfc         = $paramsItem['usu_rfcUserSeller'];
                    $transactionDetail->tran_idTransaction      = $idTransaction;
                    
                    $transactionDetail->save();
                    
                    return $transactionDetail;
                }
            } catch (QueryException $e) {
                $errorCode = $e->getCode();
                $errorMessage = $e->getMessage();
                Log::error("Error on saveDetailTransaction. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                // 'description' => 'Code - '. $errorCode .', Mensaje - '.$errorMessage
                // return response()->json(['error' => 'Ocurrió un error en la consulta.'], 500);
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    // Obtener la ultima transaccion
    public function getLastTransaction(){
        try {
            $transactions = Transaction::
                where([
                    ["tran_isActive", "=", 1],
                ])
                ->get()
            ;

            $number = count($transactions) + 1;

            return $number;
        } catch (QueryException $e) {
            return 0;
        }
        return 0;
    }

    // Eliminar items del carrito
    public function deleteItemsCartTransaction($idCartSession, $user, $value) {
        if(!empty($idCartSession) || !empty($user) || !empty($value)) {
            try {
                // Obtener los items del carrito
                $paramsItem = [
                    'idItem'    => $value['citm_idItem'],
                    'idProduct' => $value['prod_idProducto'],
                ];

                // citm_quantity
                $cartItem = $this->cartService->getCartItem($idCartSession, $paramsItem);
                
                // var_dump($cartItem);
                // die();
                if(!is_object($cartItem)) {
                    return 0;
                }
                else {
                    $cartItemRemove = $this->cartService->removeItem($idCartSession, $value['citm_idItem']);

                    if($cartItemRemove || $cartItemRemove == 1) {
                        return 1;
                    }
                    else {
                        return 0;
                    }
                }
            } catch (QueryException $e) {
                // $errorCode = $e->getCode();
                // $errorMessage = $e->getMessage();
                // Log::error("Error on deleteItemsCartTransaction. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                // // 'description' => 'Code - '. $errorCode .', Mensaje - '.$errorMessage
                // // return response()->json(['error' => 'Ocurrió un error en la consulta.'], 500);
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    
    
    // **************************************************
    // *                    ADMIN                       *
    // **************************************************

    // Obtener transacciones (vendedor)
    public function getTransactions(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        $sales = $this->transactionService->getTransactions($user);

        if(!is_object($sales)){
            $sales = [];
        }
        
        return response()->json([
            'sales' => $sales
        ]);
    }



}
