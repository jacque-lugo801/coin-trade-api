<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\User;

class UserController extends Controller
{
    // Registro usuarios
    public function signup(Request $request) {
        // Recoger datos usuario}
        $json = $request->input('json', null);
        
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array
        
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'name' => 'required',
                'lastname' => 'required',
                'identity' => 'required',
                'mail' => 'required | email | unique:users,usu_email',
                'phone' => 'required | numeric',
                'phoneLocal' => 'required | numeric',
                'birthDate' => 'required',
                'country' => 'required',
                'state' => 'required',
                'city' => 'required',
                'address' => 'required',
                'denomination' => 'required',
                'rfc' => 'required',
                'countryFiscal' => 'required',
                'stateFiscal' => 'required',
                'cityFiscal' => 'required',
                'addressFiscal' => 'required',
                'username' => 'required | alpha_num | unique:users,usu_username',
                'pwd' => 'required',
                'mailAccount' => 'required | email',
                'rol' => 'required ',
            ],
            [
                'mail.unique' => 'El email ya ha sido registrado.',
                'username.unique' => 'El nombre de usuario ya existe.',
            ]);
            
            // die();
            if($validate->fails()) {
                $data = array(
                    'status' => 'error',
                    'code' => 402,
                    'message'=> 'Ha ocurrido un error en el registro',
                    'errors' => $validate->errors()
                );
            }
            else {
                $pwd = hash('sha256', $params->pwd);    //Cifrado de contraseña
                
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

                //Creacion usuario
                $user = new User();
                $user->usu_username = $paramsArray['username'];
                $user->usu_email = $paramsArray['mail'];
                $user->usu_pswd = $pwd;
                // $user->urol_idRol =  $paramsArray['rol'];
                $user->urol_idRol =  $rol;
                $user->usu_verification_code =  $code;
                $user->usts_idStatus = 3;

                // var_dump($user);
                // die();
                //Guardar usuario
                $user->save();

                
                // var_dump($request);
                $data = array(
                    'status' => 'success',
                    'code' => 200,
                    'message'=> 'El usuario se ha creado correctamente',
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

    // Registro usuarios
    public function signup2(Request $request) {
        // Recoger datos usuario}
        $json = $request->input('json', null);

        // decodificar los datos y los convierte a datos de php
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array

        // comprueba si tiene fallos
        if(!empty($params) && !empty($paramsArray)) {
            //Limpiar datos
            $paramsArray = array_map('trim', $paramsArray);   //limpia los datos del array con la funcion trim especial de php

            // Validar datos
            // con unique:{table_name} especifica que sera unico
            $validate = \Validator::make($paramsArray, [
                'username' => 'required|alpha_num|unique:users,usu_username',
                'mail' => 'required|email|unique:users,usu_email',
                'mail2' => 'email',
                'pwd' => 'required',
                'status' => 'required',
                'rol' => 'required',
            ]);

            if($validate->fails()){
                $data = array(
                    'status' => 'error',
                    'code' => 404,
                    'message'=> 'Ha ocurrido un error en el registro.',
                    'errors' => $validate->errors()
                );
            }
            else {
                // Cifrar contraseña
                // $pwd = password_hash($params->pwd, PASSWORD_BCRYPT, ['cost' => 4] ); /// este algoritmo no genera siempre las mismas contraseñas cifra
                $pwd = hash('sha256', $params->pwd);   //la contraseña que cifre, la cifrara 4 veces 

                // comprobar is el usuario existe
                // con unique:{table_name} especifica que sera unico

                // Crear usuario  
                $user = new User();
                $user->usu_username = $paramsArray['username'];
                $user->usu_email = $paramsArray['mail'];
                $user->usu_email2 = $paramsArray['mail2'];
                $user->usu_pswd = $pwd;
                $user->usts_idStatus =  $paramsArray['status'];
                $user->urol_idRol =  $paramsArray['rol'];

                // Guardar usuario
                $user->save();

                $data = array(
                    'status' => 'success',
                    'code' => 200,
                    'message'=> 'El usuario se ha creado correctamente.',
                    'user' => $user //Arreglo con datos del usuario creado -QUITAR  
                );
            }
        }

        return response()->json($data, $data['code']);  //devolvemos la respuesta en formato json, pasando lo que queremos devolver y el codigo http
    }

    
    // Login usuarios
    public function signin(Request $request) {
        // $jwtAuth = new \JwtAuth(); //llamando al alias con la barra delante
        $jwtAuth = new \App\Helpers\JwtAuth();

                //         $sign =  $jwtAuth->signup($email, $password);
                // return response()->json($sign);
        
        // Recibir datos por post
        $json = $request->input('json', null);
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);

        // Validar datos
        // con unique:{table_name} especifica que sera unico
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

            // Cifrar password
            // $pwd =  password_hash($pass, PASSWORD_BCRYPT, ['cost' => 4] );
            // $pwd =  hash('sha256', $pass);
            $pwd =  hash('sha256', $params->pwd);

            // Devolver token o datos
            $signin = $jwtAuth->signin($params->mail, $pwd);

            if(!empty($params->getToken)) {
                $signin = $jwtAuth->signin($params->mail, $pwd, true);
            }
        }

        // return response()->json( $jwtAuth->signin($mail, $pwd, true), 200);
        return response()->json($signin, 200);

    }

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


    public function setCode() {
        // return random_int(100000, 999999);

        do {
            $code = random_int(100000, 999999);
            // $code = random_int(1, 4);
            // echo $code .' | ';
        } while (User::where("usu_verification_code", "=", $code)->first());
  
        return $code;
    }
}
