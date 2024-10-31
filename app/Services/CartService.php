<?php

namespace App\Services;

use App\Http\Controllers\CartController;
// use App\Http\Controllers\ProductStatusController;
// use App\Http\Controllers\ProductCertificationsController;

// use App\Models\User;
// use App\Models\Product;
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
    // protected $productStatusController;
    // protected $productCertificationsController;
    // protected $productController;

    public function __construct (
        CartController               $cartController,
        // ProductStatusController             $productStatusController,
        // ProductCertificationsController     $productCertificationsController,
    ) {
        $this->cartController            = $cartController;
        // $this->productStatusController          = $productStatusController;
        // $this->productCertificationsController  = $productCertificationsController;
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
            $item = [];
        }
        
        return  $item;
    }
    // END CART
}
