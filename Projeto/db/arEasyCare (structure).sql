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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
