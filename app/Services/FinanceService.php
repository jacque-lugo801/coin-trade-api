<?php

namespace App\Services;

use App\Http\Controllers\CardTypeController;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con los USUARIOS.
*/

class FinanceService
{
    protected $cardTypeController;

    public function __construct (
        CardTypeController  $cardTypeController,
    ) {
        $this->cardTypeController   = $cardTypeController;
    }

    // CARD TYPE
    // Obtener ID del producto del tipo tarjeta
    public function getCardTypeID($typeName) {
        return $this->cardTypeController->getCardTypeID($typeName);
    }
    // END CARD TYPE
}
