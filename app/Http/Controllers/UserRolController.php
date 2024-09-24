<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UserRol;

class UserRolController extends Controller
{
    // Obtener el ID de un rol dado (ej. Comprador)
    public function getRolID($rolName) {
        if(isset($rolName) && !empty($rolName)) {
            $rol = UserRol::where('urol_name', 'LIKE', '%'. $rolName.'%') -> first();
            return $rol->urol_idRol;
        }
        else {
            return 0;
        }
    }
    
    // **************************************************
    // *                    ADMIN                       *
    // **************************************************

    // Obtener todos los roles de usuario
    public function getAllRoles(Request $request) {
        $roles = UserRol::all();

        if(!empty($roles)){
            $data = array(
                'roles' => $roles,
            );
        }
        else {
            $data = array(
                'roles' => [],
            );
        }
        return response()->json($data);
    }
}