<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentStatus extends Model
{
    use HasFactory;

    protected $table        = "payments_status";
    protected $primaryKey   = 'pyst_idStatus';

    protected $hidden = [
        // 'pyst_description',
    ];
}
