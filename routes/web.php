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
use App\Http\Controllers\ProductGroupController;
use App\Http\Controllers\ProductCategoryController;
use App\Http\Controllers\ProductRatingController;
use App\Http\Controllers\UserRolController;

// Middlewares
// use App\Http\Middleware\ApiAuthMiddleware;



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

// Envio de e-mail con código de verificación
Route::post('/api/user/send-code', [MailController::class, 'userVerificationCode']);
Route::post('/api/user/resend-code', [MailController::class, 'userResendVerificationCode']);
Route::post('/api/user/validate-code', [UserController::class, 'validateVerificationCode']);

Route::post('/api/user/register-account', [MailController::class, 'userRegisterAccount']);



// Territorios
Route::get('/api/countries', [CountryController::class, 'getCountries']);
Route::get('/api/states', [StateController::class, 'getStatesFmCountry']);
Route::get('/api/cities', [CityController::class, 'getCitiesFmState']);


// Productos
Route::get('/api/categories', [ProductTypeController::class, 'getAllCategories']);


// Route::get('/api/categories/group-categories', [ProductTypeController::class, 'getGroupCategories']);
Route::get('/api/categories/metal-categories', [ProductCategoryController::class, 'getMetalCategories']);




Route::get('/api/categories-coins', [ProductTypeController::class, 'getAllCoinCategories']);
Route::get('/api/categories-bills', [ProductTypeController::class, 'getAllMoneyBillCategories']);




Route::get('/api/products', [ProductController::class, 'getAllProducts']);
Route::get('/api/products/coins', [ProductController::class, 'getAllCoins']);
Route::get('/api/products/bills', [ProductController::class, 'getAllBills']);

Route::get('/api/product/{idProduct}', [ProductController::class, 'getProduct']);

Route::get('/api/products/product-type', [ProductTypeController::class, 'getProductTypes']);




Route::get('/api/products/image/{filename}', [ProductController::class, 'getImage']);





// Si definimos un middleware para varias rutas, podría añadirse a cada uno, pero en la documentación de laravel tenemos un sistema para englobar varias rutas dentro de uno o más middlewares:
// Route::middleware(['api.auth'])->group(function(){
//     Route::post('/user/upload', [UserController::class, 'upload']);
// });

// Autenthicate is required
// Route::middleware([ApiAuthMiddleware::class])->group(function () { //Sin alias
    // All
Route::middleware(['api.auth'])->group(function () { //Con alias
    Route::put('/api/user/update-profile', [UserController::class, 'updateProfile']);

    //products
    Route::get('/api/products/products-user', [ProductController::class, 'getProductsFmUser']);

    
    Route::post('/api/products/upload', [ProductController::class, 'uploadImage']);

    Route::post('/api/products/upload-product', [ProductController::class, 'uploadProduct']);

    Route::post('/api/products/rate-product', [ProductRatingController::class, 'ratingProduct']);
    
    // Route::get('/profile', function () {
    //     // ...
    // })->withoutMiddleware([EnsureTokenIsValid::class]);
});



// Admin Autenthicate
Route::middleware(['api.auth.admin'])->group(function () { //Con alias
    Route::get('/api/user/all-users', [UserController::class, 'getAllUsers']);
    Route::post('/api/user/register-user', [UserController::class, 'addNewUser']);

    Route::get('/api/rol/all-roles', [UserRolController::class, 'getAllRoles']);
 
    // Route::get('/profile', function () {
    //     // ...
    // })->withoutMiddleware([EnsureTokenIsValid::class]);
});