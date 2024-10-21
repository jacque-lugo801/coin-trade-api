<?php

namespace App\Services;

use App\Models\Valuation;
use App\Models\ValuationStatus;

use App\Http\Controllers\ValuationStatusController;


use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con las CONFIGURACIONES.
*/

class ValuationService
{
    protected $valuationStatusController;
    // protected $shippingController;
    // protected $fiscalController;
    // protected $userController;

    public function __construct (
        ValuationStatusController  $valuationStatusController,
    ) {
        $this->valuationStatusController = $valuationStatusController;
    }

    // VALUATION STATUS
    //Obtener el ID del estado de valuacion
    public function getValuationStatusID($name) {
        return $this->valuationStatusController->getValuationStatusID($name);
    }
    // END VALUATION STATUS
}
