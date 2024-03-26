<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductFavorite extends Model
{
    use HasFactory;

    protected $table = "users_favorites";
    protected $primaryKey = 'ufav_idFavorite';
    // protected $keyType = 'int';
    
    // public $incrementing = false;

    const CREATED_AT = 'ufav_created_date';
    const UPDATED_AT = 'ufav_updated_date';

    protected $hidden = [
        'ufav_isActive',
        'usu_idUser',
        // 'prod_idProducto',
    ];

    
    public function productFavorite() {
        // return $this->BelongsTo(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
        return $this->BelongsTo(Product::class, 'prod_idProducto', 'prod_idProducto');
    }
}
