<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductImages extends Model
{
    use HasFactory;

    protected $table = "product_images";
    protected $primaryKey = 'pimg_idImage';
    
    const CREATED_AT = 'pimg_created_date';
    const UPDATED_AT = 'pimg_updated_date';

    // protected $fillable = [
    //     'usu_idUser',
    //     'usu_username',
    //     'usu_email',
    //     'usu_email2',
    //     'usu_pswd',
    //     'urol_idRol',
    //     'usts_idStatus',
    // ];

    // protected $hidden = [
    //     'prod_isActive',
    // ];
}
