<?php

namespace App\Services;

use App\Http\Controllers\UserRolController;
use App\Http\Controllers\UserShippingAddressController;
use App\Http\Controllers\UserFiscalDataController;
// use App\Http\Controllers\UserController;


use App\Models\User;


use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con los USUARIOS.
*/

class UserService
{
    protected $rolController;
    protected $shippingController;
    protected $fiscalController;
    protected $userController;

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

    // USER
    //Obtener los datos de usuario del vendedor para enviar la solicitud de mejora de su producto
    public function getUserData($mail, $username) {
        try {
            $user =  User::
                where('usu_email', '=', $mail)
                ->where('usu_username', '=', $username)
                ->first();

            return $user;
        } catch (QueryException $e)  {
            return 0;
        }
    }  

    // Obtener usuario por mail
    public function getUserByMail($mail) {
        try {
            $user =  User::
                where('usu_email', '=', $mail)
                ->first();

            return $user;
        } catch (QueryException $e)  {
            return 0;
        }
    }
    // END USER

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
    // Actualizar de los datos fiscales
    public function updatFiscalData($params, $idAddress) {
        return $this->fiscalController->updatFiscalData($params, $idAddress);
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
