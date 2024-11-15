<?php

namespace App\Services;

use App\Http\Controllers\ProductTypeController;
use App\Http\Controllers\ProductStatusController;
use App\Http\Controllers\ProductCertificationsController;

use App\Models\User;
use App\Models\Product;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con los USUARIOS.
*/

class ProductService
{
    protected $productTypeController;
    protected $productStatusController;
    protected $productCertificationsController;
    protected $productController;

    public function __construct (
        ProductTypeController               $productTypeController,
        ProductStatusController             $productStatusController,
        ProductCertificationsController     $productCertificationsController,
    ) {
        $this->productTypeController            = $productTypeController;
        $this->productStatusController          = $productStatusController;
        $this->productCertificationsController  = $productCertificationsController;
    }

    // TYPE
    // Obtener ID del producto del tipo del producto
    public function getProductTypeID($typeName) {
        return $this->productTypeController->getProductTypeID($typeName);
    }
    // END TYPE


    // STATUS
    // Obtener ID del producto del tipo de status
    public function getProductStatusID($statusName) {
        return $this->productStatusController->getProductStatusID($statusName);
    }
    // END STATUS


    // CERTIFICATES
    // Guardar de los datos de dirección de envío
    public function saveProductCertificate($params) {
        return $this->productCertificationsController->saveProductCertificate($params);
    }
    // END CERTIFICATES

    // PRODUCTS
    // Obtener el producto por ID (PRODUCTO APROBADO)
    public function getProductByID($id) {
        try {
            $product = Product::
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
                        ["prod_idProducto", "=", $id],
                        ["prod_isAuthorized", "=", 1],
                    ])
                ->get()
                ->load('productCertifications')
            ;
        }  catch (QueryException $e) {
            $product = [];
        }
        
        return  $product;
    }
    // Obtener el producto por ID (APROBADO O NO APROBADO)
    public function getProductInfoByID($id) {
        try {
            $product = Product::
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
                    ],
                )
                ->
                    where([
                        ["prod_idProducto", "=", $id]
                    ])
                ->get()
                ->load('productCertifications')
            ;
        } catch (QueryException $e) {
            $product = [];
        }
        
        return  $product;
    }
    //Actualizar calificacion global del producto
    public function updateProductRate($paramsArray, $rating) {
        try {
            $product = Product::
                where([
                    ["prod_idProducto", "=", $paramsArray['id']],
                    ["prod_sku", "=", $paramsArray['sku']],
                
                ])
            ->
                update([
                    'prod_rating' => $rating
                ])
            ;

            return $product;
        } catch (QueryException $e) {
            return 0;
        }
    }

    public function reduceStockTransaction($value) {
        if(!empty($value)) {
            $productCollection = $this->getProductByID($value['prod_idProducto']);

            if($productCollection->isEmpty()) {
                // Si no existe el producto
                return 0;
            }
            else {
                $productFind = $productCollection->first();
                // [prod_isActive] => 1
                // [prod_idType_product] => 1
                // [prod_idGroup_product] => 1
                // [prod_idCategory_product] => 1
                // [prod_isAuthorized] => 1
                // [prod_isTerms] => 1
                // [psts_idStatus] => 1
                $newStock = $productFind->prod_stock - $value['citm_quantity'];

                if($newStock < 1) {
                    // Actualizar stock y cambiar status de producto
                    $idProductStatus = $this->getProductStatusID('agotado');

                    $paramsUpdate = array(
                        "prod_stock"    => $newStock,
                        "psts_idStatus" => $idProductStatus,
                    );
                    
                    $productUpdate = Product::
                        where('prod_idProducto', $value['prod_idProducto'])
                        ->update($paramsUpdate);

                    if($productUpdate || $productUpdate == 1) {
                        return 1;
                    } else {
                        return 0;
                    }
                }
                else {
                    // Solo actualizar stock
                    $paramsUpdate = array(
                        "prod_stock"    => $newStock,
                    );

                    $productUpdate = Product::
                        where('prod_idProducto', $value['prod_idProducto'])
                        ->update($paramsUpdate);
                        
                    if($productUpdate || $productUpdate == 1) {
                        return 1;
                    } else {
                        return 0;
                    }
                }
            }

        }
        else {
            return 0;
        }
    }
    // END PRODUCTS
}
