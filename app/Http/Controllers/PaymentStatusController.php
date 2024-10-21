<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PaymentStatus;

class PaymentStatusController extends Controller
{
    // Obtener el ID de un estado de pago (ej. No pagada)
    public function getPaymentStatusID($name) {
        if(isset($name) && !empty($name)) {
            $status = PaymentStatus::where('pyst_name', 'LIKE', '%'. $name.'%') -> first();
            return $status->pyst_idStatus;
        }
        else {
            return 0;
        }
    }
}
