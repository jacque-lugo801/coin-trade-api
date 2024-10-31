<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UserFinance;

use App\Services\FinanceService;
use App\Http\Controllers\MailController;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

class UserFinanceController extends Controller
{
    protected $financeService;
    protected $mailController;

    public function __construct (
        FinanceService  $financeService,
        MailController  $mailController,
    ) {
        $this->financeService   = $financeService;
        $this->mailController   = $mailController;
    }





    
    // **************************************************
    // *                    AUTH                        *
    // **************************************************

    // Añadir cuenta
    public function addUserFinance(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos usuarios
        $json = $request->input('json', null);
                        
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'name'      => 'required',
                'clabe'     => 'required',
                'type'      => 'required ',
                'typeName'  => 'required ',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al registrar la cuenta.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $idCardType =  $this->financeService->getCardTypeID($paramsArray['typeName']);
                // $idCardType =  $this->financeService->getCardTypeID($params->typeName);

                if($idCardType == 0) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al registrar la cuenta .',
                    );
                }
                else {
                    $account = UserFinance::
                        where([
                            ['ufin_clabe', '=', $paramsArray['clabe']],
                            ['ufin_isActive', '=', 1],
                            ['usu_idUser', '=', $user->usu_idUser],
                        ])
                    ->
                        first()
                    ;
    
                    if(!empty($account)) {
                        $errors = array('clabe' => array('La cuenta CLABE ha sido registrada.') );
    
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al registrar la cuenta.',
                            'errors'    => $errors
                        );
                    }
                    else {
                        try {
                            $accountUser = new UserFinance();
                            $accountUser->ufin_name     = $paramsArray['name'];
                            $accountUser->ufin_clabe    = $paramsArray['clabe'];
                            $accountUser->ctpe_idType   = $paramsArray['type'];
                            $accountUser->usu_idUser    = $user->usu_idUser;
        
                            $accountUser->save();
        
                            $idAccount = $user->usu_idUser;
        
                            if(is_null($idAccount) || !isset($idAccount) || empty($idAccount)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error al registrar la cuenta.',
                                );
                            }
                            else {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'La cuenta se ha registrado exitosamente.',
                                );
                            }
                        } catch (QueryException $e) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al registrar la cuenta.',
                            );
                        }
                    }
                    return response()->json($data, $data['code']);
                }
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'No se encontró el recurso solicitado.',
            );
        }
        return response()->json($data, $data['code']);
    }

    // Eliminar cuenta
    public function deleteUserFinance(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos usuarios
        $json = $request->input('json', null);
                        
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array


        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'id'        => 'required',
                'name'      => 'required',
                'clabe'     => 'required',
                'type'      => 'required ',
                'typeName'  => 'required ',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al registrar la cuenta.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $idCardType =  $this->financeService->getCardTypeID($paramsArray['typeName']);
                // $idCardType =  $this->financeService->getCardTypeID($params->typeName);

                if($idCardType == 0) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al eliminar la cuenta .',
                    );
                }
                else {
                    $account = UserFinance::
                        where([
                            ['ufin_clabe', '=', $paramsArray['clabe']],
                            ['ufin_name', '=', $paramsArray['name']],
                            // ['ufin_isActive', '=', 1],
                            ['usu_idUser', '=', $user->usu_idUser],
                            ['ctpe_idType', '=', $idCardType],
                        ])
                    ->
                        first()
                    ;
    
                    if(empty($account)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al eliminar la cuenta a.',
                        );
                    }
                    else {
                        $idAccount = $account->ufin_idFinance;
                        try {
                            // Eliminar la cuenta
                            $deleted = UserFinance::where('ufin_idFinance', '=', $idAccount) -> delete();
        
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'La cuenta se ha registrado exitosamente.',
                            );
                        } catch (QueryException $e) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al registrar la cuenta.',
                            );
                        }
                    }
                    return response()->json($data, $data['code']);
                }
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                'message'   => 'No se encontró el recurso solicitado.',
            );
        }
        return response()->json($data, $data['code']);
    }
    
    //Obtener todas las cuentas(tarjetas) registradas del usuario
    public function getFinanceAccountFmUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        
        $user = $jwtAuth->checkToken($token, true);

        try {
            $accounts = UserFinance::
                with([
                    'financeCardType',
                ])
            ->
                where('usu_idUser', $user->usu_idUser)
            ->
                get()
            ;
            
            if(!empty($accounts)){
                $data = array(
                    'accounts' => $accounts,
                );
            }
            else {
                $data = array(
                    'accounts' => [],
                );
            }

        } catch (QueryException $e) {
            $data = array(
                'accounts' => [],
            );
        }
        return response()->json($data);
    }
}
