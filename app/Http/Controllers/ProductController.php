<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
// use App\Models\User;
use App\Models\Product;
// use App\Models\ProductType;

// use App\Http\Controllers\ProductCertificationsController;

use App\Http\Controllers\MailController;
use App\Services\UserService;
use App\Services\ProductService;

use Illuminate\Support\Facades\Storage;

use Money\Currencies\ISOCurrencies;
use Money\Currency;
use Money\Formatter\DecimalMoneyFormatter;
use Money\Money;

use Illuminate\Database\QueryException;
use Exception;

class ProductController extends Controller
{
    
    protected $userService;
    protected $productService;
    protected $mailController;

    public function __construct (
        UserService     $userService,
        ProductService  $productService,
        MailController  $mailController,
    ) {
        $this->userService      = $userService;
        $this->productService   = $productService;
        $this->mailController   = $mailController;
    }

    // Obtener todos los productos
    public function getAllProducts() {
        try {
            $products = Product::
                with(
                    [
                        'productCountry',
                        'productType',
                        'productGroup',
                        'productCategory',
                        'productStatus',
                    ]
                )
                ->
                where([
                    ["prod_isActive", "=", 1],
                    ["prod_isAuthorized", "=", 1],
                    ["psts_idStatus", "!=", 2],
                    ["psts_idStatus", "!=", 5],
                ])
                ->get()
                ->load('productUser')
                ->load('productCertifications')
            ;
            
            // Eliminar propiedades del rtesponse
            $products->transform(function ($product) {
                if (isset($product->productUser)) {
                    unset(
                        $product->productUser->usu_phone_local,
                        $product->productUser->usu_birth_date,
                        $product->productUser->usu_identity,
                        $product->productUser->usu_username,
                        $product->productUser->usu_mail_account,
                        $product->productUser->usu_created_date,
                        $product->productUser->usu_updated_date,
                        $product->productUser->usts_idStatus,
                        $product->productUser->urol_idRol,
                        $product->productUser->usu_isVerification,
                        $product->productUser->usu_isVerificated,
                    );
                }
                return $product;
            });
            
        } catch (QueryException $e){
            $products = [];
        }
        return response()->json([
            'products' => $products
        ]);
    }
    
    // Obtener la imagen
    public function getImage($filename) {
        $isset =  \Storage::disk('products')->exists($filename);

        if($isset) {
            $file = \Storage::disk('products')->get($filename);

            return new Response($file, 200);
        }
        else {
            $data = array(
                'status'    => 'error',
                // 'code'      => 400,
                // 'message'   => 'No existe la imagen',
                'code'      => 404,
                'message'   => 'No se encontró la imagen.',
            );
            return response()->json($data, $data['code']);
        }
    }

    // Obtener el producto con el ID proporcionado
    public function getProduct($id) {
        if(isset($id)) {
            $id = str_replace('"', '', $id);

            $product = $this->productService->getProductByID($id);
        }
        else {
            $product = [];
        }
        
        return response()->json([
            'products' => $product
        ]);
    }

    // Obtener todos los productos de MONEDAS
    public function getAllCoins() {
        $idType = $this->productService->getProductTypeID('Moneda');

        try {
            $products = Product::
                where([
                    // ["prod_isActive", "=", 1],
                    ["prod_idType_product", "=", $idType],
                ])
                ->get()
                ->load('productType')
                ->load('productUser')
                ->load('productStatus')
                ->load('productCertifications')
            ;
        } catch (QueryException $e) {
            $products = [];
        }
        return response()->json([
            'products' => $products
        ]);
    }

    // Obtener todos los productos de BILLETES
    public function getAllBills() {
        $idType = $this->productService->getProductTypeID('Billete');

        try {
            $products = Product::
                where([
                    // ["prod_isActive", "=", 1],
                    ["prod_idType_product", "=", $idType],
                ])
                ->get()
                ->load('productType')
                ->load('productUser')
                ->load('productStatus')
                ->load('productCertifications')
            ;
        } catch (QueryException $e) {
            $products = [];
        }
        return response()->json([
            'products' => $products
        ]);
    }



    
    // **************************************************
    // *                    AUTH                        *
    // **************************************************
    
    //Obtener los productos del usuario
    public function getProductsFmUser(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        try {
            $products = Product::
                with(
                    [
                        'productCountry',
                        'productType',
                        'productGroup',
                        'productCategory',
                        'productStatus',
                    ]
                )
                ->where("usu_idUser", "=", $user->usu_idUser)
                ->orderBy('prod_idProducto', 'desc')
                ->get()
                ->load('productCertifications')

            ;

            $data = array(
                'products' => $products,
            );

            // if(!empty($products)) {
            //     $data = array(
            //         'products' => $products,
            //     );
            // }
            // else {
            //     $data = array(
            //         'products' => [],
            //     );
            // }
        } catch (QueryException $e) {
            $data = array(
                'products' => [],
            );
        }
        return response()->json($data);
    }

    // Actualizar el producto del usuario
    public function updateProduct(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // Recoger datos por post
        $json = $request->input('json', null);
        
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);

        if(!empty($params) && !empty($paramsArray)) {
            $validate = \Validator::make($paramsArray, [
                "type"              => 'required',
                "typeName"          => 'required',
                "status"            => 'required',
                "idProducto"        => 'required',
                "sku"               => 'required',
                "name"              => 'required',
                "country"           => 'required',
                "productGroup"      => 'required',
                "description"       => 'required',
                "stock"             => 'required',
                "unitCost"          => 'required',
                "comission"         => 'required',
                "total"             => 'required',
                "isBill"            => 'required',
            ]);

            if ($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error en la actualizacion del producto.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                if($params->isBill == 1) {
                    $validateBill = \Validator::make($paramsArray, [
                        "serie"             => 'required',
                        "condition"         => 'required',
                        "date"              => 'required',
                        "number"            => 'required',
                    ]);

                    if($validateBill->fails()) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en la actualizacion del producto.',
                            'errors'    => $validateBill->errors()
                        );
                    }
                    else {
                        try {
                            $paramsUpdate = array (
                                "psts_idStatus"         => $params->status,
                                "prod_name"             => $params->name,
                                "prod_country"          => $params->country,
                                "prod_idGroup_product"  => $params->productGroup,
                                "prod_description"      => $params->description,
                                "prod_stock"            => $params->stock,
                                "prod_unit_cost"        => $params->unitCost,
                                "prod_commission"       => $params->comission,
                                "prod_total"            => $params->total,
    
                                "prod_serie"            => $params->serie,
                                "prod_condition"        => $params->condition,
                                "prod_date"             => $params->date,
                                "prod_number"           => $params->number,

                                "prod_isAuthorized"     => 0,
                            );
                            
                            $productUpdate = Product::
                                where('prod_idProducto', $params->idProducto)
                                ->update($paramsUpdate);

                            if(!isset($productUpdate) && empty($productUpdate)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error en la actualización del producto.',
                                );
                            }
                            else {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'El producto se ha actualizado exitosamente',
                                );
                            }
                        } catch (QueryException $e) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en la actualización de datos.',
                            );
                        }
                    }
                }
                else {
                    $validateCoin = \Validator::make($paramsArray, [
                        "weight"            => 'required',
                        "metal"             => 'required',
                        "minting"           => 'required',
                        "productGroup"      => 'required',
                        "fineness"          => 'required',
                        "diameter"          => 'required',
                        "denomination"      => 'required',
                        "productCategory"   => 'required',
                    ]);

                    if($validateCoin->fails()) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error en la actualizacion del producto.',
                            'errors'    => $validateCoin->errors()
                        );
                    }
                    else {
                        try {
                            $paramsUpdate = array (
                                "psts_idStatus"             => $params->status,
                                "prod_name"                 => $params->name,
                                "prod_country"              => $params->country,
                                "prod_idGroup_product"      => $params->productGroup,
                                "prod_description"          => $params->description,
                                "prod_stock"                => $params->stock,
                                "prod_unit_cost"            => $params->unitCost,
                                "prod_commission"           => $params->comission,
                                "prod_total"                => $params->total,
    
                                "prod_metal"                => $params->metal,
                                "prod_diameter"             => $params->diameter,
                                "prod_weight"               => $params->weight,
                                "prod_minting"              => $params->minting,
                                "prod_fineness"             => $params->fineness,
                                "prod_denomination"         => $params->denomination,
                                "prod_idCategory_product"   => $params->productCategory,

                                "prod_isAuthorized"         => 0,
                            );
                            
                            $productUpdate = Product::
                                where('prod_idProducto', $params->idProducto)
                                ->update($paramsUpdate);

                            if(!isset($productUpdate) && empty($productUpdate)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error en la actualización del producto.',
                                );
                            }
                            else {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'El producto se ha actualizado exitosamente',
                                );
                            }
                        } catch (QueryException $e) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error en la actualización de datos.',
                            );
                        }
                    }
                }
                return response()->json($data, $data['code']);
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

    // Guardar imagen en storage
    public function uploadImage(Request $request) {
        $image = $request->file('image');

        // Validacion de imagen
        $validate = \Validator::make($request->all(), [
            'image' => 'required|image|mimes:jpg,jpeg,png'
            // 'file0' => 'required|image|mimes:jpg,jpeg,png'
        ]);

        if(!$image || $validate->fails()) {
            $data = array(
                'status'    => 'error',
                'code'      => 400,
                'message'   => 'Ha ocurrido un error al intentar guardar la imagen al servidor ',
                'image'     => $image,
                'validate'  => $validate->errors()
            );
        }
        else {
            $image_name = time() . '-' .$image->getClientOriginalName();
            \Storage::disk('products')->put($image_name, \File::get($image)); 
            
            // $image_name = time() . '-' . $request->file('image')->hashName();
            // // var_dump($image_name);
            // \Storage::disk('products')->put($image_name, file_get_contents($request->file('image'))); 

            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'message'   => 'La imagen se ha guardado al servidor correctamente',
                'image'     => $image_name,
            );
        }
        return response()->json($data, $data['code']);
    }

    // Guardar un nuevo producto
    public function uploadProduct(Request $request) {
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
                "type"              => 'required',
                "typeName"          => 'required',
                "sku"               => 'required',
                "name"              => 'required',
                "country"           => 'required',
                "weight"            => 'nullable',
                "metal"             => 'nullable',
                "minting"           => 'nullable',
                "productGroup"      => 'required',
                "fineness"          => 'nullable',
                "diameter"          => 'nullable',
                "serie"             => 'nullable',
                "condition"         => 'nullable',
                "denomination"      => 'nullable',
                "date"              => 'nullable',
                "number"            => 'nullable',
                "productCategory"   => 'nullable',
                "description"       => 'required',
                "stock"             => 'required',
                "unitCost"          => 'required',
                "comission"         => 'required',
                "total"             => 'required',
                "imageFront"        => 'required',
                "imageBack"         => 'required',
                "imageCertificate"  => 'required',
                "terms"             => 'required',
            ]);

            if ($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al guardar el producto.',
                    'errors'    => $validate->errors()
                );
            }
            else {
                $idStatus = $this->productService->getProductStatusID('Pendiente');

                if($idStatus == 0) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al guardar el producto.',
                    );
                } else {
                    // check for sku name
                    $nSku = $this->getLastProduct($paramsArray['type']);
                    
                    if(!is_string($nSku)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al guardar el producto.',
                        );
                    }
                    else {
                        try {
                            $product = new Product();
        
                            $product->prod_sku                  = $nSku;
                            $product->prod_name                 = $paramsArray['name'];
                            $product->prod_description          = $paramsArray['description'];
                            $product->prod_country              = $paramsArray['country'];
                            $product->usu_idUser                = $user->usu_idUser;
            
                            $product->prod_idType_product       = $paramsArray['type'];
                            $product->prod_unit_cost            = $paramsArray['unitCost'];
                            $product->prod_commission           = $paramsArray['comission'];
                            $product->prod_total                = $paramsArray['total'];
                            $product->prod_stock                = $paramsArray['stock'];
                            $product->prod_isTerms              = $paramsArray['terms'];
                            // $product->psts_idStatus             = 2;
                            $product->psts_idStatus             = $idStatus;
            
                            switch ($params->type) {
                                case 2:
                                    $product->prod_condition            = $paramsArray['condition'];
                                    $product->prod_date                 = $paramsArray['date'];
                                    $product->prod_serie                = $paramsArray['serie'];
                                    $product->prod_number               = $paramsArray['number'];
                                    $product->prod_idGroup_product      = $paramsArray['productGroup'];
                                    $product->prod_image_front          = $paramsArray['imageFront'];
                                    $product->prod_image_back           = $paramsArray['imageBack'];
            
                                    $paramsProduct = array (
                                        "prod_sku"                  => $params->sku,
                                        "prod_name"                 => $params->name,
                                        "prod_description"          => $params->description,
                                        "prod_country"              => $params->country,
            
                                        "prod_condition"            => $params->condition,
                                        "prod_date"                 => $params->date,
                                        "prod_serie"                => $params->serie,
                                        "prod_number"               => $params->number,
            
                                        "prod_idType_product"       => $params->type,
                                        "prod_idGroup_product"      => $params->productGroup,
            
                                        "prod_image_front"          => $params->imageFront,
                                        "prod_image_back"           => $params->imageBack,
                                        "prod_image_certificate"    => $params->imageCertificate,
                                        "prod_unit_cost"            => $params->unitCost,
                                        "prod_commission"           => $params->comission,
                                        "prod_total"                => $params->total,
                                        "prod_stock"                => $params->stock,
                                        "prod_isTerms"              => $params->terms,
                                    );
                                    break;
            
                                case 1:
                                    $product->prod_metal                = $paramsArray['metal'];
                                    $product->prod_diameter             = $paramsArray['diameter'];
                                    $product->prod_weight               = $paramsArray['weight'];
                                    $product->prod_minting              = $paramsArray['minting'];
                                    $product->prod_fineness             = $paramsArray['fineness'];
                                    $product->prod_denomination         = $paramsArray['denomination'];
                                    $product->prod_idGroup_product      = $paramsArray['productGroup'];
                                    $product->prod_idCategory_product   = $paramsArray['productCategory'];
                                    $product->prod_image_front          = $paramsArray['imageFront'];
                                    $product->prod_image_back           = $paramsArray['imageBack'];
            
                                    $paramsProduct = array (
                                        "prod_sku"                  => $params->sku,
                                        "prod_name"                 => $params->name,
                                        "prod_description"          => $params->description,
                                        "prod_country"              => $params->country,
                                        "prod_metal"                => $params->metal,
                                        "prod_diameter"             => $params->diameter,
                                        "prod_weight"               => $params->weight,
                                        "prod_minting"              => $params->minting,
                                        "prod_fineness"             => $params->fineness,
                                        "prod_denomination"         => $params->denomination,
                                        "prod_idType_product"       => $params->type,
                                        "prod_idGroup_product"      => $params->productGroup,
                                        "prod_idCategory_product"   => $params->productCategory,
                                        "prod_image_front"          => $params->imageFront,
                                        "prod_image_back"           => $params->imageBack,
                                        "prod_image_certificate"    => $params->imageCertificate,
                                        "prod_unit_cost"            => $params->unitCost,
                                        "prod_commission"           => $params->comission,
                                        "prod_total"                => $params->total,
                                        "prod_stock"                => $params->stock,
                                        "prod_isTerms"              => $params->terms,
                                    );
                                    break;
                                
                                default:
                                    break;
                            }

                            $product->save();

                            $idProducto = $product->prod_idProducto;

                            if(!isset($idProducto) && empty($idProducto)) {
                                $data = array(
                                    'status'    => 'error',
                                    'code'      => 400,
                                    'message'   => 'Ha ocurrido un error al guardar el producto.',
                                );
                            }
                            else {
                                //Guardar datos certificado
                                $certificateParams = array(
                                    'imageCertificate'  => $paramsArray['imageCertificate'],
                                    'idProduct'         => $idProducto,
                                );

                                // $certificate = (new ProductCertificationsController)
                                    // ->saveCertificate($certificateParams);
                                $certificate = $this->productService->saveProductCertificate($certificateParams);
                                
                                if(!is_object($certificate)) {
                                    // Si no se guarda el certificado, borrar el producto antes guardado
                                    $deleted = Product::where('prod_idProducto', '=', $idProducto) -> delete();

                                    $data = array(
                                        'status'    => 'error',
                                        'code'      => 400,
                                        'message'   => 'Ha ocurrido un error al guardar el producto.',
                                    );
                                }
                                else {
                                    // $sendMailCode = $this->mailController->productUpload($idProducto, $user);
                                    $productInfo = $this->productService->getProductInfoByID($idProducto);
                                    
                                    $sendMailCode = $this->mailController->productUpload($productInfo, $user);

                                     // Procesar la respuesta del MailController
                                    if (isset($sendMailCode['error'])) {
                                        // $data = array(
                                        //     'status' => 'error',
                                        //     'code' => 404,
                                        //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                        // );
                                        if(isset($idProducto)) {
                                            $data = array(
                                                'status' => 'success',
                                                'code' => 200,
                                                'message' => 'El producto se ha guardado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
                                            );
                                        }
                                        else {
                                            $data = array(
                                                'status' => 'error',
                                                'code' => 400,
                                                'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                            );
                                        }
                                    }
                                    elseif ($sendMailCode['status'] === 'success') {
                                        $data = array(
                                            // 'status' => 'success',
                                            // 'code' => 200,
                                            // 'message' => 'El usuario se ha creado correctamente y se ha enviado el correo de verificación.',
                                            'status'    => 'success',
                                            'code'      => 200,
                                            'message'   => 'El producto se ha guardado correctamente y se ha enviado el correo de verificación.',
                                        );
                                        
                                    }
                                    else {
                                        // $data = array(
                                        //     'status' => 'error',
                                        //     'code' => 500,
                                        //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                        // );
                                        
                                        if(isset($idProducto)) {
                                            $data = array(
                                                'status' => 'success',
                                                'code' => 200,
                                                'message' => 'El producto se ha guardado correctamente, pero ha ocurrido un error al enviar el correo: ' . $sendMailCode['error'],
                                            );
                                        }
                                        else {
                                            $data = array(
                                                'status' => 'error',
                                                // 'code' => 500,
                                                'code' => 400,
                                                'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                            );
                                        }
                                    }
                                }

                            }
                        } catch (QueryException $e) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al guardar el producto.',
                            );
                        }
                    }
                }
                return response()->json($data, $data['code']);
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




    

    // **************************************************
    // *                    ADMIN                       *
    // **************************************************

    // Obtener los productos para verificación/aprobación
    public function getProductsForVerification() {
        try {
            $products = Product::
                with(
                    [
                        'productCountry',
                        'productType',
                        'productGroup',
                        'productCategory',
                        'productStatus',
                        'productUser',
                        'productUser.userRol',
                        'productUser.userStatus',
                    ]
                )
            ->
                where([
                    ["prod_isActive", "=", 1],
                ])
            ->orderBy('prod_idProducto', 'desc')
            ->get()
            ->load('productCertifications')
            ;
                
            return response()->json([
                'products' => $products
            ]);

        } catch (QueryException $e){
            $products = [];
        }

        return response()->json([
            'products' => $products
        ]);
    }

    // Aprobar/desaprobar un producto
    public function approveDisapproveProduct(Request $request) {
        $json = $request->input('json', null);
        
        $params = json_decode($json);
        $paramsArray = json_decode($json, true);

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'idProducto'    => 'required',
                'isApprove'     => 'required',
                'type'          => 'required ',
                'typeName'      => 'nullable ',
                'sku'           => 'required ',
                'seller'        => 'required ',
                'sellerMail'    => 'required ',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al intentar aprobar/desaprobar ',
                    'errors'    => $validate->errors()
                );
            }
            else {
                try {
                    $paramsUpdate = array (
                        "prod_isAuthorized"  => $params->isApprove,
                    );

                    $update = Product::
                        where('prod_idProducto', $params->idProducto)
                        ->where('prod_sku', $params->sku)
                        ->update($paramsUpdate);

                    if(!isset($update) && empty($update)) {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al aprobar/desaprobar el producto.',
                        );
                    }
                    else {
                        $product = Product::
                            where('prod_idProducto', $params->idProducto)
                            ->where('prod_sku', $params->sku)
                            ->first();

                        // $user = User::where('usu_email', $params->sellerMail)->first();
                        // $user = User::where('usu_email', $params->sellerMail)->first();
                        $user = $this->userService->getUserByMail($params->sellerMail);

                        if(!is_object($user)) {
                            $data = array(
                                'status'    => 'error',
                                'code'      => 400,
                                'message'   => 'Ha ocurrido un error al aprobar/desaprobar el producto.',
                            );
                        }
                        else {
                            $paramsMail = array(
                                'name'          => $user->usu_name,
                                'lastname'      => $user->usu_lastname,
                                'mail'          => $user->usu_email,
                                'prodName'      => $product->prod_name,
                                'prodTotal'     => number_format($product->prod_total, 2, '.', ','),
                                'isApprove'     => $params->isApprove,
                            );

                            // Send email that its being authorized/non authorized
                            // (new MailController)->productAuthorizedByAdmin($paramsMail);
                            $sendMail = $this->mailController->productAuthorizedByAdmin($paramsMail);

                            // Procesar la respuesta del MailController
                            if (isset($sendMail['error'])) {
                                // $data = array(
                                //     'status' => 'error',
                                //     'code' => 404,
                                //     'message' => 'Error al enviar el correo: ' . $sendMailCode['error'],
                                // );
                                if(isset($update)) {
                                    $data = array(
                                        'status' => 'success',
                                        'code' => 200,
                                        'message' => 'El producto se ha aprobado/desaprobado, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
                                    );
                                }
                                else {
                                    $data = array(
                                        'status' => 'error',
                                        'code' => 400,
                                        'message' => 'Error al enviar el correo: ' . $sendMail['error'],
                                    );
                                }
                            }
                            elseif ($sendMail['status'] === 'success') {
                                $data = array(
                                    'status'    => 'success',
                                    'code'      => 200,
                                    'message'   => 'El producto se ha aprobado/desaprobado y se ha enviado el correo de verificación.',
                                );
                            }
                            else {
                                // // $data = array(
                                // //     'status' => 'error',
                                // //     'code' => 500,
                                // //     'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                // // );
                                
                                if(isset($update)) {
                                    $data = array(
                                        'status' => 'success',
                                        'code' => 200,
                                        'message' => 'El producto se ha aprobado/desaprobado, pero ha ocurrido un error al enviar el correo: ' . $sendMail['error'],
                                    );
                                }
                                else {
                                    $data = array(
                                        'status' => 'error',
                                        // 'code' => 500,
                                        'code' => 400,
                                        'message' => 'Ha ocurrido un error inesperado al enviar el correo de verificación.',
                                    );
                                }
                            }
                        }
                    }
                } catch (QueryException $e) {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error al aprobar/desaprobar el producto.',
                    );
                }
                
            }
            return response()->json($data, $data['code']);
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

    // Obtener informacion del producto
    public function getProductInfo(Request $request, $id) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        if(isset($id)) {
            $id = str_replace('"', '', $id);

            $product = $this->productService->getProductInfoByID($id);
        }
        else {
            $product = [];
        }
        
        return response()->json([
            'products' => $product
        ]);
    }




    // *******
    // Obtener el ultimo producto
    public function getLastProduct($type) {
        try {
            $products = Product::
                where([
                    ["prod_idType_product", "=", $type],
                ])
                ->get()
            ;

            $number = count($products) + 1;

            switch ($type) {
                case 1:
                    $name = 'MND'. $number;
                    break;

                case 2:
                    $name = 'BLE'. $number;
                    break;
                
                default:
                    break;
            }
            return $name;
        } catch (QueryException $e) {
            return 0;
        }
        return 0;
    }


    // Eliminar imagen del storage *****
    public function deleteImage(Request $request){
        // Recoger datos de la petición
        $image = $request->file('image');

        $previousImage = $request->input('previous_image'); // Recoger la imagen anterior, si es necesario

        // Validación de la imagen
        $validate = \Validator::make($request->all(), [
            'image' => 'required|image|mimes:jpg,jpeg,png'
        ]);

        if (!$image || $validate->fails()) {
            $data = array(
                'status'    => 'error',
                'code'      => 400,
                'message'   => 'Error al subir imagen',
                'image'     => $image,
                'validate'  => $validate->errors()
            );
        } else {
            // Eliminar la imagen anterior si existe
            if ($previousImage && \Storage::disk('products')->exists($previousImage)) {
                \Storage::disk('products')->delete($previousImage);
            }

            // Subir la nueva imagen
            $image_name = time() . '-' . $image->getClientOriginalName();
            \Storage::disk('products')->put($image_name, \File::get($image));

            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'image'     => $image_name,
            );
        }
        
        return response()->json($data, $data['code']);
    }




    // new

    
    public function uploadImage2(Request $request) {
        // recoger datos de la peticion
        // $image = $request->file('file0');
        $image = $request->file('file0');


        // Validacion de imagen
        $validate = \Validator::make($request->all(), [
            'file0' => 'image|mimes:jpg,jpeg,png'
            // 'file0' => 'required|image|mimes:jpg,jpeg,png'
        ]);


        // guardar la imagen
        if(!$image || $validate->fails()) {
                
            $data = array(
                'status'    => 'error',
                'code'      => 400,
                'message'   => 'Error al guardar imagen',
                'image'   => $image,
                'validate' => $validate->errors()
            );
        }
        else {
            $image_name = time() . '-' .$image->getClientOriginalName();
            \Storage::disk('products')->put($image_name, \File::get($image)); 

            $data = array(
                'status'    => 'success',
                'code'      => 200,
                'image'   => $image_name,
            );
        }

        // devolver el resultado

        return response()->json($data, $data['code']);
    }









    // public function requestUpgradeProduct(Request $request) {

    //     // $token = $request->header('Authorization');
    //     // $jwtAuth = new \App\Helpers\JwtAuth();

    //     // $user = $jwtAuth->checkToken($token, true);

    //     // Recoger datos por post
    //     $json = $request->input('json', null);
        
    //     $params = json_decode($json);
    //     $paramsArray = json_decode($json, true);

    //     if(!empty($params) && !empty($paramsArray)) {

    //         $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

    //         $validate = \Validator::make($paramsArray, [
    //             'idProducto'    => 'required',
    //             'isApprove'     => 'required',
    //             'type'          => 'required ',
    //             'typeName'      => 'nullable ',
    //             'sku'           => 'required ',
    //             'seller'        => 'required ',
    //             'sellerMail'    => 'required ',
    //         ]);

    //         if($validate->fails()) {
    //             $data = array(
    //                 'status'    => 'error',
    //                 'code'      => 402,
    //                 'message'   => 'Ha ocurrido un error al intentar aprobar/desaprobar ',
    //                 'errors'    => $validate->errors()
    //             );
    //         }
    //         else {
    //             $paramsUpdate = array (
    //                 "prod_isAuthorized"  => $params->isApprove,
    //             );


    //             $update = Product::
    //                 where('prod_idProducto', $params->idProducto)
    //                 ->where('prod_sku', $params->sku)
    //                 // ->update([
    //                 //     'usu_birth_date' => $params->birthdate
    //                 // ]);
    //                 ->update($paramsUpdate);

    //             if($update || $update == 1) {
                    
    //                 $product = Product::
    //                     where('prod_idProducto', $params->idProducto)
    //                     ->where('prod_sku', $params->sku)
    //                     ->first();

    //                 $user = User::where('usu_email', $params->sellerMail)->first();


    //                 $paramsMail = array(
    //                     'name'          => $user->usu_name,
    //                     'lastname'      => $user->usu_lastname,
    //                     'mail'          => $user->usu_email,
    //                     // 'mail'          => 'jacque.lugo801@gmail.com',
    //                     'prodName'      => $product->prod_name,
    //                     // 'prodImageF'    => $product->prod_image_front,
    //                     // 'prodImageB'    => $product->prod_image_back,
    //                     // 'prodTotal'     => $product->prod_total,
    //                     // 'prodTotal'     => Money::USD($product->prod_total),
    //                     'prodTotal'     => number_format($product->prod_total, 2, '.', ','),
    //                     'isApprove'     => $params->isApprove,
    //                 );


    //                 // var_dump($paramsMail);
    //                 // die();
    //                 // Send email that its being authorized/non authorized
    //                 (new MailController)->productAuthorizedByAdmin($paramsMail);

                    
    //                 $data = array(
    //                     'status'    => 'success',
    //                     'code'      => 200,
    //                     'message'   => 'El producto se ha bloqueado/desbloqueado exitosamente',
    //                 );
    //             }
    //         }
    //     }
        
    //     return response()->json($data, $data['code']);

    // }



}
