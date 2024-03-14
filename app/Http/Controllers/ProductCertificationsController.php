<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductCertifications;

class ProductCertificationsController extends Controller
{
    //

    public function saveCertificate($params) {
        if(!empty($params)){
            $paramsArray = array_map('trim', $params); 
            
            $certification = new ProductCertifications();
            $certification->pcert_image         = $paramsArray['imageCertificate'];
            $certification->prod_idProducto     = $paramsArray['idProduct'];
            
            $certification->save();
            return $certification;
        }
        else{
            echo 'error on certification';
        }
    }
}
