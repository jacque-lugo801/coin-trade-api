<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentCategory extends Model
{
    use HasFactory;

    protected $table        = "payment_category";
    protected $primaryKey   = 'pyct_idCategory';

    protected $hidden = [
        // 'pyst_description',
    ];
}
