<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\CartItem;


use Illuminate\Support\Collection;


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
            ->first()
            ;

        //     var_dump($cart);
        // die();
        // !empty($cart) || 
        // if( count($cart) > 0){
        if( !empty($cart)){
            // $idCart = $cart->cart_idCart;
            // var_dump($idCart);
            // $data = array(
            //     'cart' => array(
            //         'cart_id_session' => $cart->cart_id_session,
            //         'items' => []
            //     ),
            // );

            $items = Cart::
            // $items = CartItem::
                with(
                    [
                        'cartItems',
                        'cartItems.itemProduct',
                        'cartItems.itemProduct.productCountry',
                        'cartItems.itemProduct.productType',
                        'cartItems.itemProduct.productGroup',
                        'cartItems.itemProduct.productCategory',
                        'cartItems.itemProduct.productStatus',
                        // 'userAddressShipping.userShippingCountry', 
                        // 'userAddressShipping.userShippingState', 
                        // 'userAddressShipping.userShippingCity', 

                        // 'userFiscalData',
                        // 'userFiscalData.userFiscalCountry', 
                        // 'userFiscalData.userFiscalState', 
                        // 'userFiscalData.userFiscalCity', 

                        // 'userAddressShipping.userShippingCountry.userState'
                    ]
                )
                        
                // ->
                    // where(
                    //     "citm_isActive", "=", 1
                    // )
                ->get()
                ;
                // print_r('<pre>');
                // print_r($items);
                // print_r('</pre>');
                // die();
                
                
            $itemsArr =  $items->flatMap->cartItems->toArray();
            // $itemsArr = json_decode( $items->flatMap->cartItems->toArray(), true);
            $itemsCollection =  new Collection($itemsArr);

            $itemsNewC = $itemsCollection->filter(function ($obj) {
                return $obj['citm_isActive'] === 1;
            });

            $itemsNewArr = $itemsNewC->toArray();
            // var_dump($items);
            // die();
            $data = array(
                // 'status'    => 'success',
                // 'code'      => 200,
                // 'message'   => 'No se han encontrado resultados',
                'cart' => [
                    // 'cart_id_session' => $items->cart_id_session,
                    'cart_id_session' => $items->first()->cart_id_session,
                    
                    'items' => array_values($itemsNewArr),
                    // 'items' => $itemsNewArr,
                    // 'items' => $items->flatMap->cartItems->toArray(),
                ],
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
