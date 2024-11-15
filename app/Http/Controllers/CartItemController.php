<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CartItem;
use App\Models\Cart;

use App\Http\Controllers\MailController;
use App\Services\CartService;
use App\Services\ProductService;


class CartItemController extends Controller
{
    protected $cartService;
    protected $productService;
    protected $mailController;

    public function __construct (
        CartService     $cartService,
        ProductService  $productService,
        MailController  $mailController,
    ) {
        $this->cartService      = $cartService;
        $this->productService   = $productService;
        $this->mailController   = $mailController;
    }
    
    // **************************************************
    // *                    AUTH                        *
    // **************************************************

    // Añadir producto al carrito
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
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al agregar el producto al carrito',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // Verificar que el producto exista
                $productCollection = $this->productService->getProductByID($paramsArray['id']);

                if($productCollection->isEmpty()) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al agregar el producto al carrito',
                    );
                }
                else {
                    $product = $productCollection->first();

                    if(
                        ($paramsArray['sku'] !== $product->prod_sku) &&  
                        ($paramsArray['name'] !== $product->prod_country)
                    ) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al agregar el producto al carrito',
                        );
                    }
                    else {
                        // Verificar que se haya creado antes un carrito para el ususario
                        $cart = $this->cartService->getCartByUserID($user->usu_idUser);

                        // || is_null($cart)
                        if(!empty($cart) ) {
                            // Si ya existe algun registro de carrito
                            $idCart = $cart->cart_idCart;
        
                            $cartItem = $this->addItem($idCart, $paramsArray);

                            if(!is_object($cartItem)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 409,
                                    'message'   => 'El producto ya se encuentra en el carrito',
                                );
                            }
                            else {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'El producto se ha agregado/actualizado en el carrito',
                                );
                            }
                        }
                        else {
                            // Si no existe algun registro de carrito
                            $cartParams = array(
                                'idUser'        => $user->usu_idUser,
                            );
                            
                            $cartUser = $this->cartService->saveCartUser($cartParams);

                            if(!is_object($cartUser)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error al agregar el producto al carrito',
                                );
                            }
                            else {
                                $idCart = $cartUser->cart_idCart;
    
                                $cartSessionArr = array(
                                    'idUser' => $user->usu_idUser,
                                    'idCart'  => $idCart,
                                );
                                $sessionID = $jwtAuth->encode($cartSessionArr);

                                $cartParamsSession = array(
                                    'cart_id_session'        => $sessionID,
                                );

                                $cartUserUpdate = $this->cartService->updateCartUserSession($idCart, $cartParamsSession);

                                if($cartUserUpdate || $cartUserUpdate == 1) {
                                    $cartItem = $this->addItem($idCart, $paramsArray);
                                            
                                    if(!is_object($cartItem)) {
                                        $data = array(
                                            'status'    => 'error',
                                            'code'      => 409,
                                            'message'   => 'El producto ya se encuentra en el carrito',
                                        );
                                    }
                                    else {
                                        $data = array(
                                            'status'    => 'success',
                                            'code'      => 200,
                                            'message'   => 'El producto se ha agregado/actualizado en el carrito',
                                        );
                                    }
                                }
                                else {
                                    $data = array(
                                        'status'    => 'error',
                                        'code'      => 400,
                                        'message'   => 'Ha ocurrido un error al agregar el producto al carrito',
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                // 'message'   => 'Petición errónea.',
                'message'   => 'No se encontró el recurso solicitado.',
            );
        }
        return response()->json($data, $data['code']);
    } 

    // Agregar el producto
    public function addItem($idCart, $paramsArray) {
        // $itemAdded = false;
        if(!empty($idCart) || !empty($paramsArray)) {
            try {
                $product = CartItem::
                    where([
                        ['cart_idCart', '=', $idCart],
                        ['prod_idProducto', '=', $paramsArray['id']],
                        ['citm_isActive', '=', 1],
                    ])
                ->
                    first()
                ;
                        
                if(!empty($product)){
                    // El item se ha agregado al carrito
                    $idItem = $product->citm_idItem;

                    $paramsItemUpdate = array (
                        "citm_quantity" => $paramsArray['quantity'],
                    );

                    $cartItem = CartItem::where('citm_idItem', $product->citm_idItem)
                        ->update($paramsItemUpdate);

                    if($cartItem || $cartItem == 1) {
                        return 1;
                    }
                    else {
                        return 0;
                    }
                }
                else {
                    // El item no se ha agregado en el carrito
                    $cartItem = new CartItem();
                    $cartItem->cart_idCart      = $idCart;
                    $cartItem->prod_idProducto  = $paramsArray['id'];
                    $cartItem->citm_quantity    = $paramsArray['quantity'];
                    
                    $cartItem->save();

                    return $cartItem;
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
    
    // Actualizar producto del carrito
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
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al actualizar el producto del carrito',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // Verificar que se haya creado antes un carrito para el ususario
                $cart = $this->cartService->getCartByUserID($user->usu_idUser);
                
                if(!empty($cart)) {
                    // Si ya existe algun registro de carrito
                    $idCart = $cart->cart_idCart;

                    $cartItem = $this->cartService->getCartItem($idCart, $paramsArray);

                    if(!is_object($cartItem)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al actualizar el producto del carrito',
                        );
                    }
                    else {
                        // Obtener informacion del producto
                        $productCollection = $this->productService->getProductByID($paramsArray['idProduct']);
                        
                        if($productCollection->isEmpty()) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al actualizar el producto del carrito',
                            );
                        }
                        else {
                            $product = $productCollection->first();
                            $productStock = $product->prod_stock;

                            // if($productStock >= $paramsArray['quantity']) {
                            if($productStock < $paramsArray['quantity']) {
                                // echo 'no suficiente stock';
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 409,
                                    'message'   => 'Ha ocurrido un error al actualizar el producto del carrito',
                                );
                            }
                            else {
                                // echo 'suficiente stock';
                                $cartItemUpdate = $this->updateItem($idCart, $cartItem->citm_idItem, $paramsArray);
                                
                                if($cartItemUpdate || $cartItemUpdate == 1) {
                                    $data = array(
                                        'status'    => 'success',
                                        'code'      => 200,
                                        'message'   => 'La cantidad se ha actualizado correctamente',
                                    );
                                }
                                else {
                                    $data = array(
                                        'status'    => 'error',
                                        'code'      => 400,
                                        'message'   => 'Ha ocurrido un error al actualizar el producto del carrito',
                                    );
                                }
                            }
                        }
                    }

                }
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 402,
                        'message'   => 'Ha ocurrido un error al actualizar el producto del carrito',
                    );
                }
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                // 'message'   => 'Petición errónea.',
                'message'   => 'No se encontró el recurso solicitado.',
            );
        }
        return response()->json($data, $data['code']);
    }

    // Actualizar producto
    public function updateItem($idCart, $idItem, $paramsArray) {
        if(!empty($idCart) || !empty($idItem) || !empty($paramsArray)) {
            try {
                $paramsItemUpdate = array (
                    "citm_quantity" => $paramsArray['quantity'],
                );
                        
                $cartItem = CartItem::where('citm_idItem', $idItem)
                    ->update($paramsItemUpdate);

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

    // Eliminar producto del carrito
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
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al eliminar el producto al carrito',
                    'errors'    => $validate->errors()
                );
            }
            else {
                // Verificar que se haya creado antes un carrito para el ususario
                $cart = $this->cartService->getCartByUserID($user->usu_idUser);
            
                if(!empty($cart)) {
                    // Si ya existe algun registro de carrito
                    $idCart = $cart->cart_idCart;

                    $cartItem = $this->cartService->getCartItem($idCart, $paramsArray);

                    if(!is_object($cartItem)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al eliminar el producto al carrito',
                        );
                    }
                    else {
                        // $cartItemRemove = $this->removeItem($idCart, $cartItem->citm_idItem);
                        $cartItemRemove = $this->cartService->removeItem($idCart, $cartItem->citm_idItem);

                        if($cartItemRemove || $cartItemRemove == 1) {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'El producto se ha eliminado del carrito.',
                            );
                        }
                        else {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al eliminar el producto al carrito',
                            );
                        }
                    }
                }
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al eliminar el producto al carrito',
                    );
                }
            }
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                // 'message'   => 'Petición errónea.',
                'message'   => 'No se encontró el recurso solicitado.',
            );
        }
        return response()->json($data, $data['code']);
    }

    // Eliminar producto
    // public function removeItem($idCart, $idItem) {
    //     if(!empty($idCart) || !empty($idItem)) {
    //         try {  
    //             $cartItem = CartItem::
    //                 where([
    //                     ['cart_idCart', '=', $idCart],
    //                     ['citm_idItem', '=', $idItem],
    //                 ])
    //             ->
    //                 update(
    //                     ['citm_isActive' => 0]
    //                 )
    //             ;

    //             if($cartItem || $cartItem == 1) {
    //                 return 1;
    //             }
    //             else {
    //                 return 0;
    //             }
    //         } catch (QueryException $e) {
    //             // $errorCode = $e->getCode();
    //             // $errorMessage = $e->getMessage();
    //             // Log::error("Error on saveSignupAddress. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
    //             // return response()->json(['error' => 'Ocurrió un error en la consulta.'], 500);
    //             return 0;
    //         }
    //     }
    //     else {
    //         return 0;
    //     }
    // }
    

}
