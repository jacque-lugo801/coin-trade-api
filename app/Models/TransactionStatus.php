<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionStatus extends Model
{
    use HasFactory;

    protected $table        = "transaction_status";
    protected $primaryKey   = 'tsta_idStatus';
    
    // const CREATED_AT = 'tran_created_date';
    // const UPDATED_AT = 'tran_updated_time';

    protected $hidden = [
        // 'tran_isActive',
        // 'prod_isTerms',
    ];
}
