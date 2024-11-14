-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 14-Nov-2024 às 15:58
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
  `ATD_DATA` date NOT NULL,
  `ATD_HORA` time NOT NULL,
  `ATD_DURACAO` int(11) NOT NULL,
  `ATD_VALOR` decimal(10,2) NOT NULL,
  `ATD_OBSERVACOES` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ATD_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ATENDIMENTOS_PESS`
--

CREATE TABLE `ATENDIMENTOS_PESS` (
  `APS_ID` bigint(20) NOT NULL,
  `APS_ATD_ID` int(11) NOT NULL,
  `APS_PES_ID` int(11) NOT NULL,
  `APS_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ATENDIMENTOS_PROC`
--

CREATE TABLE `ATENDIMENTOS_PROC` (
  `APC_ID` bigint(20) NOT NULL,
  `APC_ATD_ID` int(11) NOT NULL,
  `APC_PRC_ID` int(11) NOT NULL,
  `APC_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ATENDIMENTOS_PROF`
--

CREATE TABLE `ATENDIMENTOS_PROF` (
  `APF_ID` bigint(20) NOT NULL,
  `APF_ATD_ID` int(11) NOT NULL,
  `APF_PRF_ID` smallint(11) NOT NULL,
  `APF_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ENDERECOS`
--

CREATE TABLE `ENDERECOS` (
  `END_ID` int(11) NOT NULL,
  `END_PES_ID` int(11) NOT NULL,
  `END_TIPO` enum('P','E','C','T') COLLATE utf8mb3_unicode_ci DEFAULT 'P',
  `END_CEP` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `END_CIDADE` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `END_UF` varchar(2) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_LOGRADOURO` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `END_NUMERO` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_BAIRRO` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_COMPLEMENTO` varchar(200) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `END_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `FORMA_PGTO`
--

CREATE TABLE `FORMA_PGTO` (
  `FPG_ID` smallint(6) NOT NULL,
  `FPG_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `FPG_NOME` varchar(75) COLLATE utf8mb3_unicode_ci NOT NULL,
  `FPG_NOME_SCE` varchar(75) COLLATE utf8mb3_unicode_ci NOT NULL,
  `FPG_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `MAILS`
--

CREATE TABLE `MAILS` (
  `MAI_ID` int(11) NOT NULL,
  `MAI_PES_ID` int(11) NOT NULL,
  `MAI_TIPO` enum('P','O') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'P',
  `MAI_EMAIL` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `MAI_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `PESSOAS`
--

CREATE TABLE `PESSOAS` (
  `PES_ID` int(11) NOT NULL,
  `PES_INC` timestamp NOT NULL DEFAULT current_timestamp(),
  `PES_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `PES_TIPO` enum('C','P') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'C',
  `PES_USER` enum('N','S') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'N',
  `PES_DOC` varchar(14) COLLATE utf8mb3_unicode_ci NOT NULL,
  `PES_NOME` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `PES_NASCIMENTO` date DEFAULT NULL,
  `PES_GENERO` enum('M','F','N') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'N',
  `PES_PROFISSAO` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PES_AVATAR` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PES_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `PRC_CATEGORIAS`
--

CREATE TABLE `PRC_CATEGORIAS` (
  `CAT_ID` int(11) NOT NULL,
  `CAT_INC` timestamp NOT NULL DEFAULT current_timestamp(),
  `CAT_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `CAT_NOME` varchar(75) COLLATE utf8mb3_unicode_ci NOT NULL,
  `CAT_DESC` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `CAT_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `PROCEDIMENTOS`
--

CREATE TABLE `PROCEDIMENTOS` (
  `PRC_ID` int(11) NOT NULL,
  `PRC_PRF_ID` int(11) DEFAULT NULL,
  `PRC_EQP_ID` int(11) DEFAULT NULL,
  `PRC_CAT_ID` int(11) NOT NULL,
  `PRC_INC` timestamp NOT NULL DEFAULT current_timestamp(),
  `PRC_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `PRC_NOME` varchar(75) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_DESC` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_DURACAO` smallint(6) NOT NULL DEFAULT 0,
  `PRC_VALOR` float(10,2) DEFAULT NULL,
  `PRC_REQUISITO` varchar(250) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_CUIDADOS` varchar(250) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_RISCOS` varchar(250) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `PRC_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `PROFISSIONAIS`
--

CREATE TABLE `PROFISSIONAIS` (
  `PRF_ID` smallint(11) NOT NULL,
  `PRF_PES_ID` int(11) NOT NULL,
  `PRF_STATUS` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `PRF_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `TELEFONES`
--

CREATE TABLE `TELEFONES` (
  `TEL_ID` int(11) NOT NULL,
  `TEL_PES_ID` int(11) NOT NULL,
  `TEL_TIPO` enum('P','O') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'P',
  `TEL_DDI` varchar(3) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '55',
  `TEL_DDD` varchar(3) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `TEL_TELEFONE` varchar(15) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `TEL_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `USUARIOS`
--

CREATE TABLE `USUARIOS` (
  `USU_ID` tinyint(4) NOT NULL,
  `USU_PES_ID` int(11) NOT NULL,
  `USU_STATUS` char(1) COLLATE utf8mb3_unicode_ci NOT NULL,
  `USU_TIPO` enum('M','A','U') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'U',
  `USU_SENHA` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `USU_DATA_ATUALIZADO` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

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
-- Índices para tabela `ATENDIMENTOS_PESS`
--
ALTER TABLE `ATENDIMENTOS_PESS`
  ADD PRIMARY KEY (`APS_ID`),
  ADD KEY `FK_APS_PES` (`APS_PES_ID`),
  ADD KEY `FK_APS_ATD` (`APS_ATD_ID`);

--
-- Índices para tabela `ATENDIMENTOS_PROC`
--
ALTER TABLE `ATENDIMENTOS_PROC`
  ADD PRIMARY KEY (`APC_ID`),
  ADD KEY `FK_PRC_APC` (`APC_PRC_ID`),
  ADD KEY `FK_ATD_APC` (`APC_ATD_ID`);

--
-- Índices para tabela `ATENDIMENTOS_PROF`
--
ALTER TABLE `ATENDIMENTOS_PROF`
  ADD PRIMARY KEY (`APF_ID`),
  ADD KEY `FK_APF_ATD` (`APF_ATD_ID`),
  ADD KEY `FK_APF_PRF` (`APF_PRF_ID`);

--
-- Índices para tabela `ENDERECOS`
--
ALTER TABLE `ENDERECOS`
  ADD PRIMARY KEY (`END_ID`),
  ADD KEY `FK_END_PES` (`END_PES_ID`);

--
-- Índices para tabela `FORMA_PGTO`
--
ALTER TABLE `FORMA_PGTO`
  ADD PRIMARY KEY (`FPG_ID`);

--
-- Índices para tabela `MAILS`
--
ALTER TABLE `MAILS`
  ADD PRIMARY KEY (`MAI_ID`),
  ADD KEY `FK_MAI_PES` (`MAI_PES_ID`);

--
-- Índices para tabela `PESSOAS`
--
ALTER TABLE `PESSOAS`
  ADD PRIMARY KEY (`PES_ID`);

--
-- Índices para tabela `PRC_CATEGORIAS`
--
ALTER TABLE `PRC_CATEGORIAS`
  ADD PRIMARY KEY (`CAT_ID`);

--
-- Índices para tabela `PROCEDIMENTOS`
--
ALTER TABLE `PROCEDIMENTOS`
  ADD PRIMARY KEY (`PRC_ID`),
  ADD KEY `FK_PRC_CAT` (`PRC_CAT_ID`);

--
-- Índices para tabela `PROFISSIONAIS`
--
ALTER TABLE `PROFISSIONAIS`
  ADD PRIMARY KEY (`PRF_ID`),
  ADD KEY `FK_PRF_PES` (`PRF_PES_ID`);

--
-- Índices para tabela `TELEFONES`
--
ALTER TABLE `TELEFONES`
  ADD PRIMARY KEY (`TEL_ID`),
  ADD KEY `FK_TEL_PES` (`TEL_PES_ID`);

--
-- Índices para tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD PRIMARY KEY (`USU_ID`),
  ADD KEY `FK_USU_PES` (`USU_PES_ID`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `ATENDIMENTOS`
--
ALTER TABLE `ATENDIMENTOS`
  MODIFY `ATD_ID` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `FPG_ID` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `MAILS`
--
ALTER TABLE `MAILS`
  MODIFY `MAI_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `PESSOAS`
--
ALTER TABLE `PESSOAS`
  MODIFY `PES_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `PRC_CATEGORIAS`
--
ALTER TABLE `PRC_CATEGORIAS`
  MODIFY `CAT_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `PROCEDIMENTOS`
--
ALTER TABLE `PROCEDIMENTOS`
  MODIFY `PRC_ID` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `USU_ID` tinyint(4) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `ATENDIMENTOS`
--
ALTER TABLE `ATENDIMENTOS`
  ADD CONSTRAINT `FK_ATENDIMENTOS` FOREIGN KEY (`ATD_FPG_ID`) REFERENCES `FORMA_PGTO` (`FPG_ID`);

--
-- Limitadores para a tabela `ATENDIMENTOS_PESS`
--
ALTER TABLE `ATENDIMENTOS_PESS`
  ADD CONSTRAINT `FK_APS_ATD` FOREIGN KEY (`APS_ATD_ID`) REFERENCES `ATENDIMENTOS` (`ATD_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_APS_PES` FOREIGN KEY (`APS_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Limitadores para a tabela `ATENDIMENTOS_PROC`
--
ALTER TABLE `ATENDIMENTOS_PROC`
  ADD CONSTRAINT `FK_ATD_APC` FOREIGN KEY (`APC_ATD_ID`) REFERENCES `ATENDIMENTOS` (`ATD_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_PRC_APC` FOREIGN KEY (`APC_PRC_ID`) REFERENCES `PROCEDIMENTOS` (`PRC_ID`);

--
-- Limitadores para a tabela `ATENDIMENTOS_PROF`
--
ALTER TABLE `ATENDIMENTOS_PROF`
  ADD CONSTRAINT `FK_APF_ATD` FOREIGN KEY (`APF_ATD_ID`) REFERENCES `ATENDIMENTOS` (`ATD_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_APF_PRF` FOREIGN KEY (`APF_PRF_ID`) REFERENCES `PROFISSIONAIS` (`PRF_ID`);

--
-- Limitadores para a tabela `ENDERECOS`
--
ALTER TABLE `ENDERECOS`
  ADD CONSTRAINT `FK_END_PES` FOREIGN KEY (`END_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Limitadores para a tabela `MAILS`
--
ALTER TABLE `MAILS`
  ADD CONSTRAINT `FK_MAI_PES` FOREIGN KEY (`MAI_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Limitadores para a tabela `PROCEDIMENTOS`
--
ALTER TABLE `PROCEDIMENTOS`
  ADD CONSTRAINT `FK_PRC_CAT` FOREIGN KEY (`PRC_CAT_ID`) REFERENCES `PRC_CATEGORIAS` (`CAT_ID`);

--
-- Limitadores para a tabela `PROFISSIONAIS`
--
ALTER TABLE `PROFISSIONAIS`
  ADD CONSTRAINT `FK_PRF_PES` FOREIGN KEY (`PRF_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Limitadores para a tabela `TELEFONES`
--
ALTER TABLE `TELEFONES`
  ADD CONSTRAINT `FK_TEL_PES` FOREIGN KEY (`TEL_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);

--
-- Limitadores para a tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD CONSTRAINT `FK_USU_PES` FOREIGN KEY (`USU_PES_ID`) REFERENCES `PESSOAS` (`PES_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
