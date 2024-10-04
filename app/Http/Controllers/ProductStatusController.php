<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductStatus;

use Illuminate\Database\QueryException;
use Exception;


class ProductStatusController extends Controller
{
    // Obtener los estados de productos
    public function getStatus() {
        try {
            $productStatus = ProductStatus::
                get()
            ;
        } catch (QueryException $e) {
            $productStatus = [];
        }

        return  response()->json([
            'productStatus' => $productStatus
        ]);
    }

    // Obtener el ID de un estado del producto (ej. Pendiente)
    public function getProductStatusID($statusName) {
        if(isset($statusName) && !empty($statusName)) {
            try {
                $status = ProductStatus::where('psts_name', 'LIKE', '%'. $statusName.'%')->first();

                return $status->psts_idStatus;
            } catch (QueryException $e) {
                return 0;
            }
        }
        else {
            return 0;
        }
    }
}
