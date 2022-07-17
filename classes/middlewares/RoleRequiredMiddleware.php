<?php
    namespace App\Classes\Middlewares;

    class RoleRequiredMiddleware
    {
        public static function ifAdminIsLogin()
        {
            // If an administrator is logged in then we no longer return to this page
            if(isset($_SESSION["admin_id"])) {
                header("location:/blog_php/backoff/dashboard");
                exit;
            }
        }

        public static function ifAdminIsNotLogin()
        {
            // If no administrator is logged in then we do not go to this page
            if(!isset($_SESSION["admin_id"])) {
                // The user is sent to the login page
                header("location:/blog_php/backoff/login");
                exit;
            }
        }
    }