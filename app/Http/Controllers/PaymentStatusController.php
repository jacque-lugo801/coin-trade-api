<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PaymentStatus;

use Illuminate\Database\QueryException;
use Exception;

class PaymentStatusController extends Controller
{
    // Obtener el ID de un estado de pago (ej. No pagada)
    public function getPaymentStatusID($name) {
        if(isset($name) && !empty($name)) {
            try {
                $status = PaymentStatus::where('pyst_name', 'LIKE', '%'. $name.'%') -> first();
                return $status->pyst_idStatus;
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
