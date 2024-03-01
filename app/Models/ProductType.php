<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductType extends Model
{
    use HasFactory;

    protected $table = "product_type";
    protected $primaryKey = 'ptpe_idType';
    
    // const CREATED_AT = 'prod_created_date';
    // const UPDATED_AT = 'prod_updated_date';

    protected $hidden = [
        'ptpe_isActive',
    ];

    // public function get

    // relacion de uno a muchos, obtiene todos los productos que poertenecen a una categoria
    public function products() {
        return $this->HasMany('App\Models\Product', 'prod_idProducto');
    }
}
