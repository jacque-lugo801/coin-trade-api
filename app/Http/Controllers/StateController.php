<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\State;

class StateController extends Controller
{
    // Obtiene un listado con los estados pertenecientes a un país con {code} especifico
    public function getStatesFmCountry(Request $request) {
        
        // Recoger datos de code
        $code = $request->input('code', null);
        if(isset($code) ) {
            $code = str_replace('"', '', $code);
            
            $states = State::where([
                ['coun_iso_alpha2', '=', $code],
                ['sta_isActive', '=', 1]
            ])
            // ->select(
            //     'sta_renapo         as codeRENAPO',
            //     'sta_name           as nombre',
            //     'sta_clave          as claveEstado',
            //     'sta_iso_alpha2     as codeISO2',
            //     'sta_abbreviation   as abreviacion',
            // )
            ->orderBy('sta_name', 'asc')
            ->get();
        }
        else {
            $states = [];
        }
        
        return response()->json([
            'states' => $states
        ]);
    }
}