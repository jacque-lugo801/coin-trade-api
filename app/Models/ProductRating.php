<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductRating extends Model
{
    use HasFactory;

    protected $table = "product_rating";
    protected $primaryKey = 'prat_idRating';
    // protected $keyType = 'int';
    
    // public $incrementing = false;

    const CREATED_AT = 'prat_created_date';
    const UPDATED_AT = 'prat_updated_date';

    protected $hidden = [
        'prat_isActive',
        // 'usu_idUser',
        // 'prod_idProducto',
    ];



    
    
    public function typeProduct() {
        // return $this->BelongsTo(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
        return $this->BelongsTo(ProductType::class, 'ptpe_idType', 'ptpe_idType');
    }
}
