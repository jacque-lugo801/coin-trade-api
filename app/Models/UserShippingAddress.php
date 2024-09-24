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

    public function userShippingCountry() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(Country::class, 'coun_iso_alpha2', 'usad_country');
    }
    public function userShippingState() {
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(State::class, 'sta_iso_alpha2', 'usad_state');
    }
}