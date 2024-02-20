<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserRol extends Model
{
    use HasFactory;

    protected $table        = "user_rol";
    protected $primaryKey   = 'urol_idRol';
    
    // const CREATED_AT = 'ufdt_updated_date';
    // const UPDATED_AT = 'ufdt_created_date';

    protected $fillable = [
        'urol_idRol ',
        'urol_name',
        'urol_description',
    ];
}
