<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\User;

class UserController extends Controller
{
    //

    

    // Se pasan datos que se envian desde formulario
    public function pruebas(Request $request) {
        return 'Acción de pruebas de USER-CONTROLLER';
    }

    // Registro usuarios
    public function signup(Request $request) {


        // Recoger datos usuario}
        $json = $request->input('json', null);

        // decodificar los datos y los convierte a datos de php
        $params = json_decode($json); //objeto
        $params_array = json_decode($json, true);   //array

        // var_dump($params_array);
        //  die();
        
        // comprueba si tiene fallos
        if(!empty($params) && !empty($params_array)) {
            //Limpiar datos
            $params_array = array_map('trim', $params_array);   //limpia los datos del array con la funcion trim especial de php

            // Validar datos
            // con unique:{table_name} especifica que sera unico
            $validate = \Validator::make($params_array, [
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
                // return response()->json($validate->errors(), 400);
            }
            else {
                // Cifrar contraseña
                // $pwd = password_hash($params->pwd, PASSWORD_BCRYPT, ['cost' => 4] ); /// este algoritmo no genera siempre las mismas contraseñas cifra
                $pwd = hash('sha256', $params->pwd);   //la contraseña que cifre, la cifrara 4 veces 

                // comprobar is el usuario existe
                // con unique:{table_name} especifica que sera unico

                // Crear usuario  
                $user = new User();
                $user->usu_username = $params_array['username'];
                $user->usu_email = $params_array['mail'];
                $user->usu_email2 = $params_array['mail2'];
                $user->usu_pswd = $pwd;
                $user->usts_idStatus =  $params_array['status'];
                $user->urol_idRol =  $params_array['rol'];
                // $user->usu_created_date = $params_array['rol'];
                // $user->usu_updated_date = $params_array['rol'];


                // var_dump($user);
                // die();


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
/*
        // Cifrar contraseña
        $pwd = password_hash($params->pwd, PASSWORD_BCRYPT, ['cost' => 4] ); /// este algoritmo no genera siempre las mismas contraseñas cifra
        // $pwd = hash('sha256', $params->password);   //la contraseña que cifre, la cifrara 4 veces 

        // comprobar is el usuario existe
        // con unique:{table_name} especifica que sera unico
        

        // Crear usuario
        $user = new User();
        $user->username = $params_array['username'];
        $user->mail = $params_array['mail'];
        $user->mail2 = $params_array['mail2'];
        $user->pwd = $pwd;
        $user->status = $params_array['status'];
        $user->rol = $params_array['rol'];


        // Guardar usuario
        $user->save();

        // Devolver datos en json

*/

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
        $params_array = json_decode($json, true);

        // Validar datos
        // con unique:{table_name} especifica que sera unico
        $validate = \Validator::make($params_array, [
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
            // return response()->json($validate->errors(), 400);
        }
        else {

            // Cifrar password
            // $pwd =  password_hash($pass, PASSWORD_BCRYPT, ['cost' => 4] );
            // $pwd =  hash('sha256', $pass);
            $pwd =  hash('sha256', $params->pwd);

            // Devolver token o datos

            $signin = $jwtAuth->signin($params->mail, $pwd);
            if(!empty($params->getToken)) {
            // if(isset($params->getToken)) {
                $signin = $jwtAuth->signin($params->mail, $pwd, true);
            }
        }



        // return $jwtAuth->signin($mail, $pwd, true);

        // $sign =  $jwtAuth->signin($mail, $pwd, true);
        // return response()->json($sign)

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
}
