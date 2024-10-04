<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\State;

use Illuminate\Database\QueryException;
use Exception;

class StateController extends Controller
{
    // Obtiene un listado con los estados pertenecientes a un país con {code} especifico
    public function getStatesFmCountry(Request $request) {
        // Recoger datos de code
        $code = $request->input('code', null);
        if(isset($code) ) {
            $code = str_replace('"', '', $code);

            try {
                $states = State::where([
                    ['coun_iso_alpha2', '=', $code],
                    ['sta_isActive', '=', 1]
                ])
                ->orderBy('sta_name', 'asc')
                ->get();
            } catch (QueryException $e) {
                $states = [];
            }
        }
        else {
            $states = [];
        }
        
        return response()->json([
            'states' => $states
        ]);
    }
}