<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserFiscalData extends Model
{
    use HasFactory;

    protected $table        = "users_fiscal_data";
    protected $primaryKey   = 'ufdt_idData';
    
    const CREATED_AT = 'ufdt_updated_date';
    const UPDATED_AT = 'ufdt_created_date';

    protected $fillable = [
        'ufdt_denomination',
        'ufdt_rfc',
        'ufdt_country',
        'ufdt_state',
        'ufdt_city',
        'ufdt_address',
        'usu_idUser',
    ];
    
    protected $hidden = [
        'usu_idUser',
    ];

    
    public function userFiscalCountry() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(Country::class, 'coun_iso_alpha2', 'ufdt_country')
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
    public function userFiscalState() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(State::class, 'sta_iso_alpha2', 'ufdt_state')

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
    public function userFiscalCity() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->HasOne(City::class, 'cit_clave', 'ufdt_city')

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
