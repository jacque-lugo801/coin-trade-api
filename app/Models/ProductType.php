<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductType extends Model
{
    use HasFactory;

    protected $table = "product_type";
    protected $primaryKey = 'ptpe_idType';


    // relacion de uno a muchos, obtiene todos los productos que poertenecen a una categoria
    public function products() {
        return $this->HasMany('App\Models\Product', 'prod_idProducto');
    }
}
