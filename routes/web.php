<?php

use Illuminate\Support\Facades\Route;

// use App\Http\Controllers;
use App\Http\Controllers\UserController;
use App\Http\Controllers\MailController;
use App\Http\Controllers\CountryController;
use App\Http\Controllers\StateController;
use App\Http\Controllers\CityController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProductTypeController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


// Rutas controlador usuario
Route::post('api/user/signup', [UserController::class, 'signup']);
Route::post('api/user/signin', [UserController::class, 'signin']);
Route::post('api/user/update', [UserController::class, 'update']);

Route::post('/api/user/validate-code', [UserController::class, 'validateVerificationCode']);


// Envio de e-mail con código de verificación
Route::post('/api/user/send-code', [MailController::class, 'userVerificationCode']);
Route::post('/api/user/resend-code', [MailController::class, 'userResendVerificationCode']);
Route::post('/api/user/register-account', [MailController::class, 'userRegisterAccount']);

// Territorios
Route::get('/api/countries', [CountryController::class, 'getCountries']);
Route::get('/api/states', [StateController::class, 'getStatesFmCountry']);
// Route::get('/api/states/{code}', [StateController::class, 'getStatesFmCountry']);
Route::get('/api/cities', [CityController::class, 'getCitiesFmState']);


// Productos
// Route::get('/api/categories', [ProductTypeController::class, 'getAllCategories']);
Route::get('/api/categories-coins', [ProductTypeController::class, 'getAllCoinCategories']);
Route::get('/api/categories-bills', [ProductTypeController::class, 'getAllMoneyBillCategories']);
Route::get('/api/products', [ProductController::class, 'getAllProducts']);
Route::get('/api/product/{idProduct}', [ProductController::class, 'getProduct']);
