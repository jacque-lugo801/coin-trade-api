<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductType;
use App\Models\ProductGroup;
use App\Models\ProductCategory;

class ProductGroupController extends Controller
{
    //

    public function getMetalCategories(Request $request) {
        
        $categories = ProductGroup
        // ::with('groupCategory')
        ->where([
            ['pgrp_isActive', '=', 1],
        ])
        ->get()
        ;


        return  response()->json([
            // 'categories' => $types
            'metalCategories' => $categories
        ]);
    }
}
