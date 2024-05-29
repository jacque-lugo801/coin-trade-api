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
            $address->usad_cp           = $paramsArray['cp'];
            $address->usad_isDefault    = 1;
            $address->usu_idUser        = $paramsArray['idUser'];
            
            $address->save();
            return $address;
        }
        else{
            echo 'error on shipping';
        }
    }

    public function updateShippingAddress($params, $id) {
        if(!empty($params) && (isset($id) && $id != null)){
            // print_r('<pre>');
            // print_r($params);
            // print_r('</pre>');
            
            // print_r('<pre>');
            // print_r($id);
            // print_r('</pre>');

            // die();
            $paramsArray = array_map('trim', $params); 
            
            $address = UserShippingAddress::
                where('usad_idAddress', '=', $id)
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
            echo 'error on update shipping address';
        }
    }
}
