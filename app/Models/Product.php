<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $table = "products";
    protected $primaryKey = 'prod_idProducto';
    
    const CREATED_AT = 'prod_created_date';
    const UPDATED_AT = 'prod_updated_date';

    // protected $fillable = [
    //     'usu_idUser',
    //     'usu_username',
    //     'usu_email',
    //     'usu_email2',
    //     'usu_pswd',
    //     'urol_idRol',
    //     'usts_idStatus',
    // ];

    protected $hidden = [
        'prod_isActive',
        'usu_isTerms',
        // 'prod_itType_product',
        // 'prod_idGroup_product',
        // 'prod_idCategory_product',
    ];


    public function productUser() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        // return $this->BelongsTo('App\Models\User', 'usu_idUser');
        return $this->BelongsTo(User::class, 'usu_idUser');
    }
    // public function productImages() {
    //     return $this->HasMany(ProductImages::class, 'prod_idProducto');
    // }
    public function productCertifications() {
        return $this->HasMany(ProductCertifications::class, 'prod_idProducto');
    }

    public function productType() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(ProductType::class, 'ptpe_idType', 'prod_idType_product');

    }
    // public function productGroup() {
    //     // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
    //     return $this->HasOne(ProductGroup::class, 'ptpe_idType', 'prod_idType_product');

    // }
    // public function productGroup() {
    //     return $this->HasOne(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
    //     // return $this->HasMany(ProductType::class, 'ptpe_idType', 'ptpe_idType');
    // }
    // public function productCategory() {
    //     return $this->HasOne(ProductCategory::class, 'pcat_idCategory', 'prod_idCategory_product');
    // }


    public function productGroup() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(ProductGroup::class, 'pgrp_idGroup', 'prod_idGroup_product');
    }
    public function productCategory() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(ProductCategory::class, 'pcat_idCategory', 'prod_idCategory_product');
    }





    // public function certification() {
    //     // Obtiene el usuario relqacionado por la propiedad usu_idUser
    //     // Saca el objeto asignado en base al usu_idUser
    //     return $this->BelongsTo('App\Models\Certification', 'prod_idProducto');
    // }

    // public function productType() {
    //     return $this->BelongsTo('App\Models\ProductType', 'ptpe_idType');
    // }


    
    // public function productsUser() {
    //     // return $this->HasOne('App\Models\UserStatus', 'usts_idStatus');
    //     return $this->BelongsTo(User::class, 'usu_idUser');
    // }


    
    public function productCountry() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(Country::class, 'coun_iso_alpha2', 'prod_country')
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
    
    public function productStatus() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo(ProductStatus::class, 'psts_idStatus', 'psts_idStatus')
        // return $this->BelongsTo(UserStatus::class, 'usts_idStatus');
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }

}
