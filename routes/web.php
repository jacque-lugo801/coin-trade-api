<?php

use Illuminate\Support\Facades\Route;

// use App\Http\Controllers;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProductTypeController;
use App\Http\Controllers\MailController;
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
/*
Route::get('/', function () {
    return view('welcome');
});
*/
Route::get('/', function () {
    return view('welcome');
});
Route::get('/welcome', function () {
    return view('welcome');
});



// // Rutas de prueba
// Route::get('/user/pruebas', [UserController::class, 'pruebas']);
// Route::get('/product/pruebas', [ProductController::class, 'pruebas']);
// Route::get('/product-type/pruebas', [ProductTypeController::class, 'pruebas']);






// Rutas controlador usuario
Route::post('api/user/signup', [UserController::class, 'signup']);
Route::post('api/user/signin', [UserController::class, 'signin']);
Route::post('api/user/update', [UserController::class, 'update']);

Route::post('/api/user/send-code', [MailController::class, 'userVerificationCode']);
Route::post('/api/user/resend-code', [MailController::class, 'userResendVerificationCode']);
Route::post('/api/user/validate-code', [UserController::class, 'validateVerificationCode']);