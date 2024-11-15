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
    
    // Guardar de los items de una nueva transaccion
    // public function saveTransaction($params) {
    //     return $this->shippingController->saveShippingAddress($params);
    // }

    // // Guardar de los items de una nueva transaccion
    // public function saveTransactionDetail($params) {
    //     return $this->shippingController->saveShippingAddress($params);
    // }

    
    // TRANSACTIONS
    // Obtener las transacciones
    public function getTransactions($user) {
        if(!empty($user)) {
            try {
                $sales = TransactionDetail::
                    with([
                        'detailTransaction',
                        'detailTransaction.transactionStatus',
                        'detailTransaction.paymentStatus',
                        'detailTransaction.paymentType',
                        'detailTransaction.paymentCategory',

                        'detailTransaction.transactionShippingAddress',
                        'detailTransaction.transactionShippingAddress.userShippingCountry',
                        'detailTransaction.transactionShippingAddress.userShippingState',
                        'detailTransaction.transactionShippingAddress.userShippingCity',
                        'detailTransaction.transactionCountry',
                        'detailTransaction.transactionState',
                        'detailTransaction.transactionCity',
                        
                        'detailUserSeller',
                        'detailUserSeller.userRol',
                        'detailUserBuyer',
                        'detailUserBuyer.userRol',

                        'detailProduct',
                        'detailProduct.productCountry',
                        'detailProduct.productType',
                        'detailProduct.productGroup',
                        'detailProduct.productCategory',
                    ])
                    // ->
                    // where([
                    //     ['tdet_seller_idUser', '=', $user->usu_idUser],
                    //     // ['tran_isActive', '=', 1],
                    // ])
                    ->orderBy('tdet_idDetail', 'desc')
                    ->
                    get()
                ;

                if(!empty($sales)){
                    $sale = $sales->map(function ($sale) {
                        $sale->detailUserSeller->makeHidden([
                            'usu_identity',
                            // 'usu_email2',
                            'usu_birth_date',
                            'usu_username',
                            'usu_mail_account',
                            'usu_isAuthorized',
                            'usu_created_date',
                            'usu_updated_date',
                            'usts_idStatus',
                            'usu_isVerification',
                            'usu_isVerificated',
                            'usu_isActive',
                        ]);
                        $sale->detailUserBuyer->makeHidden([
                            'usu_identity',
                            // 'usu_email2',
                            'usu_birth_date',
                            'usu_username',
                            'usu_mail_account',
                            'usu_isAuthorized',
                            'usu_created_date',
                            'usu_updated_date',
                            'usts_idStatus',
                            'usu_isVerification',
                            'usu_isVerificated',
                            'usu_isActive',
                        ]);
                        $sale->detailProduct->makeHidden([
                            // 'prod_rating',
                            'prod_unit_cost',
                            'prod_commission',
                            // 'prod_total',
                            // 'prod_stock',
                            'prod_created_date',
                            'prod_updated_date',
                            // 'prod_isAuthorized',
                            'prod_isTerms',
                        ]);

                        return $sale;
                    });

                    return $sales;
                }
                else {
                    return 0;
                }
            } catch (QueryException $e) {
                return 0;
            }
        }
        else {
            return 0;
        }
    }
    // Obtener las transacciones de compras (VENDEDOR)
    public function getSalesFmUser($user) {
        if(!empty($user)) {
            try {
                $sales = TransactionDetail::
                    with([
                        'detailTransaction',
                        'detailTransaction.transactionStatus',
                        'detailTransaction.paymentStatus',
                        'detailTransaction.paymentType',
                        'detailTransaction.paymentCategory',

                        'detailTransaction.transactionShippingAddress',
                        'detailTransaction.transactionShippingAddress.userShippingCountry',
                        'detailTransaction.transactionShippingAddress.userShippingState',
                        'detailTransaction.transactionShippingAddress.userShippingCity',
                        'detailTransaction.transactionCountry',
                        'detailTransaction.transactionState',
                        'detailTransaction.transactionCity',
                        
                        'detailUserSeller',
                        'detailUserSeller.userRol',
                        'detailUserBuyer',
                        'detailUserBuyer.userRol',

                        'detailProduct',
                        'detailProduct.productCountry',
                        'detailProduct.productType',
                        'detailProduct.productGroup',
                        'detailProduct.productCategory',
                    ])
                    ->
                    where([
                        ['tdet_seller_idUser', '=', $user->usu_idUser],
                        // ['tran_isActive', '=', 1],
                    ])
                    ->orderBy('tdet_idDetail', 'desc')
                    ->
                    get()
                ;

                if(!empty($sales)){
                    $sale = $sales->map(function ($sale) {
                        $sale->detailUserSeller->makeHidden([
                            'usu_identity',
                            // 'usu_email2',
                            'usu_birth_date',
                            'usu_username',
                            'usu_mail_account',
                            'usu_isAuthorized',
                            'usu_created_date',
                            'usu_updated_date',
                            'usts_idStatus',
                            'usu_isVerification',
                            'usu_isVerificated',
                            'usu_isActive',
                        ]);
                        $sale->detailUserBuyer->makeHidden([
                            'usu_identity',
                            // 'usu_email2',
                            'usu_birth_date',
                            'usu_username',
                            'usu_mail_account',
                            'usu_isAuthorized',
                            'usu_created_date',
                            'usu_updated_date',
                            'usts_idStatus',
                            'usu_isVerification',
                            'usu_isVerificated',
                            'usu_isActive',
                        ]);
                        $sale->detailProduct->makeHidden([
                            // 'prod_rating',
                            'prod_unit_cost',
                            'prod_commission',
                            // 'prod_total',
                            // 'prod_stock',
                            'prod_created_date',
                            'prod_updated_date',
                            // 'prod_isAuthorized',
                            'prod_isTerms',
                        ]);

                        return $sale;
                    });

                    return $sales;
                }
                else {
                    return 0;
                }
            } catch (QueryException $e) {
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    // Obtener las transacciones de compras (COMPRADOR)
    public function getPurchasesFmUser($user) {
        if(!empty($user)) {
            try {
                $purchases = TransactionDetail::
                    with([
                        'detailTransaction',
                        'detailTransaction.transactionStatus',
                        'detailTransaction.paymentStatus',
                        'detailTransaction.paymentType',
                        'detailTransaction.paymentCategory',

                        'detailTransaction.transactionShippingAddress',
                        'detailTransaction.transactionShippingAddress.userShippingCountry',
                        'detailTransaction.transactionShippingAddress.userShippingState',
                        'detailTransaction.transactionShippingAddress.userShippingCity',
                        'detailTransaction.transactionCountry',
                        'detailTransaction.transactionState',
                        'detailTransaction.transactionCity',
                        
                        'detailUserSeller',
                        'detailUserSeller.userRol',
                        'detailUserBuyer',
                        'detailUserBuyer.userRol',

                        'detailProduct',
                        'detailProduct.productCountry',
                        'detailProduct.productType',
                        'detailProduct.productGroup',
                        'detailProduct.productCategory',
                    ])
                    ->
                    where([
                        ['tdet_buyer_idUser', '=', $user->usu_idUser],
                        // ['tran_isActive', '=', 1],
                    ])
                    ->orderBy('tdet_idDetail', 'desc')
                    ->
                    get()
                ;

                if(!empty($purchases)){
                    $purchase = $purchases->map(function ($purchase) {
                        $purchase->detailUserSeller->makeHidden([
                            'usu_identity',
                            // 'usu_email2',
                            'usu_birth_date',
                            'usu_username',
                            'usu_mail_account',
                            'usu_isAuthorized',
                            'usu_created_date',
                            'usu_updated_date',
                            'usts_idStatus',
                            'usu_isVerification',
                            'usu_isVerificated',
                            'usu_isActive',
                        ]);
                        $purchase->detailUserBuyer->makeHidden([
                            'usu_identity',
                            // 'usu_email2',
                            'usu_birth_date',
                            'usu_username',
                            'usu_mail_account',
                            'usu_isAuthorized',
                            'usu_created_date',
                            'usu_updated_date',
                            'usts_idStatus',
                            'usu_isVerification',
                            'usu_isVerificated',
                            'usu_isActive',
                        ]);
                        $purchase->detailProduct->makeHidden([
                            'prod_rating',
                            'prod_unit_cost',
                            'prod_commission',
                            'prod_total',
                            'prod_stock',
                            'prod_created_date',
                            'prod_updated_date',
                            'prod_isAuthorized',
                            'prod_isTerms',
                        ]);

                        return $purchase;
                    });

                    return $purchases;
                }
                else {
                    return 0;
                }
            } catch (QueryException $e) {
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    // Obtener las transacciones por ID (PRODUCTO APROBADO)
    public function getTransactionFmUserByID($id, $user) {
        if(!empty($id) || !empty($user)) {
            try {
                $transactions = Transaction::
                    with([
                        'transactionDetail',
                        'transactionDetail.detailUser',
                        'transactionDetail.detailUser.userRol',
                        'transactionDetail.detailProduct',
                        'transactionDetail.detailProduct.productCountry',
                        'transactionDetail.detailProduct.productType',
                        'transactionDetail.detailProduct.productGroup',
                        'transactionDetail.detailProduct.productCategory',
                        'transactionStatus',
                        'paymentStatus',
                        'paymentType',
                        'paymentCategory',
                        'transactionShippingAddress',
                        'transactionShippingAddress.userShippingCountry',
                        'transactionShippingAddress.userShippingState',
                        'transactionShippingAddress.userShippingCity',
                        'transactionCountry',
                        'transactionState',
                        'transactionCity',
                    ])
                    ->
                    where([
                        ['tran_idUserBuyer', '=', $user->usu_idUser],
                        ['tran_idTransaction', '=', $id],
                        // ['tran_isActive', '=', 1],
                    ])
                    ->
                    get()
                ;

                if(!empty($transactions)){
                    // $transactions->each(function ($transaction) {
                    //     if ($transaction->transactionDetail && $transaction->transactionDetail->detailUser) {
                    //         $transaction->transactionDetail->detailUser->makeHidden([
                    //             'usu_identity',
                    //             // 'usu_email2',
                    //             'usu_birth_date',
                    //             'usu_username',
                    //             'usu_mail_account',
                    //             'usu_isAuthorized',
                    //             'usu_created_date',
                    //             'usu_updated_date',
                    //             'usts_idStatus',
                    //             'usu_isVerification',
                    //             'usu_isVerificated',
                    //             'usu_isActive',
                    //         ]);
                    //     }
                    // });
                    
                    $transaction = $transactions->map(function ($transaction) {
                        // Aplicar makeHidden en cada instancia de detailUser dentro de transactionDetail
                        $transaction->transactionDetail->each(function ($detail) {
                            if ($detail->detailUser) {
                                $detail->detailUser->makeHidden([
                                    'usu_identity',
                                    // 'usu_email2',
                                    'usu_birth_date',
                                    'usu_username',
                                    'usu_mail_account',
                                    'usu_isAuthorized',
                                    'usu_created_date',
                                    'usu_updated_date',
                                    'usts_idStatus',
                                    'usu_isVerification',
                                    'usu_isVerificated',
                                    'usu_isActive',
                                ]);
                            }
                        });
                        return $transaction;
                    });

                    return $transactions;
                }
                else {
                    return 0;
                }
            } catch (QueryException $e) {
                return 0;
            }
        }
        else {
            return 0;
        }
    }

    public function deleteTransaction($idTransaction, $idUser) {
        if(!empty($idTransaction) || !empty($idUser)) {
            try {  
                $deleted = Transaction::
                    where([
                        ['tran_idTransaction', '=', $idTransaction],
                        ['tran_idUserBuyer', '=', $idUser],
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
    
    // TRANSACTION STATUS
    //Obtener el ID del estado de transaccion
    public function getTransactionStatusID($name) {
        return $this->transactionStatusController->getTransactionStatusID($name);
    }
    // END TRANSACTION STATUS

    // TRANSACTION DETAIL
    public function deleteDetailTransaction($idTransaction, $idUser) {
        // transactionDetailController
        return $this->transactionDetailController->deleteDetailTransaction($idTransaction, $idUser);
    }
    // END TRANSACTION DETAIL

}
