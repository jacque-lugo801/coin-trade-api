<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\ProductRating;
use App\Http\Controllers\ProductController;

class ProductRatingController extends Controller
{
    //

    public function ratingProduct(Request $request) {
        // echo 'rating product';

        
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        
        $user = $jwtAuth->checkToken($token, true);

        
        // Recoger datos usuarios
        $json = $request->input('json', null);
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array


        // var_dump($user);
        // die();

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            // var_dump($paramsArray);
            $validate = \Validator::make($paramsArray, [
                "id"    => 'required',
                "sku"   => 'required',
                "name"  => 'nullable',
                "rate"  => 'required',
            ]);


            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error al agregar la calificación',
                    'errors'    => $validate->errors()
                );
            }
            else {

                // var_dump($user->usu_idUser);
                // // var_dump($paramsArray);
                // var_dump($paramsArray['id']);
                // die();
                $productRating = ProductRating::
                                
                    where([
                        ["usu_idUser", "=", $user->usu_idUser],
                        ["prod_idProducto", "=", $paramsArray['id']],
                        ["prat_isActive", "=", 1],
                    ])
                ->
                first()
                ;

                // var_dump($productRating);
                if(!$productRating) {
                    //Si no se ha calificado aun el producto pór el usuario
                    echo 'no';
                        
                    
                    $this->addRating($user, $paramsArray);

                    $this->updateRateProduct($paramsArray);
                    // $rate = new ProductRating();
                    // $rate->usu_idUser        = $user->usu_idUser;
                    // $rate->prod_idProducto   = $paramsArray['id'];
                    // $rate->prat_isActive     = 1;

                    // $rate->save();
                    // var_dump($rate);

                    // if(!$rate) {
                    //     $data = array(
                    //         'status'    => 'error',
                    //         'code'      => 402,
                    //         'message'   => 'Ha ocurrido un error al agregar la calificación',
                    //         // 'errors'    => $validate->errors()
                    //     );
                    // }
                    // else {

                    // }

                }
                else {
                    // si ya se califico el producto
                    // var_dump($productRating);
                    // var_dump($productRating->prat_idRating);
                    // var_dump($productRating->prat_isActive);
                    // desactiva la anterior calificacion
                    // $oldRate = new ProductRating();
                    // $rate->usu_idUser        = $user->usu_idUser;
                    // $rate->prod_idProducto   = $paramsArray['id'];
                    // $rate->prat_isActive     = 1;

                    // $rate->save();
                    
                    $oldRate = ProductRating::where('prat_idRating', $productRating->prat_idRating)
                    ->update([
                        'prat_isActive' => 0
                    ]);
                    // ->update($paramsUserUpdate);

                    $this->addRating($user, $paramsArray);

                    $this->updateRateProduct($paramsArray);
                }

                // die();
                
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El producto se ha calificado exitosamente',
                );
            }
        }

        
        return response()->json($data, $data['code']);
    }



    public function addRating($user, $paramsArray) {
        
        $rate = new ProductRating();
        $rate->usu_idUser           = $user->usu_idUser;
        $rate->prod_idProducto      = $paramsArray['id'];
        $rate->prat_rating          = $paramsArray['rate'];
        $rate->prat_isActive        = 1;

        $rate->save();
    }
    
    public function updateRateProduct($paramsArray) {
        // echo 'change general rate';


        $allRates = ProductRating::
            where([
                // ["usu_idUser", "=", $user->usu_idUser],
                ["prod_idProducto", "=", $paramsArray['id']],
                ["prat_isActive", "=", 1],
            ])
        ->
        get()
        ;

        $total = 0;
        $rating = 0;
        $numCount = count($allRates);

        if($allRates){
            foreach($allRates as $rate){
                // echo '--------';
                // print_r('<pre>');
                // print_r($rate->prat_rating);
                // print_r('</pre>');
                // echo '--------';
                $total += $rate->prat_rating;

            }

            $rating = $total / $numCount;


            
            // $product = new Product();
            // $product->prod_rating   = $rating;
            // $product->save();
            
        }
        else {

        }

        // die();


        // echo 'count. ' . $numCount;
        // echo '<br>total. ' . $total;
        // echo '<br>rating. ' . $rating;


        $product = Product::
            where([
                ["prod_idProducto", "=", $paramsArray['id']],
                ["prod_sku", "=", $paramsArray['sku']],
            
            ])
        // ->
        //     first()
        ->
            update([
                'prod_rating' => $rating
            ])
        ;
            
        // var_dump($product);
        // die();
        
        // $oldRate = Product::
        //     where('prat_idRating', $productRating->prat_idRating)
        // ->update([
        //     'prod_rating' => 0
        // ]);


    }
}
