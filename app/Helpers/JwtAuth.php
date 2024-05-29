<?php

namespace App\Helpers;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

use Illuminate\Support\Facades\DB;

use App\Models\User;
use App\Models\UserRol;
use App\Models\UserStatus;
use App\Models\UserShippingAddress;
use App\Models\UserLog;

use App\Models\Country;
use App\Models\State;
use App\Models\City;

// use Jenssegers\Agent\Facades\Agent;
use Jenssegers\Agent\Agent;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;
use Illuminate\Http\Request;

class JwtAuth {

    public $key;
    public $keyWeb;
    public $keyWeb64;
    
    public function __construct(){
        $this->key = '_#C01N-TR4D3#_';
        $this->keyWeb = 'COIN_TRADE@2024';
        $this->keyWeb64 = base64_encode($this->keyWeb);
        // Q09JTl9UUkFERUAyMDI0
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
            // if($user->usu_isAuthorized === 0 && $user->usts_idStatus === 3) {
            if($user->usu_isAuthorized === 0) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 403,
                    'message'   => 'La cuenta aún no ha sido aprobada por el administrador.'
                );
            }
            else {
                if($user->usu_isVerificated === 0) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'La cuenta aun no se ha verificado.'
                    );
                }
                else {
                    if($user->usts_idStatus === 3) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 402,
                            'message'   => 'La cuenta ha sido suspendida.'
                        );
                    }
                    else if($user->usts_idStatus === 2) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 401,
                            'message'   => 'La cuenta ha sido dada de baja.'
                        );
                    }
                    else if($user->usts_idStatus === 1) {
                        // echo 'testing';
                        // $platform = Agent::platform();
    
                        $this->saveLogInfo($user);
                        
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

    public function saveLogInfo($user) {
        
        $agent = new Agent();
        
        $device = $agent->device();
        $os = $agent->platform();
        $browser = $agent->browser();
        $isDesktop = $agent->isDesktop();
        $isPhone = $agent->isPhone();
        $isRobot = $agent->isRobot();;
        

        try {
            
            $client = new Client();
            $ipAddress = file_get_contents('https://api.ipify.org');
            
            $response =  $client->request('GET', "https://ipapi.co/{$ipAddress}/json/");

            $data = json_decode($response->getBody(), true);

            $ipCity = $data['city'];
            $ipRegion = $data['region'];
            $ipRegionCode = $data['region_code'];
            // $ipCountry = $data['country'];
            $ipCountrName = $data['country_name'];
            $ipCountryCode = $data['country_code'];
            // $ipCountryCodeISO3 = $data['country_code_iso3'];
            $ipLatitude = $data['latitude'];
            $ipLongitude = $data['longitude'];
        }
        catch(RequestException $e) {
            $ipAddress = null;
            $ipCity = null;
            $ipRegion = null;
            $ipRegionCode = null;
            // $ipCountry = $data['country'];
            $ipCountrName = null;
            $ipCountryCode = null;
            // $ipCountryCodeISO3 = $data['country_code_iso3'];
            $ipLatitude = null;
            $ipLongitude = null;
        }
        catch(\Exception $e) {


            // $ipAddress = file_get_contents('https://api.ipify.org');
            $ipAddress = null;
            $ipCity = null;
            $ipRegion = null;
            $ipRegionCode = null;
            // $ipCountry = $data['country'];
            $ipCountrName = null;
            $ipCountryCode = null;
            // $ipCountryCodeISO3 = $data['country_code_iso3'];
            $ipLatitude = null;
            $ipLongitude = null;
        }
        
        // print_r($data);


        
        // die();
        $userLog = new UserLog();
        // $userLog->
        $userLog->ulog_device = $device;
        $userLog->ulog_os = $os;
        $userLog->ulog_browser = $browser;
        $userLog->ulog_isDesktop = $isDesktop;
        $userLog->ulog_isPhone = $isPhone;
        $userLog->ulog_isRobot = $isRobot;
        $userLog->ulog_ip = $ipAddress;
        $userLog->ulog_ip_city = $ipCity;
        $userLog->ulog_ip_region = $ipRegion;
        $userLog->ulog_ip_region_code = $ipRegionCode;
        $userLog->ulog_ip_country_name = $ipCountrName;
        $userLog->ulog_ip_country_code = $ipCountryCode;
        $userLog->ulog_ip_latitude = $ipLatitude;
        $userLog->ulod_ip_longitude = $ipLongitude;
        // $userLog->ulog_fingerprint = ;
        $userLog->usu_idUser = $user->usu_idUser;
        $userLog->save();
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
        ])->get();

        $userLog = UserLog::where ([
            'usu_idUser' => $user->usu_idUser,
            // 'usu_idUser' => '3',
        ])
        ->orderBy('ulog_idLog', 'desc')
        ->first();
        // print_r($address);
        
        // var_dump(count($address));
        // print_r('<pre>');
        // print_r($address);
        // print_r('</pre>');
        // die();
        
        if($address){
            
            foreach($address as $ads){
                // echo '--------';
                // print_r('<pre>');
                // print_r($ads);
                // print_r('</pre>');
                // echo '--------';
                // // .push();
                if($ads->usad_isDefault == 1) {
                    // echo '<h2>HERE</h2>';
                    $country = Country::where([
                        'coun_iso_alpha2' => $ads->usad_country,
                        // 'usu_idUser' => '3',
                    ])->first();
                }
                // if(!empty($coin)){
                //     // array_push($types, $coin);

            }
            
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

        // die();
        
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
            'ulog_date_access'  => $userLog->ulog_date_access,
            // 'device'          => $device,
            // 'platform'          => $platform,
            // 'browser'          => $browser,
            // 'isDesktop'          => $isDesktop,
            // 'isPhone'          => $isPhone,
            // 'isRobot'          => $isRobot,

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
