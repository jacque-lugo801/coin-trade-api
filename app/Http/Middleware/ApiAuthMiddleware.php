<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;


// Un middlewarte es un metodo que se ejecuta antes de que se ejecute la accion de un controlador; como un filtro
class ApiAuthMiddleware
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

            if(
                $user->usts_idStatus != 1
            ) {
                $data = array(
                    'status'    => 'error',
                    'code'      => 403,
                    // 'message'   => 'Error de identificación',
                    'message'   => 'El usuario no cuenta con permisos suficiente para ejecutar esta acción',
                );
            }
            else {
                return $next($request);
            }

            // return $next($request);
        }
        else {
            $data = array(
                'status'    => 'error',
                'code'      => 404,
                // 'message'   => 'Error de identificación',
                'message'   => 'El usuario no esta identificado Mid',
            );


            return response()->json($data, $data['code']);
        }
    }
}
