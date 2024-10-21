<?php

namespace App\Services;

use App\Models\Valuation;
use App\Models\ValuationStatus;

use App\Http\Controllers\PaymentStatusController;


use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con las PAGOS.
*/

class PaymentService
{
    protected $paymentStatusController;
    // protected $shippingController;
    // protected $fiscalController;
    // protected $userController;

    public function __construct (
        PaymentStatusController  $paymentStatusController,
    ) {
        $this->paymentStatusController = $paymentStatusController;
    }

    // PAYMENT STATUS
    //Obtener el ID del estado de pago
    public function getPaymentStatusID($name) {
        return $this->paymentStatusController->getPaymentStatusID($name);
    }
    // END PAYMENT STATUS
}
