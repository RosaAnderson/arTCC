-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 16-Nov-2024 às 21:48
-- Versão do servidor: 10.7.3-MariaDB
-- versão do PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `arEasyCare`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `MENSAGEM_HIST`
--

CREATE TABLE `MENSAGEM_HIST` (
  `MSG_ID` int(11) NOT NULL,
  `MSG_INCLUSAO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `MSG_ORI_ID` int(11) DEFAULT NULL,
  `MSG_CUS_ID` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_WGW_ID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_TIPO` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_STATUS` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_ORIGEM` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MSG_REM_NUMERO` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_REM_NOME` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MDG_DES_NUMERO` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MSG_MENSAGEM` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `MENSAGEM_HIST`
--
ALTER TABLE `MENSAGEM_HIST`
  ADD PRIMARY KEY (`MSG_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
