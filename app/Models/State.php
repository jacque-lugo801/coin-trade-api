<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class State extends Model
{
    use HasFactory;

    protected $table        = "states";
    protected $keyType      = 'string';
    protected $primaryKey   = 'sta_iso_alpha2';
    
    protected $hidden = [
        'sta_iso_alpha3',
        'coun_iso_alpha2',
        'sta_isActive',
    ];
    

    public function userState() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state');
    }
    public function city() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo(City::class, 'sta_iso_alpha2', 'usad_state');
    }
}
