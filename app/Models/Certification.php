<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Certification extends Model
{
    use HasFactory;

    
    protected $table = "certifications";
    
    public function products(){
        return $this->HasMany('App\Models\Product');
    }
}
