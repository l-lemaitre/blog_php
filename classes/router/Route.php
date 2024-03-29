<?php
	namespace App\Classes\Router;

    class Route {
       private $path;
       private $callable;
       private $matches = [];
       private $params = [];

       public function __construct($path, $callable) {
          $this->path = trim($path, '/');
          $this->callable = $callable;
       }

       public function with($param, $regex) {
          $this->params[$param] = str_replace('(', '(?:', $regex);
          return $this;
       }

       /**
       * Will capture the url with parameters
       * get('/posts/:slug-:id') for example
       **/
       public function match($url) {
          $url = trim($url, '/');
          $path = preg_replace_callback('#:([\w]+)#', [$this, 'paramMatch'], $this->path);
          $regex = "#^$path$#i";

          if(!preg_match($regex, $url, $matches)) {
             return false;
          }

          array_shift($matches);
          $this->matches = $matches;
          return true;
       }

       private function paramMatch($match) {
          if(isset($this->params[$match[1]])) {
             return '(' . $this->params[$match[1]] . ')';
          }

          return '([^/]+)';
       }

       public function getUrl($params) {
          $path = $this->path;

          foreach($params as $k => $v) {
             $path = str_replace(":$k", $v, $path);
          }

          return $path;
       }

       public function call() {
          if(is_string($this->callable)) {
             $params = explode('#', $this->callable);
             $controller = "App\\Classes\\Controllers\\" . $params[0] . "Controller";
             $controller = new $controller();

             return call_user_func_array([$controller, $params[1]], $this->matches);
          } else {
             return call_user_func_array($this->callable, $this->matches);
          }
       }
    }
