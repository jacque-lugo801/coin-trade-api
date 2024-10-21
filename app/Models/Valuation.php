<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Valuation extends Model
{
    use HasFactory;

    protected $table        = "valuations";
    protected $primaryKey   = 'val_idValuation';
    
    const CREATED_AT = 'val_created_date';
    const UPDATED_AT = 'val_updated_date';

    protected $hidden = [
        // 'val_isPaid',
    ];

    
    public function valuationProduct() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo(Product::class, 'prod_idProducto', 'prod_idProducto')
        // return $this->BelongsTo(UserStatus::class, 'usts_idStatus');
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
    public function valuationStatus() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        return $this->BelongsTo(ValuationStatus::class, 'vsta_idStatus', 'vsta_idStatus')
        // return $this->BelongsTo(UserStatus::class, 'usts_idStatus');
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
    
    public function valuationUserRequester() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(User::class, 'usu_idUser', 'val_idUserRequester')
        ;
    }
    
    public function valuationPaymentStatus() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // return $this->hasOne(Phone::class, 'foreign_key', 'local_key');
        return $this->HasOne(PaymentStatus::class, 'pyst_idStatus', 'val_idPaymentStatus')
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
    
}
