<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductFavorite;
use App\Http\Controllers\ProductController;

class ProductFavoriteController extends Controller
{
    //

    public function favoriteProduct(Request $request) {
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
                    
                    // $this->updateFavoriteProduct($paramsArray);
                    if($paramsArray['favorite'] == 0) {
                        //Si no se ha agregado como favorito

                        $this->removeFavorite($productFavorite);
                        // $this->addFavorite($user, $paramsArray, 1);
                    }
                    else if($paramsArray['favorite'] == 1) {

                        // $oldFavorite = ProductFavorite::
                        //     where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
                        //     ->update([
                        //         'ufav_isActive' => 0
                        //     ]);
                        
                        // $this->removeFavorite($productFavorite);
                        $this->addFavorite($user, $paramsArray, 1);
                    }
                }
                else {
                    //Si ya se agrego como favorito

                    // // echo 'ya agregado';
                    // $oldFavorite = ProductFavorite::
                    //     where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
                    //     ->update([
                    //         'ufav_isActive' => 0
                    //     ]);

                        // if() {
                                
                        if($paramsArray['favorite'] == 0) {
                            //Si no se ha agregado como favorito
                            // $this->addFavorite($user, $paramsArray);
                            $this->removeFavorite($productFavorite);

                        }
                        else if($paramsArray['favorite'] == 1) {

                            // $this->removeFavorite($productFavorite);
                            $this->addFavorite($user, $paramsArray);

                            // $oldFavorite = ProductFavorite::
                            //     where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
                            //     ->update([
                            //         'ufav_isActive' => 0
                            //     ]);
                        }

                        // }
                    
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

    public function addFavorite($user, $paramsArray) {
        $favorite = new ProductFavorite();
        $favorite->usu_idUser       = $user->usu_idUser;
        $favorite->prod_idProducto  = $paramsArray['id'];
        $favorite->ufav_isActive    = 1;

        $favorite->save();
    }
    public function removeFavorite($productFavorite) {
        $oldFavorite = ProductFavorite::
            where('ufav_idFavorite', $productFavorite->ufav_idFavorite)
            ->update([
                'ufav_isActive' => 0
            ]);
    }
    // public function updateFavoriteProduct($paramsArray) {

    // }
}
