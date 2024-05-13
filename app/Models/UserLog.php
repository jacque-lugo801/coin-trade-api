<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserLog extends Model
{
    use HasFactory;
    
    protected $table = "users_logs";
    protected $primaryKey = 'ulog_idLog';
    // protected $keyType = 'string';


    const CREATED_AT = 'ulog_created_date';
    const UPDATED_AT = 'ulog_updated_date';

    
    protected $fillable = [
        'ulog_date_access',
        'ulog_device',
        'ulog_os',
        'ulog_browser',
        'ulog_isDesktop',
        'ulog_isPhone',
        'ulog_isRobot',
        'ulog_ip',
        'ulog_ip_region',
        'ulog_ip_region_code',
        'ulog_ip_country_name',
        'ulog_ip_country_code',
        'ulog_ip_latitude',
        'ulog_ip_longitude',
    ];


    protected $hidden = [
        // 'coun_iso_alpha3',
        'ulog_fingerprint',
        'usu_idUser',
    ];
}
