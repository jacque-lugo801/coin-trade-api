<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Product;
use App\Models\ProductType;
use App\Http\Controllers\ProductCertificationsController;

use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    //
    
    public function pruebas(Request $request) {
        return 'Acción de pruebas de PRODUCT-CONTROLLER';
    }

    public function getAllProducts() {
        $products = Product::
       
        with(
            [
                'productCountry',
                'productType',
                // 'productType.productGroup',
                'productGroup',
                'productCategory',
                // 'userAddressShipping.userShippingCountry', 

                // 'userAddressShipping.userShippingCountry.userState'
            ],
            [
                // 'userAddressShipping',

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
            // ->load('productType')
            // // ->load('productGroup')
            // // ->load('productCategory')
            ->load('productUser')
            // // ->load('productImages')
            ->load('productCertifications')

            ;
        //     // die();
            
        return response()->json([
            'products' => $products
        ]);

    }
    public function getAllCoins() {
        $products = Product
        ::where([
            // ["prod_isActive", "=", 1],
            ["prod_idType_product", "=", 1],
        ])
            ->get()
            ->load('productType')
            ->load('productUser')
            // ->load('productImages')
            ->load('productCertifications')
            ;
        return response()->json([
            'products' => $products
        ]);
    }
    public function getAllBills() {
        $products = Product
        ::where([
            // ["prod_isActive", "=", 1],
            ["prod_idType_product", "=", 2],
        ])
            ->get()
            ->load('productType')
            ->load('productUser')
            // ->load('productImages')
            ->load('productCertifications')
            ;
        return response()->json([
            'products' => $products
        ]);
    }

    public function getProduct($id) {

        if(isset($id)) {

            $id = str_replace('"', '', $id);
            $product = Product::
            
            with(
                [
                    'productCountry',
                    'productType',
                    // 'productType.productGroup',
                    'productGroup',
                    'productCategory',
                    // 'userAddressShipping.userShippingCountry', 
    
                    // 'userAddressShipping.userShippingCountry.userState'
                ],
                [
                    // 'userAddressShipping',
    
                ]
            )
            ->
                
                where([
                    ["prod_idProducto", "=", $id],
                    ["prod_isAuthorized", "=", 1],
                ])
                ->
                get()
                        
                ->load('productCertifications')
                ->load('productStatus')
            ;

        }
        
        else {
            $product = [];
        }
        
        return response()->json([
            'products' => $product
        ]);



        // die();
        // // decode has

        // if(isset($id) ) {
        //     $id = str_replace('"', '', $id);


        //     // var_dump($id);
        //     // die();
            
           
        //     $product = Product::join(
        //         (new ProductType)->getTable(),
        //         (new Product)->getTable().'.'.(new ProductType)->getKeyName(),
        //         '=',
        //         (new ProductType)->getTable().'.'.(new ProductType)->getKeyName(),
        //         // 'product_type',
        //         // 'product_type.ptpe_idType',
        //         // '=',
        //         // 'products.ptpe_idType',
        //     )
        //     ->select(
        //         'prod_idProducto            as idProducto',
        //         'prod_name                  as name',
        //         'prod_description           as description',
        //         'prod_content               as content',
        //         'prod_country               as country',
        //         'prod_metal                 as metal',
        //         'prod_diameter              as diameter',
        //         'prod_condition             as condition',
        //         'prod_date                  as date',
        //         'prod_weight                as weight',
        //         'prod_minting               as minting',
        //         'prod_fineness              as fineness',
        //         'prod_serie                 as serie',
        //         'prod_denomination          as denomination',
        //         'prod_number                as number',
        //         'prod_rating                as rating',
        //         'prod_unit_cost             as unit_cost',
        //         'prod_commission            as commission',
        //         'prod_total                 as total',
        //         'prod_stock                 as stock',
        //         'product_type.ptpe_idType   as typeID',
        //         'product_type.ptpe_name     as typeName',
        //         // (new ProductType)->getTable().'ptpe_idType as idType',
        //         // 'usu_idUser         as dUser',
        //         'prod_image                 as image',
        //     )
        //     ->where('prod_idProducto', '=', $id)
        //     ->where('prod_isActive', '=', 1)
            
        //     ->get();
        // }
        // else {
        //     $product = [];
        // }

        
        // return response()->json([
        //     'products' => $product
        // ]);
    }


    // new
    public function getProductsFmUser(Request $request) {

        
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        
        $user = $jwtAuth->checkToken($token, true);

        // var_dump($user);
        // die();


        $products = Product::
            
        with(
            [
                'productCountry',
                'productType',
                // 'productType.productGroup',
                'productGroup',
                'productCategory',
                'productStatus',
                // 'userAddressShipping.userShippingCountry', 

                // 'userAddressShipping.userShippingCountry.userState'
            ],
            [
                // 'userAddressShipping',

            ]
        )

        ->
            where(
                "usu_idUser", "=", $user->usu_idUser
            )

        
            
        ->orderBy('prod_idProducto', 'desc')
        ->
        get()
        
        // ->load('productType')
        // // ->load('productGroup')
        // // ->load('productCategory')
        // // ->load('productUser')
        // // ->load('productImages')
        // ->load('productStatus')
        ->load('productCertifications')
        ->load('productStatus')

        ;

        if(!empty($products)){

            $data = array(
                // 'status'    => 'error',
                // 'code'      => 400,
                // 'message'   => 'Error al subir imagen',
                'products' => $products,
            );
        }
        else {
            
            $data = array(
                // 'status'    => 'error',
                // 'code'      => 400,
                // 'message'   => 'Error al subir imagen',
                'products' => [],
            );
        }

        return response()->json($data);
    }

    
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
                'message'   => 'Error al subir imagen',
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


    public function uploadImage(Request $request) {
        // recoger datos de la peticion
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
                'message'   => 'Error al subir imagen',
                'image'   => $image,
                'validate' => $validate->errors()
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
                'image'   => $image_name,
            );
        }
        return response()->json($data, $data['code']);

    }

    public function getImage($filename) {


        $isset =  \Storage::disk('products')->exists($filename);

        // var_dump($isset);
        // die();

        if($isset) {

            $file = \Storage::disk('products')->get($filename);
            // $file = \Storage::get($filename);

            return new Response($file, 200);
        }
        else {

            $data = array(
                'status'    => 'error',
                'code'      => 400,
                'message'   => 'No existe la imagen',
            );
            
            return response()->json($data, $data['code']);
        }

    }


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

            // var_dump($paramsArray);
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
            ]
            // [
            //     'mail.unique'       => 'El email ya ha sido registrado.',
            //     'username.unique'   => 'El nombre de usuario ya existe.',
            // ]
        
            );


            if ($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 402,
                    'message'   => 'Ha ocurrido un error en la actualización',
                    'errors'    => $validate->errors()
                );

            }
            else {
                // Devolver array con resultado
                
                // check for sku name
                $nSku = $this->getLastProduct($paramsArray['type']);
                // var_dump($nSku);
                // die();
                $product = new Product();
                // $product->prod_sku                  = $paramsArray['sku'];
                $product->prod_sku                 = $nSku;
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
                $product->psts_idStatus             = 2;

                switch ($params->type) {
                    case 2:
                        // $product->prod_sku                  = $paramsArray['sku'];
                        // $product->prod_name                 = $paramsArray['name'];
                        // $product->prod_description          = $paramsArray['description'];
                        // $product->prod_country              = $paramsArray['country'];
                        $product->prod_condition            = $paramsArray['condition'];
                        $product->prod_date                 = $paramsArray['date'];
                        $product->prod_serie                = $paramsArray['serie'];
                        $product->prod_number               = $paramsArray['number'];
                        // $product->prod_idType_product       = $paramsArray['type'];
                        $product->prod_idGroup_product      = $paramsArray['productGroup'];
                        $product->prod_image_front          = $paramsArray['imageFront'];
                        $product->prod_image_back           = $paramsArray['imageBack'];
                        // // $product->prod_image_certificate    = $paramsArray['imageCertificate'];
                        // $product->prod_unit_cost            = $paramsArray['unitCost'];
                        // $product->prod_commission           = $paramsArray['comission'];
                        // $product->prod_total                = $paramsArray['total'];
                        // $product->prod_stock                = $paramsArray['stock'];
                        // $product->prod_isTerms              = $paramsArray['terms'];

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
                        // $product->prod_sku                  = $paramsArray['sku'];
                        // $product->prod_name                 = $paramsArray['name'];
                        // $product->prod_description          = $paramsArray['description'];
                        // $product->prod_country              = $paramsArray['country'];
                        $product->prod_metal                = $paramsArray['metal'];
                        $product->prod_diameter             = $paramsArray['diameter'];
                        $product->prod_weight               = $paramsArray['weight'];
                        $product->prod_minting              = $paramsArray['minting'];
                        $product->prod_fineness             = $paramsArray['fineness'];
                        $product->prod_denomination         = $paramsArray['denomination'];
                        // $product->prod_idType_product       = $paramsArray['type'];
                        $product->prod_idGroup_product      = $paramsArray['productGroup'];
                        $product->prod_idCategory_product   = $paramsArray['productCategory'];
                        $product->prod_image_front          = $paramsArray['imageFront'];
                        $product->prod_image_back           = $paramsArray['imageBack'];
                        // // $product->prod_image_certificate    = $paramsArray['imageCertificate'];
                        // $product->prod_unit_cost            = $paramsArray['unitCost'];
                        // $product->prod_commission           = $paramsArray['comission'];
                        // $product->prod_total                = $paramsArray['total'];
                        // $product->prod_stock                = $paramsArray['stock'];
                        // $product->prod_isTerms              = $paramsArray['terms'];

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

                // var_dump($product);
                // die();
                
                $product->save();
                $idProducto = $product->prod_idProducto;

                //Guardar datos certificado
                $certificateParams = array(
                    'imageCertificate'  => $paramsArray['imageCertificate'],
                    'idProduct'         => $idProducto,
                );

                $certificate = (new ProductCertificationsController)
                    ->saveCertificate($certificateParams);

                $data = array(
                    'status'    => 'success',
                    'code'      => 200,
                    'message'   => 'El producto se ha guardado exitosamente',
                );
                
            }
        }
        return response()->json($data, $data['code']);

    }


    public function getLastProduct($type) {
        $products = Product
        ::where([
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
    }



    // ADMIN
    
    public function getProductsForVerification() {
        echo'test verify products';
        // die();
        $products = Product::
       
        with(
            [
                'productCountry',
                'productType',
                // 'productType.productGroup',
                'productGroup',
                'productCategory',
                // 'userAddressShipping.userShippingCountry', 

                // 'userAddressShipping.userShippingCountry.userState'
            ],
            [
                // 'userAddressShipping',

            ]
        )

        ->
        where([
            // ["prod_isActive", "=", 1],
            // ["prod_isAuthorized", "=", 1],
        ])
            ->get()
            // ->load('productType')
            // // ->load('productGroup')
            // // ->load('productCategory')
            ->load('productUser')
            // // ->load('productImages')
            ->load('productCertifications')

            ;
        //     // die();
            
        return response()->json([
            'products' => $products
        ]);

    }

}
