<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;

    protected $table        = "transactions";
    protected $primaryKey   = 'tran_idTransaction';
    
    const CREATED_AT = 'tran_created_date';
    const UPDATED_AT = 'tran_updated_date';

    protected $hidden = [
        'tran_isActive',
        // 'prod_isTerms',
    ];

    
    public function transactionStatus() {
        // Obtiene el usuario relqacionado por la propiedad usu_idUser
        // Saca el objeto asignado en base al usu_idUser
        // return $this->BelongsTo(TransactionDetail::class, 'tran_idTransaction', 'tran_idTransaction')
        return $this->BelongsTo(TransactionStatus::class, 'tsta_idStatus', 'tsta_idStatus')
        // return $this->BelongsTo(UserStatus::class, 'usts_idStatus');
            // ->BelongsTo(State::class, 'sta_iso_alpha2', 'usad_state')
        ;
    }
    public function transactionBuyer() {
        return $this->HasOne(User::class, 'usu_idUser', 'tran_idUserBuyer');
        // return $this->HasOne(Country::class, 'coun_iso_alpha2', 'tran_country');
    }
    public function transactionDetail() {
        return $this->HasMany(TransactionDetail::class, 'tran_idTransaction', 'tran_idTransaction');
    }
    public function paymentStatus() {
        return $this->HasOne(PaymentStatus::class, 'pyst_idStatus', 'tran_idPaymentStatus');
    }
    public function paymentType() {
        return $this->HasOne(PaymentType::class, 'pytp_idType', 'tran_idPaymentType');
    }
    public function paymentCategory() {
        return $this->HasOne(PaymentCategory::class, 'pyct_idCategory', 'tran_idPaymentCategory');
    }

    
    public function transactionCountry() {
        return $this->HasOne(Country::class, 'coun_iso_alpha2', 'tran_country');
    }
    public function transactionState() {
        return $this->HasOne(State::class, 'sta_iso_alpha2', 'tran_state');
    }
    public function transactionCity() {
        return $this->HasOne(City::class, 'cit_clave', 'tran_city');
    }
    public function transactionShippingAddress() {
        return $this->HasOne(UserShippingAddress::class, 'usad_idAddress', 'tran_idShippingAddress');
    }
    

    // purchases/Sales

}
