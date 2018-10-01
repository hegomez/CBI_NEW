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
CREATE DATABASE /*!32312 IF NOT EXISTS*/`grupos_vida` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `grupos_vida`;

/*Table structure for table `asistentes` */

DROP TABLE IF EXISTS `asistentes`;

CREATE TABLE `asistentes` (
  `id` int(11) NOT NULL,
  `t_id` varchar(255) DEFAULT NULL,
  `n_id` varchar(45) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `barrio` int(11) NOT NULL,
  `grupo` int(11) NOT NULL,
  `nacimiento` date DEFAULT NULL,
  `escuela` int(11) NOT NULL,
  `escalera` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_asistentes_barrios_idx` (`barrio`),
  KEY `fk_asistentes_grupo1_idx` (`grupo`),
  KEY `fk_asistentes_niveles1_idx` (`escuela`),
  KEY `fk_asistentes_escalera1_idx` (`escalera`),
  CONSTRAINT `fk_asistentes_barrios` FOREIGN KEY (`barrio`) REFERENCES `barrio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_asistentes_escalera1` FOREIGN KEY (`escalera`) REFERENCES `escalera` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_asistentes_grupo1` FOREIGN KEY (`grupo`) REFERENCES `grupos` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_asistentes_niveles1` FOREIGN KEY (`escuela`) REFERENCES `niveles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `asistentes` */

insert  into `asistentes`(`id`,`t_id`,`n_id`,`nombre`,`telefono`,`direccion`,`barrio`,`grupo`,`nacimiento`,`escuela`,`escalera`) values (100,NULL,NULL,'Heiner','3217478593','kra 9a no 14a-69',106,100,'1989-03-23',999,999),(101,NULL,NULL,'Loraine gutierrez','3014943570','DÃ­a ha gina',134,100,'1994-10-04',999,999),(102,NULL,NULL,'Heiner','3217478593','kra 9a no 14a-69',106,100,'1989-03-23',999,999),(103,NULL,NULL,'jose','321','calle',154,100,'2000-02-10',999,999),(104,NULL,NULL,'aa','aaa','aaa',102,100,'2000-01-01',999,999),(105,NULL,NULL,'ddd','ddd','dd',130,100,'2000-01-01',999,999),(106,NULL,NULL,'11','11','11',130,100,'2000-01-01',999,999),(107,NULL,NULL,'22','22','22',100,100,'2000-01-01',999,999),(108,NULL,NULL,'f','f','f',101,100,'2000-01-01',999,999);

/*Table structure for table `asitencias` */

DROP TABLE IF EXISTS `asitencias`;

CREATE TABLE `asitencias` (
  `id` double NOT NULL,
  `asistente` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `detalle` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `asitencias` */

/*Table structure for table `barrio` */

DROP TABLE IF EXISTS `barrio`;

CREATE TABLE `barrio` (
  `id` int(11) NOT NULL,
  `barrio` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `barrio` */

insert  into `barrio`(`id`,`barrio`) values (100,'20 DE DICIEMBRE'),(101,'23 DE FEBRERO'),(102,'AEROPUERTO'),(103,'ALTAMIRA'),(104,'CORDOBITA'),(105,'CHIMILA'),(106,'EL CARMEN'),(107,'EL CENTRO'),(108,'JARDIN'),(109,'EL PRADO'),(110,'FAUSTINO MOJICA'),(111,'HAWAI'),(112,'JUAN XXIII'),(113,'BANCA DEL FERROCARRIL'),(114,'LA ESPERANZA'),(115,'LAS DELICIAS'),(116,'URB. LA CANDELARIA'),(117,'16 DE JULIO'),(118,'BRISAS DEL RIO'),(119,'ARIGUANI'),(120,'EL RECREO'),(121,'DIVINO NINO'),(122,'EL PORVENIR'),(123,'LA ESTACION'),(124,'GIMNASIO MODERNO'),(125,'EL PROGRESO'),(126,'FRANCISCO DE PAULA'),(127,'JUMBO'),(128,'LA MAGDALENA'),(129,'LA ESMERALDA'),(130,'15 DE DICIEMBRE'),(131,'LAS PALMAS'),(132,'LOMA FRESCA'),(133,'MONTERREY'),(134,'SAN BERNARDO'),(135,'SAN CARLOS'),(136,'SIMON BOLIVAR'),(137,'URB. LAS BRISAS'),(138,'URB. PALERMO'),(139,'URB. PRIMERO DE MAYO'),(140,'URB. VILLA FANNY'),(141,'URB. LOS LAURELES'),(142,'URB. VERA JUDITH'),(143,'VILLA CONTRY'),(144,'LAS TABLITAS'),(145,'SAN JOSE'),(146,'ALFONSO LOPEZ'),(147,'URB. ALAMEDA'),(148,'SAN FERNDANDO'),(149,'SAN NICOLAS'),(150,'URB. EL BRILLANTE'),(151,'PAZ DEL RIO'),(152,'CIUDAD JARDIN'),(153,'URB EL MILAGROSO'),(154,'6 DE ENERO'),(155,'VILLA ESPERANZA'),(156,'URB. SANTA HELENA.'),(999,'NO EXISTE');

/*Table structure for table `consolidacion` */

DROP TABLE IF EXISTS `consolidacion`;

CREATE TABLE `consolidacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `consolidacion` */

/*Table structure for table `coordinadores` */

DROP TABLE IF EXISTS `coordinadores`;

CREATE TABLE `coordinadores` (
  `id` int(11) NOT NULL,
  `t_id` varchar(255) DEFAULT NULL,
  `n_id` varchar(45) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `nacimiento` date DEFAULT NULL,
  `academia` int(11) NOT NULL,
  `escalera` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_coordinadores_niveles1_idx` (`academia`),
  KEY `fk_coordinadores_escalera1_idx` (`escalera`),
  CONSTRAINT `fk_coordinadores_escalera1` FOREIGN KEY (`escalera`) REFERENCES `escalera` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_coordinadores_niveles1` FOREIGN KEY (`academia`) REFERENCES `niveles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `coordinadores` */

insert  into `coordinadores`(`id`,`t_id`,`n_id`,`nombre`,`telefono`,`direccion`,`nacimiento`,`academia`,`escalera`) values (101,'CC','1234567890','BORIS MIRANDA','3016215920','VERA JUDITH','1897-09-30',101,100);

/*Table structure for table `dinastia` */

DROP TABLE IF EXISTS `dinastia`;

CREATE TABLE `dinastia` (
  `cod` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dinastia` */

insert  into `dinastia`(`cod`,`nombre`) values (100,'JUDA');

/*Table structure for table `escalera` */

DROP TABLE IF EXISTS `escalera`;

CREATE TABLE `escalera` (
  `id` int(11) NOT NULL,
  `nivel` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `escalera` */

insert  into `escalera`(`id`,`nivel`) values (100,'ENCUENTRO'),(999,'N/A');

/*Table structure for table `grupos` */

DROP TABLE IF EXISTS `grupos`;

CREATE TABLE `grupos` (
  `cod` int(11) NOT NULL,
  `dinastia` int(11) NOT NULL,
  `barrio` int(11) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod`),
  KEY `fk_grupo_barrio1_idx` (`barrio`),
  KEY `fk_grupo_dinastia1_idx` (`dinastia`),
  CONSTRAINT `fk_grupo_barrio1` FOREIGN KEY (`barrio`) REFERENCES `barrio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_dinastia1` FOREIGN KEY (`dinastia`) REFERENCES `dinastia` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `grupos` */

insert  into `grupos`(`cod`,`dinastia`,`barrio`,`direccion`) values (100,100,107,'LUCHITO DE LA OSA');

/*Table structure for table `mentores` */

DROP TABLE IF EXISTS `mentores`;

CREATE TABLE `mentores` (
  `id` int(11) NOT NULL,
  `t_id` varchar(255) DEFAULT NULL,
  `n_id` varchar(45) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `grupo` int(11) NOT NULL,
  `nacimiento` date DEFAULT NULL,
  `coordinador` int(11) NOT NULL,
  `escuela` int(11) NOT NULL,
  `escalera` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mentor_grupo1_idx` (`grupo`),
  KEY `fk_mentores_coordinadores1_idx` (`coordinador`),
  KEY `fk_mentores_niveles1_idx` (`escuela`),
  KEY `fk_mentores_escalera1_idx` (`escalera`),
  CONSTRAINT `fk_mentor_grupo1` FOREIGN KEY (`grupo`) REFERENCES `grupos` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_mentores_coordinadores1` FOREIGN KEY (`coordinador`) REFERENCES `coordinadores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_mentores_escalera1` FOREIGN KEY (`escalera`) REFERENCES `escalera` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_mentores_niveles1` FOREIGN KEY (`escuela`) REFERENCES `niveles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mentores` */

insert  into `mentores`(`id`,`t_id`,`n_id`,`nombre`,`telefono`,`direccion`,`grupo`,`nacimiento`,`coordinador`,`escuela`,`escalera`) values (100,'CC','1081799901','HEINER GOMEZ','3217478593','DIAG HNA GINA',100,'1989-03-23',101,101,100),(101,'CC','1234567890','BORIS MIRANDA','3016215920','VERA JUDIT',100,'1897-09-30',101,101,100);

/*Table structure for table `modulos` */

DROP TABLE IF EXISTS `modulos`;

CREATE TABLE `modulos` (
  `id` int(11) NOT NULL,
  `modulo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `modulos` */

insert  into `modulos`(`id`,`modulo`) values (1,'MENTOR'),(2,'COORDINADOR'),(3,'COORDINAOR GV'),(4,'PASTOR');

/*Table structure for table `niveles` */

DROP TABLE IF EXISTS `niveles`;

CREATE TABLE `niveles` (
  `id` int(11) NOT NULL,
  `nivel` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `niveles` */

insert  into `niveles`(`id`,`nivel`) values (100,'VIDA ABUNDANTE'),(101,'DOULOS'),(999,'N/A');

/*Table structure for table `profesores` */

DROP TABLE IF EXISTS `profesores`;

CREATE TABLE `profesores` (
  `id` int(11) NOT NULL,
  `profesor` varchar(45) DEFAULT NULL,
  `nivel` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profesores_niveles1_idx` (`nivel`),
  CONSTRAINT `fk_profesores_niveles1` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `profesores` */

/*Table structure for table `seguimientos` */

DROP TABLE IF EXISTS `seguimientos`;

CREATE TABLE `seguimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asistente` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `detalle` text,
  `alarma` int(11) DEFAULT '0',
  `consolidacion_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seguimientos_asistentes1_idx` (`asistente`),
  KEY `fk_seguimientos_consolidacion1_idx` (`consolidacion_id`),
  CONSTRAINT `fk_seguimientos_asistentes1` FOREIGN KEY (`asistente`) REFERENCES `asistentes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_seguimientos_consolidacion1` FOREIGN KEY (`consolidacion_id`) REFERENCES `consolidacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `seguimientos` */

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `user` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT NULL,
  `modulo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuarios_modulos1_idx` (`modulo`),
  CONSTRAINT `fk_usuarios_modulos1` FOREIGN KEY (`modulo`) REFERENCES `modulos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `usuarios` */

insert  into `usuarios`(`id`,`user`,`pass`,`modulo`) values (100,'hgomez','40bd001563085fc35165329ea1ff5c5ecbdbbeef',1),(101,'bmiranda','40bd001563085fc35165329ea1ff5c5ecbdbbeef',2);

/* Procedure structure for procedure `NewSoul` */

/*!50003 DROP PROCEDURE IF EXISTS  `NewSoul` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `NewSoul`(
	IN _id int(11),
	IN _nombre VARCHAR(255),
	IN _telefono VARCHAR(45),
	IN _direccion VARCHAR(45),
	in _barrio int(11),
	in _grupo int(11),
	in _nacimiento varchar(10)
    )
BEGIN
	insert into `asistentes` (`id`,`nombre`,`telefono`,`direccion`,`barrio`,`grupo`,`nacimiento`,`escuela`,`escalera`)
	values (_id,_nombre,_telefono,_direccion,_barrio,_grupo,_nacimiento,999,999);
    END */$$
DELIMITER ;

/*Table structure for table `mentor_grupo` */

DROP TABLE IF EXISTS `mentor_grupo`;

/*!50001 DROP VIEW IF EXISTS `mentor_grupo` */;
/*!50001 DROP TABLE IF EXISTS `mentor_grupo` */;

/*!50001 CREATE TABLE  `mentor_grupo`(
 `IdMentor` int(11) ,
 `NameMentor` varchar(255) ,
 `IdGroup` int(11) ,
 `modulo` int(11) ,
 `user` varchar(45) ,
 `pass` varchar(45) 
)*/;

/*View structure for view mentor_grupo */

/*!50001 DROP TABLE IF EXISTS `mentor_grupo` */;
/*!50001 DROP VIEW IF EXISTS `mentor_grupo` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mentor_grupo` AS select `mentores`.`id` AS `IdMentor`,`mentores`.`nombre` AS `NameMentor`,`grupos`.`cod` AS `IdGroup`,`usuarios`.`modulo` AS `modulo`,`usuarios`.`user` AS `user`,`usuarios`.`pass` AS `pass` from ((`usuarios` join `mentores` on((`usuarios`.`id` = `mentores`.`id`))) join `grupos` on((`mentores`.`grupo` = `grupos`.`cod`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
