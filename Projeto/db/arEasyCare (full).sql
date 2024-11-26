/*
SQLyog Enterprise - MySQL GUI v8.12 
MySQL - 5.5.5-10.7.3-MariaDB : Database - arEasyCare
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`arEasyCare` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `arEasyCare`;

/*Table structure for table `ATENDIMENTOS` */

DROP TABLE IF EXISTS `ATENDIMENTOS`;

CREATE TABLE `ATENDIMENTOS` (
  `ATD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ATD_FPG_ID` smallint(6) NOT NULL,
  `ATD_INCLUSAO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ATD_STATUS` enum('A','C','F') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'A',
  `ATD_NOTIFICADO` enum('S','N') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'N',
  `ATD_DATA` date NOT NULL,
  `ATD_HORA` time NOT NULL,
  `ATD_DURACAO` int(11) NOT NULL,
  `ATD_VALOR` decimal(10,2) NOT NULL,
  `ATD_OBSERVACOES` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ATD_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ATD_ID`),
  KEY `FK_ATD_FPG` (`ATD_FPG_ID`),
  CONSTRAINT `FK_ATENDIMENTOS` FOREIGN KEY (`ATD_FPG_ID`) REFERENCES `FORMA_PGTO` (`FPG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `ATENDIMENTOS` */

LOCK TABLES `ATENDIMENTOS` WRITE;

insert  into `ATENDIMENTOS`(`ATD_ID`,`ATD_FPG_ID`,`ATD_INCLUSAO`,`ATD_STATUS`,`ATD_NOTIFICADO`,`ATD_DATA`,`ATD_HORA`,`ATD_DURACAO`,`ATD_VALOR`,`ATD_OBSERVACOES`,`ATD_DATA_ATUALIZADO`) values (17,1,'2024-11-23 23:53:34','F','N','2024-11-17','13:00:00',60,'120.00','Alemanha','2024-11-03 21:33:10'),(18,2,'2024-11-18 04:10:48','C','S','2024-11-18','12:00:00',60,'220.00','Roma','2024-11-03 21:59:54'),(19,4,'2024-11-23 23:32:22','F','S','2024-11-21','08:00:00',60,'90.00','Inglaterra','2024-11-03 23:07:31'),(23,2,'2024-11-09 13:02:29','A','N','2024-12-05','11:00:00',60,'120.00','alguma coisa','2024-11-04 11:15:10'),(25,1,'2024-11-23 23:54:34','F','N','2024-11-17','10:00:00',120,'150.00','bocaina','2024-11-07 19:50:56'),(26,2,'2024-11-23 23:29:22','A','N','2024-11-20','15:00:00',60,'120.00','','2024-11-08 04:31:12'),(28,2,'2024-11-23 23:33:22','A','N','2024-11-20','10:00:00',120,'180.00','','2024-11-08 04:38:23'),(29,2,'2024-11-23 23:35:50','A','N','2024-11-20','12:00:00',120,'180.00','','2024-11-08 04:42:38'),(30,4,'2024-11-23 23:36:22','A','N','2024-11-20','14:00:00',60,'120.00','','2024-11-08 04:45:00'),(31,1,'2024-11-23 23:39:25','A','N','2024-11-20','16:00:00',120,'180.00','','2024-11-08 05:02:05'),(32,2,'2024-11-23 23:30:22','F','N','2024-11-23','08:00:00',60,'120.00','','2024-11-08 05:09:56'),(33,2,'2024-11-23 23:31:22','F','N','2024-11-23','09:00:00',120,'150.00','','2024-11-08 05:11:04'),(34,4,'2024-11-23 23:48:34','A','N','2024-11-20','08:00:00',120,'180.00','','2024-11-09 04:27:10'),(35,1,'2024-11-26 17:00:22','F','N','2024-11-24','12:00:00',60,'120.00','usar luva nitrilida, alergia à látex.','2024-11-09 22:39:29'),(36,2,'2024-11-23 23:55:34','F','N','2024-11-17','12:00:00',60,'90.00','','2024-11-10 05:59:27'),(37,1,'2024-11-11 14:00:23','A','N','2024-11-24','10:00:00',60,'90.00','','2024-11-10 06:04:45'),(38,2,'2024-11-18 04:12:22','C','N','2024-11-19','09:00:00',60,'90.00','','2024-11-10 06:10:22'),(39,1,'2024-11-23 23:50:34','F','N','2024-11-19','08:00:00',120,'180.00','','2024-11-18 04:13:42'),(40,1,'2024-11-23 23:51:34','F','N','2024-11-19','10:00:00',120,'180.00','','2024-11-19 03:09:17'),(41,2,'2024-11-23 23:52:34','F','N','2024-11-18','11:00:00',0,'0.00','','2024-11-19 11:54:19'),(42,3,'2024-11-23 23:49:34','A','N','2024-11-20','17:00:00',120,'180.00','','2024-11-19 11:58:03');

UNLOCK TABLES;

/*Table structure for table `ATENDIMENTOS_PESS` */

DROP TABLE IF EXISTS `ATENDIMENTOS_PESS`;

CREATE TABLE `ATENDIMENTOS_PESS` (
  `APS_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APS_ATD_ID` int(11) NOT NULL,
  `APS_PES_ID` int(11) NOT NULL,
  `APS_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`APS_ID`),
  KEY `FK_APS_PES` (`APS_PES_ID`),
  KEY `FK_APS_ATD` (`APS_ATD_ID`),
  CONSTRAINT `FK_APS_ATD` FOREIGN KEY (`APS_ATD_ID`) REFERENCES `ATENDIMENTOS` (`ATD_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_APS_PES` FOREIGN KEY (`APS_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `ATENDIMENTOS_PESS` */

LOCK TABLES `ATENDIMENTOS_PESS` WRITE;

insert  into `ATENDIMENTOS_PESS`(`APS_ID`,`APS_ATD_ID`,`APS_PES_ID`,`APS_DATA_ATUALIZADO`) values (4,17,13,'2024-11-03 21:33:10'),(5,18,15,'2024-11-03 21:59:54'),(6,19,14,'2024-11-03 23:07:31'),(10,23,10,'2024-11-04 11:15:10'),(12,25,28,'2024-11-07 19:50:56'),(13,26,21,'2024-11-08 04:31:12'),(15,28,15,'2024-11-10 07:00:25'),(16,29,19,'2024-11-08 04:42:38'),(17,30,18,'2024-11-08 04:45:00'),(18,31,24,'2024-11-08 05:02:05'),(19,32,30,'2024-11-08 05:09:57'),(20,33,26,'2024-11-08 05:11:05'),(22,34,20,'2024-11-09 04:27:27'),(23,35,22,'2024-11-09 22:39:29'),(24,36,15,'2024-11-10 05:59:28'),(25,37,14,'2024-11-10 06:04:45'),(26,38,14,'2024-11-10 06:10:22'),(27,39,24,'2024-11-18 04:13:43'),(28,40,24,'2024-11-19 03:09:18'),(29,41,24,'2024-11-19 11:54:20'),(30,42,24,'2024-11-19 11:58:03');

UNLOCK TABLES;

/*Table structure for table `ATENDIMENTOS_PROC` */

DROP TABLE IF EXISTS `ATENDIMENTOS_PROC`;

CREATE TABLE `ATENDIMENTOS_PROC` (
  `APC_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APC_ATD_ID` int(11) NOT NULL,
  `APC_PRC_ID` int(11) NOT NULL,
  `APC_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`APC_ID`),
  KEY `FK_PRC_APC` (`APC_PRC_ID`),
  KEY `FK_ATD_APC` (`APC_ATD_ID`),
  CONSTRAINT `FK_ATD_APC` FOREIGN KEY (`APC_ATD_ID`) REFERENCES `ATENDIMENTOS` (`ATD_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_PRC_APC` FOREIGN KEY (`APC_PRC_ID`) REFERENCES `PROCEDIMENTOS` (`PRC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `ATENDIMENTOS_PROC` */

LOCK TABLES `ATENDIMENTOS_PROC` WRITE;

insert  into `ATENDIMENTOS_PROC`(`APC_ID`,`APC_ATD_ID`,`APC_PRC_ID`,`APC_DATA_ATUALIZADO`) values (2,17,4,'2024-11-03 21:33:10'),(3,18,7,'2024-11-03 21:59:54'),(4,19,8,'2024-11-03 23:07:31'),(8,23,4,'2024-11-04 11:15:10'),(10,25,1,'2024-11-07 19:50:56'),(11,26,4,'2024-11-08 04:31:13'),(13,28,3,'2024-11-08 04:38:23'),(14,29,3,'2024-11-08 04:42:38'),(15,30,4,'2024-11-08 04:45:00'),(16,31,3,'2024-11-08 05:02:05'),(17,32,4,'2024-11-08 05:09:57'),(18,33,1,'2024-11-08 05:11:05'),(19,34,3,'2024-11-09 04:27:27'),(20,35,4,'2024-11-09 22:39:29'),(21,36,6,'2024-11-10 05:59:28'),(22,37,8,'2024-11-10 06:04:46'),(23,38,8,'2024-11-10 06:10:22'),(24,39,3,'2024-11-18 04:13:43'),(25,40,3,'2024-11-19 03:09:18'),(26,41,3,'2024-11-19 11:54:20'),(27,42,3,'2024-11-19 11:58:03');

UNLOCK TABLES;

/*Table structure for table `ATENDIMENTOS_PROF` */

DROP TABLE IF EXISTS `ATENDIMENTOS_PROF`;

CREATE TABLE `ATENDIMENTOS_PROF` (
  `APF_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APF_ATD_ID` int(11) NOT NULL,
  `APF_PRF_ID` smallint(11) NOT NULL DEFAULT 1,
  `APF_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`APF_ID`),
  KEY `FK_APF_ATD` (`APF_ATD_ID`),
  KEY `FK_APF_PRF` (`APF_PRF_ID`),
  CONSTRAINT `FK_APF_ATD` FOREIGN KEY (`APF_ATD_ID`) REFERENCES `ATENDIMENTOS` (`ATD_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_APF_PRF` FOREIGN KEY (`APF_PRF_ID`) REFERENCES `PROFISSIONAIS` (`PRF_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `ATENDIMENTOS_PROF` */

LOCK TABLES `ATENDIMENTOS_PROF` WRITE;

insert  into `ATENDIMENTOS_PROF`(`APF_ID`,`APF_ATD_ID`,`APF_PRF_ID`,`APF_DATA_ATUALIZADO`) values (1,17,1,'2024-11-03 21:34:13'),(2,18,1,'2024-11-03 21:59:54'),(3,19,1,'2024-11-03 23:07:31'),(5,23,1,'2024-11-04 11:15:10'),(7,25,1,'2024-11-07 19:50:56'),(8,26,1,'2024-11-08 04:31:13'),(10,28,1,'2024-11-08 04:38:23'),(11,29,1,'2024-11-08 04:42:39'),(12,30,1,'2024-11-08 04:45:00'),(13,31,1,'2024-11-08 05:02:05'),(14,32,1,'2024-11-08 05:09:57'),(15,33,1,'2024-11-08 05:11:05'),(16,34,1,'2024-11-09 04:27:27'),(17,35,1,'2024-11-09 22:39:29'),(18,36,1,'2024-11-10 05:59:28'),(19,37,1,'2024-11-10 06:04:46'),(20,38,1,'2024-11-10 06:10:22'),(21,39,1,'2024-11-18 04:13:43'),(22,40,1,'2024-11-19 03:09:18'),(23,41,1,'2024-11-19 11:54:20'),(24,42,1,'2024-11-19 11:58:03');

UNLOCK TABLES;

/*Table structure for table `COMPROMISSOS` */

DROP TABLE IF EXISTS `COMPROMISSOS`;

CREATE TABLE `COMPROMISSOS` (
  `CMP_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CMP_INCLUSAO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CMP_STATUS` enum('C','P','X','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'P',
  `CMP_CTP_ID` smallint(6) DEFAULT NULL,
  `CMP_PRIORIDADE` enum('N','A','M','B') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `CMP_LMB_ID` smallint(6) DEFAULT NULL,
  `CMP_RECORRENCIA` enum('N','D','S','M') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `CMP_DATA_I` date NOT NULL,
  `CMP_HORA_I` time NOT NULL,
  `CMP_DATA_F` date NOT NULL,
  `CMP_HORA_F` time NOT NULL,
  `CMP_TITULO` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CMP_DESCRICAO` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CMP_LOCAL` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CMP_PARTICIPANTES` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CMP_ANEXOS` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CMP_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`CMP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `COMPROMISSOS` */

LOCK TABLES `COMPROMISSOS` WRITE;

UNLOCK TABLES;

/*Table structure for table `ENDERECOS` */

DROP TABLE IF EXISTS `ENDERECOS`;

CREATE TABLE `ENDERECOS` (
  `END_ID` int(11) NOT NULL AUTO_INCREMENT,
  `END_PES_ID` int(11) NOT NULL,
  `END_TIPO` enum('P','E','C','T') COLLATE utf8mb3_unicode_ci DEFAULT 'P',
  `END_CEP` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `END_CIDADE` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `END_UF` varchar(2) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_LOGRADOURO` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `END_NUMERO` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_BAIRRO` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_COMPLEMENTO` varchar(200) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`END_ID`),
  KEY `FK_END_PES` (`END_PES_ID`),
  CONSTRAINT `FK_END_PES` FOREIGN KEY (`END_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `ENDERECOS` */

LOCK TABLES `ENDERECOS` WRITE;

UNLOCK TABLES;

/*Table structure for table `FORMA_PGTO` */

DROP TABLE IF EXISTS `FORMA_PGTO`;

CREATE TABLE `FORMA_PGTO` (
  `FPG_ID` smallint(6) NOT NULL AUTO_INCREMENT,
  `FPG_INCLUSAO` timestamp NOT NULL DEFAULT current_timestamp(),
  `FPG_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `FPG_NOME` varchar(75) COLLATE utf8mb3_unicode_ci NOT NULL,
  `FPG_NOME_SCE` varchar(75) COLLATE utf8mb3_unicode_ci NOT NULL,
  `FPG_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`FPG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `FORMA_PGTO` */

LOCK TABLES `FORMA_PGTO` WRITE;

insert  into `FORMA_PGTO`(`FPG_ID`,`FPG_INCLUSAO`,`FPG_STATUS`,`FPG_NOME`,`FPG_NOME_SCE`,`FPG_DATA_ATUALIZADO`) values (-5,'2024-11-17 20:13:57','1','','','2024-11-01 05:02:33'),(1,'2024-11-17 20:13:57','1','Dinheiro','Dinheiro','2024-07-23 05:28:53'),(2,'2024-11-17 20:13:57','1','PIX','PIX','2024-07-23 05:28:53'),(3,'2024-11-17 20:13:57','1','Cartão de Débito','Cartao de Debito','2024-07-23 05:28:53'),(4,'2024-11-17 20:13:57','1','Cartão de Crédito','Cartao de Credito','2024-07-23 05:28:53');

UNLOCK TABLES;

/*Table structure for table `MAILS` */

DROP TABLE IF EXISTS `MAILS`;

CREATE TABLE `MAILS` (
  `MAI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MAI_PES_ID` int(11) NOT NULL,
  `MAI_TIPO` enum('P','O') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'P',
  `MAI_EMAIL` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `MAI_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`MAI_ID`),
  KEY `FK_MAI_PES` (`MAI_PES_ID`),
  CONSTRAINT `FK_MAI_PES` FOREIGN KEY (`MAI_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `MAILS` */

LOCK TABLES `MAILS` WRITE;

insert  into `MAILS`(`MAI_ID`,`MAI_PES_ID`,`MAI_TIPO`,`MAI_EMAIL`,`MAI_DATA_ATUALIZADO`) values (1,-2,'P','eu@andersonrosa.com.br','2024-10-26 05:58:43'),(2,10,'P','pegalixo123@gmail.com','2024-10-28 01:18:16'),(4,14,'P','hawking@space.com','2024-11-03 22:52:39'),(5,15,'P','123456789@gmail.com','2024-11-03 23:44:22'),(6,1,'P','ana@gmail.com','2024-11-23 01:45:38'),(7,-5,'P','master@easycare.com.br','2024-11-23 01:48:59');

UNLOCK TABLES;

/*Table structure for table `MENSAGEM_HIST` */

DROP TABLE IF EXISTS `MENSAGEM_HIST`;

CREATE TABLE `MENSAGEM_HIST` (
  `MSG_ID` int(11) NOT NULL,
  `MSG_INCLUSAO` timestamp NULL DEFAULT NULL,
  `MSG_ORI_ID` int(11) DEFAULT NULL,
  `MSG_CUS_ID` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_WGW_ID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_TIPO` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_STATUS` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_ORIGEM` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MSG_REM_NUMERO` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_REM_NOME` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MDG_DES_NUMERO` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_MENSAGEM` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`MSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `MENSAGEM_HIST` */

LOCK TABLES `MENSAGEM_HIST` WRITE;

UNLOCK TABLES;

/*Table structure for table `PESSOAS` */

DROP TABLE IF EXISTS `PESSOAS`;

CREATE TABLE `PESSOAS` (
  `PES_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PES_INCLUSAO` timestamp NULL DEFAULT NULL,
  `PES_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `PES_TIPO` enum('C','P') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'C',
  `PES_USER` enum('N','S') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'N',
  `PES_DOCUMENTO` varchar(14) COLLATE utf8mb3_unicode_ci NOT NULL,
  `PES_NOME` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `PES_NASCIMENTO` date DEFAULT NULL,
  `PES_GENERO` enum('M','F','N') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'N',
  `PES_PROFISSAO` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PES_AVATAR` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PES_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`PES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `PESSOAS` */

LOCK TABLES `PESSOAS` WRITE;

insert  into `PESSOAS`(`PES_ID`,`PES_INCLUSAO`,`PES_STATUS`,`PES_TIPO`,`PES_USER`,`PES_DOCUMENTO`,`PES_NOME`,`PES_NASCIMENTO`,`PES_GENERO`,`PES_PROFISSAO`,`PES_AVATAR`,`PES_DATA_ATUALIZADO`) values (-5,'2024-07-19 18:37:43','1','C','S','41735280000163','Master',NULL,'N',NULL,NULL,'2024-07-19 18:37:43'),(-2,'2024-10-26 05:54:16','1','P','S','26519434876','Anderson Rosa','1979-07-31','N',NULL,NULL,'2024-10-26 05:54:16'),(1,'2024-07-19 19:16:40','1','P','N','','Ana Carolina dos Santos Rosa','1983-07-26','N','',NULL,'2024-07-19 19:16:40'),(10,'2024-10-28 01:17:57','1','C','N','','Marcus Aurelius','0121-04-26','N','','Marcus_Aurelius','2024-10-28 01:17:57'),(13,'2024-11-02 00:56:41','1','C','N','','Albert Einstein','1879-03-14','N','','albert_einstein','2024-11-02 00:56:41'),(14,'2024-11-03 22:52:39','1','C','N','','Stephen William Hawking','1942-01-08','N','','stephen_hawking','2024-11-03 22:52:39'),(15,'2024-11-03 23:44:22','1','C','N','','Marie Curie','1996-11-07','N','','Marie_Curie','2024-11-03 23:44:22'),(16,'2024-11-05 04:58:42','1','C','N','12345678901','João da Silva','1985-01-15','N',NULL,'João_Silva','2024-11-05 04:58:42'),(17,'2024-11-05 04:58:42','1','C','N','98765432100','Maria Oliveira','1990-03-22','N',NULL,'Maria_Oliveira','2024-11-05 04:58:42'),(18,'2024-11-05 04:58:42','1','C','N','11223344556','Carlos Souza','1983-07-30','N',NULL,'Carlos_Souza','2024-11-05 04:58:42'),(19,'2024-11-05 04:58:42','1','C','N','22334455667','Ana Pereira','1992-11-12','N',NULL,'Ana_Pereira','2024-11-05 04:58:42'),(20,'2024-11-05 04:58:42','1','C','N','33445566778','Fernanda Costa','1987-09-09','N',NULL,'Fernanda_Costa','2024-11-05 04:58:42'),(21,'2024-11-05 04:58:42','1','C','N','44556677889','Roberto Lima','1980-02-28','N',NULL,'Roberto_Lima','2024-11-05 04:58:42'),(22,'2024-11-05 04:58:42','1','C','N','55667788990','Patrícia Martins','1988-05-05','N',NULL,'Patrícia_Martins','2024-11-05 04:58:42'),(23,'2024-11-05 04:58:42','1','C','N','66778899011','Marcos Almeida','1995-04-17','N',NULL,'Marcos_Almeida','2024-11-05 04:58:42'),(24,'2024-11-05 04:58:42','1','C','N','77889900122','Juliana Santos','1991-06-25','N',NULL,'Juliana_Santos','2024-11-05 04:58:42'),(25,'2024-11-05 04:58:42','1','C','N','88990011233','Pedro Henrique','1986-08-19','N',NULL,'Pedro_Henrique','2024-11-05 04:58:42'),(26,'2024-11-05 04:58:42','1','C','N','99001122344','Luciana Ribeiro','1994-10-02','N',NULL,'Luciana_Ribeiro','2024-11-05 04:58:42'),(27,'2024-11-05 04:58:42','1','C','N','10111223355','Ricardo Pires','1982-12-30','N',NULL,'Ricardo_Pires','2024-11-05 04:58:42'),(28,'2024-11-05 04:58:42','1','C','N','12131424566','Amaral Carvalho','1993-02-13','N',NULL,'Valeria_Amaral','2024-11-05 04:58:42'),(29,'2024-11-05 04:58:42','1','C','N','13141535677','José Fernandes','1989-07-04','N',NULL,'José_Fernandes','2024-11-05 04:58:42'),(30,'2024-11-05 04:58:42','1','C','N','14161746788','Gustavo Rocha','1996-05-20','N',NULL,'Gustavo_Rocha','2024-11-05 04:58:42');

UNLOCK TABLES;

/*Table structure for table `PROCEDIMENTOS` */

DROP TABLE IF EXISTS `PROCEDIMENTOS`;

CREATE TABLE `PROCEDIMENTOS` (
  `PRC_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PRC_PRF_ID` int(11) DEFAULT NULL,
  `PRC_EQP_ID` int(11) DEFAULT NULL,
  `PRC_CAT_ID` int(11) NOT NULL,
  `PRC_INCLUSAO` timestamp NULL DEFAULT NULL,
  `PRC_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `PRC_NOME` varchar(75) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_DESCRICAO` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_DURACAO` smallint(6) NOT NULL DEFAULT 0,
  `PRC_VALOR` float(10,2) DEFAULT NULL,
  `PRC_REQUISITO` varchar(250) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_CUIDADOS` varchar(250) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_RISCOS` varchar(250) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PRC_ID`),
  KEY `FK_PRC_CAT` (`PRC_CAT_ID`),
  CONSTRAINT `FK_PRC_CAT` FOREIGN KEY (`PRC_CAT_ID`) REFERENCES `PROCEDIMENTOS_CAT` (`CAT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `PROCEDIMENTOS` */

LOCK TABLES `PROCEDIMENTOS` WRITE;

insert  into `PROCEDIMENTOS`(`PRC_ID`,`PRC_PRF_ID`,`PRC_EQP_ID`,`PRC_CAT_ID`,`PRC_INCLUSAO`,`PRC_STATUS`,`PRC_NOME`,`PRC_DESCRICAO`,`PRC_DURACAO`,`PRC_VALOR`,`PRC_REQUISITO`,`PRC_CUIDADOS`,`PRC_RISCOS`,`PRC_DATA_ATUALIZADO`) values (1,NULL,NULL,1,'2024-07-15 16:56:50','1','Extensão de Cílios Volume Brasileiro','Aplicação de cílios sintéticos para criar um volume natural e destacado ao estilo brasileiro.',120,150.00,'Nenhum','Evitar molhar os cílios nas primeiras 24 horas.','Possível irritação ocular.','2024-07-15 19:18:38'),(2,NULL,NULL,1,'2024-07-15 16:56:50','1','Extensão de Cílios Volume Egípcio','Aplicação de cílios sintéticos para proporcionar um volume intenso e dramático ao estilo egípcio.',120,160.00,'Nenhum','Evitar molhar os cílios nas primeiras 24 horas.','Possível irritação ocular.','2024-07-15 19:18:42'),(3,NULL,NULL,1,'2024-07-15 16:56:50','1','Extensão de Cílios Volume inglês (4,5D)','Aplicação de cílios sintéticos para obter um volume denso e sofisticado ao estilo inglês com 4,5D.',120,180.00,'Nenhum','Evitar molhar os cílios nas primeiras 24 horas.','Possível irritação ocular.','2024-07-15 19:18:46'),(4,NULL,NULL,2,'2024-07-15 16:56:50','1','Limpeza de Pele','Procedimento estético que realiza uma limpeza profunda e revigorante da pele do rosto, removendo impurezas e células mortas.',60,120.00,'Nenhum','Evitar exposição ao sol nas primeiras 24 horas.','Possível vermelhidão temporária.','2024-07-15 19:18:49'),(5,NULL,NULL,3,'2024-07-15 16:56:50','1','Depilação com Cera','Remoção eficiente e rápida dos pelos corporais utilizando cera quente ou fria, garantindo uma pele lisa e livre de pelos.',30,80.00,'Nenhum','Evitar exposição ao sol nas primeiras 24 horas.','Possível irritação cutânea.','2024-07-15 16:56:50'),(6,NULL,NULL,3,'2024-07-15 16:56:50','1','Depilação com Linha','Método preciso de remoção de pelos utilizando linha de algodão, ideal para áreas delicadas do rosto e corpo.',45,90.00,'Nenhum','Evitar exposição ao sol nas primeiras 24 horas.','Possível irritação cutânea.','2024-07-15 16:56:50'),(7,NULL,NULL,4,'2024-07-15 16:56:50','1','Microagulhamento','Tratamento estético avançado que utiliza microagulhas para estimular a produção de colágeno e melhorar a textura da pele.',60,220.00,'Nenhum','Evitar exposição ao sol nas primeiras 48 horas.','Possível vermelhidão e inchaço temporários.','2024-07-15 19:19:10'),(8,NULL,NULL,5,'2024-07-15 16:56:50','1','Peeling de Diamante','Procedimento de esfoliação profunda que utiliza uma ponteira de diamante para renovar a pele, removendo células mortas e impurezas.',60,90.00,'Nenhum','Evitar exposição ao sol nas primeiras 48 horas.','Possível descamação e vermelhidão.','2024-07-15 19:19:19');

UNLOCK TABLES;

/*Table structure for table `PROCEDIMENTOS_CAT` */

DROP TABLE IF EXISTS `PROCEDIMENTOS_CAT`;

CREATE TABLE `PROCEDIMENTOS_CAT` (
  `CAT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CAT_INCLUSAO` timestamp NULL DEFAULT NULL,
  `CAT_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `CAT_NOME` varchar(75) COLLATE utf8mb3_unicode_ci NOT NULL,
  `CAT_DESCRICAO` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `CAT_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`CAT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `PROCEDIMENTOS_CAT` */

LOCK TABLES `PROCEDIMENTOS_CAT` WRITE;

insert  into `PROCEDIMENTOS_CAT`(`CAT_ID`,`CAT_INCLUSAO`,`CAT_STATUS`,`CAT_NOME`,`CAT_DESCRICAO`,`CAT_DATA_ATUALIZADO`) values (1,'2024-07-15 16:42:48','1','Extensão de cílios','Serviço de aplicação de cílios sintéticos para alongamento dos naturais','2024-07-15 16:42:48'),(2,'2024-07-15 16:42:48','1','Limpeza de pele','Procedimento estético para limpeza profunda da pele do rosto','2024-07-15 16:42:48'),(3,'2024-07-15 16:42:48','1','Depilação','Remoção de pelos corporais por diferentes métodos','2024-07-15 16:42:48'),(4,'2024-07-15 16:42:48','1','Microagulhamento','Tratamento estético com microagulhas para estimular a produção de colágeno','2024-07-15 16:42:48'),(5,'2024-07-15 16:42:48','1','Peeling','Procedimento de renovação celular por meio da aplicação de substâncias químicas ou físicas','2024-07-15 16:42:48');

UNLOCK TABLES;

/*Table structure for table `PROFISSIONAIS` */

DROP TABLE IF EXISTS `PROFISSIONAIS`;

CREATE TABLE `PROFISSIONAIS` (
  `PRF_ID` smallint(11) NOT NULL AUTO_INCREMENT,
  `PRF_PES_ID` int(11) NOT NULL,
  `PRF_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `PRF_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PRF_ID`),
  KEY `FK_PRF_PES` (`PRF_PES_ID`),
  CONSTRAINT `FK_PRF_PES` FOREIGN KEY (`PRF_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `PROFISSIONAIS` */

LOCK TABLES `PROFISSIONAIS` WRITE;

insert  into `PROFISSIONAIS`(`PRF_ID`,`PRF_PES_ID`,`PRF_STATUS`,`PRF_DATA_ATUALIZADO`) values (1,1,'1','2024-10-31 16:35:04');

UNLOCK TABLES;

/*Table structure for table `TELEFONES` */

DROP TABLE IF EXISTS `TELEFONES`;

CREATE TABLE `TELEFONES` (
  `TEL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEL_PES_ID` int(11) NOT NULL,
  `TEL_TIPO` enum('P','O') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'P',
  `TEL_DDI` varchar(3) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '55',
  `TEL_DDD` varchar(3) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `TEL_TELEFONE` varchar(15) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `TEL_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TEL_ID`),
  KEY `FK_TEL_PES` (`TEL_PES_ID`),
  CONSTRAINT `FK_TEL_PES` FOREIGN KEY (`TEL_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `TELEFONES` */

LOCK TABLES `TELEFONES` WRITE;

insert  into `TELEFONES`(`TEL_ID`,`TEL_PES_ID`,`TEL_TIPO`,`TEL_DDI`,`TEL_DDD`,`TEL_TELEFONE`,`TEL_DATA_ATUALIZADO`) values (1,-2,'P','55','14','996905500','2024-10-26 06:20:28'),(3,10,'P','55','14','99165-9298','2024-11-03 05:18:51'),(5,14,'P','55','14','996905500','2024-11-03 22:52:39'),(13,22,'P','55','14','99690-5500','2024-11-05 05:03:29'),(22,1,'P','55','14','98172-3448','2024-11-22 00:21:32');

UNLOCK TABLES;

/*Table structure for table `USUARIOS` */

DROP TABLE IF EXISTS `USUARIOS`;

CREATE TABLE `USUARIOS` (
  `USU_ID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `USU_PES_ID` int(11) NOT NULL,
  `USU_STATUS` char(1) COLLATE utf8mb3_unicode_ci NOT NULL,
  `USU_TIPO` enum('M','A','U') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'U',
  `USU_USER` varchar(25) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `USU_SENHA` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `USU_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`USU_ID`),
  KEY `FK_USU_PES` (`USU_PES_ID`),
  CONSTRAINT `FK_USU_PES` FOREIGN KEY (`USU_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Data for the table `USUARIOS` */

LOCK TABLES `USUARIOS` WRITE;

insert  into `USUARIOS`(`USU_ID`,`USU_PES_ID`,`USU_STATUS`,`USU_TIPO`,`USU_USER`,`USU_SENHA`,`USU_DATA_ATUALIZADO`) values (1,-5,'1','M','master@easycare.com.br','202cb962ac59075b964b07152d234b70','2024-07-19 18:42:31'),(2,1,'1','A','ana@gmail.com','202cb962ac59075b964b07152d234b70','2024-10-25 13:46:23'),(3,-2,'1','U','eu@andersonrosa.com.br','202cb962ac59075b964b07152d234b70','2024-11-23 01:53:29');

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
