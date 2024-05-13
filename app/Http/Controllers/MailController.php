<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

use Mail;
use App\Mail\DemoMail;
use App\Mail\UserVerificationCodeMail;
use App\Mail\UserRegisterAccountMail;
use App\Mail\UserRegisterAccountMailByAdmin;
use App\Models\User;
use App\Http\Controllers\UserController;

class MailController extends Controller
{
    public function userVerificationCode_v1(Request $request) {
        $json = $request->input('json', null);
    
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);
            
            $name           = $params->name;
            $lastname       = $params->lastname;
            $username       = $params->username;
            $mail           = $params->mail;
            $mailAccount    = $params->mailAccount;
            
            $user = User::where([
                ['usu_username', '=', $username],
                ['usu_email', '=', $mail]
            ])->first();

            $code = $user->usu_verification_code;

            Mail::to($mailAccount)
                ->send(new UserVerificationCodeMail($name, $lastname, $code));
        
            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'message'   => 'Se ha enviado el mail de verificación.'
            );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el código de verificación.'
            );
        }
       return $data;
    }
    public function userVerificationCode($params) {

        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            $name           = $params['name'];
            $lastname       = $params['lastname'];
            $username       = $params['username'];
            $mail           = $params['mail'];
            $mailAccount    = $params['mailAccount'];
            
            $user = User::where([
                ['usu_username', '=', $username],
                ['usu_email', '=', $mail]
            ])->first();

            $code = $user->usu_verification_code;

            Mail::to($mailAccount)
                ->send(new UserVerificationCodeMail($name, $lastname, $code));
        
            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'message'   => 'Se ha enviado el mail de verificación.'
            );

        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el correo .'
            );
        }
       return $data;
    }

    public function userResendVerificationCode(Request $request) {
        $json = $request->input('json', null);
    
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);
            
            $name           = $params->name;
            $lastname       = $params->lastname;
            $username       = $params->username;
            $mail           = $params->mail;
            $mailAccount    = $params->mailAccount;

            $newCode = (new UserController)->setCode();

            $dataUser = User::where([
                ['usu_username', '=', $username],
                ['usu_email', '=', $mail]
            ])->first();

            $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
                ->update(['usu_verification_code' => $newCode]);
            
            if(!empty($user)){
                Mail::to($mailAccount)
                ->send(new UserVerificationCodeMail($name, $lastname, $newCode));
        
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'Se ha enviado el mail de verificación.'
                );
            }
            else {
                $data = array(
                    'status'    => 'error',
                    'code'      => 404,
                    'message'   => 'Ha ocurrido un error al reenviar el código de verificación.'
                );
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el código de verificación.'
            );
        }
       return $data;

    }

    
    public function userRegisterAccount(Request $request) {
        $json = $request->input('json', null);
    
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);
            
            $name           = $params->name;
            $lastname       = $params->lastname;
            $username       = $params->username;
            $mail           = $params->mail;
            $mailAccount    = $params->mailAccount;
            
            $user = User::where([
                ['usu_username', '=', $username],
                ['usu_email', '=', $mail]
            ])->first();

            $code = $user->usu_verification_code;

            Mail::to($mailAccount)
                ->send(new UserRegisterAccountMail($name, $lastname, $code));
        
            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'message'   => 'Se ha enviado el mail de verificación.'
            );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el código de verificación.'
            );
        }
       return $data;
    }

    // Mail cuando la cuenta es registrada por el admin
    
    public function userResendVCodeVerification(Request $request) {
        $json = $request->input('json', null);
    
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);
            
            $mail       = $params->mail;
            $rol        = $params->rol;
            $rolKey     = $params->rolKey;

            $newCode = (new UserController)->setCode();

            $dataUser = User::
            where('usu_email', '=', $paramsArray['mail'])
            ->where('urol_idRol', '=', $paramsArray['rolKey'])
            ->first();

            // print_r
            
            $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
            ->update(['usu_verification_code' => $newCode]);
            
            // var_dump($dataUser);
            // var_dump($user);
            
            if(!empty($user)){
                $name = $dataUser->usu_name;
                $lastname = $dataUser->usu_lastname;
                Mail::to($mail)
                ->send(new UserVerificationCodeMail($name, $lastname, $newCode));
        
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'Se ha enviado el mail de verificación.'
                );
            }
            else {
                $data = array(
                    'status'    => 'error',
                    'code'      => 404,
                    'message'   => 'Ha ocurrido un error al reenviar el código de verificación.'
                );
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el código de verificación.'
            );
        }
       return $data;

    }
    


    // ADMIN
    // Mail cuando la cuenta es creada por el administrador
    public function userRegisterAccountByAdmin($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);
            
            // print_r($params);

            $name       = $params['name'];
            $lastname   = $params['lastname'];
            $mail       = $params['mail'];
            $mailEnc    = $params['mailEnc'];
            $rol        = $params['rol'];
            $rolEnc        = $params['rolEnc'];

            Mail::to($mail)
                ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $rolEnc, $mailEnc));
        
            $data = array(
                'status'    => 'success',
                'code'      => 200,
            );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el correo .'
            );
        }
       return $data;
    }

}
