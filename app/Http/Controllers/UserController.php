<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\State;
// use App\Models\Country;
// use App\Models\City;

// use App\Models\UserShippingAddress;
// use App\Models\UserFiscalData;
// use App\Http\Controllers\UserShippingAddressController;
// use App\Http\Controllers\UserFiscalDataController;


use App\Http\Controllers\MailController;
// use App\Models\UserRol;

use App\Services\UserService;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

// use Illuminate\Validation\Rule;

class UserController extends Controller
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

    // Registro nueva cuenta sitio
    public function signup(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);

        $params         = json_decode($json); // Objeto
        $paramsArray    = json_decode($json, true); // Array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray); // Limpiar datos del array
            
            $validate = \Validator::make($paramsArray, [
                'name'          => 'required',
                'lastname'      => 'required',
                'identity'      => 'required',
                'mail'          => 'required | email | unique:users,usu_email',
                'phone'         => 'required',
                'phoneLocal'    => 'required',
                'birthDate'     => 'required',
                'country'       => 'required',
                'state'         => 'required',
                'city'          => 'required',
                'address'       => 'required',
                'cp'            => 'required',
                'denomination'  => 'required',
                'rfc'           => 'required',
                'countryFiscal' => 'required',
                'stateFiscal'   => 'required',
                'cityFiscal'    => 'required',
                'addressFiscal' => 'required',
                'cpFiscal'      => 'required',
                'username'      => 'required | alpha_num | unique:users,usu_username',
                'pwd'           => 'required',
                'mailAccount'   => 'required | email',
                'rol'           => 'required ',
                'terms'         => 'required ',
            ],
            [
                'mail.unique'       => 'El email ya ha sido registrado.',
                'username.unique'   => 'El nombre de usuario ya existe.',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en el registro.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $idRol = $this->userService->getRolID($params->rol);

                if($idRol == 0) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error en el registro.',
                    );
                }
                else {
                    $code = $this->userService->setCode();
                    
                    $pwd = hash('sha256', $params->pwd); // Cifrado de contraseña

                    try {
                        //Creacion de usuario
                        $user = new User();
                        $user->usu_name                 = $paramsArray['name'];
                        $user->usu_lastname             = $paramsArray['lastname'];
                        $user->usu_identity             = $paramsArray['identity'];
                        $user->usu_email                = $paramsArray['mail'];
                        $user->usu_phone                = $paramsArray['phone'];
                        $user->usu_phone_local          = $paramsArray['phoneLocal'];
                        $user->usu_birth_date           = $paramsArray['birthDate'];
                        $user->usu_username             = $paramsArray['username'];
                        $user->usu_pswd                 = $pwd;
                        $user->usu_mail_account         = $paramsArray['mailAccount'];
                        $user->urol_idRol               = $idRol;
                        $user->usu_isTerms              = $paramsArray['terms'];
                        $user->usu_isAuthorized         = 0;
                        $user->usts_idStatus            = 1;
                        $user->usu_verification_code    = $code;

                        // var_dump($user);
                        $user->save(); // Guardar usuario en la db

                        $idUser = $user->usu_idUser;

                        if(!isset($idUser) && empty($idUser)) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en el registro.',
                            );
                        }
                        else {
                            // Datos de envío
                            $shippingParams = array(
                                'country'   => $paramsArray['country'],
                                'state'     => $paramsArray['state'],
                                'city'      => $paramsArray['city'],
                                'address'   => $paramsArray['address'],
                                'cp'        => $paramsArray['cp'],
                                'idUser'    => $idUser,
                            );

                            $shipping = $this->userService->saveShippingAddress($shippingParams);

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
                                // Datos fiscales
                                $fiscalParams = array(
                                    'denomination'  => $paramsArray['denomination'],
                                    'rfc'           => $paramsArray['rfc'],
                                    'country'       => $paramsArray['countryFiscal'],
                                    'state'         => $paramsArray['stateFiscal'],
                                    'city'          => $paramsArray['cityFiscal'],
                                    'address'       => $paramsArray['addressFiscal'],
                                    'cp'            => $paramsArray['cpFiscal'],
                                    'idUser'        => $idUser,
                                );

                                $fiscal = $this->userService->saveFiscalData($fiscalParams);

                                if(!is_object($fiscal)) {
                                    // Si no se guardan los datos de envio, primero borrar estos
                                    $deletedShipping = $this->userService->deleteShippingAddress($idUser);
                                    
                                    // Si no se guardan los datos de envio borrar los datos de usuario
                                    $deleted = User::where('usu_idUser', '=', $idUser) -> delete();

                                    $data = array(
                                        'status'    => 'error',
                                        'code'      => 400,
                                        'message'   => 'Ha ocurrido un error en el registro.',
                                    );

                                }
                                else {
                                    // $data = array(
                                    //     'status' => 'success',
                                    //     'code' => 200,
                                    //     'message' => 'El usuario se ha creado correctamente y se ha enviado el correo de verificación.',
                                    // );
                                    // // Enviar mail sobre la creacion de la cuenta
                                    // die();
                                    $sendMailCode = $this->mailController->userVerificationCode($request);

                                     // Procesar la respuesta del MailController
                                    if (isset($sendMailCode['error'])) {
                                        // $data = array(
                                        //     'status' => 'error',
                                        //     'code' => 404,
                                        //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                        // );
                                        if(isset($idUser)) {
                                            $data = array(
                                                'status' => 'success',
                                                'code' => 200,
                                                'message' => 'El usuario se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
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
                                            'message'   => 'El usuario se ha creado correctamente y se ha enviado el correo de verificación.',
                                        );
                                        
                                    }
                                    else {
                                        // $data = array(
                                        //     'status' => 'error',
                                        //     'code' => 500,
                                        //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                        // );
                                        
                                        if(isset($idUser)) {
                                            $data = array(
                                                'status' => 'success',
                                                'code' => 200,
                                                'message' => 'El usuario se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
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
                            }
                        }

                    } catch (QueryException $e) {
                        // $errorCode = $e->getCode();
                        // $errorMessage = $e->getMessage();
                        // Log::error("Error on signup. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en el registro.',
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

    // Buscar email para comprobar el email
    public function searchMail(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);

        $params         = json_decode($json); // Objeto
        $paramsArray    = json_decode($json, true); // Array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray); // Limpiar datos del array
            
            $validate = \Validator::make($paramsArray, [
                'mail'          => 'required | email',
                'search'         => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en la busqueda.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                try {
                    $userData = User::where([
                        ['usu_email', '=', $params->mail]
                    ])->first();

                    if(!isset($userData) || empty($userData)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 422,
                            'message'   => 'No se encontraron resultados para la busqueda',
                        );
                    }
                    else {
                        // $data = array(
                        //     'status'    => 'success',
                        //     'code'      => 200,
                        //     'message'   => 'Se han encontrado coincidencias para la busqueda.',
                        // );
                        // Enviar mail de codigo
                        $sendMailCode = $this->mailController->userVerificationCode($request);

                            // Procesar la respuesta del MailController
                        if (isset($sendMailCode['error'])) {
                            // $data = array(
                            //     'status' => 'error',
                            //     'code' => 404,
                            //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                            // );
                            if(isset($userData)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'Se han encontrado coincidencias para la busqueda, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
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
                                'message'   => 'Se han encontrado coincidencias para la busqueda y se ha enviado el correo de verificación.',
                            );
                            
                        }
                        else {
                            // $data = array(
                            //     'status' => 'error',
                            //     'code' => 500,
                            //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                            // );
                            
                            if(isset($userData)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'Se han encontrado coincidencias para la busqueda, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
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
                        'message'   => 'Ha ocurrido un error en el registro.',
                    );
                }
                
            }
            return response()->json($data, $data['code']);
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

    // Validar código de verificacion enviado al e-mail
    public function validateVerificationCode(Request $request ) {
        // Recoger datos usuario
        $json = $request->input('json', null);
        
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array
            
            $validate = \Validator::make($paramsArray, [
                'mail'          => 'required | email',
                'code'          => 'required',
                'isCreated'     => 'required',
                'isRecover'     => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en la validación.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                if($params->isCreated == 1) {
                    $validateCreated = \Validator::make($paramsArray, [
                        'name'          => 'required',
                        'lastname'      => 'required',
                        'username'      => 'required | alpha_num',
                        'mailAccount'   => 'required | email',
                    ]);

                    if($validateCreated->fails()) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en la validación.',
                            'errors'    => $validateCreated->errors()
                        );
                    }
                    else {
                        $userData = User::where([
                            ['usu_username', '=', $params->username],
                            ['usu_email', '=', $params->mail]
                        ])->first();

                        $dbUserCode = $userData->usu_verification_code;

                        if($params->code === $dbUserCode) {
                            // Save validation flag usu_isVerificated
                            $paramsUpdate = array (
                                "usu_isVerificated"  => 1,
                                "usu_isAuthorized"  => 1,
                            );

                            $userUpdate = User::where('usu_idUser', $userData->usu_idUser)
                                ->update($paramsUpdate);

                            if($userUpdate || $userUpdate == 1) {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'Se ha validado correctamente el código de verificación.',
                                );

                                
                            }
                            else {

                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 405,
                                    'message'   => 'Ha ocurrido un error al validar el código',
                                );
                            }
                        }
                        else {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 422,
                                'message'   => 'El código de verificación es incorrecto.',
                            );
                        }
                    }
                }
                else {
                    if($params->isRecover == 0) {
                        $validateCreated = \Validator::make($paramsArray, [
                            'rolKey'    => 'required',
                            'rol'       => 'required',
                        ]);
                        if($validateCreated->fails()) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en la validación.',
                                'errors'    => $validateCreated->errors()
                            );
                        }
                        else {
                            $userData = User::where([
                                ['usu_email', '=', $params->mail],
                                ['urol_idRol', '=', $params->rolKey],
                            ])->first();
    
                            $dbUserCode = $userData->usu_verification_code;
    
                            if($params->code === $dbUserCode) {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'Se ha validado correctamente el código de verificación.',
                                );
                            }
                            else {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 422,
                                    'message'   => 'El código de verificación es incorrecto.',
                                );
                            }
                        }
                    }
                    else {
                        $userData = User::where([
                            ['usu_email', '=', $params->mail],
                        ])->first();

                        $dbUserCode = $userData->usu_verification_code;

                        if($params->code === $dbUserCode) {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'Se ha validado correctamente el código de verificación.',
                            );
                        }
                        else {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 422,
                                'message'   => 'El código de verificación es incorrecto.',
                            );
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

    // Validar URL del e-mail (cuenta creada por admin) desde el panel gestion de usuarios
    public function validateUrl(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'mail'          => 'required | email',
                'rol'           => 'required ',
                'rolKey'        => 'required ',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en el registro.',
                    'errors'    => $validate->errors()
                );
            }
            else{
                $userData = User::
                    where('usu_email', '=', $paramsArray['mail'])
                    ->where('urol_idRol', '=', $paramsArray['rolKey'])
                    ->first();

                if(!empty($userData)) {
                    if($userData->usu_isVerification == 1 && $userData->usu_isVerificated == 0) {
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'La URL es correcta',
                        );
                    }
                    else if($userData->usu_isVerification == 1 && $userData->usu_isVerificated == 1){
                        $data = array(
                            'status'    => 'error',
                            'code'      => 409,
                            'message'   => 'El email ya ha sido verificado',
                        );
                    }
                    else if($userData->usu_isVerification == 1 && $userData->usu_isVerificated == 1){
                        $data = array(
                            'status'    => 'error',
                            'code'      => 409,
                            'message'   => 'El email ya ha sido verificado',
                        );
                    }
                }
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 422,
                        'message'   => 'El mail no existe',
                    );
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
    
    // Registro de una nueva cuenta en el sitio, cuando se hace la validacion de URL
    public function userConfigureAccount(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
        
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'name'  => 'required',
                'lastname'  => 'required',
                'mail'      => 'required | email',
                'rol'       => 'required',
                'rolKey'    => 'required',
                
                'username'  => 'required | alpha_num | unique:users,usu_username',
                'pwd'       => 'required',
                'terms'     => 'required',
            ],
            [
                'mail.unique'       => 'El email ya ha sido registrado.',
                'username.unique'   => 'El nombre de usuario ya existe.',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en el registro.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $pwd = hash('sha256', $params->pwd);    //Cifrado de contraseña
                
                $user = User::where([
                    ['urol_idRol', '=', $params->rolKey],
                    ['usu_email', '=', $params->mail]
                ])->first();

                try {
                    $updateParams = array(
                        'usu_username'      => $paramsArray['username'],
                        'usu_pswd'          => $pwd,
                        'usu_isVerificated' => 1,
                        'usu_isTerms'       => $paramsArray['terms'],
                    );

                    $update= User::where('usu_idUser', '=', $user->usu_idUser)
                        ->update($updateParams);
    
                    if(!isset($update) && empty($update)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en la actualización de datos.',
                        );
                    }
                    else {
                        $paramsMail = array(
                            'name'      => $user->usu_name,
                            'lastname'  => $user->usu_lastname,
                            'mail'      => $user->usu_email,
                            // 'rolEnc'    => $rolEnc,
                        );

                        
                        // Send email that its created
                        // (new MailController)->userConfigureAccount($paramsMail);
                        $sendMail = $this->mailController->userConfigureAccount($paramsMail);
                        
                        // var_dump($sendMail);
                        // die();
                        // Procesar la respuesta del MailController
                        if (isset($sendMail['error'])) {
                            // $data = array(
                            //     'status' => 'error',
                            //     'code' => 404,
                            //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                            // );
                            if(isset($update)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'El usuario se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
                                );
                            }
                            else {
                                $data = array(
                                    'status' => 'error',
                                    'code' => 400,
                                    'message' => 'Error al enviar el correo: ' . $sendMail['error'],
                                );
                            }
                        }
                        elseif ($sendMail['status'] === 'success') {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'El usuario se ha creado correctamente y se ha enviado el correo de verificación.',
                            );
                            
                        }
                        else {
                            // // $data = array(
                            // //     'status' => 'error',
                            // //     'code' => 500,
                            // //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                            // // );
                            
                            if(isset($update)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'El usuario se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
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
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error en la actualización de datos.',
                    );
                }
            }
            return response()->json($data, $data['code']);
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

    // Login de usuarios
    public function login(Request $request) {
        $jwtAuth = new \App\Helpers\JwtAuth(); // Llamando al alias con la barra delante
        
        $json = $request->input('json', null);
        
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array
                
            $validate = \Validator::make($paramsArray, [
                'mail'  => 'required|email',
                'pwd'   => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en la validación.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $pwd =  hash('sha256', $params->pwd); // Cifrado de contraseña

                // Devolver token o datos
                $signin = $jwtAuth->login($params->mail, $pwd);

                    
                if(!empty($params->getToken)) {
                    $signin = $jwtAuth->signin($params->mail, $pwd, true);
                }
                return response()->json($signin, 200);
            }
            return response()->json($data, $data['code']);
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

    // Guardar contraseña nueva del usuario
    public function resetPassword(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
        
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'mail'          => 'required | email',
                'pwd'           => 'required',
                'codeValidate'  => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en el registro.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $pwd = hash('sha256', $params->pwd); // Cifrado de contraseña
                
                $user = User::where([
                    ['usu_email', '=', $params->mail]
                ])->first();

                try {
                    $updateParams = array(
                        'usu_pswd'          => $pwd,
                        'usu_isVerificated' => 1,
                    );

                    $update= User::where('usu_idUser', '=', $user->usu_idUser)
                        ->update($updateParams);
    
                    if(!isset($update) && empty($update)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 422,
                            'message'   => 'Ha ocurrido un error en la actualización de contraseña.',
                        );
                    }
                    else {
                        $paramsMail = array(
                            // 'name'      => $user->usu_name,
                            // 'lastname'  => $user->usu_lastname,
                            'mail'      => $user->usu_email,
                        );

                        $sendMail = $this->mailController->userResetPassword($paramsMail);
                        
                        // Procesar la respuesta del MailController
                        if (isset($sendMail['error'])) {
                            // $data = array(
                            //     'status' => 'error',
                            //     'code' => 404,
                            //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                            // );
                            if(isset($update)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'La contraseña se ha actualizado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
                                );
                            }
                            else {
                                $data = array(
                                    'status' => 'error',
                                    'code' => 422,
                                    'message' => 'Error al enviar el correo: ' . $sendMail['error'],
                                );
                            }
                        }
                        elseif ($sendMail['status'] === 'success') {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'La contraseña se ha actualizado correctamente y se ha enviado el correo de verificación.',
                            );
                            
                        }
                        else {
                            // // $data = array(
                            // //     'status' => 'error',
                            // //     'code' => 500,
                            // //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                            // // );
                            
                            if(isset($update)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'La contraseña se ha actualizado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
                                );
                            }
                            else {
                                $data = array(
                                    'status' => 'error',
                                    // 'code' => 500,
                                    'code' => 422,
                                    'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                );
                            }
                        }
                    }
                } catch (QueryException $e) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error en la actualización de datos.',
                    );
                }
            }
            return response()->json($data, $data['code']);
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


    
    // **************************************************
    // *                    AUTH                        *
    // **************************************************

    //Actualizar perfil de usuario ()
    public function updateProfile(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos por post
        $json = $request->input('json', null);
        
        $params         = json_decode($json);
        $paramsArray    = json_decode($json, true);
    
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'name'          => 'required',
                'mail'          => 'required | email',
                'lastname'      => 'required',
                'phone'         => 'required',
                'isBS'          => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en el registro.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                if($params->isBS == 1) {
                    $validateBuyerSeller = \Validator::make($paramsArray, [
                        'middlename'    => 'nullable',
                        'lastname2'     => 'nullable',
                        'birthdate'     => 'required',
                        'country'       => 'required',
                    ]);
                    if($validateBuyerSeller->fails()) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en el registro.',
                            'errors'    => $validate->errors()
                        );
                    }
                    else {
                        try {
                            $paramsUserUpdate = array (
                                "usu_name"          => $params->name,
                                "usu_middle_name"   => $params->middlename,
                                "usu_lastname"      => $params->lastname,
                                "usu_lastname2"     => $params->lastname2,
                                "usu_birth_date"    => $params->birthdate,
                                "usu_phone"         => $params->phone,
                            );

                            $userUpdate = User::where('usu_idUser', $user->usu_idUser)
                                ->update($paramsUserUpdate);

                            if(!isset($userUpdate) && empty($userUpdate)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error en la actualización de datos.',
                                );
                            }
                            else {
                                $newUser = User::
                                    where([
                                        'usu_idUser' => $user->usu_idUser,
                                        'usu_email'  => $user->usu_email,
                                    ])
                                    ->first();
                                        
                                $newToken = $jwtAuth->encode($jwtAuth->generateToken($newUser));
                                // var_dump($newToken);

                                $newIdentity = $jwtAuth->decode($newToken);
                                // var_dump($newIdentity);
                                
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'Los datos se han actualizado exitosamente',
                                    'user'      => $user,
                                    // 'changes'   => $paramsArray
                                    'token'      => $newToken,
                                    'identity'   => $newIdentity
                                );
                            }

                        } catch (QueryException $e) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en la actualización de datos.',
                            );
                        }
                    }
                }
                else {
                    try {
                        $paramsUserUpdate = array (
                            "usu_name"          => $params->name,
                            "usu_lastname"      => $params->lastname,
                            // "usu_email"         => $params->mail,
                            "usu_phone"         => $params->phone,
                        );

                        $userUpdate = User::where('usu_idUser', $user->usu_idUser)
                            ->update($paramsUserUpdate);

                        if(!isset($userUpdate) && empty($userUpdate)) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en la actualización de datos.',
                            );
                        } else {
                            $newUser = User::
                                where([
                                    'usu_idUser' => $user->usu_idUser,
                                    'usu_email'  => $user->usu_email,
                                ])
                                ->first();
                            // var_dump($newUser);
            
                            $newToken = $jwtAuth->encode($jwtAuth->generateToken($newUser));
                            // var_dump($newToken);

                            $newIdentity = $jwtAuth->decode($newToken);
                            // var_dump($newIdentity);

                            // Devolver array con resultado
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'Los datos se han actualizado exitosamente',
                                'user'      => $user,
                                // 'changes'   => $paramsArray
                                'token'      => $newToken,
                                'identity'   => $newIdentity
                            );
                        }
                    } catch (QueryException $e) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en la actualización de datos.',
                        );
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


    
    // **************************************************
    // *                    ADMIN                       *
    // **************************************************

    // Obtener todos los usuarios
    public function getAllUsers(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        
        $user = $jwtAuth->checkToken($token, true);
        
        $users = User::
            with(
                [
                    'userAddressShipping',
                    'userAddressShipping.userShippingCountry', 
                    'userAddressShipping.userShippingState', 
                    'userFiscalData',
                    'userFiscalData.userFiscalCountry', 
                    'userFiscalData.userFiscalState', 
                ]
            )
        ->
            whereNot('usu_idUser', $user->usu_idUser)
        ->
            get()
        ->load('userRol')
        ->load('userStatus')
        ->load('userLog')
        ;
        if(!empty($users)){
            foreach ($users as $user) {
                if($user->usu_middle_name){
                    $user->usu_fullname = trim($user->usu_name). ' ' . trim($user->usu_middle_name) . ' ' . trim($user->usu_lastname) . ' '. trim($user->usu_lastname2);
                }
                else {
                    $user->usu_fullname = trim($user->usu_name). ' ' . trim($user->usu_lastname) . ' '. trim($user->usu_lastname2);
                }

                // ADDRESS
                if(isset($user->userAddressShipping) && !empty($user->userAddressShipping)) {
                    foreach ($user->userAddressShipping as $address) {
                        $cveCity = $address->usad_city;
                        $isoState = $address->usad_state;
    
                        $result = State::join('cities', 'cities.sta_iso_alpha2', '=', 'states.sta_iso_alpha2')
                            ->where('cities.cit_clave', $cveCity)
                            ->where('states.sta_iso_alpha2', $isoState)
                            ->first();
                        
                        $address['user_shipping_city'] = [
                            'cit_clave' => $result->cit_clave,
                            'cit_nombre' => $result->cit_nombre,
                            'sta_iso_alpha2' => $result->sta_iso_alpha2,
                        ];
                    }
                }

                // FISCAL
                if(isset($user->userFiscalData) && !empty($user->userFiscalData)) {
                    foreach ($user->userFiscalData as $fiscal) {
                        $cveCity = $fiscal->ufdt_city;
                        $isoState = $fiscal->ufdt_state;
    
                        $result = State::join('cities', 'cities.sta_iso_alpha2', '=', 'states.sta_iso_alpha2')
                            ->where('cities.cit_clave', $cveCity)
                            ->where('states.sta_iso_alpha2', $isoState)
                            ->first();
    
                        $fiscal['user_fiscal_city'] = [
                            'cit_clave' => $result->cit_clave,
                            'cit_nombre' => $result->cit_nombre,
                            'sta_iso_alpha2' => $result->sta_iso_alpha2,
                        ];
                    }
                }
            }
            $data = array(
                'users' => $users,
            );
        }
        else {
            $data = array(
                'users' => [],
            );
        }
        return response()->json($data);
    }
    
    // Obtener usuario determinado por su ID
    public function getUserByID(Request $request, $id) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        $users = User::
            with(
                [
                    'userAddressShipping',
                    'userAddressShipping.userShippingCountry', 
                    'userAddressShipping.userShippingState', 
                    'userFiscalData',
                    'userFiscalData.userFiscalCountry', 
                    'userFiscalData.userFiscalState', 
                ]
            )
        ->
            where('usu_idUser', $id)
        ->
            get()
        ->load('userRol')
        ->load('userStatus')
        ->load('userLog')
        ;

        if(!empty($users)){
            foreach ($users as $user) {
                if($user->usu_middle_name){
                    $user->usu_fullname = trim($user->usu_name). ' ' . trim($user->usu_middle_name) . ' ' . trim($user->usu_lastname) . ' '. trim($user->usu_lastname2);
                }
                else {
                    $user->usu_fullname = trim($user->usu_name). ' ' . trim($user->usu_lastname) . ' '. trim($user->usu_lastname2);
                }

                // ADDRESS
                if(isset($user->userAddressShipping) && !empty($user->userAddressShipping)) {
                    foreach ($user->userAddressShipping as $address) {
                        $cveCity = $address->usad_city;
                        $isoState = $address->usad_state;
    
                        $result = State::join('cities', 'cities.sta_iso_alpha2', '=', 'states.sta_iso_alpha2')
                            ->where('cities.cit_clave', $cveCity)
                            ->where('states.sta_iso_alpha2', $isoState)
                            ->first();
                        
                        $address['user_shipping_city'] = [
                            'cit_clave' => $result->cit_clave,
                            'cit_nombre' => $result->cit_nombre,
                            'sta_iso_alpha2' => $result->sta_iso_alpha2,
                        ];
                    }
                }

                // FISCAL
                if(isset($user->userFiscalData) && !empty($user->userFiscalData)) {
                    foreach ($user->userFiscalData as $fiscal) {
                        $cveCity = $fiscal->ufdt_city;
                        $isoState = $fiscal->ufdt_state;
    
                        $result = State::join('cities', 'cities.sta_iso_alpha2', '=', 'states.sta_iso_alpha2')
                            ->where('cities.cit_clave', $cveCity)
                            ->where('states.sta_iso_alpha2', $isoState)
                            ->first();
                        
                        $fiscal['user_fiscal_city'] = [
                            'cit_clave' => $result->cit_clave,
                            'cit_nombre' => $result->cit_nombre,
                            'sta_iso_alpha2' => $result->sta_iso_alpha2,
                        ];
                    }
                }
            }
            $data = array(
                'users' => $users,
            );
        }
        else {
            $data = array(
                'users' => [],
            );
        }
        return response()->json($data);
    }

    // Autorizar al usuario
    public function authorizeUser(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'usu_idUser'        => 'required',
                'usu_email'         => 'required',
                'usu_username'      => 'nullable ',
                'usu_isAuthorized'  => 'required ',
                'usu_name'          => 'required ',
                'usu_lastname'      => 'required ',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al intentar bloquear/desbloquear ',
                    'errors'    => $validate->errors()
                );
            }
            else{
                $paramsUpdate = array (
                    "usu_isAuthorized"  => $params->usu_isAuthorized,
                );

                $userUpdate = User::where('usu_idUser', $params->usu_idUser)
                    ->update($paramsUpdate);

                if($userUpdate || $userUpdate == 1) {
                    $user = User::where('usu_idUser', $params->usu_idUser)->first();

                    $paramsMail = array(
                        'name'          => $user->usu_name,
                        'lastname'      => $user->usu_lastname,
                        'mail'          => $user->usu_email,
                        'statusAccount' => $user->usu_isAuthorized,
                    );

                    $sendMailAuthorize = $this->mailController->userAuthorizedByAdmin($paramsMail);
                    
                    // Procesar la respuesta del MailController
                    if (isset($sendMailAuthorize['error'])) {
                        if(isset($userUpdate)) {
                            $data = array(
                                'status' => 'success',
                                'code' => 200,
                                'message' => 'El usuario se ha creado bloqueado/desbloqueado exitosamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailAuthorize['error'],
                            );
                        }
                        else {
                            $data = array(
                                'status' => 'error',
                                'code' => 400,
                                'message' => 'Error al enviar el correo: ' . $sendMailAuthorize['error'],
                            );
                        }
                    }
                    elseif ($sendMailAuthorize['status'] === 'success') {
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'El usuario se ha bloqueado/desbloqueado exitosamente',
                        );
                    }
                    else {
                        if(isset($userUpdate)) {
                            $data = array(
                                'status' => 'success',
                                'code' => 200,
                                'message' => 'El usuario se ha creado bloqueado/desbloqueado exitosamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailAuthorize['error'],
                            );
                        }
                        else {
                            $data = array(
                                'status' => 'error',
                                'code' => 400,
                                'message' => 'Ha ocurrido un error inesperado al enviar el correo de autorización.',
                            );
                        }
                    }
                }   
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al intentar bloquear/desbloquear al usuario',
                    );
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

    // Activar al usuario
    public function activateUser(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'usu_idUser'        => 'required',
                'usu_email'         => 'required',
                'usu_username'      => 'nullable ',
                'usts_idStatus'     => 'required ',
                'usu_name'          => 'required ',
                'usu_lastname'      => 'required ',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al intentar activar/inactivar ',
                    'errors'    => $validate->errors()
                );
            }
            else{
                $paramsUpdate = array (
                    "usts_idStatus"  => $params->usts_idStatus,
                );

                $userUpdate = User::where('usu_idUser', $params->usu_idUser)
                    // ]);
                    ->update($paramsUpdate);

                if($userUpdate || $userUpdate == 1) {
                    $user = User::where('usu_idUser', $params->usu_idUser)->first();

                    $paramsMail = array(
                        'name'          => $user->usu_name,
                        'lastname'      => $user->usu_lastname,
                        'mail'          => $user->usu_email,
                        'statusAccount' => $user->usts_idStatus,
                    );

                    // Send email that its being authorized/non authorized
                    $sendMailAuthorize = $this->mailController->userAuthorizedByAdmin($paramsMail);

                    $data = array(
                        'status'    => 'success',
                        'code'      => 200,
                        'message'   => 'El usuario se ha activado/inactivado exitosamente',
                    );
                    
            
                    // Procesar la respuesta del MailController
                    if (isset($sendMailAuthorize['error'])) {
                        if(isset($userUpdate)) {
                            $data = array(
                                'status' => 'success',
                                'code' => 200,
                                'message' => 'El usuario se ha creado activado/inactivado exitosamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailAuthorize['error'],
                            );
                        }
                        else {
                            $data = array(
                                'status' => 'error',
                                'code' => 400,
                                'message' => 'Error al enviar el correo: ' . $sendMailAuthorize['error'],
                            );
                        }
                    }
                    elseif ($sendMailAuthorize['status'] === 'success') {
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'El usuario se ha activado/inactivado exitosamente',
                        );
                    }
                    else {
                        if(isset($userUpdate)) {
                            $data = array(
                                'status' => 'success',
                                'code' => 200,
                                'message' => 'El usuario se ha creado activado/inactivado exitosamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailAuthorize['error'],
                            );
                        }
                        else {
                            $data = array(
                                'status' => 'error',
                                'code' => 400,
                                'message' => 'Ha ocurrido un error inesperado al enviar el correo de activación.',
                            );
                        }
                    }
                }   
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al intentar activar/inactivar al usuario',
                    );
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

    // Actualizar al usuario del panel por ID
    public function updateUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos por post
        $json = $request->input('json', null);
        
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);

        if(!empty($params) && !empty($paramsArray)) {
            $validate = \Validator::make($paramsArray, [
                'usu_idUser'        => 'required',
                'usu_username'      => 'nullable',
                'usu_email'         => 'required',
                'usu_email2'        => 'nullable',
                'urol_idRol'        => 'required',
                'usu_phone'         => 'required',
                'isSellerBuyer'     => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en la actualización de datos',
                    'errors'    => $validate->errors()
                );
            }
            else {
                if($params->isSellerBuyer == 1) {
                    $validateSellerBuyer = \Validator::make($paramsArray, [
                        'idAddress'         => 'required',
                        'country'           => 'required',
                        'state'             => 'required',
                        'city'              => 'required',
                        'address'           => 'required',
                        'cp'                => 'required',

                        'idAddressFiscal'   => 'required',
                        'denomination'      => 'required',
                        'countryFiscal'     => 'required',
                        'stateFiscal'       => 'required',
                        'cityFiscal'        => 'required',
                        'addressFiscal'     => 'required',
                        'cpFiscal'          => 'required',
                    ]);

                    if($validateSellerBuyer->fails()) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en la actualización de datos',
                            'errors'    => $validateSellerBuyer->errors()
                        );
                    }
                    else {
                        try {
                            $paramsUserUpdate = array (
                                "usu_email2"    => $params->usu_email2,
                                "urol_idRol"    => $params->urol_idRol,
                                "usu_phone"     => $params->usu_phone,
                            );
                            
                            $userUpdate = User::where('usu_idUser', $params->usu_idUser)
                                ->update($paramsUserUpdate);

                            if(!isset($userUpdate) && empty($userUpdate)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error en la actualización de datos.',
                                );
                            }
                            else {
                                $paramsShippingUpdate = array (
                                    "usad_country"  => $params->country,
                                    "usad_state"    => $params->state,
                                    "usad_city"     => $params->city,
                                    "usad_address"  => $params->address,
                                    "usad_cp"       => $params->cp,
                                );


                                $shippingUpdate = $this->userService->updateShippingAddress($paramsShippingUpdate, $params->idAddress);

                                if(!isset($shippingUpdate) && empty($shippingUpdate)) {
                                    $data = array(
                                        'status'    => 'error',
                                        'code'      => 400,
                                        'message'   => 'Ha ocurrido un error en la actualización de datos, no sen actualizado por completo.',
                                    );
                                }
                                else {
                                    $paramsFiscalUpdate = array (
                                        "ufdt_denomination" => $params->denomination,
                                        "ufdt_country"      => $params->countryFiscal,
                                        "ufdt_state"        => $params->stateFiscal,
                                        "ufdt_city"         => $params->cityFiscal,
                                        "ufdt_address"      => $params->addressFiscal,
                                        "ufdt_cp"           => $params->cpFiscal,
                                    );

                                    
                                    $fiscalUpdate = $this->userService->updatFiscalData($paramsFiscalUpdate, $params->idAddressFiscal);

                                    if(!isset($fiscalUpdate) && empty($fiscalUpdate)) {
                                        $data = array(
                                            'status'    => 'error',
                                            'code'      => 400,
                                            'message'   => 'Ha ocurrido un error en la actualización de datos, no sen actualizado por completo.',
                                        );
                                    }
                                    else {
                                        $data = array(
                                            'status'    => 'success',
                                            'code'      => 200,
                                            'message'   => 'Los datos se han actualizado exitosamente',
                                        );
                                    }
                                }
                            }
                        } catch (QueryException $e) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en la actualización de datos.',
                            );
                        }
                    }
                }
                else {
                    $paramsUserUpdate = array (
                        "usu_email2"    => $params->usu_email2,
                        "urol_idRol"    => $params->urol_idRol,
                        "usu_phone"     => $params->usu_phone,
                    );

                    $userUpdate = User::where('usu_idUser', $params->usu_idUser)
                        ->update($paramsUserUpdate);
                    

                    if($userUpdate || $userUpdate == 1) {
                       
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'Los datos se han actualizado exitosamente',
                        );
                         
                    }
                    else {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 402,
                            'message'   => 'Ha ocurrido un error en la actualización de datos',
                            'errors'    => $validate->errors()
                        );
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

    // Agregar un nuevo usuario
    public function addNewUser(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'name'          => 'required',
                'lastname'      => 'required',
                'mail'          => 'required | email | unique:users,usu_email',
                'rol'           => 'required ',
                'rolKey'        => 'required ',
            ],
            [
                'mail.unique'   => 'El email ya ha sido registrado.',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en el registro.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                try {
                    $user = new User();
                    $user->usu_name             = $paramsArray['name'];
                    $user->usu_lastname         = $paramsArray['lastname'];
                    $user->usu_email            = $paramsArray['mail'];
                    $user->urol_idRol           = $paramsArray['rolKey'];
                    $user->usu_isAuthorized     = 1;
                    $user->usu_isVerification   = 1;
                    $user->usu_isVerificated    = 0;
    
                    $user->save();
                    
                    $idUser = $user->usu_idUser;
                    
                    if(!isset($idUser) && empty($idUser)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en el registro.',
                        );
                    }
                    else {$jwtAuth = new \App\Helpers\JwtAuth();
                    
                        $info = array(
                            'mail'      => $paramsArray['mail'],
                            'name'      => $paramsArray['name'],
                            'lastname'  => $paramsArray['lastname'],
                            'rolKey'    => $paramsArray['rolKey'],
                            'rol'       => $paramsArray['rol'],
                        );
        
                        $infoEnc = $jwtAuth->encode($info);
        
                        $paramsMail = array(
                            'name'      => $paramsArray['name'],
                            'lastname'  => $paramsArray['lastname'],
                            'mail'      => $paramsArray['mail'],
                            'info'      =>  $infoEnc,
                            'rol'       => $paramsArray['rol'],
                        );
    
                        // Send email that its created
                        // (new MailController)->userRegisterAccountByAdmin($paramsMail);
                        $sendMail = $this->mailController->userRegisterAccountByAdmin($paramsMail);
    
                        // Procesar la respuesta del MailController
                        if (isset($sendMail['error'])) {
                            // $data = array(
                            //     'status' => 'error',
                            //     'code' => 404,
                            //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                            // );
                            if(isset($idUser)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'El usuario se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
                                );
                            }
                            else {
                                $data = array(
                                    'status' => 'error',
                                    'code' => 400,
                                    'message' => 'Error al enviar el correo: ' . $sendMail['error'],
                                );
                            }
                        }
                        elseif ($sendMail['status'] === 'success') {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'El usuario se ha creado correctamente y se ha enviado el correo de verificación.',
                            );
                            
                        }
                        else {
                            // // $data = array(
                            // //     'status' => 'error',
                            // //     'code' => 500,
                            // //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                            // // );
                            
                            if(isset($idUser)) {
                                $data = array(
                                    'status' => 'success',
                                    'code' => 200,
                                    'message' => 'El usuario se ha creado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
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
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error en el registro.',
                    );
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
