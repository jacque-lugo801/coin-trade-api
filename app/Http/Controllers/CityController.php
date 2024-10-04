<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\City;

use Illuminate\Database\QueryException;
use Exception;

class CityController extends Controller
{
    // Obtiene un listado con las ciudades pertenecientes a un esdato con {code} especifico
    public function getCitiesFmState(Request $request) {
        // Recoger datos de code
        $code = $request->input('code', null);
        if(isset($code) ) {
            $code = str_replace('"', '', $code);

            try {
                $cities = City::where([
                    ['sta_iso_alpha2', '=', $code],
                    ['cit_isActive', '=', 1]
                ])
                ->orderBy('cit_nombre', 'asc')
                ->get();
            } catch (QueryException $e) {
                $cities = [];
            }
        }
        else {
            $cities = [];
        }
        
        return response()->json([
            'cities' => $cities
        ]);
    }
    
}