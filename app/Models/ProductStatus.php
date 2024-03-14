<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductStatus extends Model
{
    use HasFactory;

    protected $table = "product_status";
    protected $primaryKey = 'psts_idStatus';
    
    // const CREATED_AT = 'pcert_created_date';
    // const UPDATED_AT = 'pcert_updated_date';
    
    protected $fillable = [
        'psts_name',
        'psts_description',
    ];
    
    protected $hidden = [
        // 'prod_idProducto',
    ];
}
