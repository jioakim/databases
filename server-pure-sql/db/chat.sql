-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: chat
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

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
-- Current Database: `chat`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `chat` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `chat`;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `text` mediumtext,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `uid_users` int(11) DEFAULT NULL,
  `rid_rooms` int(11) DEFAULT NULL,
  PRIMARY KEY (`mid`),
  KEY `uid_users` (`uid_users`),
  KEY `rid_rooms` (`rid_rooms`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`uid_users`) REFERENCES `users` (`uid`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`rid_rooms`) REFERENCES `rooms` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (2,'Men like you can never change!','2017-08-06 15:55:30','2017-08-06 15:55:30',1,1),(3,'It is all in how you say it!','2016-07-23 04:00:00','2016-07-23 04:00:00',2,2),(4,'Another test','2017-08-06 16:34:44','2017-08-06 16:34:44',1,2),(5,'Another test again','2017-08-06 16:34:54','2017-08-06 16:34:54',2,1),(6,'Another test again three times','2017-08-06 16:35:05','2017-08-06 16:35:05',2,2),(7,'Another test again four times','2017-08-06 16:47:21','2017-08-06 16:47:21',1,1),(8,'Another test again five times','2015-09-10 04:00:00','2017-08-06 16:47:27',1,1),(9,'Another test again six times','2015-10-10 04:00:00','2017-08-06 16:47:32',1,1),(10,'Another test again 13:11','2017-08-06 17:11:59','2017-08-06 17:11:59',1,1),(11,'Another test again 13:12','2017-08-06 17:12:06','2017-08-06 17:12:06',1,1),(12,'Another test again 13:13','2017-08-06 17:13:22','2017-08-06 17:13:22',1,2),(13,'Another test again 13:14','2017-08-06 17:14:01','2017-08-06 17:14:01',1,2);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `roomname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'main'),(2,'lobby');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Valjean'),(2,'Kevin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_rooms`
--

DROP TABLE IF EXISTS `users_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_rooms` (
  `urid` int(11) NOT NULL AUTO_INCREMENT,
  `uid_users` int(11) DEFAULT NULL,
  `rid_rooms` int(11) DEFAULT NULL,
  PRIMARY KEY (`urid`),
  KEY `uid_users` (`uid_users`),
  KEY `rid_rooms` (`rid_rooms`),
  CONSTRAINT `users_rooms_ibfk_1` FOREIGN KEY (`uid_users`) REFERENCES `users` (`uid`),
  CONSTRAINT `users_rooms_ibfk_2` FOREIGN KEY (`rid_rooms`) REFERENCES `rooms` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_rooms`
--

LOCK TABLES `users_rooms` WRITE;
/*!40000 ALTER TABLE `users_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_rooms` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-06 21:35:47
