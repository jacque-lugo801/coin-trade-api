<?php

namespace App\Services;

use App\Http\Controllers\UserRolController;
use App\Http\Controllers\UserShippingAddressController;
use App\Http\Controllers\UserFiscalDataController;
// use App\Http\Controllers\UserController;


use App\Models\User;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con los USUARIOS.
*/

class UserService
{
    protected $rolController;
    protected $shippingController;
    protected $fiscalController;
    // protected $userController;

    public function __construct (
        UserRolController               $rolController,
        UserShippingAddressController   $shippingController,
        UserFiscalDataController        $fiscalController,
        // UserController                  $userController,
    ) {
        $this->rolController        =   $rolController;
        $this->shippingController   =   $shippingController;
        $this->fiscalController     =   $fiscalController;
        // $this->userController       =   $userController;
    }

    // ROL
    // Obtener el nombre del rol mediante el ID
    public function getRolID($rolName) {
        return $this->rolController->getRolID($rolName);
    }
    // END ROL
    
    // ADDRESS
    
    // Shipping
    // Guardar de los datos de dirección de envío
    public function saveShippingAddress($params) {
        return $this->shippingController->saveSignupAddress($params);
    }
    // Actualizar de los datos de dirección de envío
    public function updateShippingAddress($params, $idAddress) {
        return $this->shippingController->updateShippingAddress($params, $idAddress);
    }

    // Borrar los datos de dirección que se han guardado
    public function deleteShippingAddress($idUser) {
        return $this->shippingController->deleteSignupAddress($idUser);
    }


    // Fiscal
    // Guardar de los datos fiscales
    public function saveFiscalData($params) {
        return $this->fiscalController->saveSignupFiscalData($params);
    }
    // END ADDRESS


    
    // CODE
    // Generación de código (6 digitos) para validacion de e-mail
    public function setCode() {
        do {
            $code = random_int(000001, 999999);
        } while (User::where("usu_verification_code", "=", $code)->first());
        return $code;
    }
    // END CODE
}
