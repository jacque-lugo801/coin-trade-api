<?php

namespace App\Services;

use App\Http\Controllers\TransactionDetailController;
use App\Http\Controllers\TransactionStatusController;

use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Models\TransactionStatus;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con los USUARIOS.
*/

class TransactionService
{
    protected $transactionDetailController;
    protected $transactionStatusController;

    public function __construct (
        TransactionDetailController $transactionDetailController,
        TransactionStatusController $transactionStatusController,
    ) {
        $this->transactionDetailController  = $transactionDetailController;
        $this->transactionStatusController  = $transactionStatusController;
    }

}
