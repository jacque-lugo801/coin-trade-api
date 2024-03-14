<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductType;
use App\Models\ProductGroup;
use App\Models\ProductCategory;

class ProductCategoryController extends Controller
{
    //
    public function getMetalCategories(Request $request) {
        
        $categories = ProductCategory
        // ::with('groupCategory')
        ::
        // ->
        where([
            ['pcat_isActive', '=', 1],
        ])
        ->get()
        ;


        return  response()->json([
            // 'categories' => $types
            'metalCategories' => $categories
        ]);
    }
}
