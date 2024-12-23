-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 14-Nov-2024 às 16:01
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

--
-- Extraindo dados da tabela `ATENDIMENTOS`
--

INSERT INTO `ATENDIMENTOS` (`ATD_ID`, `ATD_FPG_ID`, `ATD_INC`, `ATD_STATUS`, `ATD_DATA`, `ATD_HORA`, `ATD_DURACAO`, `ATD_VALOR`, `ATD_OBSERVACOES`, `ATD_DATA_ATUALIZADO`) VALUES
(17, 1, '2024-11-08 04:57:21', 'C', '2024-11-06', '13:00:00', 60, '120.00', 'Alemanha', '2024-11-04 00:33:10'),
(18, 2, '2024-11-04 00:59:54', 'F', '2024-11-07', '12:00:00', 60, '220.00', 'Roma', '2024-11-04 00:59:54'),
(19, 4, '2024-11-05 06:54:02', 'A', '2024-11-07', '08:00:00', 60, '90.00', 'Inglaterra', '2024-11-04 02:07:31'),
(23, 2, '2024-11-09 16:02:29', 'A', '2024-12-05', '11:00:00', 60, '120.00', 'alguma coisa', '2024-11-04 14:15:10'),
(25, 1, '2024-11-07 22:50:56', 'A', '2024-11-07', '16:00:00', 120, '150.00', 'bocaina', '2024-11-07 22:50:56'),
(26, 2, '2024-11-08 07:31:12', 'A', '2024-11-20', '15:00:00', 60, '120.00', '', '2024-11-08 07:31:12'),
(28, 3, '2024-11-08 07:38:23', 'A', '2024-11-20', '10:00:00', 120, '180.00', '', '2024-11-08 07:38:23'),
(29, 3, '2024-11-08 07:42:38', 'A', '2024-11-20', '12:00:00', 120, '180.00', '', '2024-11-08 07:42:38'),
(30, 4, '2024-11-08 07:45:00', 'A', '2024-11-20', '14:00:00', 60, '120.00', '', '2024-11-08 07:45:00'),
(31, 1, '2024-11-08 08:02:05', 'A', '2024-11-20', '16:00:00', 120, '180.00', '', '2024-11-08 08:02:05'),
(32, 2, '2024-11-08 08:09:56', 'A', '2024-11-08', '08:00:00', 60, '120.00', '', '2024-11-08 08:09:56'),
(33, 2, '2024-11-08 08:11:05', 'A', '2024-11-08', '09:00:00', 120, '150.00', '', '2024-11-08 08:11:04'),
(34, 4, '2024-11-11 14:13:02', 'A', '2024-11-20', '08:00:00', 120, '180.00', '', '2024-11-09 07:27:10'),
(35, 1, '2024-11-10 02:41:01', 'A', '2024-11-11', '12:00:00', 60, '120.00', 'usar luva nitrilida, alergia à látex.', '2024-11-10 01:39:29'),
(36, 2, '2024-11-12 08:49:25', 'A', '2024-11-12', '08:00:00', 60, '90.00', '', '2024-11-10 08:59:27'),
(37, 1, '2024-11-11 17:00:23', 'F', '2024-11-11', '10:00:00', 60, '90.00', '', '2024-11-10 09:04:45'),
(38, 2, '2024-11-10 09:10:22', 'A', '2024-11-19', '09:00:00', 60, '90.00', '', '2024-11-10 09:10:22');

--
-- Extraindo dados da tabela `ATENDIMENTOS_PESS`
--

INSERT INTO `ATENDIMENTOS_PESS` (`APS_ID`, `APS_ATD_ID`, `APS_PES_ID`, `APS_DATA_ATUALIZADO`) VALUES
(4, 17, 13, '2024-11-04 00:33:10'),
(5, 18, 15, '2024-11-04 00:59:54'),
(6, 19, 14, '2024-11-04 02:07:31'),
(10, 23, 10, '2024-11-04 14:15:10'),
(12, 25, 28, '2024-11-07 22:50:56'),
(13, 26, 21, '2024-11-08 07:31:12'),
(15, 28, 15, '2024-11-10 10:00:25'),
(16, 29, 19, '2024-11-08 07:42:38'),
(17, 30, 18, '2024-11-08 07:45:00'),
(18, 31, 24, '2024-11-08 08:02:05'),
(19, 32, 30, '2024-11-08 08:09:57'),
(20, 33, 26, '2024-11-08 08:11:05'),
(22, 34, 20, '2024-11-09 07:27:27'),
(23, 35, 22, '2024-11-10 01:39:29'),
(24, 36, 15, '2024-11-10 08:59:28'),
(25, 37, 14, '2024-11-10 09:04:45'),
(26, 38, 14, '2024-11-10 09:10:22');

--
-- Extraindo dados da tabela `ATENDIMENTOS_PROC`
--

INSERT INTO `ATENDIMENTOS_PROC` (`APC_ID`, `APC_ATD_ID`, `APC_PRC_ID`, `APC_DATA_ATUALIZADO`) VALUES
(2, 17, 4, '2024-11-04 00:33:10'),
(3, 18, 7, '2024-11-04 00:59:54'),
(4, 19, 8, '2024-11-04 02:07:31'),
(8, 23, 4, '2024-11-04 14:15:10'),
(10, 25, 1, '2024-11-07 22:50:56'),
(11, 26, 4, '2024-11-08 07:31:13'),
(13, 28, 3, '2024-11-08 07:38:23'),
(14, 29, 3, '2024-11-08 07:42:38'),
(15, 30, 4, '2024-11-08 07:45:00'),
(16, 31, 3, '2024-11-08 08:02:05'),
(17, 32, 4, '2024-11-08 08:09:57'),
(18, 33, 1, '2024-11-08 08:11:05'),
(19, 34, 3, '2024-11-09 07:27:27'),
(20, 35, 4, '2024-11-10 01:39:29'),
(21, 36, 6, '2024-11-10 08:59:28'),
(22, 37, 8, '2024-11-10 09:04:46'),
(23, 38, 8, '2024-11-10 09:10:22');

--
-- Extraindo dados da tabela `ATENDIMENTOS_PROF`
--

INSERT INTO `ATENDIMENTOS_PROF` (`APF_ID`, `APF_ATD_ID`, `APF_PRF_ID`, `APF_DATA_ATUALIZADO`) VALUES
(1, 17, 1, '2024-11-04 00:34:13'),
(2, 18, 1, '2024-11-04 00:59:54'),
(3, 19, 1, '2024-11-04 02:07:31'),
(5, 23, 1, '2024-11-04 14:15:10'),
(7, 25, 1, '2024-11-07 22:50:56'),
(8, 26, 1, '2024-11-08 07:31:13'),
(10, 28, 1, '2024-11-08 07:38:23'),
(11, 29, 1, '2024-11-08 07:42:39'),
(12, 30, 1, '2024-11-08 07:45:00'),
(13, 31, 1, '2024-11-08 08:02:05'),
(14, 32, 1, '2024-11-08 08:09:57'),
(15, 33, 1, '2024-11-08 08:11:05'),
(16, 34, 1, '2024-11-09 07:27:27'),
(17, 35, 1, '2024-11-10 01:39:29'),
(18, 36, 1, '2024-11-10 08:59:28'),
(19, 37, 1, '2024-11-10 09:04:46'),
(20, 38, 1, '2024-11-10 09:10:22');

--
-- Extraindo dados da tabela `FORMA_PGTO`
--

INSERT INTO `FORMA_PGTO` (`FPG_ID`, `FPG_STATUS`, `FPG_NOME`, `FPG_NOME_SCE`, `FPG_DATA_ATUALIZADO`) VALUES
(-5, '1', '', '', '2024-11-01 08:02:33'),
(1, '1', 'Dinheiro', 'Dinheiro', '2024-07-23 08:28:53'),
(2, '1', 'PIX', 'PIX', '2024-07-23 08:28:53'),
(3, '1', 'Cartão de Débito', 'Cartao de Debito', '2024-07-23 08:28:53'),
(4, '1', 'Cartão de Crédito', 'Cartao de Credito', '2024-07-23 08:28:53');

--
-- Extraindo dados da tabela `MAILS`
--

INSERT INTO `MAILS` (`MAI_ID`, `MAI_PES_ID`, `MAI_TIPO`, `MAI_EMAIL`, `MAI_DATA_ATUALIZADO`) VALUES
(1, -2, 'P', 'eu@andersonrosa.com.br', '2024-10-26 08:58:43'),
(2, 10, 'P', 'pegalixo123@gmail.com', '2024-10-28 04:18:16'),
(4, 14, 'P', 'hawking@space.com', '2024-11-04 01:52:39'),
(5, 15, 'P', '123456789@gmail.com', '2024-11-04 02:44:22');

--
-- Extraindo dados da tabela `PESSOAS`
--

INSERT INTO `PESSOAS` (`PES_ID`, `PES_INC`, `PES_STATUS`, `PES_TIPO`, `PES_USER`, `PES_DOC`, `PES_NOME`, `PES_NASCIMENTO`, `PES_GENERO`, `PES_PROFISSAO`, `PES_AVATAR`, `PES_DATA_ATUALIZADO`) VALUES
(-5, '2024-07-19 21:37:43', '1', 'C', 'S', '41735280000163', 'Master', NULL, 'N', NULL, NULL, '2024-07-19 21:37:43'),
(-2, '2024-10-26 08:54:16', '1', 'P', 'S', '26519434876', 'Anderson Rosa', '1979-07-31', 'N', NULL, NULL, '2024-10-26 08:54:16'),
(1, '2024-07-19 22:16:40', '1', 'P', 'N', '', 'Ana Carolina dos Santos Rosa', '1983-07-26', 'N', 'Esteticista', NULL, '2024-07-19 22:16:40'),
(10, '2024-10-28 04:17:57', '1', 'C', 'N', '', 'Marcus Aurelius', '0121-04-26', 'N', '', '', '2024-10-28 04:17:57'),
(13, '2024-11-02 03:56:41', '1', 'C', 'N', '', 'Albert Einstein', '1879-03-14', 'N', '', '', '2024-11-02 03:56:41'),
(14, '2024-11-04 01:52:39', '1', 'C', 'N', '', 'Stephen William Hawking', '1942-01-08', 'N', '', '', '2024-11-04 01:52:39'),
(15, '2024-11-04 02:44:22', '1', 'C', 'N', '', 'Marie Curie', '1996-11-07', 'N', '', '', '2024-11-04 02:44:22'),
(16, '2024-11-05 07:58:42', '1', 'C', 'N', '12345678901', 'João da Silva', '1985-01-15', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(17, '2024-11-05 07:58:42', '1', 'C', 'N', '98765432100', 'Maria Oliveira', '1990-03-22', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(18, '2024-11-05 07:58:42', '1', 'C', 'N', '11223344556', 'Carlos Souza', '1983-07-30', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(19, '2024-11-05 07:58:42', '1', 'C', 'N', '22334455667', 'Ana Pereira', '1992-11-12', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(20, '2024-11-05 07:58:42', '1', 'C', 'N', '33445566778', 'Fernanda Costa', '1987-09-09', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(21, '2024-11-05 07:58:42', '1', 'C', 'N', '44556677889', 'Roberto Lima', '1980-02-28', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(22, '2024-11-05 07:58:42', '1', 'C', 'N', '55667788990', 'Patrícia Martins', '1988-05-05', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(23, '2024-11-05 07:58:42', '1', 'C', 'N', '66778899011', 'Marcos Almeida', '1995-04-17', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(24, '2024-11-05 07:58:42', '1', 'C', 'N', '77889900122', 'Juliana Santos', '1991-06-25', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(25, '2024-11-05 07:58:42', '1', 'C', 'N', '88990011233', 'Pedro Henrique', '1986-08-19', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(26, '2024-11-05 07:58:42', '1', 'C', 'N', '99001122344', 'Luciana Ribeiro', '1994-10-02', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(27, '2024-11-05 07:58:42', '1', 'C', 'N', '10111223355', 'Ricardo Pires', '1982-12-30', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(28, '2024-11-05 07:58:42', '1', 'C', 'N', '12131424566', 'Valeria Amaral', '1993-02-13', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(29, '2024-11-05 07:58:42', '1', 'C', 'N', '13141535677', 'José Fernandes', '1989-07-04', 'N', NULL, NULL, '2024-11-05 07:58:42'),
(30, '2024-11-05 07:58:42', '1', 'C', 'N', '14161746788', 'Gustavo Rocha', '1996-05-20', 'N', NULL, NULL, '2024-11-05 07:58:42');

--
-- Extraindo dados da tabela `PRC_CATEGORIAS`
--

INSERT INTO `PRC_CATEGORIAS` (`CAT_ID`, `CAT_INC`, `CAT_STATUS`, `CAT_NOME`, `CAT_DESC`, `CAT_DATA_ATUALIZADO`) VALUES
(1, '2024-07-15 19:42:48', '1', 'Extensão de cílios', 'Serviço de aplicação de cílios sintéticos para alongamento dos naturais', '2024-07-15 19:42:48'),
(2, '2024-07-15 19:42:48', '1', 'Limpeza de pele', 'Procedimento estético para limpeza profunda da pele do rosto', '2024-07-15 19:42:48'),
(3, '2024-07-15 19:42:48', '1', 'Depilação', 'Remoção de pelos corporais por diferentes métodos', '2024-07-15 19:42:48'),
(4, '2024-07-15 19:42:48', '1', 'Microagulhamento', 'Tratamento estético com microagulhas para estimular a produção de colágeno', '2024-07-15 19:42:48'),
(5, '2024-07-15 19:42:48', '1', 'Peeling', 'Procedimento de renovação celular por meio da aplicação de substâncias químicas ou físicas', '2024-07-15 19:42:48');

--
-- Extraindo dados da tabela `PROCEDIMENTOS`
--

INSERT INTO `PROCEDIMENTOS` (`PRC_ID`, `PRC_PRF_ID`, `PRC_EQP_ID`, `PRC_CAT_ID`, `PRC_INC`, `PRC_STATUS`, `PRC_NOME`, `PRC_DESC`, `PRC_DURACAO`, `PRC_VALOR`, `PRC_REQUISITO`, `PRC_CUIDADOS`, `PRC_RISCOS`, `PRC_DATA_ATUALIZADO`) VALUES
(1, NULL, NULL, 1, '2024-07-15 19:56:50', '1', 'Extensão de cílios Volume Brasileiro', 'Aplicação de cílios sintéticos para criar um volume natural e destacado ao estilo brasileiro.', 120, 150.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', '2024-07-15 22:18:38'),
(2, NULL, NULL, 1, '2024-07-15 19:56:50', '1', 'Extensão de cílios Volume Egípcio', 'Aplicação de cílios sintéticos para proporcionar um volume intenso e dramático ao estilo egípcio.', 120, 160.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', '2024-07-15 22:18:42'),
(3, NULL, NULL, 1, '2024-07-15 19:56:50', '1', 'Extensão de cílios Volume inglês (4,5D)', 'Aplicação de cílios sintéticos para obter um volume denso e sofisticado ao estilo inglês com 4,5D.', 120, 180.00, 'Nenhum', 'Evitar molhar os cílios nas primeiras 24 horas.', 'Possível irritação ocular.', '2024-07-15 22:18:46'),
(4, NULL, NULL, 2, '2024-07-15 19:56:50', '1', 'Limpeza de pele', 'Procedimento estético que realiza uma limpeza profunda e revigorante da pele do rosto, removendo impurezas e células mortas.', 60, 120.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível vermelhidão temporária.', '2024-07-15 22:18:49'),
(5, NULL, NULL, 3, '2024-07-15 19:56:50', '1', 'Depilação com cera', 'Remoção eficiente e rápida dos pelos corporais utilizando cera quente ou fria, garantindo uma pele lisa e livre de pelos.', 30, 80.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível irritação cutânea.', '2024-07-15 19:56:50'),
(6, NULL, NULL, 3, '2024-07-15 19:56:50', '1', 'Depilação com linha', 'Método preciso de remoção de pelos utilizando linha de algodão, ideal para áreas delicadas do rosto e corpo.', 45, 90.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 24 horas.', 'Possível irritação cutânea.', '2024-07-15 19:56:50'),
(7, NULL, NULL, 4, '2024-07-15 19:56:50', '1', 'Microagulhamento', 'Tratamento estético avançado que utiliza microagulhas para estimular a produção de colágeno e melhorar a textura da pele.', 60, 220.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível vermelhidão e inchaço temporários.', '2024-07-15 22:19:10'),
(8, NULL, NULL, 5, '2024-07-15 19:56:50', '1', 'Peeling de Diamante', 'Procedimento de esfoliação profunda que utiliza uma ponteira de diamante para renovar a pele, removendo células mortas e impurezas.', 60, 90.00, 'Nenhum', 'Evitar exposição ao sol nas primeiras 48 horas.', 'Possível descamação e vermelhidão.', '2024-07-15 22:19:19');

--
-- Extraindo dados da tabela `PROFISSIONAIS`
--

INSERT INTO `PROFISSIONAIS` (`PRF_ID`, `PRF_PES_ID`, `PRF_STATUS`, `PRF_DATA_ATUALIZADO`) VALUES
(1, 1, '1', '2024-10-31 19:35:04');

--
-- Extraindo dados da tabela `TELEFONES`
--

INSERT INTO `TELEFONES` (`TEL_ID`, `TEL_PES_ID`, `TEL_TIPO`, `TEL_DDI`, `TEL_DDD`, `TEL_TELEFONE`, `TEL_DATA_ATUALIZADO`) VALUES
(1, -2, 'P', '55', '14', '999065400', '2024-10-26 09:20:28'),
(3, 10, 'P', '55', '14', '99165-9298', '2024-11-03 08:18:51'),
(4, 13, 'P', '55', '14', '99617-7820', '2024-11-02 05:58:10'),
(5, 14, 'P', '55', '14', '996905500', '2024-11-04 01:52:39'),
(6, 15, 'P', '55', '14', '98172-3448', '2024-11-04 02:44:22'),
(7, 16, 'P', '55', '11', '91234-5678', '2024-11-05 08:03:29'),
(8, 17, 'P', '55', '21', '99876-5432', '2024-11-05 08:03:29'),
(9, 18, 'P', '55', '31', '98765-4321', '2024-11-05 08:03:29'),
(10, 19, 'P', '55', '41', '99988-7766', '2024-11-05 08:03:29'),
(11, 20, 'P', '55', '51', '93456-7890', '2024-11-05 08:03:29'),
(12, 21, 'P', '55', '61', '96123-4567', '2024-11-05 08:03:29'),
(13, 22, 'P', '55', '14', '999065400', '2024-11-05 08:03:29'),
(14, 23, 'P', '55', '71', '97345-6789', '2024-11-05 08:03:29'),
(15, 24, 'P', '55', '81', '96111-2233', '2024-11-05 08:03:29'),
(16, 25, 'P', '55', '85', '99999-0000', '2024-11-05 08:03:29'),
(17, 26, 'P', '55', '91', '98000-1111', '2024-11-05 08:03:29'),
(18, 27, 'P', '55', '98', '99555-6666', '2024-11-05 08:03:29'),
(19, 28, 'P', '55', '14', '99785-0275', '2024-11-05 08:03:29'),
(20, 29, 'P', '55', '82', '94567-1234', '2024-11-05 08:03:29'),
(21, 30, 'P', '55', '83', '96789-4321', '2024-11-05 08:03:29');

--
-- Extraindo dados da tabela `USUARIOS`
--

INSERT INTO `USUARIOS` (`USU_ID`, `USU_PES_ID`, `USU_STATUS`, `USU_TIPO`, `USU_SENHA`, `USU_DATA_ATUALIZADO`) VALUES
(1, -5, '1', 'M', '123', '2024-07-19 21:42:31'),
(2, 1, '1', 'M', '123', '2024-10-25 16:46:23');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
