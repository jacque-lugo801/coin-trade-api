<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionDetail extends Model
{
    use HasFactory;

    protected $table        = "transaction_detail";
    protected $primaryKey   = 'tdet_idDetail';
    
    const CREATED_AT = 'tdet_created_date';
    const UPDATED_AT = 'tdet_updated_date';

    protected $hidden = [
        // 'tran_isActive',
        // 'prod_isTerms',
    ];

    
    public function detailUser() {
        return $this->HasOne(User::class, 'usu_idUser', 'tdet_seller_idUser');
    }
    public function detailProduct() {
        return $this->HasOne(Product::class, 'prod_idProducto', 'tdet_prod_idProducto');
    }


    
    // Purchases/Sales
    public function detailTransaction() {
        return $this->BelongsTo(Transaction::class, 'tran_idTransaction', 'tran_idTransaction');
    }
    public function detailUserSeller() {
        return $this->HasOne(User::class, 'usu_idUser', 'tdet_seller_idUser');
    }
    public function detailUserBuyer() {
        return $this->HasOne(User::class, 'usu_idUser', 'tdet_buyer_idUser');
    }
}
