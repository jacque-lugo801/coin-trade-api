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
        // 'name',
        // 'email',
        // 'password',
        'usu_username',
        'usu_email',
        'usu_email2',
        'usu_pswd',
        // 'usu_verification_code',
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
        // 'usu_idUser',
        'usu_pswd',
        // 'usu_verification_code',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];


    // Relacion uno a muhcos
    // obtiene todos los productos de ese usuario
    public function products() {
        return $this->HasMany('App\Models\Products');
    }
}
