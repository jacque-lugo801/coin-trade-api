<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Storage;

class ImageController extends Controller
{
    /**
     * Display the specified image.
     *
     * @param  string  $imageName
     * @return \Illuminate\Http\Response
     */
    public function show($imageName)
    {
        // Construct the full path to the image within the storage directory
        $path = storage_path("app/public/images/{$imageName}");

        // Check if the image exists; if not, return a 404 response
        if (!Storage::exists("public/images/{$imageName}")) {
            abort(404);
        }

        // Return the image as a response
        return response()->file($path);
    }
}
