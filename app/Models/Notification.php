<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;
    

    protected $table = "notifications";
    protected $primaryKey = 'not_idNotification';
    
    const CREATED_AT = 'not_created_date';
    const UPDATED_AT = 'not_updated_date';

    // protected $fillable = [
    //     'usu_idUser',
    //     'usu_username',
    //     'usu_email',
    //     'usu_email2',
    //     'usu_pswd',
    //     'urol_idRol',
    //     'usts_idStatus',
    // ];

    protected $hidden = [
        'prod_isActive',
        'prod_isTerms',
        // 'prod_itType_product',
        // 'prod_idGroup_product',
        // 'prod_idCategory_product',
    ];
}
