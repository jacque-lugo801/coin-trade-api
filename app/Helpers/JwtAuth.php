<?php

namespace App\Helpers;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

use Illuminate\Support\Facades\DB;

use App\Models\User;

class JwtAuth {

    public $key;

    public function __construct(){
        $this->key = '_#C01N-TR4D3#_';
    }

    public function signin($mail, $pwd, $getToken = null) {

        // Buscar si existe el usuario con la credencial
        $user = User::where([
            'usu_email' => $mail,
            'usu_pswd' => $pwd
        ])->first(); //Obtener el primer registro
            
        // Comprobar si son correctas (objeto)
        $signin = false;

        if(is_object($user)) {
            $signin = true;
        }

        // Generar tokenc con los datos del usuario identificado
        if($signin) {
            $token = array(
                'username' => $user->usu_username,
                'mail' => $user->usu_email,
                'mail2' => $user->usu_email2,
                'status' => $user->usts_idStatus,
                'rol' => $user->urol_idRol,
                'iat'      => time(),//fecha en que se ha creado el token
                'exp'      => time() + (7 * 24 * 60 * 60) //cuando va a caducar el token (aqui caduca en una semana)
            );

            $jwt = JWT::encode($token, $this->key, 'HS256'); //HS256 algoritmo de cifrado
            // $decoded = JWT::decode($jwt, $this->key, ['HS256']);
            $decoded = JWT::decode($jwt, new Key($this->key, 'HS256'));

            // Devolver los datos decodificados o el token, en funcion de un parametro
            if(is_null($getToken)) {
                //si es nulo solo devuelve el token
                $data = $jwt;
            }
            else {
                //si no es nulo, que devuelva la decodificacion del token
                $data = $decoded;
            }
        }
        else {
            $data = array(
                'status' => 'error',
                // 'code' => 404,
                'message'=> 'Login incorrecto'
            );
        }

        return  $data;
    }

    public function checkToken($jwt, $getIdentity = false) {
        $auth = false;
        
        try {
            $jwt = str_replace('"', '', $jwt);
            $decoded = JWT::decode($jwt, new Key($this->key, 'HS256'));    
        } catch (\UnexpectedValueException $e){
            $auth = false;
        } catch (\DomainException $e) {
            $auth = false;
        }
        
 
        if (!empty($decoded) && is_object($decoded) && isset($decoded->username)) {
            $auth = true;          
        } else {
            $auth = false;
        }
        
        if($getIdentity){
            return $decoded;  
        }

        return $auth;

    }
}


