<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\PaymentType;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

class PaymentTypeController extends Controller
{
    // Obtener el ID de un estado de transaccion (ej. Completa)
    public function getPaymentTypeID($name) {
        if(isset($name) && !empty($name)) {
            try {
                $type = PaymentType::where('pytp_name', 'LIKE', '%'. $name.'%') -> first();
                return $type->pytp_idType;
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
