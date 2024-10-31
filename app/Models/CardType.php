<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CardType extends Model
{
    use HasFactory;

    protected $table        = "card_type";
    protected $primaryKey   = 'ctpe_idType';
    
    protected $hidden = [
        // 'ufin_isActive',
        // 'prod_isTerms',
    ];
}
