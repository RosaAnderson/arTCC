-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 17/10/2024 às 22:51
-- Versão do servidor: 5.7.23-23
-- Versão do PHP: 8.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ande1162_arAgenda`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `ATENDIMENTOS_PESS`
--

CREATE TABLE `ATENDIMENTOS_PESS` (
  `APS_ID` bigint(20) NOT NULL,
  `APS_ATD_ID` int(11) NOT NULL,
  `APS_PES_ID` int(11) NOT NULL,
  `APS_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ATENDIMENTOS_PROC`
--

CREATE TABLE `ATENDIMENTOS_PROC` (
  `APC_ID` bigint(20) NOT NULL,
  `APC_ATD_ID` int(11) NOT NULL,
  `APC_PRC_ID` int(11) NOT NULL,
  `APC_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ATENDIMENTOS_PROF`
--

CREATE TABLE `ATENDIMENTOS_PROF` (
  `APF_ID` bigint(20) NOT NULL,
  `APF_ATD_ID` int(11) NOT NULL,
  `APF_PRF_ID` smallint(11) NOT NULL,
  `APF_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ENDERECOS`
--

CREATE TABLE `ENDERECOS` (
  `END_ID` int(11) NOT NULL,
  `END_TIPO` enum('P','E','C','T') COLLATE utf8_unicode_ci DEFAULT 'P',
  `END_CEP` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `END_CIDADE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `END_UF` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_LOGRADOURO` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `END_NUMERO` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_BAIRRO` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_COMPLEMENTO` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_PES_ID` int(11) NOT NULL,
  `END_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `FORMA_PGTO`
--

CREATE TABLE `FORMA_PGTO` (
  `FPG_ID` smallint(6) NOT NULL,
  `FPG_STATUS` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `FPG_NOME` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `FPG_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `FORMA_PGTO`
--

INSERT INTO `FORMA_PGTO` (`FPG_ID`, `FPG_STATUS`, `FPG_NOME`, `FPG_DATA_ATUALIZADO`) VALUES
(1, '1', 'DINHEIRO', '2024-07-23 08:28:53'),
(2, '1', 'PIX', '2024-07-23 08:28:53'),
(3, '1', 'CARTÃO DÉBITO', '2024-07-23 08:28:53'),
(4, '1', 'CARTÃO CRÉDITO', '2024-07-23 08:28:53');

-- --------------------------------------------------------

--
-- Estrutura para tabela `MAILS`
--

CREATE TABLE `MAILS` (
  `MAI_ID` int(11) NOT NULL,
  `MAI_TIPO` enum('P','O') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'P',
  `MAI_EMAIL` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MAI_PES_ID` int(11) NOT NULL,
  `MAI_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PESSOAS`
--

CREATE TABLE `PESSOAS` (
  `PES_ID` int(11) NOT NULL,
  `PES_INC` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PES_STATUS` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `PES_TIPO` enum('C','P') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'C',
  `PES_USER` enum('N','S') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `PES_DOC` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `PES_NOME` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `PES_NASCIMENTO` date DEFAULT NULL,
  `PES_GENERO` enum('M','F','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `PES_PROFISSAO` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PES_AVATAR` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PES_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `PESSOAS`
--

INSERT INTO `PESSOAS` (`PES_ID`, `PES_INC`, `PES_STATUS`, `PES_TIPO`, `PES_USER`, `PES_DOC`, `PES_NOME`, `PES_NASCIMENTO`, `PES_GENERO`, `PES_PROFISSAO`, `PES_AVATAR`, `PES_DATA_ATUALIZADO`) VALUES
(-5, '2024-07-19 21:37:43', '1', 'C', 'S', '0', 'Master', NULL, 'N', NULL, NULL, '2024-07-19 21:37:43'),
(1, '2024-07-19 22:16:40', '1', 'P', 'N', '0', 'Ana Carolina dos Santos Rosa', '1983-07-26', 'N', 'Esteticista', NULL, '2024-07-19 22:16:40');

--
-- Acionadores `PESSOAS`
--
DELIMITER $$
CREATE TRIGGER `TG_HIS_PESSOAS_INSERT` AFTER UPDATE ON `PESSOAS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_PESSOAS (H_PES_ID,   H_PES_STATUS,   H_PES_TIPO,   H_PES_USER,   H_PES_DOC,   H_PES_NOME,   H_PES_NASCIMENTO,   H_PES_GENERO,   H_PES_PROFISSAO,   H_PES_AVATAR,   H_PES_DATA_ATUALIZADO)
    VALUES                   (NEW.PES_ID, NEW.PES_STATUS, NEW.PES_TIPO, NEW.PES_USER, NEW.PES_DOC, NEW.PES_NOME, NEW.PES_NASCIMENTO, NEW.PES_GENERO, NEW.PES_PROFISSAO, NEW.PES_AVATAR, NEW.PES_DATA_ATUALIZADO);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_HIS_PESSOAS_UPDATE` AFTER UPDATE ON `PESSOAS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_PESSOAS (H_PES_ID,   H_PES_STATUS,   H_PES_TIPO,   H_PES_USER,   H_PES_DOC,   H_PES_NOME,   H_PES_NASCIMENTO,   H_PES_GENERO,   H_PES_PROFISSAO,   H_PES_AVATAR,   H_PES_DATA_ATUALIZADO,  H_PES_ACAO )
    VALUES                   (NEW.PES_ID, NEW.PES_STATUS, NEW.PES_TIPO, NEW.PES_USER, NEW.PES_DOC, NEW.PES_NOME, NEW.PES_NASCIMENTO, NEW.PES_GENERO, NEW.PES_PROFISSAO, NEW.PES_AVATAR, NEW.PES_DATA_ATUALIZADO, 'UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PRC_CATEGORIAS`
--

CREATE TABLE `PRC_CATEGORIAS` (
  `CAT_ID` int(11) NOT NULL,
  `CAT_INC` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CAT_STATUS` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `CAT_NOME` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `CAT_DESC` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CAT_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `PRC_CATEGORIAS`
--

INSERT INTO `PRC_CATEGORIAS` (`CAT_ID`, `CAT_INC`, `CAT_STATUS`, `CAT_NOME`, `CAT_DESC`, `CAT_DATA_ATUALIZADO`) VALUES
(1, '2024-07-15 19:42:48', '1', 'Extensão de cílios', 'Serviço de aplicação de cílios sintéticos para alongamento dos naturais', '2024-07-15 19:42:48'),
(2, '2024-07-15 19:42:48', '1', 'Limpeza de pele', 'Procedimento estético para limpeza profunda da pele do rosto', '2024-07-15 19:42:48'),
(3, '2024-07-15 19:42:48', '1', 'Depilação', 'Remoção de pelos corporais por diferentes métodos', '2024-07-15 19:42:48'),
(4, '2024-07-15 19:42:48', '1', 'Microagulhamento', 'Tratamento estético com microagulhas para estimular a produção de colágeno', '2024-07-15 19:42:48'),
(5, '2024-07-15 19:42:48', '1', 'Peeling', 'Procedimento de renovação celular por meio da aplicação de substâncias químicas ou físicas', '2024-07-15 19:42:48');

--
-- Acionadores `PRC_CATEGORIAS`
--
DELIMITER $$
CREATE TRIGGER `TG_HIS_PRC_CATEGORIA_INSERT` AFTER INSERT ON `PRC_CATEGORIAS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_PRC_CATEGORIAS (H_CAT_ID,   H_CAT_STATUS,   H_CAT_NOME,   H_CAT_DESC,   H_CAT_DATA_ATUALIZADO)
    VALUES                          (NEW.CAT_ID, NEW.CAT_STATUS, NEW.CAT_NOME, NEW.CAT_DESC, NEW.CAT_DATA_ATUALIZADO);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_HIS_PRC_CATEGORIA_UPDATE` AFTER UPDATE ON `PRC_CATEGORIAS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_PRC_CATEGORIAS (H_CAT_ID,   H_CAT_STATUS,   H_CAT_NOME,   H_CAT_DESC,   H_CAT_DATA_ATUALIZADO, H_CAT_ACAO)
    VALUES                          (NEW.CAT_ID, NEW.CAT_STATUS, NEW.CAT_NOME, NEW.CAT_DESC, NEW.CAT_DATA_ATUALIZADO, 'UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PROCEDIMENTOS`
--

CREATE TABLE `PROCEDIMENTOS` (
  `PRC_ID` int(11) NOT NULL,
  `PRC_INC` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PRC_STATUS` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `PRC_NOME` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRC_DESC` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRC_DURACAO` smallint(6) NOT NULL DEFAULT '0',
  `PRC_VALOR` float(10,2) DEFAULT NULL,
  `PRC_REQUISITO` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRC_CUIDADOS` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRC_RISCOS` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRC_PROFISSIONAL` int(11) DEFAULT NULL,
  `PRC_EQUIPAMENTO` int(11) DEFAULT NULL,
  `PRC_CAT_ID` int(11) NOT NULL,
  `PRC_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `PROCEDIMENTOS`
--

INSERT INTO `PROCEDIMENTOS` (`PRC_ID`, `PRC_INC`, `PRC_STATUS`, `PRC_NOME`, `PRC_DESC`, `PRC_DURACAO`, `PRC_VALOR`, `PRC_REQUISITO`, `PRC_CUIDADOS`, `PRC_RISCOS`, `PRC_PROFISSIONAL`, `PRC_EQUIPAMENTO`, `PRC_CAT_ID`, `PRC_DATA_ATUALIZADO`) VALUES
(1, '2024-07-15 19:56:50', '1', 'Extensão de cílios Volume Brasileiro', 'Aplicação de cílios sintéticos para criar um volume natural e destacado ao estilo brasileiro.', 2, 150.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', NULL, NULL, 1, '2024-07-15 22:18:38'),
(2, '2024-07-15 19:56:50', '1', 'Extensão de cílios Volume Egípcio', 'Aplicação de cílios sintéticos para proporcionar um volume intenso e dramático ao estilo egípcio.', 2, 160.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', NULL, NULL, 1, '2024-07-15 22:18:42'),
(3, '2024-07-15 19:56:50', '1', 'Extensão de cílios Volume inglês (4,5D)', 'Aplicação de cílios sintéticos para obter um volume denso e sofisticado ao estilo inglês com 4,5D.', 2, 180.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', NULL, NULL, 1, '2024-07-15 22:18:46'),
(4, '2024-07-15 19:56:50', '1', 'Limpeza de pele', 'Procedimento estético que realiza uma limpeza profunda e revigorante da pele do rosto, removendo impurezas e células mortas.', 1, 120.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível vermelhidão temporária.', NULL, NULL, 2, '2024-07-15 22:18:49'),
(5, '2024-07-15 19:56:50', '1', 'Depilação com cera', 'Remoção eficiente e rápida dos pelos corporais utilizando cera quente ou fria, garantindo uma pele lisa e livre de pelos.', 30, 0.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível irritação cutânea.', NULL, NULL, 3, '2024-07-15 19:56:50'),
(6, '2024-07-15 19:56:50', '1', 'Depilação com linha', 'Método preciso de remoção de pelos utilizando linha de algodão, ideal para áreas delicadas do rosto e corpo.', 45, 0.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível irritação cutânea.', NULL, NULL, 3, '2024-07-15 19:56:50'),
(7, '2024-07-15 19:56:50', '1', 'Microagulhamento', 'Tratamento estético avançado que utiliza microagulhas para estimular a produção de colágeno e melhorar a textura da pele.', 1, 220.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível vermelhidão e inchaço temporários.', NULL, NULL, 4, '2024-07-15 22:19:10'),
(8, '2024-07-15 19:56:50', '1', 'Peeling de Diamante', 'Procedimento de esfoliação profunda que utiliza uma ponteira de diamante para renovar a pele, removendo células mortas e impurezas.', 1, 90.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível descamação e vermelhidão.', NULL, NULL, 5, '2024-07-15 22:19:19');

--
-- Acionadores `PROCEDIMENTOS`
--
DELIMITER $$
CREATE TRIGGER `TG_HIS_PROCEDIMENTOS_INSERT` AFTER INSERT ON `PROCEDIMENTOS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_PROCEDIMENTOS (H_PRC_ID,   H_PRC_STATUS,   H_PRC_NOME,   H_PRC_DESC,   H_PRC_DURACAO,   H_PRC_VALOR,   H_PRC_REQUISITO,   H_PRC_CUIDADOS,   H_PRC_RISCOS,   H_PRC_CAT_ID,   H_PRC_PROFISSIONAL,   H_PRC_EQUIPAMENTO,   H_PRC_DATA_ATUALIZADO)
    VALUES                         (NEW.PRC_ID, NEW.PRC_STATUS, NEW.PRC_NOME, NEW.PRC_DESC, NEW.PRC_DURACAO, NEW.PRC_VALOR, NEW.PRC_REQUISITO, NEW.PRC_CUIDADOS, NEW.PRC_RISCOS, NEW.PRC_CAT_ID, NEW.PRC_PROFISSIONAL, NEW.PRC_EQUIPAMENTO, NEW.PRC_DATA_ATUALIZADO);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_HIS_PROCEDIMENTOS_UPDATE` AFTER UPDATE ON `PROCEDIMENTOS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_PROCEDIMENTOS (H_PRC_ID,   H_PRC_STATUS,   H_PRC_NOME,   H_PRC_DESC,   H_PRC_DURACAO,   H_PRC_VALOR,   H_PRC_REQUISITO,   H_PRC_CUIDADOS,   H_PRC_RISCOS,   H_PRC_CAT_ID,   H_PRC_PROFISSIONAL,   H_PRC_EQUIPAMENTO,   H_PRC_DATA_ATUALIZADO, H_PRC_ACAO)
    VALUES                         (NEW.PRC_ID, NEW.PRC_STATUS, NEW.PRC_NOME, NEW.PRC_DESC, NEW.PRC_DURACAO, NEW.PRC_VALOR, NEW.PRC_REQUISITO, NEW.PRC_CUIDADOS, NEW.PRC_RISCOS, NEW.PRC_CAT_ID, NEW.PRC_PROFISSIONAL, NEW.PRC_EQUIPAMENTO, NEW.PRC_DATA_ATUALIZADO, 'UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PROFISSIONAIS`
--

CREATE TABLE `PROFISSIONAIS` (
  `PRF_ID` smallint(11) NOT NULL,
  `PRF_STATUS` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `PRF_PES_ID` int(11) NOT NULL,
  `PRF_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `TELEFONES`
--

CREATE TABLE `TELEFONES` (
  `TEL_ID` int(11) NOT NULL,
  `TEL_PES_ID` int(11) NOT NULL,
  `TEL_TIPO` enum('P','O') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'P',
  `TEL_DDI` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT '55',
  `TEL_DDD` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TEL_TELEFONE` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TEL_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `USUARIOS`
--

CREATE TABLE `USUARIOS` (
  `USU_ID` tinyint(4) NOT NULL,
  `USU_PES_ID` int(11) NOT NULL,
  `USU_STATUS` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `USU_TIPO` enum('M','A','U') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'U',
  `USU_SENHA` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `USU_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `USUARIOS`
--

INSERT INTO `USUARIOS` (`USU_ID`, `USU_PES_ID`, `USU_STATUS`, `USU_TIPO`, `USU_SENHA`, `USU_DATA_ATUALIZADO`) VALUES
(1, -5, '1', 'M', '123', '2024-07-19 21:42:31');

--
-- Acionadores `USUARIOS`
--
DELIMITER $$
CREATE TRIGGER `TG_HIS_USUARIOS_INSERT` AFTER INSERT ON `USUARIOS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_USUARIOS (H_USU_ID,   H_USU_PES_ID,   H_USU_STATUS,   H_USU_TIPO,   H_USU_SENHA,   H_USU_DATA_ATUALIZADO)
    VALUES                    (NEW.USU_ID, NEW.USU_PES_ID, NEW.USU_STATUS, NEW.USU_TIPO, NEW.USU_SENHA, NEW.USU_DATA_ATUALIZADO);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_HIS_USUARIOS_UPDATE` AFTER UPDATE ON `USUARIOS` FOR EACH ROW BEGIN
    INSERT INTO Z_HIST_USUARIOS (H_USU_ID,   H_USU_PES_ID,   H_USU_STATUS,   H_USU_TIPO,   H_USU_SENHA,   H_USU_DATA_ATUALIZADO, H_USU_ACAO)
    VALUES                    (NEW.USU_ID, NEW.USU_PES_ID, NEW.USU_STATUS, NEW.USU_TIPO, NEW.USU_SENHA, NEW.USU_DATA_ATUALIZADO, 'UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Z_HIST_ATENDIMENTOS`
--

CREATE TABLE `Z_HIST_ATENDIMENTOS` (
  `H_ATD_HIS_ID` bigint(20) NOT NULL,
  `H_ATD_ID` int(11) NOT NULL,
  `H_ATD_STATUS` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_ATD_DATA` date NOT NULL,
  `H_ATD_HORA` time NOT NULL,
  `H_ATD_VALOR` decimal(10,2) NOT NULL,
  `H_ATD_OBSERVACOES` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_ATD_PES_ID` int(11) NOT NULL,
  `H_ATD_PRC_ID` int(11) NOT NULL,
  `H_ATD_FPG_ID` smallint(6) NOT NULL,
  `H_ATD_PRF_ID` smallint(6) NOT NULL,
  `H_ATD_DATA_ATUALIZACAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `H_ATD_ACAO` enum('INSERT','UPDATE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INSERT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Z_HIST_PESSOAS`
--

CREATE TABLE `Z_HIST_PESSOAS` (
  `H_PES_HIS_ID` bigint(20) NOT NULL,
  `H_PES_ID` int(11) NOT NULL,
  `H_PES_STATUS` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `H_PES_TIPO` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `H_PES_USER` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `H_PES_DOC` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `H_PES_NOME` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `H_PES_NASCIMENTO` date DEFAULT NULL,
  `H_PES_GENERO` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PES_PROFISSAO` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PES_AVATAR` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PES_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `H_PES_ACAO` enum('INSERT','UPDATE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INSERT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `Z_HIST_PESSOAS`
--

INSERT INTO `Z_HIST_PESSOAS` (`H_PES_HIS_ID`, `H_PES_ID`, `H_PES_STATUS`, `H_PES_TIPO`, `H_PES_USER`, `H_PES_DOC`, `H_PES_NOME`, `H_PES_NASCIMENTO`, `H_PES_GENERO`, `H_PES_PROFISSAO`, `H_PES_AVATAR`, `H_PES_DATA_ATUALIZADO`, `H_PES_ACAO`) VALUES
(1, -5, '1', 'N', 'S', '0', 'Master', NULL, 'N', NULL, NULL, '2024-07-19 21:37:43', 'INSERT'),
(2, 1, '1', 'P', 'N', '0', 'Ana Carolina dos Santos Rosa', '1983-07-26', 'N', 'Esteticista', NULL, '2024-07-19 22:16:40', 'INSERT');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Z_HIST_PRC_CATEGORIAS`
--

CREATE TABLE `Z_HIST_PRC_CATEGORIAS` (
  `H_CAT_HIS_ID` bigint(20) NOT NULL,
  `H_CAT_ID` int(11) NOT NULL,
  `H_CAT_STATUS` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `H_CAT_NOME` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `H_CAT_DESC` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_CAT_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `H_CAT_ACAO` enum('INSERT','UPDATE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INSERT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `Z_HIST_PRC_CATEGORIAS`
--

INSERT INTO `Z_HIST_PRC_CATEGORIAS` (`H_CAT_HIS_ID`, `H_CAT_ID`, `H_CAT_STATUS`, `H_CAT_NOME`, `H_CAT_DESC`, `H_CAT_DATA_ATUALIZADO`, `H_CAT_ACAO`) VALUES
(1, 1, '1', 'Extensão de cílios', 'Serviço de aplicação de cílios sintéticos para alongamento dos naturais', '2024-07-15 19:42:48', 'INSERT'),
(2, 2, '1', 'Limpeza de pele', 'Procedimento estético para limpeza profunda da pele do rosto', '2024-07-15 19:42:48', 'INSERT'),
(3, 3, '1', 'Depilação', 'Remoção de pelos corporais por diferentes métodos', '2024-07-15 19:42:48', 'INSERT'),
(4, 4, '1', 'Microagulhamento', 'Tratamento estético com microagulhas para estimular a produção de colágeno', '2024-07-15 19:42:48', 'INSERT'),
(5, 5, '1', 'Peeling', 'Procedimento de renovação celular por meio da aplicação de substâncias químicas ou físicas', '2024-07-15 19:42:48', 'INSERT');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Z_HIST_PROCEDIMENTOS`
--

CREATE TABLE `Z_HIST_PROCEDIMENTOS` (
  `H_PRC_HIS_ID` bigint(20) NOT NULL,
  `H_PRC_ID` int(11) NOT NULL,
  `H_PRC_STATUS` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `H_PRC_NOME` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PRC_DESC` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PRC_DURACAO` smallint(6) DEFAULT '0',
  `H_PRC_VALOR` float(10,2) DEFAULT NULL,
  `H_PRC_REQUISITO` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PRC_CUIDADOS` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PRC_RISCOS` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `H_PRC_CAT_ID` int(11) DEFAULT NULL,
  `H_PRC_PROFISSIONAL` int(11) DEFAULT NULL,
  `H_PRC_EQUIPAMENTO` int(11) DEFAULT NULL,
  `H_PRC_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `H_PRC_ACAO` enum('INSERT','UPDATE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INSERT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `Z_HIST_PROCEDIMENTOS`
--

INSERT INTO `Z_HIST_PROCEDIMENTOS` (`H_PRC_HIS_ID`, `H_PRC_ID`, `H_PRC_STATUS`, `H_PRC_NOME`, `H_PRC_DESC`, `H_PRC_DURACAO`, `H_PRC_VALOR`, `H_PRC_REQUISITO`, `H_PRC_CUIDADOS`, `H_PRC_RISCOS`, `H_PRC_CAT_ID`, `H_PRC_PROFISSIONAL`, `H_PRC_EQUIPAMENTO`, `H_PRC_DATA_ATUALIZADO`, `H_PRC_ACAO`) VALUES
(1, 1, '1', 'Extensão de cílios Volume Brasileiro', 'Aplicação de cílios sintéticos para criar um volume natural e destacado ao estilo brasileiro.', 2, 0.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', 1, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(2, 2, '1', 'Extensão de cílios Volume Egípcio', 'Aplicação de cílios sintéticos para proporcionar um volume intenso e dramático ao estilo egípcio.', 2, 0.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', 1, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(3, 3, '1', 'Extensão de cílios Volume inglês (4,5D)', 'Aplicação de cílios sintéticos para obter um volume denso e sofisticado ao estilo inglês com 4,5D.', 2, 0.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', 1, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(4, 4, '1', 'Limpeza de pele', 'Procedimento estético que realiza uma limpeza profunda e revigorante da pele do rosto, removendo impurezas e células mortas.', 1, 0.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível vermelhidão temporária.', 2, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(5, 5, '1', 'Depilação com cera', 'Remoção eficiente e rápida dos pelos corporais utilizando cera quente ou fria, garantindo uma pele lisa e livre de pelos.', 30, 0.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível irritação cutânea.', 3, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(6, 6, '1', 'Depilação com linha', 'Método preciso de remoção de pelos utilizando linha de algodão, ideal para áreas delicadas do rosto e corpo.', 45, 0.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível irritação cutânea.', 3, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(7, 7, '1', 'Microagulhamento', 'Tratamento estético avançado que utiliza microagulhas para estimular a produção de colágeno e melhorar a textura da pele.', 1, 0.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível vermelhidão e inchaço temporários.', 4, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(8, 8, '1', 'Peeling de Diamante', 'Procedimento de esfoliação profunda que utiliza uma ponteira de diamante para renovar a pele, removendo células mortas e impurezas.', 1, 0.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível descamação e vermelhidão.', 5, NULL, NULL, '2024-07-15 19:56:50', 'INSERT'),
(9, 1, '1', 'Extensão de cílios Volume Brasileiro', 'Aplicação de cílios sintéticos para criar um volume natural e destacado ao estilo brasileiro.', 2, 150.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', 1, NULL, NULL, '2024-07-15 22:18:38', 'UPDATE'),
(10, 2, '1', 'Extensão de cílios Volume Egípcio', 'Aplicação de cílios sintéticos para proporcionar um volume intenso e dramático ao estilo egípcio.', 2, 160.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', 1, NULL, NULL, '2024-07-15 22:18:42', 'UPDATE'),
(11, 3, '1', 'Extensão de cílios Volume inglês (4,5D)', 'Aplicação de cílios sintéticos para obter um volume denso e sofisticado ao estilo inglês com 4,5D.', 2, 180.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', 1, NULL, NULL, '2024-07-15 22:18:46', 'UPDATE'),
(12, 4, '1', 'Limpeza de pele', 'Procedimento estético que realiza uma limpeza profunda e revigorante da pele do rosto, removendo impurezas e células mortas.', 1, 120.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível vermelhidão temporária.', 2, NULL, NULL, '2024-07-15 22:18:49', 'UPDATE'),
(13, 7, '1', 'Microagulhamento', 'Tratamento estético avançado que utiliza microagulhas para estimular a produção de colágeno e melhorar a textura da pele.', 1, 220.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível vermelhidão e inchaço temporários.', 4, NULL, NULL, '2024-07-15 22:19:10', 'UPDATE'),
(14, 8, '1', 'Peeling de Diamante', 'Procedimento de esfoliação profunda que utiliza uma ponteira de diamante para renovar a pele, removendo células mortas e impurezas.', 1, 90.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível descamação e vermelhidão.', 5, NULL, NULL, '2024-07-15 22:19:19', 'UPDATE');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Z_HIST_USUARIOS`
--

CREATE TABLE `Z_HIST_USUARIOS` (
  `H_USU_HIS_ID` int(11) NOT NULL,
  `H_USU_ID` int(11) NOT NULL,
  `H_USU_PES_ID` int(11) NOT NULL,
  `H_USU_STATUS` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `H_USU_TIPO` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `H_USU_SENHA` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `H_USU_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `H_USU_ACAO` enum('INSERT','UPDATE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INSERT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `Z_HIST_USUARIOS`
--

INSERT INTO `Z_HIST_USUARIOS` (`H_USU_HIS_ID`, `H_USU_ID`, `H_USU_PES_ID`, `H_USU_STATUS`, `H_USU_TIPO`, `H_USU_SENHA`, `H_USU_DATA_ATUALIZADO`, `H_USU_ACAO`) VALUES
(1, 1, -5, '1', 'M', '123', '2024-07-19 21:42:31', 'INSERT');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `ATENDIMENTOS_PESS`
--
ALTER TABLE `ATENDIMENTOS_PESS`
  ADD PRIMARY KEY (`APS_ID`),
  ADD KEY `FK_APS_PES` (`APS_PES_ID`),
  ADD KEY `FK_APS_ATD` (`APS_ATD_ID`);

--
-- Índices de tabela `ATENDIMENTOS_PROC`
--
ALTER TABLE `ATENDIMENTOS_PROC`
  ADD PRIMARY KEY (`APC_ID`),
  ADD KEY `FK_PRC_APC` (`APC_PRC_ID`),
  ADD KEY `FK_ATD_APC` (`APC_ATD_ID`);

--
-- Índices de tabela `ATENDIMENTOS_PROF`
--
ALTER TABLE `ATENDIMENTOS_PROF`
  ADD PRIMARY KEY (`APF_ID`),
  ADD KEY `FK_APF_ATD` (`APF_ATD_ID`),
  ADD KEY `FK_APF_PRF` (`APF_PRF_ID`);

--
-- Índices de tabela `ENDERECOS`
--
ALTER TABLE `ENDERECOS`
  ADD PRIMARY KEY (`END_ID`),
  ADD KEY `FK_END_PES` (`END_PES_ID`);

--
-- Índices de tabela `FORMA_PGTO`
--
ALTER TABLE `FORMA_PGTO`
  ADD PRIMARY KEY (`FPG_ID`);

--
-- Índices de tabela `MAILS`
--
ALTER TABLE `MAILS`
  ADD PRIMARY KEY (`MAI_ID`),
  ADD KEY `FK_MAI_PES` (`MAI_PES_ID`);

--
-- Índices de tabela `PESSOAS`
--
ALTER TABLE `PESSOAS`
  ADD PRIMARY KEY (`PES_ID`);

--
-- Índices de tabela `PRC_CATEGORIAS`
--
ALTER TABLE `PRC_CATEGORIAS`
  ADD PRIMARY KEY (`CAT_ID`);

--
-- Índices de tabela `PROCEDIMENTOS`
--
ALTER TABLE `PROCEDIMENTOS`
  ADD PRIMARY KEY (`PRC_ID`),
  ADD KEY `FK_PRC_CAT` (`PRC_CAT_ID`);

--
-- Índices de tabela `PROFISSIONAIS`
--
ALTER TABLE `PROFISSIONAIS`
  ADD PRIMARY KEY (`PRF_ID`),
  ADD KEY `FK_PRF_PES` (`PRF_PES_ID`);

--
-- Índices de tabela `TELEFONES`
--
ALTER TABLE `TELEFONES`
  ADD PRIMARY KEY (`TEL_ID`),
  ADD KEY `FK_TEL_PES` (`TEL_PES_ID`);

--
-- Índices de tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD PRIMARY KEY (`USU_ID`),
  ADD KEY `FK_USU_PES` (`USU_PES_ID`);

--
-- Índices de tabela `Z_HIST_ATENDIMENTOS`
--
ALTER TABLE `Z_HIST_ATENDIMENTOS`
  ADD PRIMARY KEY (`H_ATD_HIS_ID`);

--
-- Índices de tabela `Z_HIST_PESSOAS`
--
ALTER TABLE `Z_HIST_PESSOAS`
  ADD PRIMARY KEY (`H_PES_HIS_ID`);

--
-- Índices de tabela `Z_HIST_PRC_CATEGORIAS`
--
ALTER TABLE `Z_HIST_PRC_CATEGORIAS`
  ADD PRIMARY KEY (`H_CAT_HIS_ID`);

--
-- Índices de tabela `Z_HIST_PROCEDIMENTOS`
--
ALTER TABLE `Z_HIST_PROCEDIMENTOS`
  ADD PRIMARY KEY (`H_PRC_HIS_ID`);

--
-- Índices de tabela `Z_HIST_USUARIOS`
--
ALTER TABLE `Z_HIST_USUARIOS`
  ADD PRIMARY KEY (`H_USU_HIS_ID`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `ATENDIMENTOS_PESS`
--
ALTER TABLE `ATENDIMENTOS_PESS`
  MODIFY `APS_ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ATENDIMENTOS_PROC`
--
ALTER TABLE `ATENDIMENTOS_PROC`
  MODIFY `APC_ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ATENDIMENTOS_PROF`
--
ALTER TABLE `ATENDIMENTOS_PROF`
  MODIFY `APF_ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ENDERECOS`
--
ALTER TABLE `ENDERECOS`
  MODIFY `END_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `FORMA_PGTO`
--
ALTER TABLE `FORMA_PGTO`
  MODIFY `FPG_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `MAILS`
--
ALTER TABLE `MAILS`
  MODIFY `MAI_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `PESSOAS`
--
ALTER TABLE `PESSOAS`
  MODIFY `PES_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `PRC_CATEGORIAS`
--
ALTER TABLE `PRC_CATEGORIAS`
  MODIFY `CAT_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `PROCEDIMENTOS`
--
ALTER TABLE `PROCEDIMENTOS`
  MODIFY `PRC_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `PROFISSIONAIS`
--
ALTER TABLE `PROFISSIONAIS`
  MODIFY `PRF_ID` smallint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `TELEFONES`
--
ALTER TABLE `TELEFONES`
  MODIFY `TEL_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `USU_ID` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `Z_HIST_ATENDIMENTOS`
--
ALTER TABLE `Z_HIST_ATENDIMENTOS`
  MODIFY `H_ATD_HIS_ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Z_HIST_PESSOAS`
--
ALTER TABLE `Z_HIST_PESSOAS`
  MODIFY `H_PES_HIS_ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `Z_HIST_PRC_CATEGORIAS`
--
ALTER TABLE `Z_HIST_PRC_CATEGORIAS`
  MODIFY `H_CAT_HIS_ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `Z_HIST_PROCEDIMENTOS`
--
ALTER TABLE `Z_HIST_PROCEDIMENTOS`
  MODIFY `H_PRC_HIS_ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `Z_HIST_USUARIOS`
--
ALTER TABLE `Z_HIST_USUARIOS`
  MODIFY `H_USU_HIS_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `ATENDIMENTOS_PESS`
--
ALTER TABLE `ATENDIMENTOS_PESS`
  ADD CONSTRAINT `FK_APS_ATD` FOREIGN KEY (`APS_ATD_ID`) REFERENCES `ande1162_arSalao`.`ATENDIMENTOS` (`ATD_ID`),
  ADD CONSTRAINT `FK_APS_PES` FOREIGN KEY (`APS_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Restrições para tabelas `ATENDIMENTOS_PROC`
--
ALTER TABLE `ATENDIMENTOS_PROC`
  ADD CONSTRAINT `FK_ATD_APC` FOREIGN KEY (`APC_ATD_ID`) REFERENCES `ande1162_arSalao`.`ATENDIMENTOS` (`ATD_ID`),
  ADD CONSTRAINT `FK_PRC_APC` FOREIGN KEY (`APC_PRC_ID`) REFERENCES `PROCEDIMENTOS` (`PRC_ID`);

--
-- Restrições para tabelas `ATENDIMENTOS_PROF`
--
ALTER TABLE `ATENDIMENTOS_PROF`
  ADD CONSTRAINT `FK_APF_ATD` FOREIGN KEY (`APF_ATD_ID`) REFERENCES `ande1162_arSalao`.`ATENDIMENTOS` (`ATD_ID`),
  ADD CONSTRAINT `FK_APF_PRF` FOREIGN KEY (`APF_PRF_ID`) REFERENCES `PROFISSIONAIS` (`PRF_ID`);

--
-- Restrições para tabelas `ENDERECOS`
--
ALTER TABLE `ENDERECOS`
  ADD CONSTRAINT `FK_END_PES` FOREIGN KEY (`END_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Restrições para tabelas `MAILS`
--
ALTER TABLE `MAILS`
  ADD CONSTRAINT `FK_MAI_PES` FOREIGN KEY (`MAI_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Restrições para tabelas `PROCEDIMENTOS`
--
ALTER TABLE `PROCEDIMENTOS`
  ADD CONSTRAINT `FK_PROCEDIMENTOS` FOREIGN KEY (`PRC_CAT_ID`) REFERENCES `PRC_CATEGORIAS` (`CAT_ID`);

--
-- Restrições para tabelas `PROFISSIONAIS`
--
ALTER TABLE `PROFISSIONAIS`
  ADD CONSTRAINT `FK_PRF_PES` FOREIGN KEY (`PRF_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Restrições para tabelas `TELEFONES`
--
ALTER TABLE `TELEFONES`
  ADD CONSTRAINT `FK_TEL_PES` FOREIGN KEY (`TEL_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Restrições para tabelas `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD CONSTRAINT `FK_USU_PES` FOREIGN KEY (`USU_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
