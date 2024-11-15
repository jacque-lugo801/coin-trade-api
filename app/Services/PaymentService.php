<?php

namespace App\Services;

use App\Models\Valuation;
use App\Models\ValuationStatus;

use App\Http\Controllers\PaymentStatusController;
use App\Http\Controllers\PaymentTypeController;
use App\Http\Controllers\PaymentCategoryController;

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
    protected $paymentTypeController;
    protected $paymentCategoryController;
    // protected $shippingController;
    // protected $fiscalController;
    // protected $userController;

    public function __construct (
        PaymentStatusController     $paymentStatusController,
        PaymentTypeController       $paymentTypeController,
        PaymentCategoryController   $paymentCategoryController,
    ) {
        $this->paymentStatusController      = $paymentStatusController;
        $this->paymentTypeController        = $paymentTypeController;
        $this->paymentCategoryController    = $paymentCategoryController;
    }

    // PAYMENT STATUS
    //Obtener el ID del estado de pago
    public function getPaymentStatusID($name) {
        return $this->paymentStatusController->getPaymentStatusID($name);
    }
    // END PAYMENT STATUS

    // PAYMENT TYPE
    //Obtener el ID del tipo de pago
    public function getPaymentTypeID($name) {
        return $this->paymentTypeController->getPaymentTypeID($name);
    }
    // END PAYMENT TYPE

    // PAYMENT TYPE
    //Obtener el ID del tipo de pago
    public function getPaymentCategoryID($name, $idType) {
        return $this->paymentCategoryController->getPaymentCategoryID($name, $idType);
    }
    // END PAYMENT TYPE
}
