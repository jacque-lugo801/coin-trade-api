<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class City extends Model
{
    use HasFactory;
    
    protected $table = "cities";
    protected $keyType = 'string';
    protected $primaryKey = 'cit_clave';

    
    protected $hidden = [
        'sta_iso_alpha3',
        'coun_iso_alpha2',
        'cit_isActive',
    ];
}
