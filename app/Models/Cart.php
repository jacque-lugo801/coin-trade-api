<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    use HasFactory;

    protected $table = "cart";
    protected $primaryKey = 'cart_idCart';
    
    const CREATED_AT = 'cart_created_date';
    const UPDATED_AT = 'cart_updated_date';
}
