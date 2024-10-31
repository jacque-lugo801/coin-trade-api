<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ValuationStatus;

class ValuationStatusController extends Controller
{
    // Obtener el ID de un estado de valuacion (ej. En progreso)
    public function getValuationStatusID($name) {
        if(isset($name) && !empty($name)) {
            $rol = ValuationStatus::where('vsta_name', 'LIKE', '%'. $name.'%') -> first();
            return $rol->vsta_idStatus;
        }
        else {
            return 0;
        }
    }

    
    // Obtener los estados de productos
    public function getValuationStatus() {
        try {
            $valuationStatus = ValuationStatus::
                get()
            ;
        } catch (QueryException $e) {
            $valuationStatus = [];
        }

        return  response()->json([
            'valuationStatus' => $valuationStatus
        ]);
    }
    
}
