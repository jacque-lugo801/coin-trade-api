<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

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

    public function userShippingCountry() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(Country::class, 'coun_iso_alpha2', 'usad_country');

    }
    public function userShippingState() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(State::class, 'sta_iso_alpha2', 'usad_state');
    }

    // public function userShippingCity() {
    //     // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
    //     return $this->HasOne(City::class, 'cit_clave', 'usad_city');
    // }

    // public function userShippingCity() {
    //     return $this->hasOne(City::class, 'cit_clave', 'usad_city')
    //                 ->whereColumn('cities.sta_iso_alpha2', '=', 'states.usad_state');
    // }
    
    
        // public function userShippingCity($cit_clave, $sta_iso_alpha2) {
        //     return $this->hasOne(City::class, 'cit_clave', 'usad_city')
        //                 ->join('states', 'cities.sta_iso_alpha2', '=', 'states.sta_iso_alpha2')
        //                 ->where('cities.cit_clave', '=', $cit_clave)
        //                 ->where('states.sta_iso_alpha2', '=', $sta_iso_alpha2);
        // }
    
    /*
    public function shippingCountry() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        // return $this->HasOne(Country::class, 'coun_iso_alpha2', 'usad_country');
        return $this->belongsTo(Country::class, 'usad_country', 'coun_iso_alpha2');
    }

    public function userShippingCountry() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        // return $this->HasOne(Country::class, 'coun_iso_alpha2', 'usad_country')
        return $this->belongsTo(Country::class, 'usad_country', 'coun_iso_alpha2');
        ;
    }
    public function userShippingState() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        // return $this->HasOne(State::class, 'sta_iso_alpha2', 'usad_state')
        return $this->belongsTo(State::class, 'usad_state', 'sta_iso_alpha2');
        

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
        // return $this->HasOne(City::class, 'cit_clave', 'usad_city')
        // return $this->belongsTo(City::class, 'usad_city', 'cit_clave');
        // return $this->belongsTo(City::class, 'usad_city', 'cit_clave');
        // return $this->belongsTo(City::class, 'usad_city', 'cit_clave')->where('sta_iso_alpha2', $this->usad_state);
        
    // return $this->belongsTo(City::class, 'usad_city', 'cit_clave');
    return $this->hasOne(City::class, function ($query) {
        $query->where('cit_clave', $this->usad_city)
              ->where('sta_iso_alpha2', $this->usad_state);
    });
            // return $this->HasManyThrough(
                
            //     City::class    , // Owner::class,
            //      State::class   , // Car::class,
            // 'coun_iso_alpha2'    , // 'mechanic_id', // Foreign key on the cars table...
            //     'sta_iso_alpha2'    , // 'car_id', // Foreign key on the owners table...
            //     'coun_iso_alpha2'    , // 'id', // Local key on the mechanics table...
            //     'sta_iso_alpha2'   , // 'id' // Local key on the cars table...
            // )
        // ;
    }

    public function getUserShippingCityAttribute()
    {
        $city = DB::table('cities')
                    ->select('cit_clave', 'cit_nombre')
                    ->where('sta_iso_alpha2', $this->usad_state)
                    ->where('cit_clave', $this->usad_city)
                    ->first();
    
        return $city;
    }*/

}
