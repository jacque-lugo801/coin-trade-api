<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Country;

class CountryController extends Controller
{
    //Obtiene lista de paises que se encuentren activos en la DB
    public function getCountries() {
        $countries = Country::where("coun_isActive", "=", 1)
            ->select(
                'coun_iso_alpha2 as codeISO2',
                'coun_name as nombre'
            )
            ->get();
            // ->get(
            //     ['coun_iso_alpha2 as codeISO2',
            //     'coun_name as name'
            // ]);
            
        return response()->json([
            'countries' => $countries
        ]);
    }
}