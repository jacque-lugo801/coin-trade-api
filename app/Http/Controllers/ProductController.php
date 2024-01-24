<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\ProductType;

class ProductController extends Controller
{
    //
    
    public function pruebas(Request $request) {
        return 'Acción de pruebas de PRODUCT-CONTROLLER';
    }

    public function getAllProducts() {
        $products = Product::join(
            (new ProductType)->getTable(),
            (new Product)->getTable().'.'.(new ProductType)->getKeyName(),
            '=',
            (new ProductType)->getTable().'.'.(new ProductType)->getKeyName(),
            // 'product_type',
            // 'product_type.ptpe_idType',
            // '=',
            // 'products.ptpe_idType',
        )
        ->where("prod_isActive", "=", 1)
            ->select(
                'prod_idProducto            as idProducto',
                'prod_name                  as name',
                'prod_description           as description',
                'prod_content               as content',
                'prod_country               as country',
                'prod_metal                 as metal',
                'prod_diameter              as diameter',
                'prod_condition             as condition',
                'prod_date                  as date',
                'prod_weight                as weight',
                'prod_minting               as minting',
                'prod_fineness              as fineness',
                'prod_serie                 as serie',
                'prod_denomination          as denomination',
                'prod_number                as number',
                'prod_rating                as rating',
                'prod_unit_cost             as unit_cost',
                'prod_commission            as commission',
                'prod_total                 as total',
                'prod_stock                 as stock',
                'product_type.ptpe_idType   as typeID',
                'product_type.ptpe_name     as typeName',
                // (new ProductType)->getTable().'ptpe_idType as idType',
                // 'usu_idUser         as dUser',
                'prod_image                 as image',
            )
            ->get();
            // die();
            
        return response()->json([
            'products' => $products
        ]);

    }
}
