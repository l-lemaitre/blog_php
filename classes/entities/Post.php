<?php
    namespace App\Classes\Entities;

    class Post
    {
        public	$id_post;
        public	$category_id;
        public	$user_id;
        public	$title;
        public	$chapo;
        public	$contents;
        public	$slug;
        public	$published;
        public	$date_add;
        public	$date_updated;

        const PUBLISHED = 1;
        const NOT_DELETED = 0;
    }
