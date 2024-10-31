<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UserShippingAddress;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;
use Illuminate\Support\Str;


class UserShippingAddressController extends Controller
{
    // Guardar direccion de envio
    public function saveSignupAddress($params) {
        if(!empty($params)){
            try {
                $paramsArray = array_map('trim', $params); 
                
                $address = new UserShippingAddress();
                $address->usad_country      = $paramsArray['country'];
                $address->usad_state        = $paramsArray['state'];
                $address->usad_city         = $paramsArray['city'];
                $address->usad_address      = $paramsArray['address'];
                $address->usad_cp           = $paramsArray['cp'];
                $address->usad_isDefault    = 1;
                $address->usu_idUser        = $paramsArray['idUser'];
                
                $address->save();
                
                return $address;
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

    // Guardar nueva direccion de envio
    public function saveShippingAddress($params) {
        if(!empty($params)){
            try {
                $paramsArray = array_map('trim', $params); 
                
                $address = new UserShippingAddress();
                $address->usad_country      = $paramsArray['usad_country'];
                $address->usad_state        = $paramsArray['usad_state'];
                $address->usad_city         = $paramsArray['usad_city'];
                $address->usad_address      = $paramsArray['usad_address'];
                $address->usad_cp           = $paramsArray['usad_cp'];
                $address->usad_isDefault    = 0;
                $address->usu_idUser        = $paramsArray['usu_idUser'];
                
                $address->save();
                
                return $address;
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
    
    // Borrar direccion de envio
    public function deleteSignupAddress($idUser) {
        if(!empty($idUser)){
            try {
                // $idUser = array_map('trim', $idUser); 
                Str::of($idUser)->trim();

                $addresses = UserShippingAddress::where('usu_idUser', '=', $idUser)->get();

                foreach ($addresses as $address) {
                    $id = $address->usad_idAddress;
                    
                    $deleted = UserShippingAddress::where('usad_idAddress', '=', $id) -> delete();
                }
                // return $deleted;
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

    // Actualizar direccion de envio
    public function updateShippingAddress($params, $id) {
        if(!empty($params) && (isset($id) && $id != null)){
            $paramsArray = array_map('trim', $params); 
            
            $address = UserShippingAddress::
                where('usad_idAddress', '=', $id)
                ->
                update($params);
                ;

            if($address || $address == 1) {
                return 1;
            } else {
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    // Obtener direccion de envio
    public function getShippingAddress($idUser) {
        if(!empty($idUser)){
            $id = trim($idUser); 
            
            $address = UserShippingAddress::
                where('usu_idUser', '=', $id)
                ->
                    get()
                ;

            return $address;
            
        }
        else {
            return 0;
        }
    }

    // Obtener direccion de envio por ID
    public function getShippingAddressByID($idUser, $id) {
        if(!empty($idUser) || !empty($id)){
            $idUser = trim($idUser); 
            $id = trim($id); 

            $address = UserShippingAddress::
                // where('usu_idUser', '=', $id)
                where([
                    ['usu_idUser', '=', $idUser],
                    ['usad_idAddress', '=', $id],
                ])
                ->
                    get()
                ;

            return $address;
        }
        else {
            return 0;
        }
    }

    public function getAddress(Request $request) {
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();

        $user = $jwtAuth->checkToken($token, true);

        // $address = $this->getShippingAddress($user->usu_idUser);
        
        $address = UserShippingAddress::
            with(
                [
                    'userShippingCountry', 
                    'userShippingState', 
                    'userShippingCity', 
                ]
            )
        ->
            where('usu_idUser', '=', $user->usu_idUser)
        ->
            get()
        ;

        if(empty($address)) {
            $address = [];
        }

        return response()->json([
            'shippingAddresses' => $address
        ]);
    }
}
