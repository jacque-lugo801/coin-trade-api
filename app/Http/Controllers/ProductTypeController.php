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











    public function getMetalCategories() {
        
        $categories = ProductType
        ::with('typeGroup', 'typeGroup.groupCategory')
        ->where([
            ['ptpe_isActive', '=', 1],
            ['ptpe_idType', '=', 1],
            ['pgrp_idGroup', '=', 4],
        ])
        ->get()
        ;

        return  response()->json([
            // 'categories' => $types
            'metal' => $categories
        ]);
    }

    
    // public function getGroupCategories(Request $request) {
        
    //     $categories = ProductType
    //     ::with([
    //         'typeGroup',
    //         'typeGroup.groupCategory',

    //     ])
    //     ->where([
    //         ['ptpe_isActive', '=', 1],
    //     ])
    //     ->get()
    //     ;


    //     return  response()->json([
    //         // 'categories' => $types
    //         'groupCategories' => $categories
    //     ]);
    // }

    public function getAllCategories2() {

        $categoriesCoins        = $this->getAllCoinCategories();
        $categoriesMoneyBills   = $this->getAllMoneyBillCategories();

        // $arr = $categoriesMoneyBills[0];
        // var_dump($arr);

        // $types = array_merge($categoriesCoins, $categoriesMoneyBills);
        // $types =  $this->getAllMoneyBillCategories();
        // $types = array();

        foreach($categoriesCoins as $coin){
            print_r('<pre>');
            print_r($coin);
            print_r('</pre>');
            // // .push();
            if(!empty($coin)){
                // array_push($types, $coin);

            }
        }
        return $types;
    }


    public function getAllCoinCategories() {
        // $types = ProductType::join('product_group', 'product_type.ptpe_idType', '=', 'product_group.ptpe_idType' )
        $types = ProductType::join(
                (new ProductGroup)->getTable(),
                (new ProductType)->getTable().'.'.(new ProductType)->getKeyName(),
                '=',
                (new ProductGroup)->getTable().'.'.(new ProductType)->getKeyName()
            )
            ->select(
                'product_type.ptpe_idType   as tipoID',
                'ptpe_name                  as tipoNombre',
                'product_group.pgrp_idGroup as grupoID',
                'pgrp_name                  as grupoNombre',
            )
            ->where("ptpe_isActive", "=", 1)
            ->where("product_type.ptpe_idType", "=", 1)
            ->get();

        $categories = array();

        foreach ($types as $type ) {
            $categoriesByGroup = ProductCategory::where("pcat_isActive", "=", 1)
                ->where("product_category.pgrp_idGroup", "=", $type->grupoID)
                ->select(
                    'pcat_idCategory    AS categoriaID',
                    'pcat_name          AS categoriaNombre'
                )
                ->get();
                
            array_push($categories, (object)[
                'tipoID'        => $type->tipoID,
                'tipoNombre'    => $type->tipoNombre,
                'grupoID'       => $type->grupoID,
                'grupoNombre'   => $type->grupoNombre,
                'categorias'    => $categoriesByGroup
            ]);
        }
        return  response()->json([
            // 'categories' => $types
            'categories' => $categories
        ]);
    }

    public function getCategories(){

    }
    
    public function getAllMoneyBillCategories() {
        $types = ProductType::join(
                (new ProductGroup)->getTable(),
                (new ProductType)->getTable().'.'.(new ProductType)->getKeyName(),
                '=',
                (new ProductGroup)->getTable().'.'.(new ProductType)->getKeyName()
            )
            ->select(
                'product_type.ptpe_idType           as tipoID',
                'ptpe_name                          as tipoNombre',
                'product_group.pgrp_idGroup         as grupoID',
                'pgrp_name                          as grupoNombre',
            )
            ->where("ptpe_isActive", "=", 1)
            ->where("product_type.ptpe_idType", "=", 2)
            ->get();
        return  response()->json([
            'categories' => $types
        ]);
    }
}
