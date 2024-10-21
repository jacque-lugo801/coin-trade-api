<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\ProductRating;
// use App\Http\Controllers\ProductController;

use App\Services\ProductService;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;
use Illuminate\Support\Str;


class ProductRatingController extends Controller
{
    protected $productService;

    public function __construct (
        ProductService  $productService,
    ) {
        $this->productService   = $productService;
    }

    // Obtener los productos que ha calificado el usuario(Comprador)
    public function getProductsRatedFmUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        try {
            $productsRated = ProductRating::
                where([
                    ["usu_idUser", "=", $user->usu_idUser],
                    ["prat_isActive", "=", 1],
                ])
                ->get()
                ->load('productRated')
            ;

            if(!empty($productsRated)){
                $data = array(
                    'rated' => $productsRated,
                );
            }
            else {
                $data = array(
                    'rated' => [],
                );
            }
        } catch (QueryException $e) {
            $data = array(
                'rated' => [],
            );
        }
        return response()->json($data);
    }

    // Calificar un producto
    public function ratingProduct(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        $json = $request->input('json', null);
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                "id"    => 'required',
                "sku"   => 'required',
                "name"  => 'nullable',
                "rate"  => 'required',
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
                $productRating = ProductRating::
                    where([
                        ["usu_idUser", "=", $user->usu_idUser],
                        ["prod_idProducto", "=", $paramsArray['id']],
                        ["prat_isActive", "=", 1],
                    ])
                ->
                    first()
                ;

                if(!empty($productRating)) {
                    //Si existe una calificacion del producto
                    $oldRate = ProductRating::
                        where('prat_idRating', $productRating->prat_idRating)
                        ->update([
                            'prat_isActive' => 0
                        ]);
                    
                    if($oldRate || $oldRate == 1) {
                        $rating = $this->addRating($user, $paramsArray);

                        if(!is_object($rating)) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al agregar la calificación.',
                            );
                        }
                        else {
                            $generalRate = $this->updateRateProduct($paramsArray);

                            if($generalRate || $generalRate == 1) {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'El producto se ha calificado exitosamente',
                                );
                            } else {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error al agregar la calificación.',
                                );
                            }
                        }
                    } else {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al agregar la calificación.',
                        );
                    }
                }
                else {
                    //Si NO existe una calificacion del producto
                    echo 'esta vacio, no se ha calificado';
                    $rating = $this->addRating($user, $paramsArray);

                    if(!is_object($rating)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al agregar la calificación.',
                        );
                    }
                    else {
                        $generalRate = $this->updateRateProduct($paramsArray);

                        if($generalRate || $generalRate == 1) {
                            $data = array(
                                'status'    => 'success',
                                'code'      => 200,
                                'message'   => 'El producto se ha calificado exitosamente',
                            );
                        } else {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al agregar la calificación.',
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


    // Agregar una calificacion al producto
    public function addRating($user, $paramsArray) {
        if(!empty($user || !empty($paramsArray))) {
            try {
                $rate = new ProductRating();
                $rate->usu_idUser           = $user->usu_idUser;
                $rate->prod_idProducto      = $paramsArray['id'];
                $rate->prat_rating          = $paramsArray['rate'];
                $rate->prat_isActive        = 1;
        
                $rate->save();
                return $rate;
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
    
    //Actualizar calificación al producto
    public function updateRateProduct($paramsArray) {
        if(!empty($paramsArray)) {
            $allRates = ProductRating::
                where([
                    ["prod_idProducto", "=", $paramsArray['id']],
                    ["prat_isActive", "=", 1],
                ])
            ->
                get()
            ;

            $total = 0;
            $rating = 0;
            $numCount = count($allRates);

            if($allRates->isEmpty()){
                return 0;
            }
            else {
                foreach($allRates as $rate){
                    $total += $rate->prat_rating;
                }

                $rating = $total / $numCount;

                $productRate = $this->productService->updateProductRate($paramsArray, $rating);

                return $productRate;
            }
        }
        else {
            return 0;
        }
    }
}
