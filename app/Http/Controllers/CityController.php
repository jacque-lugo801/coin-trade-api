<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\City;

class CityController extends Controller
{
    // Obtiene un listado con las ciudades pertenecientes a un esdato con {code} especifico
    public function getCitiesFmState(Request $request) {
        
        // Recoger datos de code
        $code = $request->input('code', null);
        if(isset($code) ) {
            $code = str_replace('"', '', $code);
            
            $cities = City::where([
                ['sta_iso_alpha2', '=', $code],
                ['cit_isActive', '=', 1]
            ])
            // ->select(
            //     'cit_clave  as cveCiudad',
            //     'cit_nombre as nombre'
            // )
            ->orderBy('cit_nombre', 'asc')
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