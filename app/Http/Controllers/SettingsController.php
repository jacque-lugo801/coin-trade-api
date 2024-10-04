<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Settings;

use Illuminate\Database\QueryException;
use Exception;


class SettingsController extends Controller
{
    // Obtener el precio para hacer la valuacion
    public function getValuationPrice(){
        try {
            $setting = Settings::
                where([
                    ["set_name", "=", "valuation_cost"],
                ])
                ->get()
            ;
        }  catch (QueryException $e) {
            $setting = [];
        }

        return response()->json([
            'setting' => $setting
        ]);
    }


     
    // **************************************************
    // *                    ADMIN                       *
    // **************************************************

    // Actualizar el precio del costo de valuacion
    public function updateValuationPrice(Request $request) {
        // Recoger datos usuarios
        $json = $request->input('json', null);
                
        $params         = json_decode($json); //objeto
        $paramsArray    = json_decode($json, true);   //array

        if(!empty($params) && !empty($paramsArray)) {
            $paramsArray = array_map('trim', $paramsArray);   //Limpiar datos del array

            $validate = \Validator::make($paramsArray, [
                'valuationCost' => 'required',
            ]);

            if($validate->fails()) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 400,
                    'message'   => 'Ha ocurrido un error al intentar bloquear/desbloquear ',
                    'errors'    => $validate->errors()
                );
            }
            else {
                try {
                    $paramsUpdate = array (
                        "set_value"  => $params->valuationCost,
                    );
    
                    $update = Settings::where('set_name', 'valuation_cost')
                        ->update($paramsUpdate);

                    if($update || $update == 1) {
                        $data = array(
                            'status' => 'success',
                            'code' => 200,
                            'message' => 'El costo de valuación se ha actualizado correctamente',
                        );
                    }
                    else {
                        $data = array(
                            'status'    => 'error',
                            'code'      => 400,
                            'message'   => 'Ha ocurrido un error al intentar actualizar el costo de valuacion',
                        );
                    }
                } catch (QueryException $e) {
                    // $errorCode = $e->getCode();
                    // $errorMessage = $e->getMessage();
                    // Log::error("Error on saveSignupFiscalData. Code - $errorCode, Mensaje - $errorMessage"); //Registrar el error en los logs
                    
                    $data = array(
                        'status'    => 'error',
                        'code'      => 400,
                        'message'   => 'Ha ocurrido un error en la actualización de datos.',
                        // 'errorMessage' => 'Code - ' .$errorCode .' | Message - ' . $errorMessage,
                    );
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
}
