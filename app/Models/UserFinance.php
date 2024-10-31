<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserFinance extends Model
{
    use HasFactory;

    protected $table        = "user_finances";
    protected $primaryKey   = 'ufin_idFinance';
    
    const CREATED_AT = 'ufin_created_date';
    const UPDATED_AT = 'ufin_updated_date';

    protected $hidden = [
        'ufin_isActive',
        // 'prod_isTerms',
    ];

    
    public function financeCardType() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo(CardType::class, 'ctpe_idType', 'ctpe_idType')
        // return $this->BelongsTo(UserStatus::class, 'usts_idStatus');
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
}
