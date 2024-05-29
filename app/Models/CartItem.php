<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CartItem extends Model
{
    use HasFactory;
    protected $table = "cart_items";
    protected $primaryKey = 'citm_idItem';
    
    const CREATED_AT = 'citm_created_date';
    const UPDATED_AT = 'citm_updated_date';

    
    protected $hidden = [
        // 'citm_isActive',
    ];

    public function itemsCart() {
        // return $this->HasMany('App\Models\UserShippingAddress', 'usad_idAddress');
        return $this->BelongsTo(Cart::class, 'cart_idCart');
    }
    public function itemProduct() {
        // return $this->HasMany('App\Models\UserShippingAddress', 'usad_idAddress');
        // return $this->BelongsTo(Product::class, 'prod_idProducto');
        return $this->BelongsTo(Product::class, 'prod_idProducto');
    }
}
