<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $table = "products";
    // protected $primaryKey = 'prod_idProducto';
    // Relacion
    // Uno a muchos inversa ó muchos a uno normal
    // Muchos productos pueden pértenecer a un usuario

    // muchos productos pertenecen a un typo


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
}
