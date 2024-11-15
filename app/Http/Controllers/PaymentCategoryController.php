<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\PaymentCategory;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

class PaymentCategoryController extends Controller
{
    // Obtener el ID de un estado de transaccion (ej. Completa)
    public function getPaymentCategoryID($name, $idType) {
        if((isset($name) && !empty($name)) || (isset($idType) && !empty($idType))) {
            try {
                $category = PaymentCategory::
                // where('pytp_name', 'LIKE', '%'. $name.'%') -> first();
                where([
                    ['pyct_name', 'LIKE', '%'. $name.'%'],
                    ['pytp_idType', '=', $idType]
                ])
                ->first();

                // var_dump($category);
                // var_dump(!is_null($category));

                // die();
                // if(!empty($category) || !is_null($category)) {
                if(is_null($category)) {
                    return null;
                }
                else {
                    return $category->pyct_idCategory;
                }
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
}
