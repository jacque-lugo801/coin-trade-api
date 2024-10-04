<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Notification;
// use App\Models\User;

use App\Services\UserService;
use App\Http\Controllers\MailController;

use Illuminate\Database\QueryException;
use Exception;

class NotificationController extends Controller
{
    protected $userService;
    protected $mailController;

    public function __construct (
        UserService     $userService,
        MailController  $mailController,
    ) {
        $this->userService      = $userService;
        $this->mailController   = $mailController;
    }

    // Solicitar mejora del producto
    public function sendRequestUpgrade(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array
        
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'idProduct'     => 'required',
                'productSku'    => 'required',
                'productName'   => 'required',
                'productType'   => 'required',
                'productTName'  => 'required',
                'idSeller'      => 'required',
                'sellerMail'    => 'required | email',
                'sellerUser'    => 'required',
                'message'       => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al solicitar mejora del producto ',
                    'errors'    => $validate->errors()
                );
            }
            else{
                // $userDestination =  User::
                //     where('usu_email', '=', $paramsArray['sellerMail'])
                //     ->where('usu_username', '=', $paramsArray['sellerUser'])
                //     ->first();

                $userDestination = $this->userService->getUserData($paramsArray['sellerMail'], $paramsArray['sellerUser']);
                // var_dump($userDestination);

                if(!is_object($userDestination)) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'No se ha encontrado al usuario solicitado',
                    );
                }
                else {
                    try {
                        $notification = new Notification();
                        $notification->not_content              = $paramsArray['message'];
                        $notification->usu_idUser               = $user->usu_idUser;
                        $notification->not_idUserDestination    = $userDestination->usu_idUser;

                        $notification->save();

                        $idNotification = $notification->not_idNotification;
                        // var_dump($idNotification);

                        if(!isset($idNotification) && empty($idNotification)) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'No se ha encontrado al usuario solicitado',
                            );
                        }
                        else {
                            $paramsMail = array(
                                'name'          => $userDestination->usu_name,
                                'lastname'      => $userDestination->usu_lastname,
                                'sellerMail'    => $userDestination->usu_email,
                                'productName'   => $paramsArray['productName'],
                                'message'       => $paramsArray['message'],
                            );
            
                            // Send email that its created
                            // (new MailController)->productRequestUpgradeByAdmin($paramsMail);
                            
                            $sendMailCode = $this->mailController->productRequestUpgradeByAdmin($paramsMail);
                            
                            // Procesar la respuesta del MailController
                            if (isset($sendMailCode['error'])) {
                                // $data = array(
                                //     'status' => 'error',
                                //     'code' => 404,
                                //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                // );
                                if(isset($idNotification)) {
                                    $data = array(
                                        'status' => 'success',
                                        'code' => 200,
                                        'message' => 'La solicitud de mejora se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
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
                                    'message'   => 'La solicitud de mejora se ha creado correctamente y se ha enviado el correo de verificación.',
                                );
                                
                            }
                            else {
                                // $data = array(
                                //     'status' => 'error',
                                //     'code' => 500,
                                //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                // );
                                
                                if(isset($idNotification)) {
                                    $data = array(
                                        'status' => 'success',
                                        'code' => 200,
                                        'message' => 'La solicitud de mejora se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
                                    );
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
                    } catch (QueryException $e) {
                        // $errorCode = $e->getCode();
                        // $errorMessage = $e->getMessage();
                        // Log::error("Error on signup. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error la solicitud de mejora',
                        );
                    }
                }
                return response()->json($data, $data['code']);
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
