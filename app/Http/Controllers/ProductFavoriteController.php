<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductFavorite;
use App\Http\Controllers\ProductController;

use App\Services\ProductService;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;
use Illuminate\Support\Str;

class ProductFavoriteController extends Controller
{
    protected $productService;

    public function __construct (
        ProductService  $productService,
    ) {
        $this->productService   = $productService;
    }

    // Obtener los productos favoritos del usuario
    public function getProductsFavoriteFmUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        
        $user = $jwtAuth->checkToken($token, true);

        try {
            $productsFavorites = ProductFavorite::
                where([
                    ["usu_idUser", "=", $user->usu_idUser],
                    ["ufav_isActive", "=", 1],
                ])
                ->get()
                ->load('productFavorite')
            ;
            if(!empty($productsFavorites)){
                $data = array(
                    'favorites' => $productsFavorites,
                );
            }
            else {
                $data = array(
                    'favorites' => [],
                );
            }

        } catch (QueryException $e) {
            $data = array(
                'favorites' => [],
            );
        }
        return response()->json($data);
    }

    // Agregar como favorito
    public function favoriteProduct(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);
        
        // Recoger datos usuarios
        $json = $request->input('json', null);
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            // var_dump($paramsArray);
            $validate = \Validator::make($paramsArray, [
                "id"        => 'required',
                "sku"       => 'required',
                "name"      => 'nullable',
                "favorite"  => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al agregar la calificación.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $productFavorite = ProductFavorite::
                    where([
                        ["usu_idUser",      "=", $user->usu_idUser],
                        ["prod_idProducto", "=", $paramsArray['id']],
                        ["ufav_isActive",   "=", 1],
                    ])
                ->
                    first()
                ;

                if(!empty($productFavorite)) {
                    //Si ya se ha agregado como favorito
                    if($paramsArray['favorite'] == 0) {
                        $remove = $this->removeFavorite($productFavorite);
                        
                        if($remove || $remove == 1) {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'El producto se ha removido de favoritos',
                            );
                        }
                        else {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al agregar como favorito. d',
                            );
                        }
                    }
                }
                else {
                    //Si NO se ha agregado como favorito
                    if($paramsArray['favorite'] == 1) {
                        $add = $this->addFavorite($user, $paramsArray);
                            
                        if(!is_object($add)) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al agregar como favorito.',
                            );
                        }
                        else {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'El producto se ha agregado a favoritos',
                            );
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

    // Agregar producto como favorito
    public function addFavorite($user, $paramsArray) {
        if(!empty($user || !empty($paramsArray))) {
            try {
                $favorite = new ProductFavorite();
                $favorite->usu_idUser       = $user->usu_idUser;
                $favorite->prod_idProducto  = $paramsArray['id'];
                $favorite->ufav_isActive    = 1;
        
                $favorite->save();
                return $favorite;
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

    // Eliminar favorito
    public function removeFavorite($productFavorite) {
        if(!empty($productFavorite)) {
            try {
                $oldFavorite = ProductFavorite::
                    where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
                    ->update([
                        'ufav_isActive' => 0
                    ]);
                return $oldFavorite;
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



    
    public function favoriteProduct2(Request $request) {
        // echo 'fav';

        
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
                "id"        => 'required',
                "sku"       => 'required',
                "name"      => 'nullable',
                "favorite"  => 'required',
            ]);

            if($validate->fails()) {
                
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error al agregar como favorito',
                    'errors'    => $validate->errors()
                );
            }
            else {
                
                $productFavorite = ProductFavorite::
                                
                    where([
                        ["usu_idUser",      "=", $user->usu_idUser],
                        ["prod_idProducto", "=", $paramsArray['id']],
                        ["ufav_isActive",   "=", 1],
                    ])
                ->
                first()
                ;

                // var_dump($paramsArray['favorite']);

                // die();

                if(!$productFavorite) {
                    //Si no se ha agregado como favorito

                    if($paramsArray['favorite'] == 1) {
                        // echo 'agregar-----<br>';
                        $this->addFavorite($user, $paramsArray);

                    }
                    /*
                    if($paramsArray['favorite'] == 0) {
                        // echo 'remover-----<br>';
                        $this->removeFavorite($productFavorite);
                        //     //Si no se ha agregado como favorito
                        //     // $this->addFavorite($user, $paramsArray);
                        //     $this->removeFavorite($productFavorite);

                    }
                    else if($paramsArray['favorite'] == 1) {
                        // echo 'agregar-----<br>';
                        $this->addFavorite($user, $paramsArray);

                    }

                    */
                    // // $this->updateFavoriteProduct($paramsArray);
                    // if($paramsArray['favorite'] == 0) {

                    //     $this->removeFavorite($productFavorite);
                    //     // $this->addFavorite($user, $paramsArray, 1);
                    // }
                    // else if($paramsArray['favorite'] == 1) {

                    //     // $oldFavorite = ProductFavorite::
                    //     //     where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
                    //     //     ->update([
                    //     //         'ufav_isActive' => 0
                    //     //     ]);
                        
                    //     // $this->removeFavorite($productFavorite);
                    //     $this->addFavorite($user, $paramsArray);
                    // }
                }
                else {
                    //Si ya se agrego como favorito
                    // echo 'ya agregado-----<br>';
                    if($paramsArray['favorite'] == 0) {
                        // echo 'remover-----<br>';
                        $this->removeFavorite($productFavorite);
                        //     //Si no se ha agregado como favorito
                        //     // $this->addFavorite($user, $paramsArray);
                        //     $this->removeFavorite($productFavorite);

                    }
                    else if($paramsArray['favorite'] == 1) {
                        // echo 'agregar-----<br>';
                        // $this->addFavorite($user, $paramsArray);

                        if(!empty($productFavorite)) {

                            $this->removeFavorite($productFavorite);
                            $this->addFavorite($user, $paramsArray);
                        }
                        else {
                            $this->addFavorite($user, $paramsArray);
                        }

                    }
                    // // echo 'ya agregado';
                    // $oldFavorite = ProductFavorite::
                    //     where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
                    //     ->update([
                    //         'ufav_isActive' => 0
                    //     ]);

                        // if() {
                                
                        // if($paramsArray['favorite'] == 0) {
                        //     //Si no se ha agregado como favorito
                        //     // $this->addFavorite($user, $paramsArray);
                        //     $this->removeFavorite($productFavorite);

                        // }
                        // else if($paramsArray['favorite'] == 1) {

                        //     // $this->removeFavorite($productFavorite);
                        //     $this->addFavorite($user, $paramsArray);

                        //     // $oldFavorite = ProductFavorite::
                        //     //     where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
                        //     //     ->update([
                        //     //         'ufav_isActive' => 0
                        //     //     ]);
                        // }

                        // // }
                    
                    // $this->addFavorite($user, $paramsArray);
                }

                
                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El producto se ha calificado exitosamente',
                );
            }

        }
        return response()->json($data, $data['code']);
    }

    public function test() {
        echo 'hola';
    }

}


