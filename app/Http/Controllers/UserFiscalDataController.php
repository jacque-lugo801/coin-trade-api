<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UserFiscalData;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;
use Illuminate\Support\Str;

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

    // Obtener datos fiscales
    public function getFiscalData($idUser) {
        if(!empty($idUser)){
            $id = trim($idUser); 
            
            $fiscal = UserFiscalData::
                where('usu_idUser', '=', $id)
                ->
                    get()
                ;
            return $fiscal;
        }
        else {
            return 0;
        }
    }

    // Borrar direccion de envio
    public function deleteSignupFiscal($idUser) {
        if(!empty($idUser)){
            try {
                // $idUser = array_map('trim', $idUser); 
                Str::of($idUser)->trim();

                $addresses = UserFiscalData::where('usu_idUser', '=', $idUser)->get();

                foreach ($addresses as $address) {
                    $id = $address->ufdt_idData;
                    
                    $deleted = UserFiscalData::where('ufdt_idData', '=', $id) -> delete();
                }
                // return $deleted;
            } catch (QueryException $e) {
                // $errorCode = $e->getCode();
                // $errorMessage = $e->getMessage();
                // Log::error("Error on saveSignupAddress. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                // return response()->json(['error' => 'Ocurrió un error en la consulta.'], 500);
                return 0;
            }
        }
        else {
            return 0;
        }
    }
}
