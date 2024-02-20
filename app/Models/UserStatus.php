<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserStatus extends Model
{
    use HasFactory;

    protected $table        = "user_status";
    protected $primaryKey   = 'usts_idStatus';
    
    // const CREATED_AT = 'ufdt_updated_date';
    // const UPDATED_AT = 'ufdt_created_date';

    protected $fillable = [
        'usts_idStatus ',
        'usts_name',
        'usts_description',
    ];

    // protected $appends = [ 'status' ];
    // protected $hidden = [ 'userStatus' ];
}
