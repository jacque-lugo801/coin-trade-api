<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Country;

use Illuminate\Database\QueryException;
use Exception;

class CountryController extends Controller
{
    // Obtiene lista de paises
    public function getCountries() {
        try {
            $countries = Country::get();

        } catch (QueryException $e) {
            $data = array(
                'status'    => 'error',
                'code'      => 400,
                'message'   => 'Ha ocurrido un error al tratar de obtener los países',
            );
            $countries = [];
        }
        return response()->json([
            'countries' => $countries
        ]);
    }
}