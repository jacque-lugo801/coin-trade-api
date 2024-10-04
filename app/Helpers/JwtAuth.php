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
use Illuminate\Database\QueryException;
use Exception;

class JwtAuth {
    public $key;
    public $keyWeb;
    public $keyWeb64;
    public $passEncode;
    
    public function __construct(){
        $this->key = '_#C01N-TR4D3#_';
        $this->keyWeb = 'COIN_TRADE@2024';
        $this->keyWeb64 = base64_encode($this->keyWeb);

        $this->passEnconde = 'Q09JTl9UUkFERUAyMDI0';
        // Q09JTl9UUkFERUAyMDI0
    }
    
    // Cifrar con algoritmo HS256
    public function encode($data) {
        return JWT::encode($data, $this->key, 'HS256'); // HS256 algoritmo de cifrado
    }

    // Decodificacion de cifrado HS256
    public function decode($data) {
        return JWT::decode($data, new Key($this->key, 'HS256'));
    }

    // Loggear usuario 
    public function login($mail, $pwd, $getToken = null) {
        // Buscar si existe el usuarios con las credenciales
        $user = User::where([
            'usu_email' => $mail,
            'usu_pswd'  => $pwd
        ])
        ->first();

        // Comprobar si las credenciales son correctas
        $signin = false;

        if(is_object($user)) {
            $signin = true;
        }
        if($signin) {
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
                        'code'      => 409,
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
                        $logged = $this->saveLogInfo($user);

                        if(!is_object($logged)) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al intentar ingresar.',
                            );
                        }
                        else {
                            // Generar token
                            $token = $this->generateToken($user);

                            // $jwt = JWT::encode($token, $this->key, 'HS256'); // HS256 algoritmo de cifrado
                            $jwt = $this->encode($token);
                            // var_dump($jwt);
    
                            $identity = $this->decode($jwt);
                            // var_dump($identity);
            
                            // Devolver los datos decodificados o el token, en funcion de un parametro
                            $data = array(
                                'token'     => $jwt,
                                'identity'  => $identity
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
                'message'   => 'Las credenciales son incorrectas.'
            );
        }

        return  $data;
    }


    // Obtener datos para loggear a usuario, y guardar ese log
    public function saveLogInfo($user) {
        $agent = new Agent();
        
        $device     = $agent->device();
        $os         = $agent->platform();
        $browser    = $agent->browser();
        $isDesktop  = $agent->isDesktop();
        $isPhone    = $agent->isPhone();
        $isRobot    = $agent->isRobot();;

        try {
            $client     = new Client();
            $ipAddress  = file_get_contents('https://api.ipify.org');
            
            $response =  $client->request('GET', "https://ipapi.co/{$ipAddress}/json/");

            $data = json_decode($response->getBody(), true);

            $ipCity         = $data['city'] ?? null;
            $ipRegion       = $data['region'] ?? null;
            $ipRegionCode   = $data['region_code'] ?? null;
            $ipCountrName   = $data['country_name'] ?? null;
            $ipCountryCode  = $data['country_code'] ?? null;
            $ipLatitude     = $data['latitude'] ?? null;
            $ipLongitude    = $data['longitude'] ?? null;
        }
        catch(RequestException $e) {
            // $errorCode = $e->getCode();
            // $errorMessage = $e->getMessage();
            // Log::error("Error on login. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
            $ipAddress      = null;
            $ipCity         = null;
            $ipRegion       = null;
            $ipRegionCode   = null;
            $ipCountrName   = null;
            $ipCountryCode  = null;
            $ipLatitude     = null;
            $ipLongitude    = null;
        }
        catch(\Exception $e) {
            // $errorCode = $e->getCode();
            // $errorMessage = $e->getMessage();
            // Log::error("Error on login. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
            $ipAddress      = null;
            $ipCity         = null;
            $ipRegion       = null;
            $ipRegionCode   = null;
            $ipCountrName   = null;
            $ipCountryCode  = null;
            $ipLatitude     = null;
            $ipLongitude    = null;
        }
        
        try {
            $userLog = new UserLog();
            
            $userLog->ulog_device       = $device;
            $userLog->ulog_os           = $os;
            $userLog->ulog_browser      = $browser;
            $userLog->ulog_isDesktop    = $isDesktop;
            $userLog->ulog_isPhone      = $isPhone;
            $userLog->ulog_isRobot      = $isRobot;
            $userLog->ulog_ip           = $ipAddress;
            $userLog->ulog_ip_city      = $ipCity;
            $userLog->ulog_ip_region    = $ipRegion;
            $userLog->ulog_ip_region_code   = $ipRegionCode;
            $userLog->ulog_ip_country_name  = $ipCountrName;
            $userLog->ulog_ip_country_code  = $ipCountryCode;
            $userLog->ulog_ip_latitude      = $ipLatitude;
            $userLog->ulod_ip_longitude     = $ipLongitude;
            // $userLog->ulog_fingerprint   = ;
            $userLog->usu_idUser            = $user->usu_idUser;
            
            $userLog->save();

            return $userLog;
        } catch (QueryException $e) {
            // $errorCode = $e->getCode();
            // $errorMessage = $e->getMessage();
            // Log::error("Error on saveSignupAddress. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
            // return response()->json(['error' => 'Ocurrió un error en la consulta.'], 500);
            return 0;
        }
    }

    // Generacion de token
    public function generateToken($user) {
        // Obtener el rol del ususario
        $rol = UserRol::where([
            'urol_idRol' => $user->urol_idRol,
        ])->first();

        // Obtener el estatus del ususario
        $status = UserStatus::where([
            'usts_idStatus' => $user->usts_idStatus,
        ])->first();
        
        // Obtenerel ultimo log del usuario
        $userLog = UserLog::where ([
            'usu_idUser' => $user->usu_idUser,
        ])
        ->orderBy('ulog_idLog', 'desc')
        ->first();

        /*
        if($user->urol_idRol == 2 || $user->urol_idRol == 3) {
            $token = $this->generateBuyerSeller($user, $rol, $status, $userLog);
        }
        else {
            $token = $this->generateAdmin($user, $rol, $status, $userLog);
        }
        */
        if(strtolower($rol->urol_name) == strtolower('Comprador') || strtolower($rol->urol_name) == strtolower('Vendedor')) {
            $token = $this->generateBuyerSeller($user, $rol, $status, $userLog);
        }
        else {
            $token = $this->generateAdmin($user, $rol, $status, $userLog);
        }
        return $token;
    }

    // Generacion de token para comprador/vendedor
    public function generateBuyerSeller($user, $rol, $status, $userLog) {
        // Generar token con los datos del usuario identificado
        $token = array(
            'usu_idUser'        => $user->usu_idUser,
            'usu_name'          => $user->usu_name,
            'usu_middle_name'   => $user->usu_middle_name,
            'usu_lastname'      => $user->usu_lastname,
            'usu_lastname2'     => $user->usu_lastname2,
            'usu_phone'         => $user->usu_phone,
            'usu_phone_local'   => $user->usu_phone_local,
            'usu_birth_date'    => $user->usu_birth_date,

            'usu_username'      => $user->usu_username,
            'usu_email'         => $user->usu_email,
            'usu_isTerms'       => $user->usu_isTerms,
            'usu_isAuthorized'  => $user->usu_isAuthorized,
            'usu_created_date'  => $user->usu_created_date,
            'usu_updated_date'  => $user->usu_updated_date,

            'urol_idRol'        => $rol->urol_idRol,
            'urol_name'         => $rol->urol_name,
            'urol_description'  => $rol->urol_description,

            'usts_idStatus'     => $status->usts_idStatus,
            'usts_name'         => $status->usts_name,
            'usts_description'  => $status->usts_description,
            'ulog_date_access'  => $userLog->ulog_date_access,
            'iat'               => time(),  // Fecha en que se ha creado el token
            'exp'               => time() + (7 * 24 * 60 * 60) // Fecha de caducidad del token (aqui caduca en una semana)
        );
        
        $address = UserShippingAddress::where([
            'usu_idUser' => $user->usu_idUser
        ])->get();

        if($address && count($address) > 0){
            foreach($address as $ads) {
                if($ads->usad_isDefault == 1) {
                    $country = Country::where([
                        'coun_iso_alpha2' => $ads->usad_country,
                    ])->first();
                }
            }
        }
        
        if($address){
            $token['coun_name']         = $country->coun_name;
            $token['coun_iso_alpha2']   = $country->coun_iso_alpha2;
        }

        return $token;
    }

    // Generacion de token para administrador,soporte, etc.
    public function generateAdmin($user, $rol, $status, $userLog) {
        // Generar token con los datos del usuario identificado
        $token = array(
            'usu_idUser'        => $user->usu_idUser,
            'usu_name'          => $user->usu_name,
            'usu_middle_name'   => $user->usu_middle_name,
            'usu_lastname'      => $user->usu_lastname,
            'usu_lastname2'     => $user->usu_lastname2,
            'usu_phone'         => $user->usu_phone,
            'usu_phone_local'   => $user->usu_phone_local,
            // 'usu_birth_date'    => $user->usu_birth_date,

            'usu_username'      => $user->usu_username,
            'usu_email'         => $user->usu_email,
            'usu_isTerms'       => $user->usu_isTerms,
            'usu_isAuthorized'  => $user->usu_isAuthorized,
            'usu_created_date'  => $user->usu_created_date,
            'usu_updated_date'  => $user->usu_updated_date,

            'urol_idRol'        => $rol->urol_idRol,
            'urol_name'         => $rol->urol_name,
            'urol_description'  => $rol->urol_description,

            'usts_idStatus'     => $status->usts_idStatus,
            'usts_name'         => $status->usts_name,
            'usts_description'  => $status->usts_description,

            'ulog_date_access'  => $userLog->ulog_date_access,
            'iat'               => time(),  // Fecha en que se ha creado el token
            'exp'               => time() + (7 * 24 * 60 * 60) // Fecha de caducidad del token (aqui caduca en una semana)
        );
        return $token;
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
