/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.7.19 : Database - grupos_vida
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`grupos_vida` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `grupos_vida`;

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `roles` */

insert  into `roles`(`id`,`rol`) values (1,'MENTOR'),(2,'COORDINADOR'),(3,'COORD. GRUPOS'),(4,'PASTOR');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) DEFAULT NULL,
  `pass` varchar(255) DEFAULT '8cb2237d0679ca88db6464eac60da96345513964',
  `name` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `dir` varchar(255) DEFAULT NULL,
  `rol` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`user`,`pass`,`name`,`tel`,`dir`,`rol`) values (101,'bmiranda','8cb2237d0679ca88db6464eac60da96345513964','BORIS MIRANDA','3016215920','VERAJUDITH',2),(102,'hgomez','8cb2237d0679ca88db6464eac60da96345513964','HEINER GOMEZ','3214748593','SAN BERNARDO',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
