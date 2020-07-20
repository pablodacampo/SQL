-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2020 at 04:20 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tp01`
--
CREATE DATABASE IF NOT EXISTS `tp01` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tp01`;

-- --------------------------------------------------------

--
-- Table structure for table `t_bon`
--

DROP TABLE IF EXISTS `t_bon`;
CREATE TABLE IF NOT EXISTS `t_bon` (
  `b_id` int(10) NOT NULL,
  `b_number` int(10) NOT NULL,
  `b_date_ord` timestamp NOT NULL DEFAULT current_timestamp(),
  `b_delai` int(10) NOT NULL,
  `b_id_supp` int(11) NOT NULL,
  PRIMARY KEY (`b_id`),
  KEY `FK_supp_bon` (`b_id_supp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `t_bon`:
--   `b_id_supp`
--       `t_supplier` -> `s_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `t_compo`
--

DROP TABLE IF EXISTS `t_compo`;
CREATE TABLE IF NOT EXISTS `t_compo` (
  `c_id` int(10) NOT NULL AUTO_INCREMENT,
  `c_quantity` int(10) NOT NULL,
  `c_id_item` int(11) NOT NULL,
  `c_id_bon` int(11) NOT NULL,
  PRIMARY KEY (`c_id`),
  KEY `FK_bon_comp` (`c_id_bon`) USING BTREE,
  KEY `FK_item_comp` (`c_id_item`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `t_compo`:
--   `c_id_bon`
--       `t_bon` -> `b_id`
--   `c_id_item`
--       `t_item` -> `i_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `t_item`
--

DROP TABLE IF EXISTS `t_item`;
CREATE TABLE IF NOT EXISTS `t_item` (
  `i_id` int(10) NOT NULL,
  `i_ref` varchar(13) NOT NULL,
  `i_designation` varchar(255) NOT NULL,
  `i_price` decimal(7,2) NOT NULL,
  PRIMARY KEY (`i_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `t_item`:
--

-- --------------------------------------------------------

--
-- Table structure for table `t_supplier`
--

DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE IF NOT EXISTS `t_supplier` (
  `s_id` int(10) NOT NULL,
  `s_name` varchar(50) NOT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `t_supplier`:
--

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_bon`
--
ALTER TABLE `t_bon`
  ADD CONSTRAINT `FK_bon_supp` FOREIGN KEY (`b_id_supp`) REFERENCES `t_supplier` (`s_id`);

--
-- Constraints for table `t_compo`
--
ALTER TABLE `t_compo`
  ADD CONSTRAINT `FK_comp_bon` FOREIGN KEY (`c_id_bon`) REFERENCES `t_bon` (`b_id`),
  ADD CONSTRAINT `FK_comp_item` FOREIGN KEY (`c_id_item`) REFERENCES `t_item` (`i_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
