<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class SecurityEDServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        //
        require_once app_path() .'/Helpers/SecurityED.php';
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}
