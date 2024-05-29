<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ApiAuthAdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        //Comprobar si el usuario esta identificado
        $token = $request->header('Authorization');
        $jwtAuth = new \App\Helpers\JwtAuth();
        $checkToken = $jwtAuth->checkToken($token);

        if($checkToken) {
            $user = $jwtAuth->checkToken($token, true);

            // var_dump($user);
            // die();

            if(
                strtolower($user->urol_name) === strtolower('Vendedor') ||
                strtolower($user->urol_name) === strtolower('Comprador') ||
                $user->urol_idRol === 2 ||
                $user->urol_idRol === 3
            ) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 403,
                    // 'message'   => 'Error de identificación',
                    'message'   => 'El usuario no cuenta con permisos suficiente para ejecutar esta acción',
                );
            }
            else {

                if($user->usts_idStatus == 1 ) {

                    return $next($request);
                }
                else {
                    $data = array(
                        'status'    => 'error',
                        'code'      => 403,
                        // 'message'   => 'Error de identificación',
                        'message'   => 'El usuario no cuenta con permisos suficiente para ejecutar esta acción',
                    );
                }
                
            }

        }
        else {
            
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                // 'message'   => 'Error de identificación',
                'message'   => 'El usuario no esta identificado MidAdmin',
            );

        }
        return response()->json($data, $data['code']);
    }
}
