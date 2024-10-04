<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserRol extends Model
{
    use HasFactory;

    protected $table        = "user_rol";
    protected $primaryKey   = 'urol_idRol';
    
    protected $fillable = [
        'urol_idRol ',
        'urol_name',
        'urol_description',
    ];
}
