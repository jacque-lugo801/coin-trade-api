<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

use Mail;
use App\Mail\DemoMail;
use App\Mail\UserVerificationCodeMail;
use App\Models\User;

class MailController extends Controller
{
    public function userVerificationCode(Request $request) {
        // echo 'testing
        // ';
        // Recoger datos usuario}
        $json = $request->input('json', null);
    
        $params = json_decode($json); //objeto
        $params_array = json_decode($json, true);   //array

        // var_dump($params_array);
        if(!empty($params) && !empty($params_array)) {
            $params_array = array_map('trim', $params_array);
            
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
}
