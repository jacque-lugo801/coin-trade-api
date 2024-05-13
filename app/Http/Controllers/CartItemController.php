<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CartItem;
use App\Models\Cart;


use App\Http\Controllers\CartController;
class CartItemController extends Controller
{
    
    
    public function addItemToCart(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos usuarios
        $json = $request->input('json', null);
        
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'id'        => 'required',
                'sku'       => 'required',
                'name'      => 'nullable',
                'quantity'  => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error al agregar el producto al carrito',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // Verificar que se haya creado antes un carrito para el ususario
                $cart = Cart::
                    where(
                        "usu_idUser", "=", $user->usu_idUser
                    )
                    ->first()
                    ;

                // if(count($cart) > 0) {
                if(!empty($cart)) {
                    // Si existe un carrito
                    $idCart = $cart->cart_idCart;
                    // var_dump($idCart);
                    // var_dump($paramsArray);
                    // die();

                    $cartItem = $this->addItem($idCart, $paramsArray);
                }
                else {
                    // Si no existe un carrito
                    $cartParams = array(
                        'idUser'        => $user->usu_idUser,
                    );

                    $userCart = (new CartController)
                        ->saveUserCart($cartParams);

                    // var_dump($userCart);
                    // var_dump($userCart->cart_idCart);
                    $idCart = $userCart->cart_idCart;

                    
                    $cartSessionArr = array(
                        'idUser' => $user->usu_idUser,
                        'idCart'  => $idCart,
                    );
                    // var_dump($cartSessionArr);
                    // die();

                    $sessionID = $jwtAuth->encode($cartSessionArr);
                    $cartParamsSession = array(
                        'cart_id_session'        => $sessionID,
                    );
                    
                    $userCart = (new CartController)
                        ->updateUserCartSession($idCart, $cartParamsSession);

                    // var_dump($userCart);

                   $this->addItem($idCart, $paramsArray);


                    $data = array(
                        'status'    => 'success',
                        'code'      => 200,
                        'message'   => 'El producto se ha agregado al carrito exitosamente',
                    );
                }

            }
        }
        return response()->json($data, $data['code']);
    }

    public function addItem($idCart, $paramsArray) {
        $itemAdded = false;

        $product = CartItem::

            // with(
            //     [
            //         'itemsCart',
            //         // 'userAddressShipping.userShippingCountry', 
            //         // 'userAddressShipping.userShippingCountry.userState'
            //     ]
            // )

            where(
                ['cart_idCart', $idCart],
                // ['prod_idProducto', $paramsArray['id']],
            )
            ->get()
            ;

            var_dump($product);

        return 0;
        die();

        $cartItem = new CartItem();
        $cartItem->cart_idCart      = $idCart;
        $cartItem->prod_idProducto  = $paramsArray['id'];
        $cartItem->citm_quantity    = $paramsArray['quantity'];
        
        $cartItem->save();
        return $cartItem;
    }
}
