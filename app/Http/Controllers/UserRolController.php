<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\UserRol;

class UserRolController extends Controller
{
    
    // **************************************************
    // *                    ADMIN                       *
    // **************************************************

    public function getAllRoles(Request $request) {

        $roles = UserRol::all();

        if(!empty($roles)){
            $data = array(
                // 'status'    => 'error',
                // 'code'      => 400,
                // 'message'   => 'Error al subir imagen',
                'roles' => $roles,
            );
        }
        else {

            $data = array(
                // 'status'    => 'error',
                // 'code'      => 400,
                // 'message'   => 'Error al subir imagen',
                'roles' => [],
            );
        }

        return response()->json($data);

    }
}
