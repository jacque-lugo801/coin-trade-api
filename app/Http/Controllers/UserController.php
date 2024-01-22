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
                // $user->usts_idStatus            = 3;

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

                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El usuario se ha creado correctamente',
                    // // 'user' => $user //Arreglo con datos del usuario creado -QUITAR  
                    // 'user' => array(
                    //     'id' => $user->usu_idUser,
                    //     'username' => $user->usu_username,
                    //     'email' => $user->usu_email,
                    //     // 'verification_code' => $user->usu_verification_code
                    // )
                );
            }
        }
        return response()->json($data, $data['code']);
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
                'name' => 'required',
                'lastname' => 'required',
                'mail' => 'required | email',
                'username' => 'required | alpha_num',
                'mailAccount' => 'required | email',
            ]);

            
                
                $name = $params->name;
                $lastname = $params->lastname;
                $username = $params->username;
                $mail = $params->mail;
                $mailAccount = $params->mailAccount;
                $code = $params->code;
                

            if($validate->fails()) {
                $data = array(
                    'status' => 'error',
                    'code' => 402,
                    'message'=> 'Ha ocurrido un error en la validación.',
                    'errors' => $validate->errors()
                );
            }
            else {

                $userData = User::where([
                    ['usu_username', '=', $username],
                    ['usu_email', '=', $mail]
                ])->first();

                $dbUserCode = $userData->usu_verification_code;
                // var_dump($code);
                // var_dump($dbUserCode);

                if($code === $dbUserCode) {

                    $data = array(
                        'status' => 'success',
                        'code' => 200,
                        'message'=> 'Se ha validado correctamente el código de verificación.',
                        // // 'user' => $user //Arreglo con datos del usuario creado -QUITAR  
                        // 'user' => array(
                        //     'id' => $user->usu_idUser,
                        //     'username' => $user->usu_username,
                        //     'email' => $user->usu_email,
                        //     // 'verification_code' => $user->usu_verification_code
    
                        // )

                    );
                }
                else {

                    $data = array(
                        'status' => 'error',
                        'code' => 403,
                        'message'=> 'El código de verificación es incorrecto.',
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
            'mail' => 'required|email',
            'pwd' => 'required',
        ]);

        if($validate->fails()){
            $data = array(
                'status' => 'error',
                'code' => 404,
                'message'=> 'El usuario no se ha podido loggear',
                'errors' => $validate->errors()
            );
        }
        else {
            $pwd =  hash('sha256', $params->pwd);

            // Devolver token o datos
            $signin = $jwtAuth->signin($params->mail, $pwd);

            if(!empty($params->getToken)) {
                $signin = $jwtAuth->signin($params->mail, $pwd, true);
            }
        }
        // return response()->json($signin, 200);
        return response()->json($signin, 200);
    }




    // falta

    

    public function update(Request $request){
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        $checkToken = $jwtAuth->checkToken($token);

        if($checkToken) {
            echo '<h1>Token correcto</h1>';
        }
        else {
            echo '<h1>Token incorrecto</h1>';
        }


    }


    // Generación de codigo para validacion de e-mail
    public function setCode() {
        do {
            $code = random_int(100000, 999999);
        } while (User::where("usu_verification_code", "=", $code)->first());
        return $code;
    }
}
