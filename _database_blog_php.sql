# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.39-0ubuntu0.18.04.2-log)
# Database: blog_php
# Generation Time: 2022-09-09 20:39:16 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id_category` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_category`,`title`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;

INSERT INTO `category` (`id_category`, `title`, `slug`, `date_add`)
VALUES
	(1,'Actualités','actualites','2022-06-05 14:51:23'),
	(2,'Autre','autre','2022-07-10 15:50:31');

/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id_comment` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `contents` text NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id_comment`),
  KEY `post_id` (`post_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id_post`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;

INSERT INTO `comment` (`id_comment`, `user_id`, `post_id`, `contents`, `status`, `deleted`, `date_add`, `date_updated`)
VALUES
	(1,1,1,'Test.','rejected',0,'2022-07-27 10:17:14','2022-07-27 16:55:11'),
	(2,2,1,'Praesent ut tellus pharetra, fermentum eros ac, porttitor nibh.\nPraesent quis fringilla erat. Vivamus sit amet auctor velit, nec rhoncus tortor. Morbi eget erat vel nulla vehicula sollicitudin. Cras faucibus rhoncus auctor. Pellentesque condimentum dolor vel mauris viverra, nec pharetra orci mollis. Sed sed posuere quam. Maecenas iaculis purus a tellus ultricies elementum ut eu odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit.','approved',0,'2022-07-27 13:25:18','2022-07-27 13:25:18'),
	(3,3,1,'Test2.','approved',0,'2022-07-27 14:31:38','2022-07-27 14:31:38'),
	(4,2,2,'Test3.','approved',0,'2022-07-27 14:32:38','2022-07-27 14:32:38'),
	(5,3,1,'Test 4.','pending',0,'2022-08-01 22:19:51','2022-08-01 22:19:51'),
	(6,1,1,'Test 5.','approved',0,'2022-08-07 15:36:44','2022-08-07 15:36:44'),
	(7,1,5,'Test edit.','approved',0,'2022-08-28 17:53:50','2022-08-28 20:27:10'),
	(8,3,1,'Test soutenance.','approved',1,'2022-09-09 09:26:22','2022-09-09 09:34:35'),
	(9,1,6,'Test soutenance 2.','approved',0,'2022-09-09 09:32:19','2022-09-09 09:32:19');

/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id_post` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `chapo` varchar(255) NOT NULL,
  `contents` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id_post`),
  UNIQUE KEY `slug` (`slug`),
  KEY `category_id` (`category_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id_category`),
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;

INSERT INTO `post` (`id_post`, `category_id`, `user_id`, `title`, `chapo`, `contents`, `slug`, `published`, `deleted`, `date_add`, `date_updated`)
VALUES
	(1,1,1,'Lorem Ipsum','Lorem Ipsum dolor sit amet, consectetur adipiscing elit.','Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consequat tortor nec leo rutrum, ac convallis nibh pellentesque. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed accumsan nibh tellus, ut interdum diam eleifend eu. Sed cursus feugiat augue. Phasellus bibendum vehicula molestie. Proin vitae justo eros. Donec placerat lacinia lorem et imperdiet. Pellentesque a accumsan diam, id lacinia risus.\r\n\r\nSuspendisse varius massa non interdum semper. Ut a sapien magna. Phasellus blandit eros a interdum varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sit amet fringilla odio, sed rutrum urna. Maecenas quis volutpat tellus, et rhoncus augue. Praesent dictum lacinia elit, in dictum mauris vulputate sed. Aenean id orci mauris. Etiam interdum euismod efficitur. Praesent mauris lectus, porttitor quis pellentesque nec, auctor in libero. Integer sit amet velit id lorem maximus vulputate eget at odio. Mauris placerat tellus sed mauris dapibus, sed euismod orci egestas. Fusce quis placerat ante, a convallis dui. Maecenas dapibus accumsan quam, id imperdiet purus ullamcorper id. Pellentesque gravida ullamcorper egestas.\r\n\r\nNunc malesuada lectus eu purus hendrerit, at scelerisque neque efficitur. Vivamus est diam, aliquam quis malesuada nec, luctus a dui. Nulla feugiat sem eget molestie condimentum. Duis vel faucibus eros, vel mattis erat. Aenean fermentum consectetur vehicula. Aliquam sit amet orci vel elit tincidunt semper ut quis elit. Nunc fringilla eget mi vitae fringilla. Nunc posuere, nulla quis imperdiet dictum, diam neque bibendum tortor, pulvinar accumsan ipsum lectus eu mi. Donec sagittis massa in libero aliquet molestie. Integer varius leo malesuada risus posuere venenatis. Aliquam tempor finibus turpis a auctor. Donec faucibus consequat risus ac mattis. Pellentesque cursus faucibus posuere. Integer in nunc tristique, ornare neque a, fringilla libero. Phasellus venenatis sollicitudin magna in luctus. Integer finibus tellus lorem, sit amet euismod quam efficitur finibus.','lorem-ipsum',1,0,'2022-06-05 15:00:55','2022-07-15 19:28:54'),
	(2,2,1,'Suspendisse potenti','Integer sed placerat dui.','Suspendisse potenti. Integer sed placerat dui. Nullam sed pellentesque quam. Morbi egestas fermentum lacus, a ornare orci iaculis porttitor. Mauris interdum justo leo, ut porta ante malesuada vel. Praesent non vestibulum ipsum, vitae sollicitudin nulla. Vivamus aliquam, arcu sit amet tempus mollis, sapien elit sodales purus, a suscipit augue dolor eu ipsum. Etiam sit amet enim mollis, placerat risus sit amet, accumsan justo. Integer placerat luctus velit, et accumsan lacus gravida vel. Aenean posuere vitae libero et dapibus.\r\n\r\nPraesent pharetra consectetur eros a pharetra. Aenean in placerat mauris, quis dictum lectus. Nunc et molestie turpis, non gravida nunc. Donec non varius ligula. Aenean tincidunt turpis ac arcu faucibus, viverra mattis turpis commodo. Sed eleifend orci ac diam gravida, ac posuere tortor pharetra. Nullam non congue erat. Nulla at molestie metus. Donec est leo, hendrerit quis urna nec, mattis tempor dui.\r\n\r\nNunc tempus dignissim rutrum. Sed ornare mauris in gravida dapibus. Nulla in facilisis ante. Integer ac velit purus. Nunc molestie erat vehicula ullamcorper pharetra. Ut rutrum, nulla vel egestas viverra, massa leo pharetra odio, a suscipit tellus mauris in nibh. Vivamus quis suscipit est, ac molestie ante. Cras cursus purus sit amet viverra blandit. Nullam gravida ultrices felis, eget eleifend turpis gravida sed. Nulla et aliquam nisi. Praesent vel justo ante. Maecenas eu mattis urna. Duis et tellus sed ligula facilisis volutpat. Proin accumsan nisl et purus porta, in fermentum purus semper. Aenean nec sem vitae ligula fringilla vulputate.','suspendisse-potenti',1,0,'2022-06-05 15:19:13','2022-07-15 19:28:49'),
	(3,1,1,'Test','Test.','Test.','test',0,0,'2022-07-15 19:56:52','2022-08-28 20:25:18'),
	(4,1,1,'Test2','Test 2.','Test 2.','test2',1,1,'2022-07-20 18:38:43','2022-07-20 18:50:56'),
	(5,1,1,'Test3','Test 3.','Donec nec urna gravida, auctor lorem a, aliquam orci. Morbi ut arcu et tortor fringilla tristique. Sed eget laoreet ipsum. Cras quis sapien eros. Sed eget lobortis lacus. Vivamus aliquet purus vitae sodales placerat. Donec mattis ultricies ligula sed venenatis. Nullam pulvinar nisl sit amet nulla sodales, vitae interdum dolor vehicula. Vestibulum et neque risus. Nullam luctus vulputate pharetra. Pellentesque consequat augue a ipsum varius placerat. Aliquam ullamcorper blandit porta. Integer semper gravida venenatis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.','test3',1,0,'2022-08-28 17:32:32','2022-08-28 17:47:11'),
	(6,1,1,'Aliquam lobortis','Aliquam lobortis.','Aliquam lobortis ex eu nisl rutrum blandit. Nullam maximus ante ac ipsum imperdiet sollicitudin. Vestibulum lorem nisi, pulvinar in consequat nec, faucibus in turpis. Integer dignissim ullamcorper magna at posuere. Fusce in leo vehicula, hendrerit lacus dignissim, scelerisque nisl. Donec et interdum ante. Duis nec mi a purus mollis faucibus vel vel dui. Integer id dui a orci auctor blandit. Aliquam tempor erat vel mauris elementum, quis egestas metus imperdiet. Proin vel nisi ligula. Nullam blandit, ante quis tincidunt mattis, justo nunc vestibulum arcu, a maximus sem urna sed odio. Suspendisse scelerisque sollicitudin vulputate. Mauris egestas turpis a accumsan elementum. Nam eu rutrum enim, a mattis odio. Pellentesque convallis consectetur mi, non scelerisque dui tristique id. Cras sit amet mi quis velit congue ullamcorper.','aliquam-lobortis',1,0,'2022-09-09 09:31:00','2022-09-09 09:31:31');

/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT '',
  `lastname` varchar(255) DEFAULT '',
  `firstname` varchar(255) DEFAULT '',
  `is_admin` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `registration_date` datetime NOT NULL,
  `unsubscribe_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id_user`, `username`, `email`, `password`, `lastname`, `firstname`, `is_admin`, `deleted`, `registration_date`, `unsubscribe_date`)
VALUES
	(1,'Ludo','contact@llemaitre.com','$argon2i$v=19$m=1024,t=2,p=2$Qk1rbncxUVVzUktKQm5kYQ$ljUJnaKyct49EBfG1U85X+tVo9rWeZ8CT7rzUpif15Q','Lemaître','Ludovic',1,0,'2022-06-05 13:43:06','2022-08-28 14:27:24'),
	(2,'Nerofaust','shooting.star@orange.fr','','','',0,0,'2022-07-27 10:15:35','2022-08-28 14:27:22'),
	(3,'Satô','ludovic@23prod.com','','','',0,0,'2022-07-27 14:31:38',NULL),
	(4,'Christophe','ludoviclemaitre@orange.fr','$argon2i$v=19$m=65536,t=4,p=1$T2FKbVRyMmViL3VBUUpnVA$KA9ktg2L0AebJnjbMLUVeDigDMvZoB52sbJ8E5jAAQU','Christophe','Gilles',1,0,'2022-09-09 09:37:06',NULL);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
