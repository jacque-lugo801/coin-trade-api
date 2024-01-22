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
            $fiscal->usu_idUser         = $paramsArray['idUser'];
            
            $fiscal->save();
            return $fiscal;
        }
        else{
            echo 'error on fiscal';
        }
    }
}
