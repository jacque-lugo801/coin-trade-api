<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\UserController;
use App\Http\Controllers\UserRolController;
use App\Http\Controllers\MailController;
use App\Http\Controllers\CountryController;
use App\Http\Controllers\StateController;
use App\Http\Controllers\CityController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProductTypeController;
use App\Http\Controllers\ProductGroupController;
use App\Http\Controllers\ProductCategoryController;
use App\Http\Controllers\ProductRatingController;
use App\Http\Controllers\ProductFavoriteController;
use App\Http\Controllers\ProductStatusController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\CartItemController;
use App\Http\Controllers\ImageController;
use App\Http\Controllers\SettingsController;


// Middlewares
// use App\Http\Middleware\ApiAuthMiddleware;

// VIEWS
Route::get('/', function () {
    return view('welcome');
});
Route::get('list/routes', function () {
    return view('routes');
});
// Route::get('/view-account-reset-pass', function () {
//     return view('emails/userResetPassword');
// });
// Route::get('/view-account-registration-admin', function () {
//     return view('emails/userRegisterAccountByAdmin');
// });
// Route::get('/view-verification-code', function () {
//     return view('emails/userVerificationCode');
// });
// Route::get('/view-authorized', function () {
//     return view('emails/userAuthorizedByAdmin');
// });
// Route::get('/view-approve-product', function () {
//     return view('emails/productApproveByAdmin');
// });
// Route::get('/view-upload-product', function () {
//     return view('emails/productUpload');
// });
Route::get('api/user/code', [UserController::class, 'code']); // Registrar nueva cuenta de usuario
// END VIEWS


// IMAGES
Route::get('/images/{imageName}', [ImageController::class, 'show'])->name('image.show'); // Obtener las imagenes almacenadas en el storage
// END IMAGES

// USER
Route::post('api/user/signup', [UserController::class, 'signup'])->name('user.signup'); // Registrar nueva cuenta de usuario
Route::post('api/user/search-mail', [UserController::class, 'searchMail'])->name('user.searchMail'); // Buscar el email cuando se intente recuperar la contraseña
Route::post('/api/user/validate-code', [UserController::class, 'validateVerificationCode'])->name('user.validateCode'); // Validación del código
Route::put('/api/user/configure-account', [UserController::class, 'userConfigureAccount'])->name('user.configureAccount'); // Configurar cuenta cuando se valida por URL

Route::post('api/user/login', [UserController::class, 'login'])->name('user.login'); // Login de usuarios
Route::put('/api/user/reset-pass', [UserController::class, 'resetPassword'])->name('user.resetPassword'); // Guardar contraseña nueva
// END USER

// MAIL
Route::post('/api/user/send-code', [MailController::class, 'userVerificationCode'])->name('mail.sendCode'); // E-mail para enviar el código de verificacion
Route::post('/api/user/register-account', [MailController::class, 'userRegisterAccount'])->name('mail.validatedAccount'); // E-mail para notificar la correcta creación y validación de la cuenta)
// END MAIL

// TERRITORIES
Route::get('/api/countries', [CountryController::class, 'getCountries'])->name('territory.countries'); // Obtener los países
Route::get('/api/states', [StateController::class, 'getStatesFmCountry'])->name('territory.states'); // Obtener los estados del país
Route::get('/api/cities', [CityController::class, 'getCitiesFmState'])->name('territory.cities'); // Obtener las ciudades del estado
// END TERRITORIES

// PRODUCTS
Route::get('/api/products', [ProductController::class, 'getAllProducts'])->name('products.all'); // Obtener todos los productos
Route::get('/api/products/image/{filename}', [ProductController::class, 'getImage'])->name('products.imageShow'); // Obtener la imagen
Route::get('/api/product/{idProduct}', [ProductController::class, 'getProduct'])->name('products.product'); // Obtiene el producto con el ID
Route::get('/api/products/product-type', [ProductTypeController::class, 'getProductTypes'])->name('products.types'); //*
Route::get('/api/products/coins', [ProductController::class, 'getAllCoins'])->name('products.coins'); //*
Route::get('/api/products/bills', [ProductController::class, 'getAllBills'])->name('products.bills'); //*
// END PRODUCTS

// CATEGORIES
Route::get('/api/categories', [ProductTypeController::class, 'getAllCategories'])->name('categories.all'); //*
// END CATEGORIES

// URL
Route::post('/api/user/validate-url', [UserController::class, 'validateUrl'])->name('url.validate'); // *
// END URL

// SETTINGS
Route::get('/api/settings/valuation-price', [SettingsController::class, 'getValuationPrice'])->name('settings.valuation.price'); //*
// END SETTINGS



// Autenticación requerida (todos los usuarios)
// Route::middleware([ApiAuthMiddleware::class])->group(function () { //Sin alias
Route::middleware(['api.auth'])->group(function () { //Con alias
    // USER
    Route::put('/api/user/update-profile', [UserController::class, 'updateProfile'])->name('auth.user.profileUpdate'); //*
    // END USER

    // PRODUCTS
    Route::get('/api/products/products-user', [ProductController::class, 'getProductsFmUser'])->name('auth.products.products'); //*
    Route::put('/api/products/update-product', [ProductController::class, 'updateProduct'])->name('auth.products.updateProduct'); //*
    Route::get('/api/product/product/{idProduct}', [ProductController::class, 'getProductInfo'])->name('auth.products.productInfo'); //*
    Route::get('/api/products/status', [ProductStatusController::class, 'getStatus'])->name('auth.products.status'); //*
    Route::get('/api/products/products-rated-user', [ProductRatingController::class, 'getProductsRatedFmUser'])->name('auth.products.userRated'); // *
    Route::get('/api/products/products-favorites-user', [ProductFavoriteController::class, 'getProductsFavoriteFmUser'])->name('auth.products.userFavorites'); //*
    Route::get('/api/products/product-type', [ProductTypeController::class, 'getProductTypes'])->name('auth.products.types'); //*
    Route::post('/api/products/upload-image', [ProductController::class, 'uploadImage'])->name('auth.products.uploadImage'); //*
    Route::post('/api/products/upload-product', [ProductController::class, 'uploadProduct'])->name('auth.products.upload'); //*
    // END PRODUCTS



    Route::post('/api/products/rate-product', [ProductRatingController::class, 'ratingProduct']);
    Route::post('/api/products/favorite-product', [ProductFavoriteController::class, 'favoriteProduct']);
    

    // CART
    Route::get('/api/cart/', [CartController::class, 'getCart']);
    Route::post('/api/cart/add-item', [CartItemController::class, 'addItemToCart']);
    Route::post('/api/cart/remove-item', [CartItemController::class, 'removeItemFromCart']);
    // Route::put('/api/cart/update-item', [CartItemController::class, 'updateItemFromCart']);
    Route::put('/api/cart/update-item', [CartItemController::class, 'updateItemFromCart']);

});


// Autenticación de administrador
Route::middleware(['api.auth.admin'])->group(function () { //Con alias
    // USER
    Route::get('/api/user/all-users', [UserController::class, 'getAllUsers'])->name('admin.user.allUsers'); // *
    Route::get('/api/user/{idUser}', [UserController::class, 'getUserByID'])->name('admin.user.user'); // *
    Route::put('/api/user/authorize', [UserController::class, 'authorizeUser'])->name('admin.user.authorize'); // *
    Route::put('/api/user/activate', [UserController::class, 'activateUser'])->name('admin.user.activate'); // *
    Route::put('/api/user/update-user', [UserController::class, 'updateUser'])->name('admin.user.update'); // *
    Route::post('/api/user/register-user', [UserController::class, 'addNewUser'])->name('admin.user.register'); // *
    // END USER

    // Route::get('/api/product/{idProduct}', [ProductController::class, 'getProduct']);
    
    // ROL
    Route::get('/api/rol/all-roles', [UserRolController::class, 'getAllRoles'])->name('admin.rol.allRoles'); // *
    // END ROL

    // PRODUCTS
    Route::get('/api/products/products-verify', [ProductController::class, 'getProductsForVerification'])->name('admin.products.all'); //*
    Route::put('/api/products/approve', [ProductController::class, 'approveDisapproveProduct'])->name('admin.products.aprove'); //*
    // END PRODUCTS



    // NOTIFICATIONS
    Route::post('/api/notifications/request-upgrade', [NotificationController::class, 'sendRequestUpgrade'])->name('admin.notifications.requestUpgrade');
    // END NOTIFICATIONS
    
    // SETTINGS
        Route::put('/api/settings/valuation-price-update', [SettingsController::class, 'updateValuationPrice'])->name('admin.settings.valuationPriceUpdate'); //* 
    // END SETTINGS

});