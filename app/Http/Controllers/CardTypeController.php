<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CardType;

use App\Http\Controllers\MailController;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

class CardTypeController extends Controller
{
    //Obtener los tipos de tarjeta
    public function getCardTypes() {
        try {
            $cardTypes = CardType::
                get()
            ;
        } catch (QueryException $e) {
            $cardTypes = [];
        }

        return  response()->json([
            'cardTypes' => $cardTypes
        ]);
    }

    // Obtener el ID de un tipo de tarjeta (ej. débito, crédito)
    public function getCardTypeID($typeName) {
        if(isset($typeName) && !empty($typeName)) {
            try {
                $type = CardType::where('ctpe_name', 'LIKE', '%'. $typeName.'%')->first();

                return $type->ctpe_idType;
            } catch (QueryException $e) {
                return 0;
            }
        }
        else {
            return 0;
        }
    }
}
