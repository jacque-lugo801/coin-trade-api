<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Config;
 
use Mail;
use App\Mail\DemoMail;
use App\Mail\UserVerificationCodeMail;
use App\Mail\UserRegisterAccountMail;
use App\Mail\UserRegisterAccountMailByAdmin;
use App\Mail\userAuthorizedByAdmin;
use App\Mail\userActivatedByAdmin;
use App\Mail\UserConfigureAccount;
use App\Mail\ProductApproveByAdmin;
use App\Mail\ProductRequestUpgradeByAdmin;

use App\Models\User;
use App\Http\Controllers\UserController;

use App\Services\UserService;

class MailController extends Controller
{
    public $imgLogo;
    protected $userService;

    public function __construct(
        UserService $userService
    ) {
        $this->imgLogo      = public_path('images/[Project Files] Logo_CoinTrade.png');
        $this->userService  = $userService;
    }

    //E-mail para envio del código de verificación
    public function userVerificationCode(Request $request) {
        $json = $request->input('json', null);
        
        $params = json_decode($json); //objeto
        $paramsArray = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);
            
            $newCode = $this->userService->setCode();

            if($params->isCreated == 1) {
                $dataUser = User::where([
                    ['usu_username', '=', $params->username],
                    ['usu_email', '=', $params->mail]
                ])->first();
    
                $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
                    ->update(['usu_verification_code' => $newCode]);
                
                if(!empty($user)){
                    Mail::to($params->mailAccount)
                    ->send(new UserVerificationCodeMail($params->name, $params->lastname, $newCode, $this->imgLogo));
            
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
            }
            else {
                $dataUser = User::where([
                    ['urol_idRol', '=', $params->rolKey],
                    ['usu_email', '=', $params->mail]
                ])->first();

                $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
                    ->update(['usu_verification_code' => $newCode]);

                if(!empty($user)) {
                    Mail::to($params->mail)
                    ->send(new UserVerificationCodeMail($params->name, $params->lastname, $newCode, $this->imgLogo));
            
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

    // E-mail para notificación de cuenta creada y/o validada
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
                ->send(new UserRegisterAccountMail($name, $lastname, $this->imgLogo));
        
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

            // $newCode = (new UserController)->setCode();
            $newCode = $this->userService->setCode();

            $dataUser = User::where([
                ['usu_username', '=', $username],
                ['usu_email', '=', $mail]
            ])->first();

            $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
                ->update(['usu_verification_code' => $newCode]);
            
            if(!empty($user)){
                Mail::to($mailAccount)
                ->send(new UserVerificationCodeMail($name, $lastname, $newCode,  $this->imgLogo));
        
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

    

    
    public function userConfigureAccount($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);
            // var_dump($params);
            // die();
            $name       = $params['name'];
            $lastname   = $params['lastname'];
            $mail       = $params['mail'];

            $website = Config::get('app.web_url');

            // var_dump($name);
            // die();
            Mail::to($mail)
                // ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $rolEnc, $mailEnc, $website));
                ->send(new UserConfigureAccount($name, $lastname, $website, $this->imgLogo));
        
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

        die();
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

    public function userVerificationCodeAccount(Request $request) {
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
                ->send(new UserVerificationCodeMail($name, $lastname, $code, $this->imgLogo));
        
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

    public function userResendVerificationCodeAccount(Request $request) {
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
                ->send(new UserVerificationCodeMail($name, $lastname, $code, $this->imgLogo));
        
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

            // $newCode = (new UserController)->setCode();
            $newCode = $this->userService->setCode();

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
                ->send(new UserVerificationCodeMail($name, $lastname, $newCode, $this->imgLogo));
        
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
    


    // **************************************************
    // *                    ADMIN                       *
    // **************************************************


    // E-mail para notificación cuando la cuenta ha sido autorizada por el administrador
    public function userAuthorizedByAdmin($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            $name           = $params['name'];
            $lastname       = $params['lastname'];
            $mail           = $params['mail'];
            $statusAccount  = $params['statusAccount'];

            Mail::to($mail)
                ->send(new UserAuthorizedByAdmin($name, $lastname, $statusAccount, $this->imgLogo));
        
            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'message'   => 'Se ha enviado el mail de autorización.'
            );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el mail de autorización.'
            );
        }
       return $data;
    }
    
    // E-mail para notificación cuando la cuenta ha sido activada por el administrador
    public function userActivatedByAdmin($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            $name           = $params['name'];
            $lastname       = $params['lastname'];
            $mail           = $params['mail'];
            $statusAccount  = $params['statusAccount'];

            Mail::to($mail)
                ->send(new userActivatedByAdmin($name, $lastname, $statusAccount, $this->imgLogo));
        
            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'message'   => 'Se ha enviado el mail de activación.'
            );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el mail de activación .'
            );
        }
       return $data;
    }



    // Mail cuando la cuenta es creada por el administrador
    public function userRegisterAccountByAdmin($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);
            
            // print_r($params);

            $name       = $params['name'];
            $lastname   = $params['lastname'];
            $mail       = $params['mail'];
            $account    = $params['info'];
            // $mailEnc    = $params['mailEnc'];
            $rol        = $params['rol'];
            // $rolEnc     = $params['rolEnc'];

            // var_dump($params);
            // var_dump($lastname);
            // var_dump($this->webURL);
            $website = Config::get('app.web_url');
            // $website = Config::get('app.web_url');
            // var_dump($website);
            // die();

            Mail::to($mail)
                // ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $rolEnc, $mailEnc, $website));
                ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $account, $website, $this->imgLogo));
        
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


    // Mail producto aprobado por administrador
    public function productAuthorizedByAdmin($params) {

        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            $name       = $params['name'];
            $lastname   = $params['lastname'];
            $mail       = $params['mail'];
            $prodName   = $params['prodName'];
            // $imageF     = public_path('products/'.$params['prodImageF']);
            // $imageF     = $params['prodImageF'];
            // $imageB     = public_path('products/'.$params['prodImageB']);
            // $imageB     = $params['prodImageB'];
            $prodTotal  = $params['prodTotal'];
            $isApprove  = $params['isApprove'];

            // $imagePath = public_path('images/[Project Files] Logo_CoinTrade.png');

            Mail::to($mail)
                // ->send(new ProductApproveByAdmin($name, $lastname, $prodName, $imageF, $imageB, $isApprove, $imageLogo));
                ->send(new ProductApproveByAdmin($name, $lastname, $prodName, $prodTotal, $isApprove, $this->imgLogo));
        
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
    // Mail solicitud mejor por administrador
    public function productRequestUpgradeByAdmin($params) {

        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            $name       = $params['name'];
            $lastname   = $params['lastname'];
            $mail       = $params['sellerMail'];
            $prodName   = $params['productName'];
            $message    = $params['message'];

            Mail::to($mail)
                // ->send(new ProductApproveByAdmin($name, $lastname, $prodName, $imageF, $imageB, $isApprove, $imageLogo));
                ->send(new ProductRequestUpgradeByAdmin($name, $lastname, $prodName, $message, $this->imgLogo));
        
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
