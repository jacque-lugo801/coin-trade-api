<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UserFiscalData;

class UserFiscalDataController extends Controller
{
    public function saveSignupFiscalData($params) {
        if(!empty($params)){
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
        }
        else{
            echo 'error on fiscal';
        }
    }

    
    public function updatFiscalData($params, $id) {
        if(!empty($params) && (isset($id) && $id != null)){
            // print_r('<pre>');
            // print_r($params);
            // print_r('</pre>');
            
            // print_r('<pre>');
            // print_r($id);
            // print_r('</pre>');

            // die();
            $paramsArray = array_map('trim', $params); 
            
            $address = UserFiscalData::
                where('ufdt_idData', '=', $id)
                ->
                update($params);
                // ->get()
                ;
                            // ->update($paramsUserUpdate);

            if($address || $address == 1) {
                return true;
            } else {
                return false;
            }
        }
        else{
            echo 'error on update fsical address';
        }
    }
}
