<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Notification;

use App\Models\User;

class NotificationController extends Controller
{
    //
    
    
    public function sendRequestUpgrade(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        $user = $jwtAuth->checkToken($token, true);

        if(!empty($params) && !empty($paramsArray)) {

            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                // 'name'          => 'required',
                // 'lastname'      => 'required',
                // 'mail'          => 'required | email | unique:users,usu_email',
                // 'rol'           => 'required ',
                // 'rolKey'        => 'required ',

                'idProduct'     => 'required',
                'productSku'    => 'required',
                'productName'   => 'required',
                'productType'   => 'required',
                'productTName'  => 'required',
                'idSeller'      => 'required',
                'sellerMail'    => 'required | email',
                'sellerUser'    => 'required',
                'message'       => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en el registro',
                    'errors'    => $validate->errors()
                );
            }
            else{
                // var_dump($user);

                $userDestination =  User::
                    where('usu_email', '=', $paramsArray['sellerMail'])
                    ->where('usu_username', '=', $paramsArray['sellerUser'])
                    ->first();

                    
                // var_dump($userDestination);
                
                // die();
                
                $notification = new Notification();
                $notification->not_content              = $paramsArray['message'];
                $notification->usu_idUser               = $user->usu_idUser;
                $notification->not_idUserDestination    = $userDestination->usu_idUser;
                // $user->usu_email            = $paramsArray['mail'];
                // $user->urol_idRol           = $paramsArray['rolKey'];
                // $user->usu_isAuthorized     = 1;
                // $user->usu_isVerification   = 1;
                // $user->usu_isVerificated    = 0;

                $notification->save();
                
                // // Mail
                // $jwtAuth = new \App\Helpers\JwtAuth();

                // // $mail = array(
                // //     // 'mail' => $paramsArray['mail']
                // //     $paramsArray['mail']
                // // );
                
                // // $mailEnc = $jwtAuth->encode($mail);
                // // // var_dump($mailEnc);
                // // $rol = array(
                // //     'id' => $paramsArray['rolKey'],
                // //     'name' => $paramsArray['rol'],
                // // );
                // // $rolEnc = $jwtAuth->encode($rol);

                // $info = array(
                //     'mail'      => $paramsArray['mail'],
                //     'name'      => $paramsArray['name'],
                //     'lastname'  => $paramsArray['lastname'],
                //     'rolKey'    => $paramsArray['rolKey'],
                //     'rol'       => $paramsArray['rol'],
                // );

                
                // $user = User::where('usu_email', $params->sellerMail)->first();


                $paramsMail = array(
                    'name'          => $userDestination->usu_name,
                    'lastname'      => $userDestination->usu_lastname,
                    // 'mail'          => $user->usu_email,
                    // 'sellerMail'    => $paramsArray['sellerMail'],
                    'sellerMail'    => $userDestination->usu_email,
                    // 'sellerMail'    => 'jacque.lugo801@gmail.com',
                    'productName'   => $paramsArray['productName'],
                    'message'       => $paramsArray['message'],
                );


                // var_dump($paramsMail);
                // die();

                // Send email that its created
                (new MailController)->productRequestUpgradeByAdmin($paramsMail);

                // var_dump($mail);
                
                // // Send email that its created
                // $mail = (new MailController)
                //     ->saveSignupAddress($shippingParams);

                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El usuario se ha creado correctamente',
                );
            }

        }
        return response()->json($data, $data['code']);
    }
}
