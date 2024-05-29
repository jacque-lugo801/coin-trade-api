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

                    // var_dump($cart);
                    // die();
                // if(count($cart) > 0) {
                if(!empty($cart)) {
                    // echo 'no vacio o cart declarado antes';
                    // Si existe un carrito
                    $idCart = $cart->cart_idCart;
                    // var_dump($idCart);
                    // var_dump($paramsArray);
                    // die();

                    $cartItem = $this->addItem($idCart, $paramsArray);

                    if($cartItem) {
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'El producto se ha agregado/actualizado en el carrito',
                        );
                    }
                    else {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 404,
                            'message'   => 'El producto ya se encuentra en el carrito',
                        );

                    }

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

                   
                    $cartItem = $this->addItem($idCart, $paramsArray);

                    if($cartItem) {
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'El producto se ha agregado/actualizado en el carrito',
                        );
                    }
                    else {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 404,
                            'message'   => 'El producto ya se encuentra en el carrito',
                        );

                    }


                    // $data = array(
                    //     'status'    => 'success',
                    //     'code'      => 200,
                    //     'message'   => 'El producto se ha agregado al carrito exitosamente',
                    // );
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

            // // where(
            // //     ['cart_idCart', $idCart],
            // //     // ['prod_idProducto', $paramsArray['id']],
            // // )
            // ->
            where([
                ['cart_idCart', '=', $idCart],
                ['prod_idProducto', '=', $paramsArray['id']],
                ['citm_isActive', '=', 1],
            ])
            ->first()
            ;

            // var_dump($product);
            // var_dump(empty($product));
            // die();

            // // if

            // var_dump($product);
            // print_r($product);

        if(!empty($product)) {
            // El item se ha agregado al carrito
            // return false;
            $idItem = $product->citm_idItem;

            $paramsItemUpdate = array (
                "citm_quantity" => $paramsArray['quantity'],
            );

            // var_dump($product->citm_idItem);
            $cartItem = CartItem::where('citm_idItem', $product->citm_idItem)
            // ->update([
            //     'usu_birth_date' => $params->birthdate
            // ]);
            ->update($paramsItemUpdate);

            // var_dump($cartItem);

        }
        else {
            // El item no se ha agregado en el carrito
            $cartItem = new CartItem();
            $cartItem->cart_idCart      = $idCart;
            $cartItem->prod_idProducto  = $paramsArray['id'];
            $cartItem->citm_quantity    = $paramsArray['quantity'];
            
            $cartItem->save();
        }

        // var_dump($cartItem);
        if($cartItem || $cartItem == 1){
            return true;
        }
        else {
            return false;
        }
    }
    
    public function removeItemFromCart(Request $request) {
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
                'idItem'    => 'required',
                'idProduct' => 'nullable',
                'idCart'    => 'nullable',
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
                        
                // var_dump($paramsArray);
                // echo '<br>';
                // var_dump($user);
                // die();

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

                    $cartItem = $this->removeItem($idCart, $paramsArray);

                    if($cartItem) {
                        $data = array(
                            'status'    => 'success',
                            'code'      => 200,
                            'message'   => 'El producto se ha eliminado del carrito.',
                        );
                    }
                    else {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 405,
                            'message'   => 'El producto ya se había eliminado del carrito.',
                        );

                    }

                }
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 403,
                        'message'   => 'Ha ocurrido un error al intentar eliminar el producto del carrito.',
                    );
                }

            }
        }
        return response()->json($data, $data['code']);
    }

    public function removeItem($idCart, $paramsArray) {
        $itemAdded = false;

        $product = CartItem::
            where([
                ['cart_idCart', '=', $idCart],
                ['citm_idItem', '=', $paramsArray['idItem']],
            ])         
                ->update(['citm_isActive' => 0]);
                // ->first()
            ;

            // var_dump($product);
        if($product || $product == 1){
            return true;
        }
        else {
            return false;
        }
    }

    
    
    public function updateItemFromCart(Request $request) {
        
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
                'idItem'    => 'required',
                'idCart'    => 'required',
                'idProduct' => 'required',
                'quantity'  => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error al actualizar el producto',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // var_dump($paramsArray);
                // die();

                // Verificar que se haya creado antes un carrito para el ususario
                $cart = Cart::
                    where(
                        "usu_idUser", "=", $user->usu_idUser
                    )
                    ->first()
                    ;

                // var_dump($cart);
                // die();
                // if(count($cart) > 0) {
                if(!empty($cart)) {
                    // echo 'no vacio o cart declarado antes';
                    // Si existe un carrito
                    $idCart = $cart->cart_idCart;
                    // var_dump($idCart);
                    // // var_dump($paramsArray);
                    // die();

                    $item = CartItem::

                    where([
                        ['cart_idCart', '=', $idCart],
                        ['prod_idProducto', '=', $paramsArray['idProduct']],
                        ['citm_idItem', '=', $paramsArray['idItem']],
                        ['citm_isActive', '=', 1],
                    ])
                    ->first()
                    ;

                    // var_dump($item);
                    // die();

                    // Aquí asume que $yourJsonResponse es tu objeto JsonResponse
                    $jsonResponse  = (new ProductController)
                    ->getProduct($paramsArray['idProduct'])
                    ;

                    // Obtener el contenido JSON de la respuesta
                    $jsonProduct =  $jsonResponse->getContent();

                    // Decodificar el JSON a un array asociativo
                    $arrProduct = json_decode($jsonProduct, true);

                    // Acceder a la propiedad 'prod_stock'
                    $prodStock = $arrProduct['products'][0]['prod_stock']; // Aquí asumo que hay al menos un producto en la lista
                    // var_dump($prodStock);
                    // die();

                    
                    // // var_dump($product->products->prod_stock);
                    // // var_dump($product['products']['prod_stock']);
                    // // // $stock = $product->first()->prod_stock;
                    // var_dump($product);
                    // die();


                    if($prodStock >= $paramsArray['quantity']) {
                        // echo 'hay suficiente stock';

                        $cartItem = $this->updateItem($idCart, $paramsArray);


                        if($cartItem) {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'La cantidad se ha actualizado correctamente',
                            );
                        }
                        else {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 402,
                                'message'   => 'Ha ocurrido un error al actualizar',
                            );

                        }


                    }
                    else {
                        // echo 'no hay suficiente stock';
                        $data = array(
                            'status'    => 'error',
                            'code'      => 403,
                            'message'   => 'No hay suficiente stock para la cantidad deseada',
                        );
                    }


                    // die();

                    // $cartItem = $this->addItem($idCart, $paramsArray);

                    // if($cartItem) {
                    //     $data = array(
                    //         'status'    => 'success',
                    //         'code'      => 200,
                    //         'message'   => 'El producto se ha agregado/actualizado en el carrito',
                    //     );
                    // }
                    // else {
                    //     $data = array(
                    //         'status'    => 'error',
                    //         'code'      => 404,
                    //         'message'   => 'El producto ya se encuentra en el carrito',
                    //     );

                    // }

                }
                // else {
                //     // Si no existe un carrito
                //     $cartParams = array(
                //         'idUser'        => $user->usu_idUser,
                //     );

                //     $userCart = (new CartController)
                //         ->saveUserCart($cartParams);

                //     // var_dump($userCart);
                //     // var_dump($userCart->cart_idCart);
                //     $idCart = $userCart->cart_idCart;

                    
                //     $cartSessionArr = array(
                //         'idUser' => $user->usu_idUser,
                //         'idCart'  => $idCart,
                //     );
                //     // var_dump($cartSessionArr);
                //     // die();

                //     $sessionID = $jwtAuth->encode($cartSessionArr);
                //     $cartParamsSession = array(
                //         'cart_id_session'        => $sessionID,
                //     );
                    
                //     $userCart = (new CartController)
                //         ->updateUserCartSession($idCart, $cartParamsSession);

                //     // var_dump($userCart);

                   
                //     $cartItem = $this->addItem($idCart, $paramsArray);

                //     if($cartItem) {
                //         $data = array(
                //             'status'    => 'success',
                //             'code'      => 200,
                //             'message'   => 'El producto se ha agregado/actualizado en el carrito',
                //         );
                //     }
                //     else {
                //         $data = array(
                //             'status'    => 'error',
                //             'code'      => 404,
                //             'message'   => 'El producto ya se encuentra en el carrito',
                //         );

                //     }


                //     // $data = array(
                //     //     'status'    => 'success',
                //     //     'code'      => 200,
                //     //     'message'   => 'El producto se ha agregado al carrito exitosamente',
                //     // );
                // }

            }
        }
        return response()->json($data, $data['code']);
    }
    
    
    public function updateItem($idCart, $paramsArray) {

        // // echo 'updating'; 
        // var_dump($idCart);
        // echo'|';
        // var_dump($paramsArray);
        // die();
        $itemUpdated = false;

        
        $paramsItemUpdate = array (
            "citm_quantity" => $paramsArray['quantity'],
        );

        // $cartItem = CartItem::where('citm_idItem', $product->citm_idItem)
        $cartItem = CartItem::where('citm_idItem', $paramsArray['idItem'])
        // ->update([
        //     'usu_birth_date' => $params->birthdate
        // ]);
        ->update($paramsItemUpdate);

        if($cartItem || $cartItem == 1){
            return true;
        }
        else {
            return false;
        }

        die();

        $product = CartItem::

            // with(
            //     [
            //         'itemsCart',
            //         // 'userAddressShipping.userShippingCountry', 
            //         // 'userAddressShipping.userShippingCountry.userState'
            //     ]
            // )

            // // where(
            // //     ['cart_idCart', $idCart],
            // //     // ['prod_idProducto', $paramsArray['id']],
            // // )
            // ->
            where([
                ['cart_idCart', '=', $idCart],
                ['prod_idProducto', '=', $paramsArray['id']],
                ['citm_isActive', '=', 1],
            ])
            ->first()
            ;

            // var_dump($product);
            // var_dump(empty($product));
            // die();

            // // if

            // var_dump($product);
            // print_r($product);

        if(!empty($product)) {
            // El item se ha agregado al carrito
            // return false;
            $idItem = $product->citm_idItem;

            $paramsItemUpdate = array (
                "citm_quantity" => $paramsArray['quantity'],
            );

            // var_dump($product->citm_idItem);
            $cartItem = CartItem::where('citm_idItem', $product->citm_idItem)
            // ->update([
            //     'usu_birth_date' => $params->birthdate
            // ]);
            ->update($paramsItemUpdate);

            // var_dump($cartItem);

        }
        else {
            // El item no se ha agregado en el carrito
            $cartItem = new CartItem();
            $cartItem->cart_idCart      = $idCart;
            $cartItem->prod_idProducto  = $paramsArray['id'];
            $cartItem->citm_quantity    = $paramsArray['quantity'];
            
            $cartItem->save();
        }

        // var_dump($cartItem);
        if($cartItem || $cartItem == 1){
            return true;
        }
        else {
            return false;
        }
    }
    

}
