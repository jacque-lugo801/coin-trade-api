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
}
