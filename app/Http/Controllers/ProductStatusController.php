<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductStatus;

class ProductStatusController extends Controller
{
    //

    public function getStatus() {

        $productStatus = ProductStatus
            ::get()
        ;


        return  response()->json([
            // 'categories' => $types
            'productStatus' => $productStatus
        ]);
    }
}
