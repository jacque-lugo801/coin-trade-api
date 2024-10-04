<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductCertifications;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

class ProductCertificationsController extends Controller
{
    // Guardar imagen de certificado del producto
    public function saveProductCertificate($params) {
        if(!empty($params)) {
            try {
                $paramsArray = array_map('trim', $params); 
                
                $certification = new ProductCertifications();
                $certification->pcert_image     = $paramsArray['imageCertificate'];
                $certification->prod_idProducto = $paramsArray['idProduct'];
                
                $certification->save();
                
                return $certification;
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
