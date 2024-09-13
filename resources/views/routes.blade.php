<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- <title>Laravel</title> -->

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />

        <!-- Styles -->
        <style>
        </style>
    </head>
    <body class="">
        <table width="100%" style="text-align: left;">
            <thead>
                <th>
                    HTTP Method
                </th>
                <th>
                    Route
                </th>
                <th>
                    Action
                </th>
            </thead>
            <tbody>
                <?php
                    $routeCollection = Route::getRoutes();

                    foreach ($routeCollection as $value) {
                        echo "<tr>";

                        echo "<td>" . $value->methods()[0] . "</td>";
                        echo "<td>" . $value->uri() . "</td>";
                        echo "<td>" . $value->getActionName() . "</td>";

                        echo "</tr>";
                    }
                ?>
            </tbody>
        </table>
    </body>
</html>
