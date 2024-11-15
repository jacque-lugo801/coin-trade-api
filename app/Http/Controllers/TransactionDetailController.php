<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

class TransactionDetailController extends Controller
{

    //Eliminar los detalles de transacción
    public function deleteDetailTransaction($idTransaction, $idUser) {
        if(!empty($idTransaction) || !empty($idUser)) {
            try {  
                $deleted = TransactionDetail::
                    where([
                        ['tran_idTransaction', '=', $idTransaction],
                        ['tdet_buyer_idUser', '=', $idUser],
                    ])
                ->delete()
                    // update(
                    //     ['citm_isActive' => 0]
                    // )
                ;

                if($deleted || $deleted == 1) {
                    return 1;
                }
                else {
                    return 0;
                }
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
}
