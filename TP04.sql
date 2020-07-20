-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2020 at 05:12 PM
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
  `b_id_item` int(11) NOT NULL,
  PRIMARY KEY (`b_id`),
  KEY `FK_supp_bon` (`b_id_supp`) USING BTREE,
  KEY `FK_item_bon` (`b_id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `t_bon`:
--   `b_id_supp`
--       `t_supplier` -> `s_id`
--   `b_id_item`
--       `t_item` -> `i_id`
--

--
-- Dumping data for table `t_bon`
--

INSERT INTO `t_bon` (`b_id`, `b_number`, `b_date_ord`, `b_delai`, `b_id_supp`, `b_id_item`) VALUES
(1, 3, '2020-07-20 15:10:50', 3, 1, 1),
(2, 4, '2020-07-20 15:10:50', 3, 1, 5),
(3, 1, '2020-07-20 15:10:50', 3, 1, 7);

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
  `i_id_supp` int(11) NOT NULL,
  PRIMARY KEY (`i_id`),
  KEY `FK_supp_item` (`i_id_supp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `t_item`:
--   `i_id_supp`
--       `t_supplier` -> `s_id`
--

--
-- Dumping data for table `t_item`
--

INSERT INTO `t_item` (`i_id`, `i_ref`, `i_designation`, `i_price`, `i_id_supp`) VALUES
(1, 'A01', 'Drill P1', '74.99', 1),
(2, 'F01', 'Brass bolt 4 x 40 mm (bag of 10)', '2.25', 2),
(3, 'F02', 'Brass bolt 5 x 40 mm (bag of 10)', '4.45', 2),
(4, 'D01', 'Brass bolt 5 x 40 mm (bag of 10)', '4.40', 3),
(5, 'A02', 'Grinder 125mm', '37.85', 1),
(6, 'D03', 'Zinc plated steel bolt 4 x 40mm (bag of 10)', '1.80', 3),
(7, 'A03', 'Column Drill', '185.25', 3),
(8, 'D04', 'Wooden Wicks Box', '12.25', 3),
(9, 'F03', 'Flat Wicks Box', '6.25', 2),
(10, 'F04', 'Countersinks', '8.14', 2);

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
-- Dumping data for table `t_supplier`
--

INSERT INTO `t_supplier` (`s_id`, `s_name`) VALUES
(1, 'French Imports '),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_bon`
--
ALTER TABLE `t_bon`
  ADD CONSTRAINT `FK_bon_supp` FOREIGN KEY (`b_id_supp`) REFERENCES `t_supplier` (`s_id`),
  ADD CONSTRAINT `FK_item_bon` FOREIGN KEY (`b_id_item`) REFERENCES `t_item` (`i_id`);

--
-- Constraints for table `t_compo`
--
ALTER TABLE `t_compo`
  ADD CONSTRAINT `FK_comp_bon` FOREIGN KEY (`c_id_bon`) REFERENCES `t_bon` (`b_id`),
  ADD CONSTRAINT `FK_comp_item` FOREIGN KEY (`c_id_item`) REFERENCES `t_item` (`i_id`);

--
-- Constraints for table `t_item`
--
ALTER TABLE `t_item`
  ADD CONSTRAINT `FK_supp_item` FOREIGN KEY (`i_id_supp`) REFERENCES `t_supplier` (`s_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
