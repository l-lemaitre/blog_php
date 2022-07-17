<?php
    require "vendor/autoload.php";

    session_start();

    use App\Classes\Controllers\AdminController;
    use App\Classes\Controllers\ErrorController;
    use App\Classes\Controllers\FrontController;
    use App\Classes\Router\Router;
    use App\Classes\Router\RouterException;

    $pathUrl = htmlspecialchars($_GET['url']);

    $pathUrl = $pathUrl == 'index' ? $pathUrl = '/' : $pathUrl;

    $pathUrl = $pathUrl == 'backoff/login' ? $pathUrl = '/backoff' : $pathUrl;

    $router = new Router($pathUrl);

    $router->get('/', function() {
        $frontController = new FrontController();
        $frontController->displayHomePage();
    });

    $router->post('/', function() {
        $frontController = new FrontController();
        $frontController->renderContactForm();
    });

    $router->get('/posts', function() {
        $frontController = new FrontController();
        $frontController->displayPosts();
    });

    $router->get('/post/:slug-:id', 'Front#displayPost')->with("slug", "[a-z\-0-9]+")->with("id", "[0-9]+");

    $router->get('/backoff/dashboard', function() {
        $adminController = new AdminController();
        $adminController->displayDashboard();
    });

    $router->get('/backoff/posts', function() {
        $adminController = new AdminController();
        $adminController->displayPosts();
    });

    $router->post('/backoff/posts', function() {
        $adminController = new AdminController();
        $adminController->renderFormResetPost($_POST["resetPost"]);
    });

    $router->get('/backoff/add-post', function() {
        $adminController = new AdminController();
        $adminController->displayAddPost();
    });

    $router->post('/backoff/add-post', function() {
        $adminController = new AdminController();
        $adminController->renderFormAddPost();
    });

    $router->get('/backoff/post-:id', 'Admin#displayEditPost')->with("id", "[0-9]+");

    if(isset($_POST["editPost"])) {
        $router->post('/backoff/post-:id', 'Admin#renderFormEditPost')->with("id", "[0-9]+");
    } elseif(isset($_POST["resetPost"])) {
        $router->post('/backoff/post-:id', 'Admin#renderFormResetPost')->with("id", "[0-9]+");
    }

    $router->get('/backoff/logout', function() {
        $adminController = new AdminController();
        $adminController->logoutBackOffice();
    });

    $router->get('/backoff', function() {
        $adminController = new AdminController();
        $adminController->displayLoginBackOffice();
    });

    $router->post('/backoff', function() {
        $adminController = new AdminController();
        $adminController->renderFormLoginBackOffice();
    });

    try {
        $router->run();
    }
    catch(RouterException $e) {
        $errorController = new ErrorController();
        $errorController->displayError();
    }
