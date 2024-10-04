<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UserFiscalData;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

class UserFiscalDataController extends Controller
{
    // Guardar datos fiscales
    public function saveSignupFiscalData($params) {
        if(!empty($params)){
            try {
                $paramsArray = array_map('trim', $params); 
                
                $fiscal = new UserFiscalData();
                $fiscal->ufdt_denomination  = $paramsArray['denomination'];
                $fiscal->ufdt_rfc           = $paramsArray['rfc'];
                $fiscal->ufdt_country       = $paramsArray['country'];
                $fiscal->ufdt_state         = $paramsArray['state'];
                $fiscal->ufdt_city          = $paramsArray['city'];
                $fiscal->ufdt_address       = $paramsArray['address'];
                $fiscal->ufdt_cp            = $paramsArray['cp'];
                $fiscal->usu_idUser         = $paramsArray['idUser'];
                
                $fiscal->save();

                return $fiscal;
            } catch (QueryException $e) {
                // $errorCode = $e->getCode();
                // $errorMessage = $e->getMessage();
                // Log::error("Error on saveSignupFiscalData. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    // Actualizar datos fiscales
    public function updatFiscalData($params, $id) {
        if(!empty($params) && (isset($id) && $id != null)){
            $paramsArray = array_map('trim', $params); 
            
            $address = UserFiscalData::
                where('ufdt_idData', '=', $id)
                ->
                update($params);
                ;
            if($address || $address == 1) {
                return 1;
            } else {
                return 0;
            }
        }
        else {
            return 0;
        }
    }
}
