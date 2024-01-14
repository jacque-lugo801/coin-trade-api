<?php

use Illuminate\Support\Facades\Route;

// use App\Http\Controllers;
// // use App\Http\Controllers\PruebasController;
use App\Http\Controllers\TestController;

use App\Http\Controllers\UserController;
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






// TEST
Route::get('/test-orm', [TestController::class, 'testOrm']);
// Con el @ hace referencia a que llama a la funcion


// Rutas de prueba
Route::get('/user/pruebas', [UserController::class, 'pruebas']);
Route::get('/product/pruebas', [ProductController::class, 'pruebas']);
Route::get('/product-type/pruebas', [ProductTypeController::class, 'pruebas']);




// Rutas controlador usuario


Route::post('api/user/signup', [UserController::class, 'signup']);
Route::post('api/user/signin', [UserController::class, 'signin']);
Route::post('api/user/update', [UserController::class, 'update']);