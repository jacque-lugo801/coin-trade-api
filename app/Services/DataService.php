<?php

namespace App\Services;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Log;
use Exception;

/*
| Servicio para acceder de forma más rapida a los métodos de los controladores
| usados relacionados con los USUARIOS.
*/

class DataService
{
    // public function __construct (
    // ) {
    // }
    
    // Limpiar un arreglo
    public function trimArray($array) {
        foreach ($array as $key => &$value) {
            if (is_array($value)) {
                $value = $this->trimArray($value);  // Llamada recursiva si el valor es un arreglo
            } elseif (is_string($value)) {
                $value = trim($value);  // Aplica trim solo a valores de tipo string
            }
        }
        return $array;
    }

}
