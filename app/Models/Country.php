<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    use HasFactory;
    
    protected $table = "countries";
    protected $keyType = 'string';
    protected $primaryKey = 'coun_iso_alpha2';

    protected $hidden = [
        'coun_iso_alpha3',
        'coun_iso_numerico',
        // 'coun_isActive',
    ];
}
