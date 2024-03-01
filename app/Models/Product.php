<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $table = "products";
    protected $primaryKey = 'prod_idProducto';
    
    const CREATED_AT = 'prod_created_date';
    const UPDATED_AT = 'prod_updated_date';

    protected $hidden = [
        'prod_isActive',
    ];


    public function user() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo('App\Models\User', 'usu_idUser');
    }

    // public function certification() {
    //     // Obtiene el usuario relqacionado por la propiedad usu_idUser
    //     // Saca el objeto asignado en base al usu_idUser
    //     return $this->BelongsTo('App\Models\Certification', 'prod_idProducto');
    // }

    public function productType() {
        return $this->BelongsTo('App\Models\ProductType', 'ptpe_idType');
    }


    
    public function productsUser() {
        // return $this->HasOne('App\Models\UserStatus', 'usts_idStatus');
        return $this->BelongsTo(User::class, 'usu_idUser');
    }


}
