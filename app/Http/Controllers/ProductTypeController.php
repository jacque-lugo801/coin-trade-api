<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductType;
use App\Models\ProductGroup;
use App\Models\ProductCategory;

use Illuminate\Database\QueryException;
use Exception;

class ProductTypeController extends Controller
{
    // Obtener todas las categorias (con sus grupos y subcategorias)
    public function getAllCategories() {
        try {
            $categories = ProductType::
                with([
                    'typeGroup',
                    'typeGroup.groupCategory',

                ])
                ->where([
                    ['ptpe_isActive', '=', 1],
                ])
                ->get()
            ;
        } catch (QueryException $e) {
            $categories = [];
        }

        return  response()->json([
            'categories' => $categories
        ]);
    }
    
    // Obtener el ID de un tipo de producto (ej. moneda)
    public function getProductTypeID($typeName) {
        if(isset($typeName) && !empty($typeName)) {
            try {
                $type = ProductType::where('ptpe_name', 'LIKE', '%'. $typeName.'%')->first();

                return $type->ptpe_idType;
            } catch (QueryException $e) {
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    
    // **************************************************
    // *                    AUTH                        *
    // **************************************************

    // Obtener los tipos de productos
    public function getProductTypes() {
        try {
            $types = ProductType::all();
        } catch (QueryException $e) {
            $types = [];
        }
        
        return response()->json([
            'types' => $types
        ]);
    }

}
