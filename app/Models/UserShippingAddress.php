<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserShippingAddress extends Model
{
    use HasFactory;

    protected $table        = "users_shipping_address";
    protected $primaryKey   = 'usad_idAddress';
    
    const CREATED_AT = 'usad_created_date';
    const UPDATED_AT = 'usad_updated_date';

    protected $fillable = [
        'usad_country',
        'usad_state',
        'usad_city',
        'usad_address',
        'usad_isDefault',
        'usu_idUser',
    ];
    
    protected $hidden = [
        'usu_idUser',
    ];


    
    public function country() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo('App\Models\Country', 'coun_iso_alpha2', 'usad_country');
    }

    public function shippingCountry() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(Country::class, 'coun_iso_alpha2', 'usad_country');
    }

    public function userShippingCountry() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(Country::class, 'coun_iso_alpha2', 'usad_country')
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
    public function userShippingState() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(State::class, 'sta_iso_alpha2', 'usad_state')

            // return $this->HasManyThrough(
                
            //     City::class    , // Owner::class,
            //      State::class   , // Car::class,
            // 'coun_iso_alpha2'    , // 'mechanic_id', // Foreign key on the cars table...
            //     'sta_iso_alpha2'    , // 'car_id', // Foreign key on the owners table...
            //     'coun_iso_alpha2'    , // 'id', // Local key on the mechanics table...
            //     'sta_iso_alpha2'   , // 'id' // Local key on the cars table...
            // )
        ;
    }
    public function userShippingCity() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(City::class, 'cit_clave', 'usad_city')

            // return $this->HasManyThrough(
                
            //     City::class    , // Owner::class,
            //      State::class   , // Car::class,
            // 'coun_iso_alpha2'    , // 'mechanic_id', // Foreign key on the cars table...
            //     'sta_iso_alpha2'    , // 'car_id', // Foreign key on the owners table...
            //     'coun_iso_alpha2'    , // 'id', // Local key on the mechanics table...
            //     'sta_iso_alpha2'   , // 'id' // Local key on the cars table...
            // )
        ;
    }
}
