<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductType extends Model
{
    use HasFactory;

    protected $table        = "product_type";
    protected $primaryKey   = 'ptpe_idType';
    
    // const CREATED_AT = 'prod_created_date';
    // const UPDATED_AT = 'prod_updated_date';

    protected $hidden = [
        'ptpe_isActive',
    ];

    // public function get

    // relacion de uno a muchos, obtiene todos los productos que poertenecen a una categoria
    // public function products() {
    //     return $this->HasMany('App\Models\Product', 'prod_idProducto');
    // }
    
    public function typeHasGroup() {
        return $this->BelongsTo(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
        // return $this->BelongsTo(ProductGroup::class, 'ptpe_idType', 'ptpe_idType');
    }
    
    public function typeGroup() {
        // return $this->BelongsTo(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
        return $this->HasMany(ProductGroup::class, 'ptpe_idType', 'ptpe_idType');
    }

    
    public function productGroup() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->BelongsTo(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');

    }



}
