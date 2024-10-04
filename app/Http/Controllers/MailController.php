<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Config;
 
use Mail;
use App\Mail\DemoMail;
use App\Mail\UserVerificationCodeMail;
use App\Mail\UserRegisterAccountMail;
use App\Mail\UserRegisterAccountMailByAdmin;
use App\Mail\UserAuthorizedByAdmin;
use App\Mail\UserActivatedByAdmin;
use App\Mail\UserConfigureAccount;
use App\Mail\ProductApproveByAdmin;
use App\Mail\ProductRequestUpgradeByAdmin;
use App\Mail\UserResetPassword;
use App\Mail\ProductUpload;

use App\Models\User;
use App\Http\Controllers\UserController;

use App\Services\UserService;


use Money\Currencies\ISOCurrencies;
use Money\Currency;
use Money\Formatter\DecimalMoneyFormatter;
use Money\Money;

class MailController extends Controller
{
    public $imgLogo;
    protected $userService;

    public function __construct(
        UserService     $userService,
    ) {
        $this->imgLogo          = public_path('images/[Project Files] Logo_CoinTrade.png');
        $this->userService      = $userService;
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
                    ->send(new UserVerificationCodeMail($params->name, $params->lastname, $newCode, $this->imgLogo, $params->isCreated, $params->isRecover));
            
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
                if($params->isRecover == 0) {
                    $dataUser = User::where([
                        ['urol_idRol', '=', $params->rolKey],
                        ['usu_email', '=', $params->mail]
                    ])->first();
    
                    $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
                        ->update(['usu_verification_code' => $newCode]);
    
                    if(!empty($user)) {
                        Mail::to($params->mail)
                        ->send(new UserVerificationCodeMail($params->name, $params->lastname, $newCode, $this->imgLogo, $params->isCreated, $params->isRecover));
                
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
                        ['usu_email', '=', $params->mail]
                    ])->first();
    
                    $user= User::where('usu_idUser', '=', $dataUser->usu_idUser)
                        ->update(['usu_verification_code' => $newCode]);

    
                    if(!empty($user)) {
                        Mail::to($params->mail)
                        ->send(new UserVerificationCodeMail($dataUser->name, $dataUser->lastname, $newCode, $this->imgLogo, $params->isCreated, $params->isRecover));
                
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
    
    // E-mail para notificación a usuario por configuracion de cuenta (a traves de validacion de URL)
    public function userConfigureAccount($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            $name       = $params['name'];
            $lastname   = $params['lastname'];
            $mail       = $params['mail'];

            $website = Config::get('app.web_url');

            Mail::to($mail)
                // ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $rolEnc, $mailEnc, $website));
                ->send(new UserConfigureAccount($name, $lastname, $website, $this->imgLogo));
        
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'Se ha enviado el mail de configuración de cuenta.'
                );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el mail de configuración de cuenta.'
            );
        }
       return $data;
    }
    
    // E-mail para notificación a usuario por actualización de contraseña
    public function userResetPassword($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            // $name       = $params['name'];
            // $lastname   = $params['lastname'];
            $mail       = $params['mail'];

            Mail::to($mail)
                // ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $rolEnc, $mailEnc, $website));
                ->send(new UserResetPassword($this->imgLogo));
        
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'Se ha enviado el mail de configuración de cuenta.'
                );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el mail de configuración de cuenta.'
            );
        }
       return $data;
    }



    // **************************************************
    // *                    AUTH                        *
    // **************************************************
    
    // E-mail para notificación de producto guardado
    public function productUpload($productInfo, $userInfo) {
        if(!empty($productInfo) || !empty($userInfo)) {
            $product    = $productInfo->first();
            $user       = $userInfo;
            
            $cost       = number_format($product->prod_unit_cost, 2, '.', ',');
            $comission  = number_format($product->prod_commission, 2, '.', ',');
            $total      = number_format($product->prod_total, 2, '.', ',');

            Mail::to($user->usu_email)
                ->send(new ProductUpload($user, $product, $cost, $comission, $total, $this->imgLogo));
        
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
                'message'   => 'Ha ocurrido un error al enviar el mail de configuración de cuenta.'
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

    // E-mail para notificación cuando la cuenta ha sido creada por el administrador
    public function userRegisterAccountByAdmin($params) {
        if(!empty($params)) {
            $paramsArray = array_map('trim', $params);

            $name       = $params['name'];
            $lastname   = $params['lastname'];
            $mail       = $params['mail'];
            $account    = $params['info'];
            $rol        = $params['rol'];

            // var_dump($this->webURL);
            $website = Config::get('app.web_url');
            // $website = Config::get('app.web_url');
            // var_dump($website);

            Mail::to($mail)
                // ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $rolEnc, $mailEnc, $website));
                ->send(new UserRegisterAccountMailByAdmin($name, $lastname, $rol, $account, $website, $this->imgLogo));
        
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'Se ha enviado el mail de nueva cuenta.'
                );
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'Ha ocurrido un error al enviar el mail de nuevo cuenta .'
            );
        }
       return $data;
    }
    
    // E-mail para notificación de mejora al producto
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
    
    // E-mail para notificación de producto aprobado por administrador
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

}
