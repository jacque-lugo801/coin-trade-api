<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductType;
use App\Models\ProductGroup;
use App\Models\ProductCategory;

class ProductTypeController extends Controller
{
    //
    
    public function pruebas(Request $request) {
        return 'Acción de pruebas de PRODUCT_TYPE-CONTROLLER';
    }

    public function getAllCategories() {
       

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
        // echo 'getAllCoinCategories';
        // $types = ProductType::join('product_group', 'product_type.ptpe_idType', '=', 'product_group.ptpe_idType' )
        $types = ProductType::join(
                (new ProductGroup)->getTable(),
                (new ProductType)->getTable().'.'.(new ProductType)->getKeyName(),
                '=',
                (new ProductGroup)->getTable().'.'.(new ProductType)->getKeyName()
            )
            // ->join(
            //     (new ProductCategory)->getTable(),
            //     (new ProductCategory)->getTable().'.'.(new ProductGroup)->getKeyName(),
            //     '=',
            //     (new ProductGroup)->getTable().'.'.(new ProductGroup)->getKeyName()
            // )
            ->select(
                // 'product_type.ptpe_idType           as tipoID',
                // 'ptpe_name                          as tipoNombre',
                // 'product_group.pgrp_idGroup         as grupoID',
                // 'pgrp_name                          as grupoNombre',
                // 'product_category.pcat_idCategory   AS categoriaID',
                // 'pcat_name                          AS categoriaNombre'
                // ,
                'product_type.ptpe_idType       as tipoID',
                'ptpe_name                      as tipoNombre',
                'product_group.pgrp_idGroup     as grupoID',
                'pgrp_name                      as grupoNombre',
                // 'product_group.ptpe_idType      as grupoIDGrupo',
                // 'pcat_idCategory                as categoriaID',
                // 'pcat_name                      as categoriaNombre',
                // // 'product_group.pgrp_idGroup     as ',
                // 'product_category.pgrp_idGroup  as grupoIDCategoria',


            )

            // ->where([
            //         ["ptpe_isActive", "=", 1],
            //         ["ptpe_idType", "=", 1]
            //     ])
            ->where("ptpe_isActive", "=", 1)
            ->where("product_type.ptpe_idType", "=", 1)
            ->get();

                // print_r('<pre>');
                // print_r($types);
                // print_r('</pre>');
        
        $categories = array();
        // array_push($categories, (object)[

        // ]);


        foreach ($types as $type ) {
            // echo $type->grupoID.'|';
            $categoriesByGroup = ProductCategory::where("pcat_isActive", "=", 1)
                ->where("product_category.pgrp_idGroup", "=", $type->grupoID)
                ->select(
                    'pcat_idCategory    AS categoriaID',
                    'pcat_name          AS categoriaNombre'
                )
                ->get();
                // var_dump($categoriesByGroup);
                
            array_push($categories, (object)[
                'tipoID'        => $type->tipoID,
                'tipoNombre'    => $type->tipoNombre,
                'grupoID'       => $type->grupoID,
                'grupoNombre'   => $type->grupoNombre,
                'categorias'    => $categoriesByGroup
            ]);
        }

        // // var_dump($categories);

        //         print_r('<pre>');
        //         print_r($categories);
        //         print_r('</pre>');
        // // die();

        // return  response()->json([
        //     'categories' => $types
        // ]);
        return  response()->json([
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
