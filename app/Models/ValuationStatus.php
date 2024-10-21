<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ValuationStatus extends Model
{
    use HasFactory;

    protected $table        = "valuation_status";
    protected $primaryKey   = 'vsta_idStatus';

    protected $hidden = [
        // 'vsta_description',
    ];
}
