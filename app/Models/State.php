<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class State extends Model
{
    use HasFactory;

    protected $table = "states";
    protected $keyType = 'string';
    protected $primaryKey = 'sta_iso_alpha2';

    
    protected $hidden = [
        'sta_iso_alpha3',
        'coun_iso_alpha2',
        'sta_isActive',
    ];
}
