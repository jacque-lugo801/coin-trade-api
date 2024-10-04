<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductCertifications extends Model
{
    use HasFactory;

    protected $table        = "product_certifications";
    protected $primaryKey   = 'pcert_idCertification';
    
    const CREATED_AT = 'pcert_created_date';
    const UPDATED_AT = 'pcert_updated_date';
    
    protected $fillable = [
        'pcert_name',
        'pcert_description',
        'pcert_image',
    ];
    
    protected $hidden = [
        'prod_idProducto',
    ];
}
