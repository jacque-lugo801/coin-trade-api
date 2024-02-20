<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserFiscalData extends Model
{
    use HasFactory;

    protected $table        = "users_fiscal_data";
    protected $primaryKey   = 'ufdt_idData';
    
    const CREATED_AT = 'ufdt_updated_date';
    const UPDATED_AT = 'ufdt_created_date';

    protected $fillable = [
        'ufdt_denomination',
        'ufdt_rfc',
        'ufdt_country',
        'ufdt_state',
        'ufdt_city',
        'ufdt_address',
        'usu_idUser',
    ];
    
    protected $hidden = [
        'usu_idUser',
    ];
}
