<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;

    protected $table        = "transactions";
    protected $primaryKey   = 'tran_idTransaction';
    
    const CREATED_AT = 'tran_created_date';
    const UPDATED_AT = 'tran_updated_date';

    protected $hidden = [
        'tran_isActive',
        // 'prod_isTerms',
    ];
    
}
