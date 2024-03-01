<?php

namespace App\Helpers;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

use Illuminate\Support\Facades\DB;

use App\Models\User;
use App\Models\UserRol;
use App\Models\UserStatus;
use App\Models\UserShippingAddress;

use App\Models\Country;
use App\Models\State;
use App\Models\City;

class JwtAuth {

    public $key;

    public function __construct(){
        $this->key = '_#C01N-TR4D3#_';
    }

    public function signin($mail, $pwd, $getToken = null) {
        // Buscar si existe el usuarios con las credenciales
        $user = User::where([
            'usu_email' => $mail,
            'usu_pswd'  => $pwd
        ])
        ->first()

        // ->load('userRol')
        // ->load('userStatus')
        // ->load('userAddress')
        // ->load('userFiscal')
        ;

        // print_r('<pre>');
        // print_r($user);
        // print_r('</pre>');
        // die();

        // Comprobar si las credenciales son correctas
        $signin = false;

        if(is_object($user)) {
            $signin = true;
        }

        if($signin) {
            if($user->usu_isAuthorized === 0 && $user->usts_idStatus === 3) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 403,
                    'message'   => 'La cuenta aún no ha sido aprobada por el administrador.'
                );
            }
            else {

                $token = $this->generateToken($user);
                // var_dump($token);
                // die();
                // // Obtener el rol del ususario
                // $rol = UserRol::where([
                //     'urol_idRol' => $user->urol_idRol,
                // ])->first();
                // $status = UserStatus::where([
                //     'usts_idStatus' => $user->usts_idStatus,
                // ])->first();
                // $address = UserShippingAddress::where([
                //     'usu_idUser' => $user->usu_idUser,
                //     // 'usu_idUser' => '3',
                // ])->first();


                // var_dump($address);

                // if($address){

                //     $country = Country::where([
                //         'coun_iso_alpha2' => $address->usad_country,
                //         // 'usu_idUser' => '3',
                //     ])->first();
                    
                //     // $state = State::where([
                //     //     'sta_iso_alpha2' => $address->usad_state,
                //     //     // 'usu_idUser' => '3',
                //     // ])->first();

                //     // $city = State::where([
                //     //     'sta_iso_alpha2' => $address->usad_state,
                //     //     // 'usu_idUser' => '3',
                //     // ])->first();


                //     // var_dump($city);
                //     // die();
                // }
                // else {

                // }
                // die();

                // Generar token con los datos del usuario identificado

                // $token = array(
                //     'usu_idUser'        => $user->usu_idUser,
                //     'usu_name'          => $user->usu_name,
                //     'usu_middle_name'    => $user->usu_middle_name,
                //     'usu_lastname'      => $user->usu_lastname,
                //     'usu_lastname2'     => $user->usu_lastname2,
                //     'usu_phone'         => $user->usu_phone,
                //     'usu_phone_local'         => $user->usu_phone_local,
                //     'usu_birth_date'     => $user->usu_birth_date,

                //     'usu_username'      => $user->usu_username,
                //     'usu_email'          => $user->usu_email,
                //     'usu_isTerms'          => $user->usu_isTerms,
                //     'usu_isAuthorized'          => $user->usu_isAuthorized,
                //     'usu_created_date'          => $user->usu_created_date,
                //     'usu_updated_date'          => $user->usu_updated_date,

                //     'urol_idRol'          => $rol->urol_idRol,
                //     'urol_name'          => $rol->urol_name,
                //     'urol_description'          => $rol->urol_description,

                //     'usts_idStatus'          => $status->usts_idStatus,
                //     'usts_name'          => $status->usts_name,
                //     'usts_description'          => $status->usts_description,

                //     // 'usad_country'          => $address->usad_country,
                //     // 'usad_state'          => $address->usad_state,
                //     // 'usad_city'          => $address->usad_city,
                //     // 'usad_address'          => $address->usad_address,
                //     // 'usad_isDefault'          => $address->usad_isDefault,

                //     // 'usts_idStatus'          => $rol->usts_idStatus,

                //     // 'usu_mail_account'         => $user->usu_mail_account,

                //     // 'status'        => $user->usts_idStatus,
                //     // 'status'        => $status->usts_name,
                //     // 'rol'           => $user->urol_idRol,
                //     // 'rol'           => $rol->urol_name,
                //     'iat'           => time(),//fecha en que se ha creado el token
                //     'exp'           => time() + (7 * 24 * 60 * 60) //cuando va a caducar el token (aqui caduca en una semana)
                // );

                // if($address){
                //     // echo 'Hay data';
                //     // $token['usad_country']    = $address->usad_country;
                //     // $token['usad_state']      = $address->usad_state;
                //     // $token['usad_city']       = $address->usad_city;
                //     // $token['usad_address']    = $address->usad_address;
                //     // $token['usad_isDefault']  = $address->usad_isDefault;

                //     $token['coun_name']         = $country->coun_name;
                //     $token['coun_iso_alpha2']   = $country->coun_iso_alpha2;

                //     // $token['sta_name']         = $state->sta_name;
                //     // $token['sta_iso_alpha2']   = $state->sta_iso_alpha2;

                //     // $token['sta_name']         = $state->sta_name;
                //     // $token['sta_iso_alpha2']   = $state->sta_iso_alpha2;

                // }
                // else {
                //     // echo 'no hay data';
                    
                //     // $token['usad_country']    = NULL;
                //     // $token['usad_state']      = NULL;
                //     // $token['usad_city']       = NULL;
                //     // $token['usad_address']    = NULL;
                //     // $token['usad_isDefault']  = NULL;
                // }


                // print_r('<pre>');
                // print_r($token);
                // print_r('</pre>');
                // die();


                // $token = $user;
                // $token->iat = time(); //fecha en que se ha creado el token
                // $token->exp = time() + (7 * 24 * 60 * 60);  //cuando va a caducar el token (aqui caduca en una semana)


                // $jwt = JWT::encode($token, $this->key, 'HS256'); // HS256 algoritmo de cifrado
                $jwt = $this->encode($token);
                // var_dump($jwt);

                $identity = $this->decode($jwt);
                // var_dump($identity);

                // die();

                // if(is_null($getToken)) {
                //     //si es nulo solo devuelve el token
                //     $data = $jwt;
                // }
                // else {
                //     //si no es nulo, que devuelva la decodificacion del token
                //     $data = $decoded;
                // }

                // Devolver los datos decodificados o el token, en funcion de un parametro
                $data = array(
                    'token'     => $jwt,
                    'identity'  => $identity
                );
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Las credenciales son incorrectas.'
            );
        }

        return  $data;
    }



    public function generateToken($user) {
        // echo 'generating token';

        // Obtener el rol del ususario
        $rol = UserRol::where([
            'urol_idRol' => $user->urol_idRol,
        ])->first();
        $status = UserStatus::where([
            'usts_idStatus' => $user->usts_idStatus,
        ])->first();
        $address = UserShippingAddress::where([
            'usu_idUser' => $user->usu_idUser,
            // 'usu_idUser' => '3',
        ])->first();

        
        if($address){

            $country = Country::where([
                'coun_iso_alpha2' => $address->usad_country,
                // 'usu_idUser' => '3',
            ])->first();
            
            // $state = State::where([
            //     'sta_iso_alpha2' => $address->usad_state,
            //     // 'usu_idUser' => '3',
            // ])->first();

            // $city = State::where([
            //     'sta_iso_alpha2' => $address->usad_state,
            //     // 'usu_idUser' => '3',
            // ])->first();


            // var_dump($city);
            // die();
        }
        else {

        }

        
        // Generar token con los datos del usuario identificado

        $token = array(
            'usu_idUser'        => $user->usu_idUser,
            'usu_name'          => $user->usu_name,
            'usu_middle_name'    => $user->usu_middle_name,
            'usu_lastname'      => $user->usu_lastname,
            'usu_lastname2'     => $user->usu_lastname2,
            'usu_phone'         => $user->usu_phone,
            'usu_phone_local'         => $user->usu_phone_local,
            'usu_birth_date'     => $user->usu_birth_date,

            'usu_username'      => $user->usu_username,
            'usu_email'          => $user->usu_email,
            'usu_isTerms'          => $user->usu_isTerms,
            'usu_isAuthorized'          => $user->usu_isAuthorized,
            'usu_created_date'          => $user->usu_created_date,
            'usu_updated_date'          => $user->usu_updated_date,

            'urol_idRol'          => $rol->urol_idRol,
            'urol_name'          => $rol->urol_name,
            'urol_description'          => $rol->urol_description,

            'usts_idStatus'          => $status->usts_idStatus,
            'usts_name'          => $status->usts_name,
            'usts_description'          => $status->usts_description,

            // 'usad_country'          => $address->usad_country,
            // 'usad_state'          => $address->usad_state,
            // 'usad_city'          => $address->usad_city,
            // 'usad_address'          => $address->usad_address,
            // 'usad_isDefault'          => $address->usad_isDefault,

            // 'usts_idStatus'          => $rol->usts_idStatus,

            // 'usu_mail_account'         => $user->usu_mail_account,

            // 'status'        => $user->usts_idStatus,
            // 'status'        => $status->usts_name,
            // 'rol'           => $user->urol_idRol,
            // 'rol'           => $rol->urol_name,
            'iat'           => time(),//fecha en que se ha creado el token
            'exp'           => time() + (7 * 24 * 60 * 60) //cuando va a caducar el token (aqui caduca en una semana)
        );

        if($address){
            // echo 'Hay data';
            // $token['usad_country']    = $address->usad_country;
            // $token['usad_state']      = $address->usad_state;
            // $token['usad_city']       = $address->usad_city;
            // $token['usad_address']    = $address->usad_address;
            // $token['usad_isDefault']  = $address->usad_isDefault;

            $token['coun_name']         = $country->coun_name;
            $token['coun_iso_alpha2']   = $country->coun_iso_alpha2;

            // $token['sta_name']         = $state->sta_name;
            // $token['sta_iso_alpha2']   = $state->sta_iso_alpha2;

            // $token['sta_name']         = $state->sta_name;
            // $token['sta_iso_alpha2']   = $state->sta_iso_alpha2;

        }
        else {
            // echo 'no hay data';
            
            // $token['usad_country']    = NULL;
            // $token['usad_state']      = NULL;
            // $token['usad_city']       = NULL;
            // $token['usad_address']    = NULL;
            // $token['usad_isDefault']  = NULL;
        }


        return $token;


    }

    public function encode($data) {
        return JWT::encode($data, $this->key, 'HS256'); // HS256 algoritmo de cifrado
    }

    public function decode($data) {
        return JWT::decode($data, new Key($this->key, 'HS256'));
    }

    // falta
    // Comprobar que el token es correcto y devolver dtos del usuario identificado
    public function checkToken($jwt, $getIdentity = false) {
        $auth = false;

        try {
            $jwt = str_replace('"', '', $jwt);
            // $decoded = JWT::decode($jwt, new Key($this->key, 'HS256'));
            $decoded =  $this->decode($jwt);
        } catch (\UnexpectedValueException $e){
            $auth = false;
        } catch (\DomainException $e) {
            $auth = false;
        }

        // if (!empty($decoded) && is_object($decoded) && isset($decoded->username)) {
        if (!empty($decoded) && is_object($decoded) && isset($decoded->usu_username)) {
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
