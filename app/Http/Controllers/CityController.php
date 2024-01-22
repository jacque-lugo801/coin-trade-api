<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CityController extends Controller
{
    // Obtiene un listado con las ciudades pertenecientes a un esdato con {code} especifico
    public function getStatesFmCountry(Request $request) {
        
        // Recoger datos de code
        $code = $request->input('code', null);
        if(isset($code) ) {
            $code = str_replace('"', '', $code);
            
            $cities = State::where([
                ['coun_iso_alpha2', '=', $code],
                ['sta_isActive', '=', 1]
            ])
            ->select(
                'sta_renapo as codeRENAPO',
                'sta_name as nombre',
                'sta_clave as claveEstado',
                'sta_iso_alpha2 as codeISO2',
            )
            ->get();
        }
        else {
            $cities = [];
        }
        
        return response()->json([
            'cities' => $cities
        ]);
    }
    
}
