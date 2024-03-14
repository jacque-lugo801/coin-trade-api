<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductGroup extends Model
{
    use HasFactory;

    protected $table = "product_group";
    protected $primaryKey = 'pgrp_idGroup';
    protected $keyType = 'int';
    
    public $incrementing = false;
    
    
    public function typeProduct() {
        // return $this->BelongsTo(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
        return $this->BelongsTo(ProductType::class, 'ptpe_idType', 'ptpe_idType');
    }

    public function groupCategory() {
        // return $this->BelongsTo(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
        return $this->HasMany(ProductCategory::class, 'pgrp_idGroup', 'pgrp_idGroup');
    }
    
}
