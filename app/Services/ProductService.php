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
    // END PRODUCTS
}
