-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 16-Nov-2024 às 21:51
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
-- Estrutura da tabela `ATENDIMENTOS`
--

CREATE TABLE `ATENDIMENTOS` (
  `ATD_ID` int(11) NOT NULL,
  `ATD_FPG_ID` smallint(6) NOT NULL,
  `ATD_INC` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ATD_STATUS` enum('A','C','F') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'A',
  `ATD_NOTIFICADO` enum('S','N') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'N',
  `ATD_DATA` date NOT NULL,
  `ATD_HORA` time NOT NULL,
  `ATD_DURACAO` int(11) NOT NULL,
  `ATD_VALOR` decimal(10,2) NOT NULL,
  `ATD_OBSERVACOES` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ATD_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Extraindo dados da tabela `ATENDIMENTOS`
--

INSERT INTO `ATENDIMENTOS` (`ATD_ID`, `ATD_FPG_ID`, `ATD_INC`, `ATD_STATUS`, `ATD_NOTIFICADO`, `ATD_DATA`, `ATD_HORA`, `ATD_DURACAO`, `ATD_VALOR`, `ATD_OBSERVACOES`, `ATD_DATA_ATUALIZADO`) VALUES
(17, 1, '2024-11-08 04:57:21', 'C', 'N', '2024-11-06', '13:00:00', 60, '120.00', 'Alemanha', '2024-11-04 00:33:10'),
(18, 2, '2024-11-04 00:59:54', 'F', 'N', '2024-11-07', '12:00:00', 60, '220.00', 'Roma', '2024-11-04 00:59:54'),
(19, 4, '2024-11-05 06:54:02', 'A', 'N', '2024-11-07', '08:00:00', 60, '90.00', 'Inglaterra', '2024-11-04 02:07:31'),
(23, 2, '2024-11-09 16:02:29', 'A', 'N', '2024-12-05', '11:00:00', 60, '120.00', 'alguma coisa', '2024-11-04 14:15:10'),
(25, 1, '2024-11-07 22:50:56', 'A', 'N', '2024-11-07', '16:00:00', 120, '150.00', 'bocaina', '2024-11-07 22:50:56'),
(26, 2, '2024-11-08 07:31:12', 'A', 'N', '2024-11-20', '15:00:00', 60, '120.00', '', '2024-11-08 07:31:12'),
(28, 3, '2024-11-08 07:38:23', 'A', 'N', '2024-11-20', '10:00:00', 120, '180.00', '', '2024-11-08 07:38:23'),
(29, 3, '2024-11-08 07:42:38', 'A', 'N', '2024-11-20', '12:00:00', 120, '180.00', '', '2024-11-08 07:42:38'),
(30, 4, '2024-11-08 07:45:00', 'A', 'N', '2024-11-20', '14:00:00', 60, '120.00', '', '2024-11-08 07:45:00'),
(31, 1, '2024-11-08 08:02:05', 'A', 'N', '2024-11-20', '16:00:00', 120, '180.00', '', '2024-11-08 08:02:05'),
(32, 2, '2024-11-08 08:09:56', 'A', 'N', '2024-11-08', '08:00:00', 60, '120.00', '', '2024-11-08 08:09:56'),
(33, 2, '2024-11-08 08:11:05', 'A', 'N', '2024-11-08', '09:00:00', 120, '150.00', '', '2024-11-08 08:11:04'),
(34, 4, '2024-11-11 14:13:02', 'A', 'N', '2024-11-20', '08:00:00', 120, '180.00', '', '2024-11-09 07:27:10'),
(35, 1, '2024-11-10 02:41:01', 'A', 'N', '2024-11-11', '12:00:00', 60, '120.00', 'usar luva nitrilida, alergia à látex.', '2024-11-10 01:39:29'),
(36, 2, '2024-11-12 08:49:25', 'A', 'N', '2024-11-12', '08:00:00', 60, '90.00', '', '2024-11-10 08:59:27'),
(37, 1, '2024-11-11 17:00:23', 'F', 'N', '2024-11-11', '10:00:00', 60, '90.00', '', '2024-11-10 09:04:45'),
(38, 2, '2024-11-15 09:02:37', 'A', 'N', '2024-11-19', '09:00:00', 60, '90.00', '', '2024-11-10 09:10:22');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `ATENDIMENTOS`
--
ALTER TABLE `ATENDIMENTOS`
  ADD PRIMARY KEY (`ATD_ID`),
  ADD KEY `FK_ATD_FPG` (`ATD_FPG_ID`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `ATENDIMENTOS`
--
ALTER TABLE `ATENDIMENTOS`
  MODIFY `ATD_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `ATENDIMENTOS`
--
ALTER TABLE `ATENDIMENTOS`
  ADD CONSTRAINT `FK_ATENDIMENTOS` FOREIGN KEY (`ATD_FPG_ID`) REFERENCES `FORMA_PGTO` (`FPG_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
