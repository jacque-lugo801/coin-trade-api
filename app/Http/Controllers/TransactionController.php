<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Models\Transaction;

use App\Http\Controllers\MailController;
use App\Services\UserService;
use App\Services\ProductService;
use App\Services\TransactionService;
use App\Services\DataService;


use Money\Currencies\ISOCurrencies;
use Money\Currency;
use Money\Formatter\DecimalMoneyFormatter;
use Money\Money;

use Illuminate\Database\QueryException;
use Exception;


class TransactionController extends Controller
{
    protected $userService;
    protected $productService;
    protected $transactionService;
    protected $dataService;
    protected $mailController;

    public function __construct (
        UserService         $userService,
        ProductService      $productService,
        TransactionService  $transactionService,
        DataService         $dataService,
        MailController      $mailController,
    ) {
        $this->userService          = $userService;
        $this->productService       = $productService;
        $this->transactionService   = $transactionService;
        $this->dataService          = $dataService;
        $this->mailController       = $mailController;
    }


    // **************************************************
    // *                    AUTH                        *
    // **************************************************

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
                // $validateItems = \Validator::make($paramsItemsArray, [
                //     "items"                     => 'required|array',
                //     "items.*.citm_idItem"       => 'required|integer',
                //     "items.*.citm_quantity"     => 'required|integer',
                //     "items.*.prod_idProducto"   => 'required|integer',
                //     "items.*.prod_sku"          => 'required|string',
                //     "items.*.prod_name"         => 'required|string',
                //     "items.*.total"             => 'required|numeric',
                //     "items.*.usu_idUserSeller"  => 'required|integer',
                // ]);
                $validateItems = \Validator::make($paramsItemsArray, [
                    "items"                     => 'required|array',
                    "items.*.citm_idItem"       => 'required',
                    "items.*.citm_quantity"     => 'required',
                    "items.*.prod_idProducto"   => 'required',
                    "items.*.prod_sku"          => 'required',
                    "items.*.prod_name"         => 'required',
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
                                foreach ($paramsItemsArray as $item => $value) {
                                    // Comprobar la información de cada producto
                                    print_r($value);
                                }
                                die();
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
    /*
    {
    "idSession": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZFVzZXIiOjMsImlkQ2FydCI6MX0.NdnKxAWASiMNjPR1amH4eO3rw8gbMPE0EfnFq9ujAhw",
    "items": [
        {
            "citm_idItem": 1,
            "citm_quantity": 1,
            "prod_idProducto": 1,
            "prod_sku": "MND1",
            "prod_name": "Moneda Francisco I. Madero 20 centavos",
            "total": 9405,
            "usu_idUserSeller": 2
        },
        {
            "citm_idItem": 2,
            "citm_quantity": 1,
            "prod_idProducto": 2,
            "prod_sku": "BLE1",
            "prod_name": "1 Pound (Commonwealth Bank)",
            "total": 6132.5,
            "usu_idUserSeller": 2
        }
    ],
    "total": 15537.5,
    "addressCountry": "MX",
    "addressState": "QT",
    "addressCity": "016",
    "addressAddress": "Pozo Grande",
    "addressCp": "42500",
    "isNewAddress": 0,
    "isAddressEdited": 0
}
    
    */

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


}
