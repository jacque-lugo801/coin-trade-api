<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UserShippingAddress;

class UserShippingAddressController extends Controller
{
    public function saveSignupAddress($params) {
        if(!empty($params)){
            $paramsArray = array_map('trim', $params); 
            
            $address = new UserShippingAddress();
            $address->usad_country      = $paramsArray['country'];
            $address->usad_state        = $paramsArray['state'];
            $address->usad_city         = $paramsArray['city'];
            $address->usad_address      = $paramsArray['address'];
            $address->usad_isDefault    = 1;
            $address->usu_idUser        = $paramsArray['idUser'];
            
            $address->save();
            return $address;
        }
        else{
            echo 'error on shipping';
        }
    }
}
