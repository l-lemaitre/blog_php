<?php
    namespace App\Classes\Controllers;

    class Controller {
        protected function render($file, $table = []) {
            $loader = new \Twig\Loader\FilesystemLoader('views/templates/front');
            $twig = new \Twig\Environment($loader, [
                'cache' => 'cache/twig',
            ]);

            echo $twig->render($file, $table);
        }
    }