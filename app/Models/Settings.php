<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Settings extends Model
{
    use HasFactory;

    protected $table        = "settings";
    protected $primaryKey   = 'set_idSetting';
    
    const CREATED_AT = 'set_created_date';
    const UPDATED_AT = 'set_updated_date';

    protected $hidden = [
        // 'prod_isActive',
        // 'prod_isTerms',
    ];

}
