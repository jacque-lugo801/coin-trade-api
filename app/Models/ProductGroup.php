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
    
    
}
