<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\User;
use App\Models\Country;
use App\Models\State;
use App\Models\City;

use App\Models\UserShippingAddress;
use App\Models\UserFiscalData;
use App\Http\Controllers\UserShippingAddressController;
use App\Http\Controllers\UserFiscalDataController;

use App\Http\Controllers\MailController;

use App\Models\UserRol;

use Illuminate\Validation\Rule;

class UserController extends Controller
{
    // Registro de una nueva cuenta para el sitio
    public function signup(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
        
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

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
                'denomination'  => 'required',
                'rfc'           => 'required',
                'countryFiscal' => 'required',
                'stateFiscal'   => 'required',
                'cityFiscal'    => 'required',
                'addressFiscal' => 'required',
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
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en el registro',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $pwd = hash('sha256', $params->pwd);    //Cifrado de contraseña
                
                // Tipo de usuario
                switch (strtolower($params->rol)) {
                    case 'vendedor':
                        $rol = 1;
                        break;
                    case 'comprador':
                        $rol = 2;
                        break;
                    
                    default:
                        break;
                }

                $code = $this->setCode();

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
                $user->urol_idRol               =  $rol;
                $user->usu_isTerms              = $paramsArray['terms'];
                $user->usu_isAuthorized         = 0;
                $user->usu_verification_code    = $code;

                $user->save();
                $idUser = $user->usu_idUser;
                
                //Guardar datos de envio
                $shippingParams = array(
                    'country'   => $paramsArray['country'],
                    'state'     => $paramsArray['state'],
                    'city'      => $paramsArray['city'],
                    'address'   => $paramsArray['address'],
                    'idUser'    => $idUser,
                );

                $shipping = (new UserShippingAddressController)
                    ->saveSignupAddress($shippingParams);

                    
                //Guardar datos de información fiscal
                $fiscalParams = array(
                    'denomination'  => $paramsArray['denomination'],
                    'rfc'           => $paramsArray['rfc'],
                    'country'       => $paramsArray['countryFiscal'],
                    'state'         => $paramsArray['stateFiscal'],
                    'city'          => $paramsArray['cityFiscal'],
                    'address'       => $paramsArray['addressFiscal'],
                    'idUser'        => $idUser,
                );

                //Guardar datos de envio
                $fiscal = (new UserFiscalDataController)
                    ->saveSignupFiscalData($fiscalParams);

                    
                // Send email that its created

                (new MailController)->userVerificationCode($paramsArray);

                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El usuario se ha creado correctamente',
                );
            }
        }
        return response()->json($data, $data['code']);
    }

    // Generación de codigo para validacion de e-mail
    public function setCode() {
        do {
            $code = random_int(100000, 999999);
        } while (User::where("usu_verification_code", "=", $code)->first());
        return $code;
    }

    // Validar codigo enviado para email
    public function validateVerificationCode(Request $request ) {
        // Recoger datos usuario}
        $json = $request->input('json', null);
        
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array
            
            $validate = \Validator::make($paramsArray, [
                'name'          => 'required',
                'lastname'      => 'required',
                'mail'          => 'required | email',
                'username'      => 'required | alpha_num',
                'mailAccount'   => 'required | email',
            ]);
                
                $name           = $params->name;
                $lastname       = $params->lastname;
                $username       = $params->username;
                $mail           = $params->mail;
                $mailAccount    = $params->mailAccount;
                $code           = $params->code;
                

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en la validación.',
                    'errors'    => $validate->errors()
                );
            }
            else {

                $userData = User::where([
                    ['usu_username', '=', $username],
                    ['usu_email', '=', $mail]
                ])->first();

                $dbUserCode = $userData->usu_verification_code;

                if($code === $dbUserCode) {
                    $data = array(
                        'status'    => 'success',
                        'code'      => 200,
                        'message'   => 'Se ha validado correctamente el código de verificación.',
                    );
                }
                else {

                    $data = array(
                        'status'    => 'error',
                        'code'      => 403,
                        'message'   => 'El código de verificación es incorrecto.',
                    );
                }
            }
        }
        return response()->json($data, $data['code']);
    }

    // Login de usuarios
    public function signin(Request $request) {
        $jwtAuth = new \App\Helpers\JwtAuth(); // Llamando al alias con la barra delante
        
        $json = $request->input('json', null);
        
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);

        $validate = \Validator::make($paramsArray, [
            'mail'  => 'required|email',
            'pwd'   => 'required',
        ]);

        if($validate->fails()){
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'El usuario no se ha podido loggear',
                'errors'    => $validate->errors()
            );
        }
        else {
            $pwd =  hash('sha256', $params->pwd);

            // Devolver token o datos
            $signin = $jwtAuth->signin($params->mail, $pwd);

            // var_dump($params);
            // var_dump(!empty($params->getToken));
            // die();
            if(!empty($params->getToken)) {
                $signin = $jwtAuth->signin($params->mail, $pwd, true);
            }
        }
        // return response()->json($signin, 200);
        return response()->json($signin, 200);
    }


    // Actualizar usuario
    public function update(Request $request) {
        //Comprobar si el usuario esta identificado
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        $checkToken = $jwtAuth->checkToken($token);
        
        // Recoger datos por post
        $json = $request->input('json', null);
        
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);

        if($checkToken && !empty($params) && !empty($paramsArray)) {
            // Sacar usuario identificado
            $user = $jwtAuth->checkToken($token, true);

            // Validar datos
            $validate = \Validator::make($paramsArray, [
                'name'          => 'required',
                'middlename'    => 'nullable',
                'lastname'      => 'required',
                'lastname2'     => 'nullable',
                'birthdate'     => 'required',
                'mail'          => [
                    'required',
                    'email',
                    Rule::unique('users', 'usu_email')->ignore($user->idUser, 'usu_idUser')
                ],
                // 'mail'          => 'required | email | unique:users,usu_email,$user->idUser,usu_idUser',
                'country'   => 'required',
                'phone'     => 'required',
            ],
            [
                'mail.unique'       => 'El email ya ha sido registrado.',
                'username.unique'   => 'El nombre de usuario ya existe.',
            ]);

            if ($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en la actualización',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // Quitar campos que no se van a actualizar
                // unset($paramsArray['idUser']);
                // unset($paramsArray['username']);
                // unset($paramsArray['identity']);
                // unset($paramsArray['pwd']);
                // unset($paramsArray['code']);
                // unset($paramsArray['terms']);
                // unset($paramsArray['authorized']);
                // unset($paramsArray['authorized']);
                // unset($paramsArray['status']);
                // unset($paramsArray['rol']);
                // unset($paramsArray['rememberToken']);
                // unset($paramsArray['iat']);
                // unset($paramsArray['exp']);

                // Actualizar ususario en DB
                // var_dump($user->birthdate);
                // // die();

                $paramsUserUpdate = array (
                    "usu_name"          => $params->name,
                    "usu_middle_name"   => $params->middlename,
                    "usu_lastname"      => $params->lastname,
                    "usu_lastname2"     => $params->lastname2,
                    "usu_birth_date"    => $params->birthdate,
                    "usu_email"         => $params->mail,
                    "usu_phone"         => $params->phone,
                    // "" => $params->country,
                );
                // var_dump($paramsUserUpdate);
                // die();
                $userUpdate = User::where('usu_idUser', $user->idUser)
                    // ->update([
                    //     'usu_birth_date' => $params->birthdate
                    // ]);
                    ->update($paramsUserUpdate);

                // Devolver array con resultado
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El producto se ha agregado exitosamente',
                    'user'      => $user,
                    'changes'   => $paramsArray
                );
            }
        }
        else {
            // Mensaje de error
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'El usuario no esta identificado',
            );
        }
        return response()->json($data, $data['code']);
    }

    public function updateProfile(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos por post
        $json = $request->input('json', null);
        
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);
    
        if(!empty($params) && !empty($paramsArray)) {

            // var_dump(($paramsArray));
            // die();

            $validate = \Validator::make($paramsArray, [
                'name'          => 'required',
                'mail'          => 'required | email',
                'middlename'    => 'nullable',
                'lastname'      => 'required',
                'lastname2'     => 'nullable',
                'birthdate'     => 'required',
                'phone'         => 'required',
                'country'       => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en la actualización de datos',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // var_dump(
                //     $paramsArray['middlename']
                // );
                // var_dump(
                //     $paramsArray['lastname']
                // );

                // die();

                
                $paramsUserUpdate = array (
                    "usu_name"          => $params->name,
                    "usu_middle_name"   => $params->middlename,
                    "usu_lastname"      => $params->lastname,
                    "usu_lastname2"     => $params->lastname2,
                    "usu_birth_date"    => $params->birthdate,
                    "usu_email"         => $params->mail,
                    "usu_phone"         => $params->phone,
                    // "" => $params->country,
                );
                // $paramsShippingUpdate = array(
                //     "usad_country"         => $params->phone,
                // );

                // var_dump($paramsUserUpdate);
                // var_dump($paramsUserUpdate['usu_middle_name']);
                // var_dump($user->usu_idUser);
                // die();
                $userUpdate = User::where('usu_idUser', $user->usu_idUser)
                    // ->update([
                    //     'usu_birth_date' => $params->birthdate
                    // ]);
                    ->update($paramsUserUpdate);

                // var_dump($user);
                $newUser = User::where([
                    'usu_idUser' => $user->usu_idUser,
                    'usu_email'  => $user->usu_email,
                ])
                ->first();
                // var_dump($newUser);


                $newToken = $jwtAuth->encode($jwtAuth->generateToken($newUser));
                // var_dump($newToken);
                $newIdentity = $jwtAuth->decode($newToken);
                // var_dump($newIdentity);
                // die();
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
        }
        else {
            
            $data = array(
                'status'    => 'error',
                'code'      => 405,
                'message'   => 'Ha ocurrido un error',
            );
        }
        
        return response()->json($data, $data['code']);

        
    }


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
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en el registro',
                    'errors'    => $validate->errors()
                );
            }
            else{
                // // $rol = 
                // var_dump($params);
                // die();
                

                
                $userData = User::
                    where('usu_email', '=', $paramsArray['mail'])
                    ->where('urol_idRol', '=', $paramsArray['rolKey'])
                    ->first();

                if(!empty($userData)) {

                    // var_dump($userData->usu_isVerification);
                    // var_dump($userData->usu_isVerificated);
                    if($userData->usu_isVerification == 1 && $userData->usu_isVerificated == 0) {
                        // var_dump($userData->usu_isVerificated);
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'La URL es correcta',
                            // 'errors'    => $validate->errors()
                        );
                    }
                    else {

                        $data = array(
                            'status'    => 'error',
                            'code'      => 402,
                            'message'   => 'El mail ya ha sido verificado',
                            // 'errors'    => $validate->errors()
                        );
                    }
                    // die();
                }
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 401,
                        'message'   => 'El mail no existe',
                        // 'errors'    => $validate->errors()
                    );
                }

                // print_r($userData);
                // die();
                            
                // $securityED = new \App\Helpers\SecurityED();

                
                // $s = $securityED->getString($paramsArray['mail']);
                // print_r($s);
                // die();
                // $rolName = $paramsArray['rol'];
                // $rolID = $paramsArray['rolKey'];
                // // var_dump($rolName);
                // // $rol = UserRol::
                // //     // where('urol_name', 'LIKE', '%'. strtolower($rolName) .'%')
                // //     // where('urol_name', 'LIKE', '%'. $rolName .'%')
                // //     where('urol_name', '=', $rolName)
                // //     ->first()
                // //     ;

                // // var_dump($rol->urol_idRol);
                // // die();
                // $user = new User();
                // $user->usu_name         = $paramsArray['name'];
                // $user->usu_lastname     = $paramsArray['lastname'];
                // $user->usu_email        = $paramsArray['mail'];
                // // $user->urol_idRol       = $rol->urol_idRol;
                // $user->urol_idRol       =  $paramsArray['rolKey'];
                // $user->usu_isAuthorized = 0;

                // // var_dump($paramsArray['rol']);
                // // die();
                // // var_dump($user);
                // // die();
                // $user->save();
                // // $idUser = $user->usu_idUser;
                
                // $data = array(
                //     'status'    => 'success',
                //     'code'      => 200,
                //     'message'   => 'El usuario se ha creado correctamente',
                // );
            }


        }
        return response()->json($data, $data['code']);
    }

    // Validar code for account by admin
    
    public function validateCodeAccount(Request $request ) {
        // Recoger datos usuario}
        $json = $request->input('json', null);
        
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array
            
            $validate = \Validator::make($paramsArray, [
                // 'name'          => 'required',
                // 'lastname'      => 'required',
                'mail'          => 'required | email',
                'rol'           => 'required ',
                'rolKey'        => 'required ',
            ]);
                
                $name           = $params->name;
                $lastname       = $params->lastname;
                $username       = $params->username;
                $mail           = $params->mail;
                $mailAccount    = $params->mailAccount;
                $code           = $params->code;
                

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en la validación.',
                    'errors'    => $validate->errors()
                );
            }
            else {

                $userData = User::where([
                    ['usu_username', '=', $username],
                    ['usu_email', '=', $mail]
                ])->first();

                $dbUserCode = $userData->usu_verification_code;

                if($code === $dbUserCode) {
                    $data = array(
                        'status'    => 'success',
                        'code'      => 200,
                        'message'   => 'Se ha validado correctamente el código de verificación.',
                    );
                }
                else {

                    $data = array(
                        'status'    => 'error',
                        'code'      => 403,
                        'message'   => 'El código de verificación es incorrecto.',
                    );
                }
            }
        }
        return response()->json($data, $data['code']);
    }


    // Tutorial UDEMY

    public function upload(Request $request) {

        // Recoger datos de peticion

        // Subir imagen en laravel

        // Devolver el resultado
        
        $data = array(
            'status'    => 'error',
            'code'      => 400,
            'message'   => 'Error al subir imagen',
        );

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

        // var_dump($user);
        // die();
        
        $users = User::
            with(
                [
                    'userAddressShipping',
                    'userAddressShipping.userShippingCountry', 
                    'userAddressShipping.userShippingState', 
                    'userAddressShipping.userShippingCity', 

                    'userFiscalData',
                    'userFiscalData.userFiscalCountry', 
                    'userFiscalData.userFiscalState', 
                    'userFiscalData.userFiscalCity', 

                    // 'userAddressShipping.userShippingCountry.userState'
                ],
                [
                    // 'userAddressShipping',

                ]
            )
        ->
            whereNot('usu_idUser', $user->usu_idUser)
        ->
        get()
        ->load('userRol')
        ->load('userStatus')
        ->load('userLog')
        // ->load('userAddress')
        // ->load('userFiscal')
        // ->load('userShippingCountry')
        // // ->with('userAddress.userShippingCountry')
        ;

        // $users =  User::
        // whereNot('usu_idUser', $user->usu_idUser)

        // ->with()
        // ->get()
        // ;


        if(!empty($users)){
            foreach ($users as $user) {
                if($user->usu_middle_name){
                    // $user->fullname = $user->usu_name. '' . $user->usu_middle_name .''. $user->usu_lastname . ''. $user->usu_lastname2;
                    $user->usu_fullname = trim($user->usu_name). ' ' . trim($user->usu_middle_name) . ' ' . trim($user->usu_lastname) . ' '. trim($user->usu_lastname2);

                }
                else {
                    $user->usu_fullname = trim($user->usu_name). ' ' . trim($user->usu_lastname) . ' '. trim($user->usu_lastname2);
                }

                // var_dump($user_fiscal);
                // if(empty($user->userFiscal)){
                //     $user->user_fiscal = [];
                // }
                // if(empty($user->user_fiscal)){
                //     $user->user_fiscal = [];
                // }


                // $countryFIscal = $user->user_fiscal;
                // var_dump($countryFIscal);
                // die()
                // var_dump(empty($user->user_fiscal));
                // die();
                // Get country, state, city
                // $dataCSCFiscal = $this->getDataAddress();


            }
            $data = array(
                // 'status'    => 'error',
                // 'code'      => 400,
                // 'message'   => 'Error al subir imagen',
                'users' => $users,
            );
        }
        else {

            $data = array(
                // 'status'    => 'error',
                // 'code'      => 400,
                // 'message'   => 'Error al subir imagen',
                'users' => [],
            );
        }


        
        // $data = array(
        //     'status'    => 'error',
        //     'code'      => 400,
        //     'message'   => 'Error al subir imagen',
        // );

        return response()->json($data);
    }

    public function getDataAddress($country, $state, $city) {

    }

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
                'mail.unique'       => 'El email ya ha sido registrado.',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en el registro',
                    'errors'    => $validate->errors()
                );
            }
            else{
                // $rol = 
                
                // print_r($paramsArray);
                            

                // $securityED = new \App\Helpers\SecurityED();
                
                $jwtAuth = new \App\Helpers\JwtAuth();

                $mail = array(
                    // 'mail' => $paramsArray['mail']
                    $paramsArray['mail']
                );
                
                $mailEnc = $jwtAuth->encode($mail);
                // var_dump($mailEnc);
                $rol = array(
                    'id' => $paramsArray['rolKey'],
                    'name' => $paramsArray['rol'],
                );
                $rolEnc = $jwtAuth->encode($rol);


                $paramsMail = array(
                    'name'      => $paramsArray['name'],
                    'lastname'  => $paramsArray['lastname'],
                    'mail'      => $paramsArray['mail'],
                    'mailEnc'   => $mailEnc,
                    'rol'       => $paramsArray['rol'],
                    'rolEnc'    => $rolEnc,
                );

                // Send email that its created
                (new MailController)->userRegisterAccountByAdmin($paramsMail);

                // var_dump($mail);

                // die();
                
                // $rolName = $paramsArray['rol'];
                // $rolID = $paramsArray['rolKey'];
                // var_dump($rolName);
                // $rol = UserRol::
                //     // where('urol_name', 'LIKE', '%'. strtolower($rolName) .'%')
                //     // where('urol_name', 'LIKE', '%'. $rolName .'%')
                //     where('urol_name', '=', $rolName)
                //     ->first()
                //     ;

                // var_dump($rol->urol_idRol);
                // die();
                $user = new User();
                $user->usu_name         = $paramsArray['name'];
                $user->usu_lastname     = $paramsArray['lastname'];
                $user->usu_email        = $paramsArray['mail'];
                // $user->urol_idRol       = $rol->urol_idRol;
                $user->urol_idRol       =  $paramsArray['rolKey'];
                $user->usu_isAuthorized = 0;
                $user->usu_isVerification = 1;
                $user->usu_isVerificated = 0;

                // var_dump($paramsArray['rol']);
                // die();
                // var_dump($user);
                // die();
                $user->save();
                // $idUser = $user->usu_idUser;

                
                // // Send email that its created
                // $mail = (new MailController)
                //     ->saveSignupAddress($shippingParams);

                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El usuario se ha creado correctamente',
                );
            }


        }
        return response()->json($data, $data['code']);
    }


    public function unlockUser(Request $request) {
        
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {

            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'unlock'    => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en el registro',
                    'errors'    => $validate->errors()
                );
            }
            else{
                // $rol = 
                
                // print_r($paramsArray);
                            
                $securityED = new \App\Helpers\SecurityED();

                
                $s = $securityED->getString($paramsArray['mail']);
                print_r($s);
                die();
                $rolName = $paramsArray['rol'];
                $rolID = $paramsArray['rolKey'];
                // var_dump($rolName);
                // $rol = UserRol::
                //     // where('urol_name', 'LIKE', '%'. strtolower($rolName) .'%')
                //     // where('urol_name', 'LIKE', '%'. $rolName .'%')
                //     where('urol_name', '=', $rolName)
                //     ->first()
                //     ;

                // var_dump($rol->urol_idRol);
                // die();
                $user = new User();
                $user->usu_name         = $paramsArray['name'];
                $user->usu_lastname     = $paramsArray['lastname'];
                $user->usu_email        = $paramsArray['mail'];
                // $user->urol_idRol       = $rol->urol_idRol;
                $user->urol_idRol       =  $paramsArray['rolKey'];
                $user->usu_isAuthorized = 0;

                // var_dump($paramsArray['rol']);
                // die();
                // var_dump($user);
                // die();
                $user->save();
                // $idUser = $user->usu_idUser;
                
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El usuario se ha creado correctamente',
                );
            }


        }
        return response()->json($data, $data['code']);
    }







}






