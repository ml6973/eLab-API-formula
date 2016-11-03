-- MySQL dump 10.16  Distrib 10.1.13-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: oci_eLab
-- ------------------------------------------------------
-- Server version	10.1.13-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `oci_eLab`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `oci_eLab` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `oci_eLab`;

--
-- Table structure for table `Registration`
--

DROP TABLE IF EXISTS `Registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Registration` (
  `userId` int(11) NOT NULL,
  `complete` tinyint(1) DEFAULT '0',
  KEY `userId` (`userId`),
  CONSTRAINT `Registration_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registration`
--

LOCK TABLES `Registration` WRITE;
/*!40000 ALTER TABLE `Registration` DISABLE KEYS */;
INSERT INTO `Registration` VALUES (2,1);
/*!40000 ALTER TABLE `Registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserData`
--

DROP TABLE IF EXISTS `UserData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserData` (
  `userId` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vmPassword` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `messengerId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `userId` (`userId`),
  CONSTRAINT `UserData_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserData`
--

LOCK TABLES `UserData` WRITE;
/*!40000 ALTER TABLE `UserData` DISABLE KEYS */;
INSERT INTO `UserData` VALUES (2,'test@gdail.com','oci','456');
/*!40000 ALTER TABLE `UserData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `facebookId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `passwordHash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userId` (`userId`),
  UNIQUE KEY `userName` (`userName`),
  UNIQUE KEY `facebookId` (`facebookId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (2,NULL,'paul_rad','$2y$10$Z7qnZ1ogDw3vfIoIbV2Txe7F/Qc/PlU9kVXCK8.701lXXQER9bMNa','2016-10-24 15:43:53');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-02 18:21:14

