<?php
    namespace App\Classes\Models;

    use \PDO;
    use App\Classes\Entities\Post;

    class PostRepository
    {
        // FrontController
        public static function getPostsPusblished() {
            $bdd = DataBaseConnection::getConnect();

            $query = "SELECT *
                      FROM `post`
                      WHERE `published` = ?
                      AND `deleted` = ?
                      ORDER BY `id_post` DESC";
            $resultSet = $bdd->query($query, array(Post::PUBLISHED, Post::NOT_DELETED));
            $resultSet->setFetchMode(PDO::FETCH_CLASS, Post::class);
            return $resultSet->fetchAll();
        }

        // AdminController
        public static function getPosts() {
            $bdd = DataBaseConnection::getConnect();

            $query = "SELECT a.*, u.`username` AS user_username, c.`title` AS category_title
                      FROM `post` a
                      LEFT JOIN `user` u ON (u.`id_user` = a.`user_id`)
                      LEFT JOIN `category` c ON (c.`id_category` = a.`category_id`)
                      WHERE `deleted` = ?
                      ORDER BY `id_post` DESC";
            $resultSet = $bdd->query($query, array(Post::NOT_DELETED));
            $resultSet->setFetchMode(PDO::FETCH_CLASS, Post::class);
            return $resultSet->fetchAll();
        }

        // Admin/FrontController
        public static function getPostById($id)
        {
            $bdd = DataBaseConnection::getConnect();

            $query = "SELECT a.*, u.`username` AS user_username
                      FROM `post` a
                      LEFT JOIN `user` u ON (u.`id_user` = a.`user_id`)
                      WHERE a.`id_post` = ?";
            $resultSet = $bdd->query($query, array($id));
            $resultSet->setFetchMode(PDO::FETCH_CLASS, Post::class);
            return $resultSet->fetch();
        }

        // AdminController
        public static function insertPost($category, $author, $title, $chapo, $contents, $slug, $published)
        {
            // We set the default time offset of all date/time functions to that of French time
            date_default_timezone_set("Europe/Paris");

            $bdd = DataBaseConnection::getConnect();

            $query = "INSERT INTO `post` (`category_id`, `user_id`, `title`, `chapo`, `contents`, `slug`, `published`, `date_add`, `date_updated`)
                      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            $bdd->insert($query, array($category, $author, $title, $chapo, $contents, $slug, $published, date("Y-m-d H:i:s"), date("Y-m-d H:i:s")));
        }

        // AdminController
        public static function setPost($category, $title, $chapo, $contents, $slug, $published, $id)
        {
            date_default_timezone_set("Europe/Paris");

            $bdd = DataBaseConnection::getConnect();

            $query = "UPDATE `post`
                      SET `category_id` = ?, `title` = ?, `chapo` = ?, `contents` = ?, `slug` = ?, `published` = ?, `date_updated` = ?
                      WHERE `id_post` = ?";
            $bdd->insert($query, array($category, $title, $chapo, $contents, $slug, $published, date("Y-m-d H:i:s"), $id));
        }

        // AdminController
        public static function resetPost($id)
        {
            date_default_timezone_set("Europe/Paris");

            $bdd = DataBaseConnection::getConnect();

            // We reset the columns containing the information of the post
            $query = "UPDATE `post`
                      SET `deleted` = 1, `date_updated` = ?
                      WHERE `id_post` = ?";
            $bdd->insert($query, array(date("Y-m-d H:i:s"), $id));
        }
    }
