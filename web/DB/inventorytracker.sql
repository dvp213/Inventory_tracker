-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2023 at 08:33 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventorytracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `addremove`
--

CREATE TABLE `addremove` (
  `ARID` varchar(10) NOT NULL,
  `SKID` varchar(10) NOT NULL,
  `SID` varchar(10) NOT NULL,
  `itemID` varchar(10) NOT NULL,
  `Quantity` varchar(30) NOT NULL,
  `Date` date NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `itemID` varchar(10) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `type` varchar(30) NOT NULL,
  `UnitPrice` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `marketingteam`
--

CREATE TABLE `marketingteam` (
  `MID` varchar(10) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phonoNo` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `releaseitem`
--

CREATE TABLE `releaseitem` (
  `RLID` varchar(10) NOT NULL,
  `SKID` varchar(10) NOT NULL,
  `MID` varchar(10) NOT NULL,
  `itemID` varchar(10) NOT NULL,
  `Quantity` varchar(30) NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `requestitems`
--

CREATE TABLE `requestitems` (
  `RID` varchar(10) NOT NULL,
  `SKID` varchar(10) NOT NULL,
  `SID` varchar(10) NOT NULL,
  `itemID` varchar(10) NOT NULL,
  `Quantity` varchar(30) NOT NULL,
  `Date` date NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `StockID` varchar(10) NOT NULL,
  `Location` varchar(500) NOT NULL,
  `FullCapacity` varchar(50) NOT NULL,
  `StoredCapacity` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `stockkeeper`
--

CREATE TABLE `stockkeeper` (
  `SKID` varchar(10) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phonoNo` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `SID` varchar(10) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phonoNo` varchar(10) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `supply`
--

CREATE TABLE `supply` (
  `SupplyID` varchar(10) NOT NULL,
  `SID` varchar(10) NOT NULL,
  `itemID` varchar(10) NOT NULL,
  `SKID` varchar(10) NOT NULL,
  `Quantity` varchar(30) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addremove`
--
ALTER TABLE `addremove`
  ADD PRIMARY KEY (`ARID`),
  ADD KEY `SKID` (`SKID`),
  ADD KEY `SID` (`SID`),
  ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `marketingteam`
--
ALTER TABLE `marketingteam`
  ADD PRIMARY KEY (`MID`);

--
-- Indexes for table `releaseitem`
--
ALTER TABLE `releaseitem`
  ADD PRIMARY KEY (`RLID`),
  ADD KEY `itemID` (`itemID`),
  ADD KEY `SKID` (`SKID`),
  ADD KEY `MID` (`MID`);

--
-- Indexes for table `requestitems`
--
ALTER TABLE `requestitems`
  ADD KEY `SKID` (`SKID`),
  ADD KEY `SID` (`SID`),
  ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`StockID`);

--
-- Indexes for table `stockkeeper`
--
ALTER TABLE `stockkeeper`
  ADD PRIMARY KEY (`SKID`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`SID`);

--
-- Indexes for table `supply`
--
ALTER TABLE `supply`
  ADD PRIMARY KEY (`SupplyID`),
  ADD KEY `itemID` (`itemID`),
  ADD KEY `SKID` (`SKID`),
  ADD KEY `SID` (`SID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addremove`
--
ALTER TABLE `addremove`
  ADD CONSTRAINT `addremove_ibfk_1` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `addremove_ibfk_10` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `addremove_ibfk_11` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`),
  ADD CONSTRAINT `addremove_ibfk_12` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`),
  ADD CONSTRAINT `addremove_ibfk_13` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `addremove_ibfk_14` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`),
  ADD CONSTRAINT `addremove_ibfk_15` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`),
  ADD CONSTRAINT `addremove_ibfk_2` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`),
  ADD CONSTRAINT `addremove_ibfk_3` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`),
  ADD CONSTRAINT `addremove_ibfk_4` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `addremove_ibfk_5` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`),
  ADD CONSTRAINT `addremove_ibfk_6` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`),
  ADD CONSTRAINT `addremove_ibfk_7` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `addremove_ibfk_8` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`),
  ADD CONSTRAINT `addremove_ibfk_9` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`);

--
-- Constraints for table `releaseitem`
--
ALTER TABLE `releaseitem`
  ADD CONSTRAINT `releaseitem_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`),
  ADD CONSTRAINT `releaseitem_ibfk_2` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `releaseitem_ibfk_3` FOREIGN KEY (`MID`) REFERENCES `marketingteam` (`MID`);

--
-- Constraints for table `requestitems`
--
ALTER TABLE `requestitems`
  ADD CONSTRAINT `requestitems_ibfk_1` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `requestitems_ibfk_2` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`),
  ADD CONSTRAINT `requestitems_ibfk_3` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`);

--
-- Constraints for table `supply`
--
ALTER TABLE `supply`
  ADD CONSTRAINT `supply_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`itemID`),
  ADD CONSTRAINT `supply_ibfk_2` FOREIGN KEY (`SKID`) REFERENCES `stockkeeper` (`SKID`),
  ADD CONSTRAINT `supply_ibfk_3` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
