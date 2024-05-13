<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;

class CartController extends Controller
{
    public function getCart(Request $request) {
       
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        
        $user = $jwtAuth->checkToken($token, true);

        // print_r($user);
        // var_dump($user->usu_idUser);
        // die();
        $cart = Cart::
            where(
                "usu_idUser", "=", $user->usu_idUser
            )
            ->get()
            ;

        // !empty($cart) || 
        if( count($cart) > 0){
            $data = array(
                'cart' => $cart,
            );
        }
        else {
            $data = array(
                // 'status'    => 'success',
                // 'code'      => 200,
                // 'message'   => 'No se han encontrado resultados',
                'cart' => [
                    'items' => [],
                ],
            );
        }
        return response()->json($data, 200);
    }


    public function saveUserCart($params) {
        
        // echo 'save usu cart';
        // die();
        if(!empty($params)){
            $paramsArray = array_map('trim', $params); 
            
            $cart = new Cart();
            $cart->usu_idUser  = $paramsArray['idUser'];
            
            $cart->save();
            return $cart;
        }
        else{
            echo 'error on cart';
        }
    }

    public function updateUserCartSession($idCart, $params) {
        
        // echo 'save usu cart';
        // die();
        if(!empty($params)){
            $paramsArray = array_map('trim', $params); 
            
            $cart = Cart:: where ('cart_idCart', $idCart)
                ->update($params)
            ;
            return $cart;
        }
        else{
            echo 'error on cart';
        }
    }

}
