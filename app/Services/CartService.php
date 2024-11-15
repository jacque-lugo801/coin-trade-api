<?php

namespace App\Services;

use App\Http\Controllers\CartController;
// use App\Http\Controllers\CartItemController;

use App\Models\Cart;
use App\Models\CartItem;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con los USUARIOS.
*/

class CartService
{
    protected $cartController;
    // protected $cartItemController;

    public function __construct (
        CartController      $cartController,
        // CartItemController  $cartItemController,
    ) {
        $this->cartController       = $cartController;
        // $this->cartItemController   = $cartItemController;
    }

    
    // CART
    // Obtener el cart por ID de usuario
    public function getCartByUserID($id) {
        try {
            $cart = Cart::
                where(
                    "usu_idUser", "=", $id
                )
            ->first()
            ;
        }  catch (QueryException $e) {
            $cart = [];
        }
        
        return  $cart;
    }

    public function saveCartUser($params) {
        return $this->cartController->saveCartUser($params);
    }
    public function updateCartUserSession($id, $params) {
        return $this->cartController->updateCartUserSession($id, $params);
    }

    public function getCartItem($id, $params) {
        try {
            $item = CartItem::
                where([
                    ['cart_idCart', '=', $id],
                    ['prod_idProducto', '=', $params['idProduct']],
                    ['citm_idItem', '=', $params['idItem']],
                    ['citm_isActive', '=', 1],
                ])
            ->
                first()
            ;
            
        }  catch (QueryException $e) {
            // $errorCode = $e->getCode();
            // $errorMessage = $e->getMessage();
            // Log::error("Error on getCartItem. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs

            $item = [];
        }

        return  $item;
    }
    // END CART

    // CART ITEM
    // Delete cart item
    public function removeItem($idCart, $idItem){
        if(!empty($idCart) || !empty($idItem)) {
            try {  
                $cartItem = CartItem::
                    where([
                        ['cart_idCart', '=', $idCart],
                        ['citm_idItem', '=', $idItem],
                    ])
                ->delete()
                    // update(
                    //     ['citm_isActive' => 0]
                    // )
                ;

                if($cartItem || $cartItem == 1) {
                    return 1;
                }
                else {
                    return 0;
                }
            } catch (QueryException $e) {
                // $errorCode = $e->getCode();
                // $errorMessage = $e->getMessage();
                // Log::error("Error on saveSignupAddress. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                // return response()->json(['error' => 'Ocurrió un error en la consulta.'], 500);
                return 0;
            }
        }
        else {
            return 0;
        }
    }
    // END CART ITEM
}
