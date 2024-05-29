<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;



class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $primaryKey = 'usu_idUser';
    
    const CREATED_AT = 'usu_created_date';
    const UPDATED_AT = 'usu_updated_date';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'usu_idUser',
        'usu_username',
        'usu_email',
        'usu_email2',
        'usu_pswd',
        'urol_idRol',
        'usts_idStatus',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */

     //Datos que estaran bkloqueados en la base de datos para no mostrarlos en los arrays
    protected $hidden = [
        'usu_pswd',
        'usu_verification_code',
        'usu_verification_code_pass',
        'usu_isTerms',

        // 'usu_isVerification',
        // 'usu_isVerificated',


    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password'          => 'hashed',
    ];


    // Relacion uno a muhcos
    // obtiene todos los productos de ese usuario
    // public function products() {
    //     return $this->HasMany('App\Models\Products');
    // }

    public function userRol() {
        // return $this->HasOne('App\Models\UserRol', 'urol_idRol');
        // return $this->HasOne(UserRol::class, 'urol_idRol');
        return $this->BelongsTo(UserRol::class, 'urol_idRol');
    }

    // STATUS
    public function userStatus() {
        // return $this->HasOne('App\Models\UserStatus', 'usts_idStatus');
        return $this->BelongsTo(UserStatus::class, 'usts_idStatus');
    }
    


    public function userAddress() {
        // return $this->HasMany('App\Models\UserShippingAddress', 'usad_idAddress');
        return $this->HasMany(UserShippingAddress::class, 'usu_idUser');
    }
    public function userFiscal() {
        // return $this->HasMany('App\Models\UserFiscalData', 'ufdt_idData');
        return $this->HasOne(UserFiscalData::class, 'usu_idUser');
    }

    public function userAddressShipping() {
        // return $this->HasOne(UserShippingAddress::class, 'ufdt_idData');
        
        // return $this->HasMany(UserShippingAddress::class, 'usu_idUser', 'usu_idUser')
        return $this->HasMany(UserShippingAddress::class, 'usu_idUser', 'usu_idUser')
        
        ;
    }
    public function userShippingCity($cit_clave, $sta_iso_alpha2) {
        return $this->hasOne(City::class, 'cit_clave', 'usad_city')
                    ->join('states', 'cities.sta_iso_alpha2', '=', 'states.sta_iso_alpha2')
                    ->where('cities.cit_clave', '=', $cit_clave)
                    ->where('states.sta_iso_alpha2', '=', $sta_iso_alpha2);
    }
    

    public function userFiscalData() {
        // return $this->HasOne(UserShippingAddress::class, 'ufdt_idData');
        
        // return $this->HasMany(UserShippingAddress::class, 'usu_idUser', 'usu_idUser')
        return $this->HasMany(UserFiscalData::class, 'usu_idUser', 'usu_idUser')
        
        ;
    }

    public function userState () {
        
        // return $this->HasOne(S::class, 'usu_idUser');
    }


    public function userLog() {
        return $this->HasOne(UserLog::class, 'usu_idUser', 'usu_idUser')->latest();
    }
}
