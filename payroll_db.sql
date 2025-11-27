CREATE DATABASE  IF NOT EXISTS `payroll_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `payroll_db`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: payroll_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-11-25 14:42:39.647593'),(2,'auth','0001_initial','2025-11-25 14:42:39.657774'),(3,'admin','0001_initial','2025-11-25 14:42:39.660863'),(4,'admin','0002_logentry_remove_auto_add','2025-11-25 14:42:39.663347'),(5,'admin','0003_logentry_add_action_flag_choices','2025-11-25 14:42:39.666570'),(6,'payroll','0001_initial','2025-11-25 14:42:39.669447'),(7,'users','0001_initial','2025-11-25 14:42:39.672028'),(8,'attendance','0001_initial','2025-11-25 14:42:39.675033'),(9,'attendance','0002_initial','2025-11-25 14:42:39.677855'),(10,'contenttypes','0002_remove_content_type_name','2025-11-25 14:42:39.680666'),(11,'auth','0002_alter_permission_name_max_length','2025-11-25 14:42:39.683531'),(12,'auth','0003_alter_user_email_max_length','2025-11-25 14:42:39.686036'),(13,'auth','0004_alter_user_username_opts','2025-11-25 14:42:39.688258'),(14,'auth','0005_alter_user_last_login_null','2025-11-25 14:42:39.690707'),(15,'auth','0006_require_contenttypes_0002','2025-11-25 14:42:39.693173'),(16,'auth','0007_alter_validators_add_error_messages','2025-11-25 14:42:39.696018'),(17,'auth','0008_alter_user_username_max_length','2025-11-25 14:42:39.698294'),(18,'auth','0009_alter_user_last_name_max_length','2025-11-25 14:42:39.700882'),(19,'auth','0010_alter_group_name_max_length','2025-11-25 14:42:39.703335'),(20,'auth','0011_update_proxy_permissions','2025-11-25 14:42:39.705822'),(21,'auth','0012_alter_user_first_name_max_length','2025-11-25 14:42:39.708519'),(22,'funds','0001_initial','2025-11-25 14:42:39.711831'),(23,'funds','0002_initial','2025-11-25 14:42:39.714814'),(24,'payroll','0002_initial','2025-11-25 14:42:39.717741'),(25,'sessions','0001_initial','2025-11-25 14:42:39.720561'),(26,'users','0002_alter_person_id','2025-11-25 14:42:39.723522');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_leave`
--

DROP TABLE IF EXISTS `employee_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_leave` (
  `leave_id` int NOT NULL,
  `leave_date` date NOT NULL,
  PRIMARY KEY (`leave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_leave`
--

LOCK TABLES `employee_leave` WRITE;
/*!40000 ALTER TABLE `employee_leave` DISABLE KEYS */;
INSERT INTO `employee_leave` VALUES (500,'2025-11-20');
/*!40000 ALTER TABLE `employee_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fund`
--

DROP TABLE IF EXISTS `fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fund` (
  `fund_id` int NOT NULL,
  `fund_amount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`fund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fund`
--

LOCK TABLES `fund` WRITE;
/*!40000 ALTER TABLE `fund` DISABLE KEYS */;
INSERT INTO `fund` VALUES (1,1999994000.00);
/*!40000 ALTER TABLE `fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fundtransaction`
--

DROP TABLE IF EXISTS `fundtransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fundtransaction` (
  `transaction_id` int NOT NULL,
  `fund_id` int DEFAULT NULL,
  `admin_id` varchar(36) DEFAULT NULL,
  `old_amount` decimal(15,2) DEFAULT NULL,
  `new_amount` decimal(15,2) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_trans_fund_idx` (`fund_id`),
  KEY `fk_trans_admin_idx` (`admin_id`),
  CONSTRAINT `fk_trans_fund` FOREIGN KEY (`fund_id`) REFERENCES `fund` (`fund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fundtransaction`
--

LOCK TABLES `fundtransaction` WRITE;
/*!40000 ALTER TABLE `fundtransaction` DISABLE KEYS */;
INSERT INTO `fundtransaction` VALUES (1,1,'1',2000000000.00,1970000000.00,'2025-11-30 15:00:00'),(355666,1,'4',1999997000.00,1999994000.00,'2025-11-26 20:01:15'),(667139,1,'4',2000000000.00,1999997000.00,'2025-11-25 13:27:14');
/*!40000 ALTER TABLE `fundtransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave`
--

DROP TABLE IF EXISTS `leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leave` (
  `leave_id` int NOT NULL,
  `leave_date` date DEFAULT NULL,
  PRIMARY KEY (`leave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave`
--

LOCK TABLES `leave` WRITE;
/*!40000 ALTER TABLE `leave` DISABLE KEYS */;
INSERT INTO `leave` VALUES (1,'2025-12-25');
/*!40000 ALTER TABLE `leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leavedetail`
--

DROP TABLE IF EXISTS `leavedetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leavedetail` (
  `detail_id` int NOT NULL,
  `leave_id` int DEFAULT NULL,
  `staff_id` varchar(36) DEFAULT NULL,
  `reason` longtext,
  `status` enum('Pending','Approved','Rejected') DEFAULT NULL,
  `leavedetail_date` date DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `fk_detail_id_idx` (`leave_id`),
  KEY `fk_detail_staff_idx` (`staff_id`),
  CONSTRAINT `fk_detail_id` FOREIGN KEY (`leave_id`) REFERENCES `leave` (`leave_id`),
  CONSTRAINT `fk_detail_staff` FOREIGN KEY (`staff_id`) REFERENCES `staffprofile` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leavedetail`
--

LOCK TABLES `leavedetail` WRITE;
/*!40000 ALTER TABLE `leavedetail` DISABLE KEYS */;
INSERT INTO `leavedetail` VALUES (1,NULL,'5','1','Approved','2025-11-24'),(2,NULL,'5','1','Approved','2025-11-25'),(3,NULL,'5','123avc','Approved','2025-11-25');
/*!40000 ALTER TABLE `leavedetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` varchar(36) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `role` enum('Admin','Staff') DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('1','admin_boss','123456','2020-01-01','Admin','Male','1990-05-20'),('2','staff_alice','123456','2024-06-01','Staff','Female','2000-01-15'),('3','staff_bob','123456','2024-07-01','Staff','Male','1995-11-05'),('4','admin','1','2025-01-01','Admin','Male','2005-01-01'),('5','staff','1','2025-01-01','Staff','Male','2025-01-01'),('6','staff2','1','2025-11-25','Staff','Male','2025-11-26'),('7','staff3','1','2025-11-25','Staff','Female','2025-11-11');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary` (
  `salary_id` varchar(20) NOT NULL,
  `rank` varchar(100) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `multiplier` float DEFAULT NULL,
  PRIMARY KEY (`salary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
INSERT INTO `salary` VALUES ('1','Senior3',5000.00,1.5),('L001','Junior 1',2500.00,1),('L002','Junior 2',2000.00,1),('L003','Intermediate 1',5000.00,1.3),('L004','Intermediate 2',6000.00,1.3);
/*!40000 ALTER TABLE `salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salarychangehistory`
--

DROP TABLE IF EXISTS `salarychangehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salarychangehistory` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `admin_id` varchar(36) DEFAULT NULL,
  `salary_id` varchar(20) DEFAULT NULL,
  `old_amount` decimal(15,2) DEFAULT NULL,
  `new_amount` decimal(15,2) DEFAULT NULL,
  `old_multiplier` float DEFAULT NULL,
  `new_multiplier` float DEFAULT NULL,
  `old_rank` varchar(20) DEFAULT NULL,
  `new_rank` varchar(20) DEFAULT NULL,
  `change_date` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `fk_history_admin_idx` (`admin_id`),
  KEY `fk_history_salary_idx` (`salary_id`),
  CONSTRAINT `fk_history_salary` FOREIGN KEY (`salary_id`) REFERENCES `salary` (`salary_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salarychangehistory`
--

LOCK TABLES `salarychangehistory` WRITE;
/*!40000 ALTER TABLE `salarychangehistory` DISABLE KEYS */;
INSERT INTO `salarychangehistory` VALUES (7,NULL,'1',4000.00,4000.00,1.6,1.6,'Senior 3','Senior3','2025-11-23 21:11:15'),(8,NULL,'L004',10000.00,2000.00,1.5,1.5,'Senior2','Senior2','2025-11-23 21:51:05'),(9,NULL,'1',4000.00,5000.00,1.6,1.6,'Senior3','Senior3','2025-11-24 11:05:59'),(11,'4','L004',2000.00,3000.00,1.5,1.5,'Senior2','Senior2','2025-11-26 20:07:35'),(12,'4','L001',2000.00,2500.00,1,1,'Junior 3','Junior 3','2025-11-27 07:26:57'),(13,'4','1',5000.00,5000.00,1.6,1.5,'Senior3','Senior3','2025-11-27 07:27:05'),(14,'4','L001',2500.00,2500.00,1,1,'Junior 1','Junior 1','2025-11-27 07:54:21'),(15,'4','L004',3000.00,3000.00,1.5,1.5,'Senior2','Senior2','2025-11-27 07:54:56'),(16,'4','L003',6000.00,5000.00,1.5,1.3,'Senior 1','Intermediate 1','2025-11-27 07:56:12'),(17,'4','L004',3000.00,6000.00,1.5,1.3,'Senior2','Intermediate 2','2025-11-27 07:56:38');
/*!40000 ALTER TABLE `salarychangehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salarypayment`
--

DROP TABLE IF EXISTS `salarypayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salarypayment` (
  `payment_id` int NOT NULL,
  `staff_id` varchar(36) DEFAULT NULL,
  `admin_id` varchar(36) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `salary_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_payment_admin_idx` (`admin_id`),
  KEY `fk_payment_staff_idx` (`staff_id`),
  KEY `fk_payment_salary_idx` (`salary_id`),
  CONSTRAINT `fk_payment_admin` FOREIGN KEY (`admin_id`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_payment_salary` FOREIGN KEY (`salary_id`) REFERENCES `salary` (`salary_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_staff` FOREIGN KEY (`staff_id`) REFERENCES `staffprofile` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salarypayment`
--

LOCK TABLES `salarypayment` WRITE;
/*!40000 ALTER TABLE `salarypayment` DISABLE KEYS */;
INSERT INTO `salarypayment` VALUES (1,'2','4',8000.00,'2025-11-15 00:00:00','1'),(2,'5','4',1000.00,'2025-11-15 00:00:00','L004'),(3,'3','4',3000.00,'2025-11-15 00:00:00','L004'),(4,'6','4',2000.00,'2025-11-15 00:00:00','L004');
/*!40000 ALTER TABLE `salarypayment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffmanagement`
--

DROP TABLE IF EXISTS `staffmanagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffmanagement` (
  `manage_id` int NOT NULL AUTO_INCREMENT,
  `admin_id` varchar(36) DEFAULT NULL,
  `staff_id` varchar(36) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`manage_id`),
  KEY `fk_manage_admin_idx` (`admin_id`),
  KEY `fk_manage_staff_idx` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffmanagement`
--

LOCK TABLES `staffmanagement` WRITE;
/*!40000 ALTER TABLE `staffmanagement` DISABLE KEYS */;
INSERT INTO `staffmanagement` VALUES (1,'4','2','vang','2025-11-25 00:00:00'),(2,'4','3','vang','2025-11-25 00:00:00'),(3,'4','6','vang','2025-11-25 00:00:00'),(4,'4','7','Thêm nhân viên mới','2025-11-25 21:47:49'),(5,'4','5','chamcong','2025-11-25 00:00:00'),(6,'4','5','vang','2025-11-27 00:00:00'),(7,'4','5','vang','2025-11-26 00:00:00'),(8,'5','5','chamcong','2025-11-24 00:00:00'),(9,'5','5','chamcong','2025-11-23 00:00:00'),(10,'5','5','chamcong','2025-11-22 00:00:00'),(11,'5','5','vang','2025-11-21 00:00:00'),(12,'5','5','chamcong','2025-11-20 00:00:00'),(13,'4','3','chamcong','2025-11-26 00:00:00');
/*!40000 ALTER TABLE `staffmanagement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffprofile`
--

DROP TABLE IF EXISTS `staffprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffprofile` (
  `staff_id` varchar(36) NOT NULL,
  `salary_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_staff_salary_idx` (`salary_id`),
  CONSTRAINT `fk_staff_id` FOREIGN KEY (`staff_id`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_staff_salary` FOREIGN KEY (`salary_id`) REFERENCES `salary` (`salary_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffprofile`
--

LOCK TABLES `staffprofile` WRITE;
/*!40000 ALTER TABLE `staffprofile` DISABLE KEYS */;
INSERT INTO `staffprofile` VALUES ('2','1'),('3','L004'),('5','L004'),('6','L004'),('7','L004');
/*!40000 ALTER TABLE `staffprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-27  7:57:34
