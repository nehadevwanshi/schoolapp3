CREATE DATABASE  IF NOT EXISTS `schooldb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `schooldb`;
-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: schooldb
-- ------------------------------------------------------
-- Server version	5.5.42

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
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `room_number` varchar(45) DEFAULT NULL,
  `course_number` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `teachers_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_courses_teachers1_idx` (`teachers_id`),
  CONSTRAINT `fk_courses_teachers1` FOREIGN KEY (`teachers_id`) REFERENCES `teachers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_has_students`
--

DROP TABLE IF EXISTS `courses_has_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_has_students` (
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `fk_courses_has_students_students1_idx` (`student_id`),
  KEY `fk_courses_has_students_courses_idx` (`course_id`),
  CONSTRAINT `fk_courses_has_students_courses` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_has_students_students1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_has_students`
--

LOCK TABLES `courses_has_students` WRITE;
/*!40000 ALTER TABLE `courses_has_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_has_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` varchar(45) DEFAULT NULL,
  `students_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_messages_students1_idx` (`students_id`),
  KEY `fk_messages_post1_idx` (`post_id`),
  CONSTRAINT `fk_messages_students1` FOREIGN KEY (`students_id`) REFERENCES `students` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_post1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `students_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_students1_idx` (`students_id`),
  CONSTRAINT `fk_post_students1` FOREIGN KEY (`students_id`) REFERENCES `students` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `school_location` varchar(45) DEFAULT NULL,
  `pw` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'kcwdw','hellohello','hello@hello.com','66666666666','San Jose State','$2b$12$cRar3vOJEsdNm7Lp9olU7.qYe1FRU.MOwRGJh4UazSVmPjlXKBPAu'),(2,'kcwdw','hellohello','hello@hello.com','66666666666','San Jose State','$2b$12$Ies55.q99yKJNS6Mnde7g.VXeEJb4fA7URv5T.3NqpRKDMOttoQAC'),(3,'kcwdwssssss','hellohello','hello@hello.com','66666666666','San Jose State','$2b$12$Hukt78EIQQ./0wAG5hb9iOFhr00.z0XPMXuihftpY/HQ/8GqMiDGm'),(4,'Ish','Khan','me@gmail.com','5104619099','san jose state','$2b$12$8aV7wuSBOf/7D7b3.CTkmuiYtagyDJ..svTwn8d/pBvcf5tSSIpMi'),(5,'Ish','Khan','me@gmail.com','5104619099','san jose state','$2b$12$PBZJURvIQUrJfjEVjlki8u36XTE585cv7q2mz.5OXbIPlGrtVYJum');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `pw` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers_has_students`
--

DROP TABLE IF EXISTS `teachers_has_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers_has_students` (
  `teacher_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`teacher_id`,`student_id`),
  KEY `fk_teachers_has_students_students1_idx` (`student_id`),
  KEY `fk_teachers_has_students_teachers1_idx` (`teacher_id`),
  CONSTRAINT `fk_teachers_has_students_teachers1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_teachers_has_students_students1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers_has_students`
--

LOCK TABLES `teachers_has_students` WRITE;
/*!40000 ALTER TABLE `teachers_has_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachers_has_students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

DROP TABLE IF EXISTS `buildings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buildings` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '		',
  `building_name` varchar(45) DEFAULT NULL,
  `Lng` double(200,6) DEFAULT NULL,
  `Lat` double(200,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buildings`
--

LOCK TABLES `buildings` WRITE;
/*!40000 ALTER TABLE `buildings` DISABLE KEYS */;
INSERT INTO `buildings` VALUES (1,'BBC',37.336672,-121.878569),(2,'BT',37.337056,-121.878912),(3,'BK',37.336800,-121.880146),(4,'SU',37.336288,-121.881573),(5,'MUS',37.335759,-121.880844),(6,'CH',37.335495,-121.880865),(7,'ART',37.335862,-121.879878),(8,'EC',37.335324,-121.879964),(9,'HB',37.335734,-121.879170),(10,'BBC',37.336638,-121.878580),(11,'CP',37.336075,-121.878473),(12,'CVB',37.334958,-121.877325),(13,'CVA',37.334377,-121.877528),(14,'CVC',37.335444,-121.878204),(15,'JWH',37.334292,-121.878011),(16,'DC',37.334028,-121.878312),(17,'ASP',37.334369,-121.879642),(18,'HOV',37.334420,-121.880221),(19,'RYC',37.334011,-121.879342),(20,'WSH',37.336440,-121.879342),(21,'UPD',37.333328,-121.880243),(22,'South Garage',37.333004,-121.881155),(23,'DH',37.332612,-121.881959),(24,'West Garage',37.332407,-121.883032),(25,'ASH',37.333294,-121.882668),(26,'MQH',37.333550,-121.881766),(27,'SH',37.333780,-121.880854),(28,'FOB',37.334633,-121.882582),(29,'SPM',37.334249,-121.883354),(30,'YUH',37.333610,-121.883826),(31,'SPXC',37.334190,-121.882582),(32,'SPXE',37.334377,-121.881874),(33,'SWC',37.334761,-121.881241),(34,'CCB',37.335546,-121.881766),(35,'DBH',37.335128,-121.882335),(36,'MD',37.335239,-121.883193),(37,'CL',37.336186,-121.882442),(38,'CC',37.335981,-121.883247),(39,'SCI',37.334497,-121.884449),(40,'WSQ',37.334497,-121.884449),(41,'KING',37.335521,-121.885049),(42,'UT',37.336041,-121.884577),(43,'HGH',37.336041,-121.884577),(44,'DMH',37.336263,-121.883944),(45,'IRC',37.336263,-121.883944),(46,'CAR',37.336681,-121.882753),(47,'ADM',37.336681,-121.882753),(48,'ENG',37.337303,-121.881520),(49,'IS',37.337568,-121.880575);
/*!40000 ALTER TABLE `buildings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-28 14:35:00
