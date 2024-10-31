<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\CartItem;

use Illuminate\Database\QueryException;
use Exception;


use Illuminate\Support\Collection;


class CartController extends Controller
{

    
    // **************************************************
    // *                    AUTH                        *
    // **************************************************

    // Obtener carrito
    public function getCart(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        
        $user = $jwtAuth->checkToken($token, true);

        try {
            $cart = Cart::
                where(
                    "usu_idUser", "=", $user->usu_idUser
                )
            ->first()
            ;

            if(!empty($cart)){

                $items = Cart::
                    with([
                        'cartItems',
                        'cartItems.itemProduct',
                        'cartItems.itemProduct.productCountry',
                        'cartItems.itemProduct.productType',
                        'cartItems.itemProduct.productGroup',
                        'cartItems.itemProduct.productCategory',
                        'cartItems.itemProduct.productStatus',
                    ])
                    ->get()
                ;

                $itemsArr =  $items->flatMap->cartItems->toArray();
                // $itemsArr = json_decode( $items->flatMap->cartItems->toArray(), true);
                
                $itemsCollection =  new Collection($itemsArr);

                $itemsNewC = $itemsCollection->filter(function ($obj) {
                    return $obj['citm_isActive'] === 1;
                });

                $itemsNewArr = $itemsNewC->toArray();

                $data = array(
                    'cart' => [
                        // 'cart_id_session' => $items->cart_id_session,
                        'cart_id_session'   => $items->first()->cart_id_session,
                        'items'             => array_values($itemsNewArr),
                        // 'items' => $itemsNewArr,
                        // 'items' => $items->flatMap->cartItems->toArray(),
                    ],
                );
            }
            else {
                $data = array(
                    'cart' => [
                        'items' => [],
                    ],
                );
            }
        } catch (QueryException $e) {
            $data = array(
                'cart' => [
                    'items' => [],
                ],
            );
        }
        return response()->json($data);
        // return response()->json($data, 200);
    }


    // Guardar/crear un nuevo carrito para el usuario
    public function saveCartUser($params) {
        if(!empty($params)) {
            try {
                $paramsArray = array_map('trim', $params); 
                
                $cart = new Cart();
                $cart->usu_idUser  = $paramsArray['idUser'];
                
                $cart->save();
                return $cart;

            } catch (QueryException $e) {
                // $errorCode = $e->getCode();
                // $errorMessage = $e->getMessage();
                // Log::error("Error on saveSignupFiscalData. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                return 0;
            }
        }
        else {
            return 0;
        }
    }
    
    // Actualizar el carrito
    public function updateCartUserSession($idCart, $params) {
        if(!empty($idCart) || !empty($params)) {
            try {
                $paramsArray = array_map('trim', $params); 
                
                $cart = Cart:: where ('cart_idCart', $idCart)
                    ->update($paramsArray)
                ;
                
                if($cart || $cart == 1) {
                    return 1;
                } else {
                    return 0;
                }
            } catch (QueryException $e) {
                // $errorCode = $e->getCode();
                // $errorMessage = $e->getMessage();
                // Log::error("Error on saveSignupFiscalData. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                return 0;
            }
        }
        else {
            return 0;
        }
    }

}
