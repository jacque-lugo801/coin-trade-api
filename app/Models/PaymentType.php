<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentType extends Model
{
    use HasFactory;

    protected $table        = "payment_type";
    protected $primaryKey   = 'pytp_idType';

    protected $hidden = [
        // 'pyst_description',
    ];
}
