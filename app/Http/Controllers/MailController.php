<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

use Mail;
use App\Mail\DemoMail;
use App\Mail\UserVerificationCodeMail;
use App\Models\User;
use App\Http\Controllers\UserController;

class MailController extends Controller
{
    public function userVerificationCode(Request $request) {
        // echo 'testing
        // ';
        // Recoger datos usuario}
        $json = $request->input('json', null);
    
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array

        // var_dump($paramsArray);
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);
            
            $name = $params->name;
            $lastname = $params->lastname;
            $username = $params->username;
            $mail = $params->mail;
            $mailAccount = $params->mailAccount;
            // $code = $params->code;
            
            $user = User::where([
                ['usu_username', '=', $username],
                ['usu_email', '=', $mail]
            ])->first();

            $code = $user->usu_verification_code;
            // var_dump($code);
            // die();

            Mail::to($mailAccount)
                ->send(new UserVerificationCodeMail($name, $lastname, $code));
                // ->queue(new UserVerificationCodeMail($name, $lastname, $code));
        
            $data = array(
                'status' => 'success',
                'code' => 200,
                'message'=> 'Se ha enviado el mail de verificación.'
            );
            

        }
        else {
            $data = array(
                'status' => 'error',
                'code' => 404,
                'message'=> 'Ha ocurrido un error al enviar el código de verificación.'
            );
        }

        // $name = $request->name;
        // $lastName = $request->lastName;
        // $mail = $request->mail;
        // $code = $request->code;
        

       return $data;

    }
    public function userResendVerificationCode(Request $request) {
        // echo 'testing
        // ';
        // Recoger datos usuario}
        $json = $request->input('json', null);
    
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array
        

        // var_dump($paramsArray);
        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);
            
            $name = $params->name;
            $lastname = $params->lastname;
            $username = $params->username;
            $mail = $params->mail;
            $mailAccount = $params->mailAccount;
            // $code = $params->code;
            
            
            // $controller = new UserController;
            // $code = $controller->setCode();
            $newCode = (new UserController)->setCode();

            // var_dump($newCode);


            $dataUser = User::where([
                ['usu_username', '=', $username],
                ['usu_email', '=', $mail]
            ])->first();

            // var_dump($dataUser);
            // var_dump($dataUser->usu_idUser);
            // die();
            $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
                ->update(['usu_verification_code' => $newCode]);
            
            // var_dump($user);

            if(!empty($user)){

                Mail::to($mailAccount)
                ->send(new UserVerificationCodeMail($name, $lastname, $newCode));
                // ->queue(new UserVerificationCodeMail($name, $lastname, $code));
        
                $data = array(
                    'status' => 'success',
                    'code' => 200,
                    'message'=> 'Se ha enviado el mail de verificación.'
                );
                
            }
            else {
                $data = array(
                    'status' => 'error',
                    'code' => 404,
                    'message'=> 'Ha ocurrido un error al reenviar el código de verificación.'
                );
            }
        }
        else {
            $data = array(
                'status' => 'error',
                'code' => 404,
                'message'=> 'Ha ocurrido un error al enviar el código de verificación.'
            );
        }

       return $data;

    }
}
