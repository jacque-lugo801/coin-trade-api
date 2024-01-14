<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

// Cambia App\Post por App\Models\Post
use App\Models\Product;
// use App\Models\User;
use App\Models\ProductType;


class TestController extends Controller
{
    //

    // public function testOrm() {
    //     $products = Product::all();
    //     var_dump($products);

    //     foreach( $products as $product) {
    //         echo "<pre>". $product ."</pre>";
    //         echo $product->prod_name;
    //         echo "<h1>". $product->prod_name ."</h1>";
    //         // echo "<span>". ($product->user->usu_idUser) ."</span>";
    //         echo "<p>". $product->prod_content ."</p>"; 
    //         echo "<hr>"; 
    //     }

    //     // die() ; //No muestra ninguna vista
    // }

    public function testOrm() {

        // $products = Product::all();

        // var_dump($products);

        // foreach($products as $product) {
        //     echo "<h1>". $product->prod_name ."</h1>";
        //     echo "<span>". ($product->user->usu_username) . " - ".  ($product->productType->ptpe_name) ."</span>";
        //     echo "<p>". $product->prod_content ."</p>";
        //     echo "<hr>";
        // }

        $productTypes = ProductType::all();
        
        foreach($productTypes as $prodType) {
            echo "<h1>". $prodType->ptpe_name ."</h1>";

            foreach ($prodType->products as $product) {
                echo "<h1>". $product->prod_name ."</h1>";
                echo "<span>". ($product->user->usu_username) . " - ".  ($product->productType->ptpe_name) ."</span>";
                echo "<p>". $product->prod_content ."</p>";
                echo "<hr>";
            }

        }

        die();
    }
}
