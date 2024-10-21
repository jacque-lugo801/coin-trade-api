<?php

namespace App\Services;

use App\Http\Controllers\SettingsController;

use App\Models\Settings;


use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con las CONFIGURACIONES.
*/

class SettingService
{
    protected $settingsController;
    // protected $shippingController;
    // protected $fiscalController;
    // protected $userController;

    public function __construct (
        SettingsController      $settingsController,
    ) {
        $this->settingsController   =   $settingsController;
    }

    // SETTINGS
    //Obtener el costo de la valuacion
    public function getValuationCost() {
        try {
            $setting = Settings::
                where([
                    ["set_name", "=", "valuation_cost"],
                ])
                ->first()
            ;
            return $setting;
        } catch (QueryException $e)  {
            return 0;
        }
    }
    // END SETTINGS
}
