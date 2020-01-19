CREATE DATABASE  IF NOT EXISTS `django_test_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `django_test_db`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: localhost    Database: django_test_db
-- ------------------------------------------------------
-- Server version	5.6.46-log

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Patient',7,'add_patient'),(26,'Can change Patient',7,'change_patient'),(27,'Can delete Patient',7,'delete_patient'),(28,'Can view Patient',7,'view_patient'),(29,'Can add Clinic',8,'add_clinic'),(30,'Can change Clinic',8,'change_clinic'),(31,'Can delete Clinic',8,'delete_clinic'),(32,'Can view Clinic',8,'view_clinic'),(33,'Can add Appointment',9,'add_appointment'),(34,'Can change Appointment',9,'change_appointment'),(35,'Can delete Appointment',9,'delete_appointment'),(36,'Can view Appointment',9,'view_appointment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(9,'server','appointment'),(8,'server','clinic'),(7,'server','patient'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-11-05 11:22:25.692568'),(2,'auth','0001_initial','2019-11-05 11:22:26.024652'),(3,'admin','0001_initial','2019-11-05 11:22:26.909548'),(4,'admin','0002_logentry_remove_auto_add','2019-11-05 11:22:27.101290'),(5,'admin','0003_logentry_add_action_flag_choices','2019-11-05 11:22:27.115281'),(6,'contenttypes','0002_remove_content_type_name','2019-11-05 11:22:27.263862'),(7,'auth','0002_alter_permission_name_max_length','2019-11-05 11:22:27.367333'),(8,'auth','0003_alter_user_email_max_length','2019-11-05 11:22:27.465080'),(9,'auth','0004_alter_user_username_opts','2019-11-05 11:22:27.481395'),(10,'auth','0005_alter_user_last_login_null','2019-11-05 11:22:27.558582'),(11,'auth','0006_require_contenttypes_0002','2019-11-05 11:22:27.567527'),(12,'auth','0007_alter_validators_add_error_messages','2019-11-05 11:22:27.585524'),(13,'auth','0008_alter_user_username_max_length','2019-11-05 11:22:27.682068'),(14,'auth','0009_alter_user_last_name_max_length','2019-11-05 11:22:27.778760'),(15,'auth','0010_alter_group_name_max_length','2019-11-05 11:22:27.873029'),(16,'auth','0011_update_proxy_permissions','2019-11-05 11:22:27.894176'),(17,'sessions','0001_initial','2019-11-05 11:22:27.943198');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('p9ey9px9965375xc3vxg41jyo2h9zce2','OGE4ZWU0Yzc2YTEyOTAwNjYyYTgzZTQzNzA1NDk2MDE3MDhmNDhlNzp7InVzZXIiOnsiaWQiOjEsImVtYWlsIjoiY2FzZWdpa0AxLmNvbSIsIm5hbWUiOiJDYXNlIiwicm9sZSI6InBhdGllbnQifSwiY2xpbmljX3VzZXIiOm51bGx9','2019-12-06 14:36:17.631575'),('qa82gi5sdr88udbgrl7muiqe9pa3xxyw','NjlmMGY5Mzc2OTE0MzU0YWE0MjY5MmNjM2ZmYjA5Njg2MDFjZDNkMzp7InVzZXIiOm51bGwsImNsaW5pY191c2VyIjp7ImlkIjoxLCJlbWFpbCI6InRlc3RfeF9yYXlAcS5jb20iLCJuYW1lIjoiVGVzdCBYLVJheSIsInJvbGUiOiJjbGluaWMifX0=','2019-11-22 11:26:44.671293'),('wxrqw8tejtjj0twv6gdrxp851hwkbgbg','OWExZjg5ZWI4ZGNhMTQ2ZGU1ZWM3ZDk1YTYxOGIyNDg3OWU4N2YzZjp7ImNsaW5pY191c2VyIjp7ImlkIjoxMiwiZW1haWwiOiJkZW50aXN0cnlfMkAyLm9yZyIsIm5hbWUiOiJWaWN0b3JpYSBEZW50aXN0cnkiLCJyb2xlIjoiY2xpbmljIn0sInVzZXIiOm51bGx9','2019-12-04 08:31:17.919085'),('zln7jz9how6qcs6io7ibpdq8t1nktjpj','YTkxYjhkYmI2NTE1ODVjNTBhYzI4NzU0NmNiMzJhMzA2N2NhMDBiZDp7ImNsaW5pY191c2VyIjp7ImlkIjoxLCJlbWFpbCI6InRlc3RfeF9yYXlAcS5jb20iLCJuYW1lIjoiVGVzdCBYLVJheSIsInJvbGUiOiJjbGluaWMifSwidXNlciI6bnVsbH0=','2019-11-26 03:47:12.596936');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_appointment`
--

DROP TABLE IF EXISTS `server_appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_appointment` (
  `AppointmentID` int(11) NOT NULL AUTO_INCREMENT,
  `ClinicID` int(11) DEFAULT NULL,
  `PatientID` int(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Time` varchar(45) DEFAULT NULL,
  `Examination` varchar(45) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Questionaires` varchar(1000) DEFAULT NULL,
  `file` varchar(1000) DEFAULT NULL,
  `requirement` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `ClinicID_idx` (`ClinicID`),
  KEY `PatientID_idx` (`PatientID`),
  CONSTRAINT `ClinicID` FOREIGN KEY (`ClinicID`) REFERENCES `server_clinic` (`ClinicID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PatientID` FOREIGN KEY (`PatientID`) REFERENCES `server_patient` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1 COMMENT='Appointment Record Databse';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_appointment`
--

LOCK TABLES `server_appointment` WRITE;
/*!40000 ALTER TABLE `server_appointment` DISABLE KEYS */;
INSERT INTO `server_appointment` VALUES (7,7,1,'2019-12-02','8:00 AM','CT','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(8,7,3,'2019-12-02','9:00 AM','CT','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(9,7,5,'2019-12-02','10:00 AM','CT','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(10,7,7,'2019-12-02','11:00 AM','CT','Cancel','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(12,7,1,'2019-10-20','10:00 AM','CT','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(13,3,24,'2019-10-25','2:00 PM','MRI','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(14,2,26,'2019-11-05','3:00 PM','ChildrenImage','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(15,5,28,'2019-11-20','2:30 PM','Pregnancy_Pelvic_Imaging','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(16,1,32,'2019-11-20','4:30 PM','X_Ray','Requirement Added','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','','requirement/12_Boltzmann4.pdf'),(17,1,34,'2019-11-20','4:30 PM','X_Ray','Cancel','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(18,1,44,'2019-11-21','8:00 AM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(19,1,5,'2019-12-02','4:00 PM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(20,1,7,'2019-12-02','5:00 PM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(21,1,19,'2019-11-27','5:00 PM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(22,1,29,'2019-11-29','5:00 PM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(23,5,35,'2019-12-02','1:30 PM','MRI','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(24,5,25,'2019-12-02','2:30 PM','MRI','Cancel','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(25,5,15,'2019-12-02','4:30 PM','MRI','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','',''),(35,1,37,'2019-12-02','10:30 AM','X_Ray','Report Uploaded','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}','file/COMP39-9900-19T3-P4P5-resourcess.pdf','requirement/07_Image4.pdf'),(36,5,45,'2019-12-02','9:30 AM','MRI','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(37,3,27,'2019-12-10','10:00 AM','CT','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(38,3,18,'2019-12-10','11:00 AM','CT','Cancel','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(39,3,49,'2019-12-10','2:30 PM','CT','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(40,3,50,'2019-12-10','3:00 PM','CT','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(41,3,30,'2019-12-10','3:30 PM','CT','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(42,1,1,'2019-10-10','11:00 AM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"Not Sure\"}',NULL,NULL),(43,10,1,'2019-11-08','8:00 AM','Dentistry','Pending','{\"Dentistry1 Q1\": \"No\", \"Dentistry1 Q2\": \"No\", \"Dentistry1 Q3\": \"No\", \"Dentistry1 Q4\": \"No\", \"Dentistry1 Q5\": \"No\"}','',''),(44,4,1,'2019-11-01','3:00 PM','Pregnancy and Pelvic Imaging','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(45,1,1,'2019-12-06','4:00 PM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(46,1,1,'2019-12-06','2:30 PM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(47,1,1,'2019-12-06','4:30 PM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(48,5,2,'2019-12-19','5:00 PM','MRI','Pending','{\"Do you have  Artificial heart valve\": \"No\", \"Do you have  Electrical stimulator for nerves, brain or bone\": \"No\", \"Do you have  Implanted infusion or drug pump\": \"No\"}','',''),(49,7,2,'2019-12-12','10:30 AM','CT','Pending','{\"Have you ever had metal in your eyes or worked extensively with metal?\": \"No\", \"Mechanically or electronically activated implants?\": \"No\", \"Bullets, shrapnel or other pieces of metal in your body?\": \"No\"}','',''),(50,1,2,'2019-12-02','4:30 PM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(51,1,2,'2019-12-02','9:30 AM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(82,1,48,'2019-11-25','9:00 AM','X_Ray','Requirement Added','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(83,1,37,'2019-11-25','2:30 PM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}',NULL,NULL),(84,1,2,'2019-11-26','10:30 AM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}',NULL,NULL),(85,1,54,'2019-11-26','4:00 PM','X_Ray','Requirement Added','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}',NULL,''),(86,1,47,'2019-11-27','11:00 AM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',NULL),(87,1,29,'2019-11-27','5:00 PM','X_Ray','Requirement Added','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(88,1,30,'2019-11-29','8:00 AM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}',NULL,NULL),(89,1,18,'2019-11-28','3:30 PM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}',NULL,NULL),(90,1,16,'2019-11-28','10:00 AM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}',NULL,NULL),(91,1,26,'2019-11-29','2:30 PM','X_Ray','Approved','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}',NULL,NULL),(92,1,2,'2019-12-02','9:00 AM','X_Ray','Pending','{\"Do you have any allergies?\": \"No\", \"Do you have a history of kidney problems?\": \"No\", \"Do you have diabetes?\": \"No\", \"Do you have heart disease or high blood pressure for which you are taking medications?\": \"No\", \"Is there any possibility that you could be pregnant?\": \"No\", \"Do you have asthma?\": \"No\"}','',''),(93,9,2,'2019-12-20','9:00 AM','Cardiology','Pending','{\"Artificial heart valve?\": \"No\", \"Electrical stimulator for nerves, brain or bone?\": \"No\", \"Cardiac/Heart Pacemaker/pacing wires or Implanted Cardioverter Defibrillator?\": \"No\", \"Mechanically or electronically activated implants?\": \"No\"}','',''),(94,9,2,'2019-12-20','4:30 PM','Cardiology','Pending','{\"Artificial heart valve?\": \"No\", \"Electrical stimulator for nerves, brain or bone?\": \"No\", \"Cardiac/Heart Pacemaker/pacing wires or Implanted Cardioverter Defibrillator?\": \"No\", \"Mechanically or electronically activated implants?\": \"No\"}','','');
/*!40000 ALTER TABLE `server_appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_clinic`
--

DROP TABLE IF EXISTS `server_clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_clinic` (
  `ClinicID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `ClinicName` varchar(100) DEFAULT NULL,
  `Address` varchar(500) DEFAULT NULL,
  `address_latitude` varchar(20) DEFAULT NULL COMMENT 'location latitude for map use',
  `address_longitude` varchar(20) DEFAULT NULL COMMENT 'location longitude for map use',
  `ZipCode` varchar(4) DEFAULT NULL,
  `Contact` varchar(20) DEFAULT NULL,
  `TimeTable` varchar(2000) DEFAULT NULL,
  `Questiones` varchar(5000) DEFAULT NULL,
  `MRI` varchar(1) DEFAULT NULL,
  `CT` varchar(1) DEFAULT NULL,
  `X_Ray` varchar(1) DEFAULT NULL,
  `ChildrenImage` varchar(1) DEFAULT NULL,
  `Pregnancy_Pelvic_Imaging` varchar(1) DEFAULT NULL,
  `Cardiology` varchar(1) DEFAULT NULL,
  `Dentistry` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ClinicID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COMMENT='Radiology Clinic Database';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_clinic`
--

LOCK TABLES `server_clinic` WRITE;
/*!40000 ALTER TABLE `server_clinic` DISABLE KEYS */;
INSERT INTO `server_clinic` VALUES (1,'test_x_ray@q.com','123456','Test X-Ray','70 Pitt St, Sydney NSW','-33.871290','151.110210','2000','123456789','{\"8:00 AM\": \"1\", \"8:30 AM\": \"1\", \"9:00 AM\": \"1\", \"9:30 AM\": \"1\", \"10:00 AM\": \"1\", \"10:30 AM\": \"1\", \"11:00 AM\": \"1\", \"11:30 AM\": \"1\", \"12:00 PM\": \"0\", \"1:30 PM\": \"1\", \"2:00 PM\": \"1\", \"2:30 PM\": \"1\", \"3:00 PM\": \"1\", \"3:30 PM\": \"1\", \"4:00 PM\": \"1\", \"4:30 PM\": \"1\", \"5:00 PM\": \"1\"}','[\"Do you have any allergies?\", \"Do you have a history of kidney problems?\", \"Do you have diabetes?\", \"Do you have heart disease or high blood pressure for which you are taking medications?\", \"Is there any possibility that you could be pregnant?\", \"Do you have asthma?\"]','0','0','1','0','0','0','0'),(2,'test_children_rad@g.com','123456','Test Children\'s Radiology','32 Luke Ave, Burwood NSW','-33.879314','151.192219','2134','123456789','{\"10.00 A.M.\":1,\"10.30 A.M.\":1,\"11.00 A.M.\":1,\"11.30 A.M.\":1,\"12.00 P.M.- 1.00 P.M\":0,\"1.30 P.M\":1,\"2.00 P.M\":1,\"2.30 P.M\":1,\"3.00 P.M\":1,\"3.30 P.M\":1,\"4.00 P.M\":1,\"4.30 P.M\":1,\"5.00 P.M\":1}','[\"Do you have any allergies?\",\"Do you have a history of kidney problems?\",\"Do you have diabetes?\",\"Do you have heart disease or high blood pressure for which you are taking medications?\",\"Do you have asthma?\"]','0','0','0','1','0','0','0'),(3,'test_ct1@g.com','123456','Test CT Clinic','Level 8/287 Elizabeth St, Sydney NSW','-33.876749','151.203886','2000','123456789','{\"8.00 A.M.\":1,\"8.30 A.M.\":1,\"9.00 A.M.\":1,\"9.30 A.M.\":1,\"10.00 A.M.\":1,\"10.30 A.M.\":1,\"11.00 A.M.\":1,\"11.30 A.M.\":1,\"12.00 P.M.- 1.00 P.M\":0,\"1.30 P.M\":1,\"2.00 P.M\":1,\"2.30 P.M\":1,\"3.00 P.M\":1,\"3.30 P.M\":1,\"4.00 P.M\":1,\"4.30 P.M\":1,\"5.00 P.M\":1}','[\"Do you have any allergies?\",\"Do you have a history of kidney problems?\",\"Do you have diabetes?\",\"Do you have heart disease or high blood pressure for which you are taking medications?\",\"Is there any possibility that you could be pregnant?\",\"Do you have asthma?\"]','0','1','0','0','0','0','0'),(4,'test_women_rad@g.com','123456','Pregnancy and Pelvic Imaging','161 New South Head Rd, Edgecliff NSW','-33.895275','151.210750','2027','123456789','{\"9.00 A.M.\":1,\"9.30 A.M.\":1,\"10.00 A.M.\":1,\"10.30 A.M.\":1,\"11.00 A.M.\":1,\"11.30 A.M.\":1,\"12.00 P.M.- 1.00 P.M\":0,\"1.30 P.M\":1,\"2.00 P.M\":1,\"2.30 P.M\":1,\"3.00 P.M\":1,\"3.30 P.M\":1,\"4.00 P.M\":1,\"4.30 P.M\":1,\"5.00 P.M\":1}','[\"Do you have any allergies?\",\"Do you have a history of kidney problems?\",\"Do you have diabetes?\",\"Do you have heart disease or high blood pressure for which you are taking medications?\",\"Do you have asthma?\"]','0','0','0','0','1','0','0'),(5,'test_mri1@g.com','123456','Test MRI 1','O\'Sullivan, 101/91 O\'Sullivan Rd, Rose Bay NSW','-33.836549','151.209720','2029','123456789','{\"9:00 AM\": \"2\", \"9:30 AM\": \"2\", \"10:00 AM\": \"2\", \"10:30 AM\": \"2\", \"11:00 AM\": \"2\", \"11:30 AM\": \"2\", \"12:00 PM\": \"0\", \"1:30 PM\": \"1\", \"2:00 PM\": \"1\", \"2:30 PM\": \"1\", \"3:00 PM\": \"1\", \"3:30 PM\": \"1\", \"4:00 PM\": \"1\", \"4:30 PM\": \"1\", \"5:00 PM\": \"1\"}','[\"Do you have  Artificial heart valve\", \"Do you have  Electrical stimulator for nerves, brain or bone\", \"Do you have  Implanted infusion or drug pump\"]','1','0','0','0','0','0','0'),(6,'test_x_ray2@1.com','123456','X_ray No.2','44 Market St, Sydney NSW','-33.838830','151.217289','2000','123456789','{\"8:00 AM\": \"2\", \"8:30 AM\": \"2\", \"9:00 AM\": \"2\", \"9:30 AM\": \"2\", \"10:00 AM\": \"2\", \"10:30 AM\": \"2\", \"11:00 AM\": \"2\", \"11:30 AM\": \"2\", \"12:00 PM\": \"0\", \"1:30 PM\": \"1\", \"2:00 PM\": \"1\", \"2:30 PM\": \"1\", \"3:00 PM\": \"1\", \"3:30 PM\": \"1\"}','[\"Do you have Aneurysm clips\", \"Do you have Aneurysm clips\", \"Did you have Ocular (eye) implant?\", \"Did you have Cochlear (ear) implant?\"]','0','0','1','0','0','0','0'),(7,'test_ct2@g.com','123456','Test CT No.2','Shop 6 52/48 Sydney Rd, Manly NSW','-33.919209','151.223466','2095','123456789','{\"8:00 AM\": \"1\", \"8:30 AM\": \"1\", \"9:00 AM\": \"1\", \"9:30 AM\": \"1\", \"10:00 AM\": \"1\", \"10:30 AM\": \"1\", \"11:00 AM\": \"1\", \"11:30 AM\": \"1\", \"12:00 PM\": \"0\", \"1:30 PM\": \"1\", \"2:00 PM\": \"1\", \"2:30 PM\": \"1\", \"3:00 PM\": \"1\", \"3:30 PM\": \"1\", \"4:00 PM\": \"1\", \"4:30 PM\": \"1\", \"5:00 PM\": \"1\"}','[\"Have you ever had metal in your eyes or worked extensively with metal?\", \"Mechanically or electronically activated implants?\", \"Bullets, shrapnel or other pieces of metal in your body?\"]','0','1','0','0','0','0','0'),(8,'x_ray_ct_rad@rad.rad','123456','X-ray and CT Radiologist','185 Pitt St, Merrylands NSW','-33.938295','151.217632','2160','1234567','{\"8:00 AM\": \"1\", \"8:30 AM\": \"1\", \"9:00 AM\": \"1\", \"9:30 AM\": \"1\", \"10:00 AM\": \"1\", \"10:30 AM\": \"1\", \"11:00 AM\": \"1\", \"11:30 AM\": \"1\", \"12:00 PM\": \"0\", \"1:30 PM\": \"1\", \"2:00 PM\": \"1\", \"2:30 PM\": \"1\", \"3:00 PM\": \"1\", \"3:30 PM\": \"1\", \"4:00 PM\": \"1\", \"4:30 PM\": \"1\", \"5:00 PM\": \"1\"}','[\"Hearing aid\", \"Dental work: dentures, or dental plate\", \"Tattoos or Body piercing\", \"Metal joints/joint replacement, pins, plates, rods, screws, nails or clips\"]','0','1','1','0','0','0','0'),(9,'test_card_1@1.com','123456','Test Caradiology Clinic','4d/658 Pittwater Rd','-33.928326','151.141791','2100','654321789','{\"8:00 AM\": \"1\", \"8:30 AM\": \"1\", \"9:00 AM\": \"1\", \"9:30 AM\": \"1\", \"10:00 AM\": \"1\", \"10:30 AM\": \"1\", \"11:00 AM\": \"1\", \"11:30 AM\": \"1\", \"12:00 PM\": \"0\", \"1:30 PM\": \"1\", \"2:00 PM\": \"1\", \"2:30 PM\": \"1\", \"3:00 PM\": \"1\", \"3:30 PM\": \"1\", \"4:00 PM\": \"1\", \"4:30 PM\": \"1\", \"5:00 PM\": \"1\"}','[\"Artificial heart valve?\", \"Electrical stimulator for nerves, brain or bone?\", \"Cardiac/Heart Pacemaker/pacing wires or Implanted Cardioverter Defibrillator?\", \"Mechanically or electronically activated implants?\"]','0','0','0','0','0','1','0'),(10,'test_dentistry1@2.com','123456','Test Dentistry Imaging','1 Warringah Ln, Mosman NSW','-33.923768','151.159169','2088','123123123','{\"8.00 A.M.\":1,\"8.30 A.M.\":1,\"9.00 A.M.\":1,\"9.30 A.M.\":1,\"10.00 A.M.\":1,\"10.30 A.M.\":1,\"11.00 A.M.\":1,\"11.30 A.M.\":1,\"12.00 P.M.- 1.00 P.M\":0,\"1.30 P.M\":1,\"2.00 P.M\":1,\"2.30 P.M\":1,\"3.00 P.M\":1,\"3.30 P.M\":1,\"4.00 P.M\":1,\"4.30 P.M\":1,\"5.00 P.M\":1}','[\"Dentistry1 Q1\",\"Dentistry1 Q2\",\"Dentistry1 Q3\",\"Dentistry1 Q4\",\"Dentistry1 Q5\"]','0','0','0','0','0','0','1'),(11,'test_mri2@g.com','123456','Test MRI Clinic','126 Ridge St, North Sydney NSW','-33.917215','151.205174','2060','654321789','{\"9:00 AM\": \"2\", \"10:00 AM\": \"2\", \"11:00 AM\": \"2\", \"1:00 PM\": \"2\", \"2:00 PM\": \"2\", \"3:00 PM\": \"2\", \"4:00 PM\": \"2\", \"5:00 PM\": \"2\"}','[\"Do you have an implantable device?\", \"Do you have problems with your thyroid gland?\", \"Are you currently receiving chemotherapy?\"]','1','0','0','0','0','0','0'),(12,'dentistry_2@2.org','123456','Victoria Dentistry','438 Victoria St, Darlinghurst NSW','-33.916930','151.237103','2010','654321789','{}','[\"Dental work: dentures, or dental plate\"]','0','0','0','0','0','0','1'),(13,'test_mri3@g.com','123456','MRI No.3 Clinic','50 King St, Sydney NSW','-33.920919','151.251179','2000','654321789',NULL,NULL,'0','0','0','0','0','0','0'),(14,'ryde_clinic@2.com','123456','Ryde Clinic','2 Pope St, Ryde NSW','-33.892710','151.267662','2112','654321789',NULL,NULL,'1','1','0','0','0','0','0'),(15,'strat_dentis@1.com','123456','Strathfield Dentistry','Suite 8 Level 5 Strathfield Plaza, 11th Boulevarde, Sydney NSW','-33.887865','151.231270','2135','654321789',NULL,NULL,'0','0','0','0','0','0','1'),(16,'test_card_2@1.com','123456','Another Caradiology Clinic','72 Anderson Ave, Panania NSW','-33.887295','151.270409','2213','654321789',NULL,NULL,'0','0','0','0','0','1','0'),(17,'test_children@1.com','123456','Some Children\'s Imaging','15/60 Station St, Parramatta NSW','-33.876749','151.217194','2150','654321789',NULL,NULL,'0','0','0','1','0','0','0'),(18,'test_4@q.com','123456','Test Clinic 4 CT','D3a 11/15 Moxon Road','-33.830560','151.246719','2196','654321789',NULL,NULL,'0','1','0','0','0','0','0'),(19,'test_5@q.com','123456','Test Clinic 5 Prengnent Care','15/2 Ash Rd, Prestons NSW','-33.830845','151.186638','2170','654321789',NULL,NULL,'0','0','0','0','1','0','0'),(20,'test_6@q.com','123456','Test Clinic 6 Dentistry','41 Bridge Rd, Glebe NSW','-33.833697','151.207924','2037','654321789',NULL,NULL,'0','0','0','0','0','0','1');
/*!40000 ALTER TABLE `server_clinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_patient`
--

DROP TABLE IF EXISTS `server_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_patient` (
  `PatientID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(45) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `First_name` varchar(45) DEFAULT NULL,
  `Last_name` varchar(45) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Gender` varchar(45) DEFAULT NULL,
  `Address` varchar(500) DEFAULT NULL,
  `Zipcode` varchar(4) DEFAULT NULL,
  `Insurance` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PatientID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1 COMMENT='Patient databse';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_patient`
--

LOCK TABLES `server_patient` WRITE;
/*!40000 ALTER TABLE `server_patient` DISABLE KEYS */;
INSERT INTO `server_patient` VALUES (1,'casegik@1.com','123456','Gil','Case','2019-11-26','F','7075 Elit Avenue','2000','Medicare'),(2,'CChristina229@gmail.com','123456','Christina','Test_user','1999-09-09','F','926-1935 Arcu. Street','2016','Medicare'),(3,'handsome_boy@q.com','123456','Boya','Handsome','1988-08-08','M','1058 Duis Rd.','2017','Medicare'),(4,'youlan0za@ok.com','123456','klaus','hu','1994-03-13','M','P.O. Box 906, 9073 Donec Av','2018','Medicare'),(5,'fringilla.mi@aaarQuisque.co.uk','123456','Day','Wang','1988-07-17','M','501-2921 Eleifend, Street','2019','Private Health Insurance'),(6,'Nunc.laoreet@te.c','123456','Leila','Webb','1977-10-23','F','Ap #259-2046 Nunc Street','2020','Private Health Insurance'),(7,'enim@Sed.net','123456','Lysandra','Davidson','1965-07-08','M','4074 Netus Street','2210','Private Health Insurance'),(8,'ipsum@als.edu','123456','Brett','Barron','1984-04-18','M','P.O. Box 806, 5153 Dui, Avenue','2093','Medicare'),(9,'tis.quam@enmi.o','123456','Tanek','Stuart','1992-02-22','F','Ap #130-1925 Morbi Avenue','2037','Private Health Insurance'),(10,'dnalder0@google.nl','123456','Derrik','Nalder','1992-11-23','M','72 Mayer Junction','2037','Private Health Insurance'),(11,'blitel1d@fr44.f','123456','Boyce','Litel','1998-04-25','M','2371 Prairie Rose Road','2035','Private Health Insurance'),(12,'mcaberas0@wsj.blabla','123456','Margaux','Caberas','1998-03-13','F','20 Charing Cross Pass','2038','Private Health Insurance'),(13,'ralbany1@storify.blabla','123456','Reidar','Albany','1981-08-08','M','62154 5th Place','2100','Private Health Insurance'),(14,'atrathan2@booking.blabla','123456','Arron','Trathan','1970-10-24','M','8801 Packers Hill','2121','Medicare'),(15,'adie3@a.edu','123456','Milt','Adie','1981-10-11','M','099 Brown Road','2112','Medicare'),(16,'bscapelhorn4@cnn.blabla','123456','Beltran','Scapelhorn','1997-08-19','M','536 Service Trail','2112','Private Health Insurance'),(17,'aquibell5@twitter.blabla','123456','Aldridge','Quibell','1972-05-24','M','294 Homewood Plaza','2300','Medicare'),(18,'kbassett6@naver.blabla','123456','Klaus','Bassett','1992-12-30','M','94 Saint Paul Road','2010','Private Health Insurance'),(19,'glockhart7@amazonaws.blabla','123456','Gabriella','Lockhart','1999-07-28','F','76 Amoth Circle','2010','Private Health Insurance'),(20,'rconville8@multiply.blabla','123456','Rollins','Conville','1990-12-16','M','19162 Green Crossing','2014','Medicare'),(21,'bhenricsson9@auda.org.au','123456','Barr','Henricsson','1992-09-20','M','1520 Gerald Hill','2015','Medicare'),(22,'rlongmatea@stanf.edu','123456','Roze','Longmate','1995-06-27','F','4 Continental Plaza','2016','Medicare'),(23,'tpigfordb@uni.org','123456','Travers','Pigford','1993-08-02','M','082 Corry Plaza','2017','Private Health Insurance'),(24,'dmumbrayc@yo.be','123456','Demetrius','Mumbray','1991-05-21','M','6496 Bobwhite Street','2018','Medicare'),(25,'fcorragand@sina.blabla.cn','123456','Flory','Corragan','1992-04-26','M','347 Gerald Court','2025','Private Health Insurance'),(26,'edunmuire@n.gov','123456','Ernaline','Dunmuir','1975-07-16','F','9866 Reinke Point','2058','Private Health Insurance'),(27,'mjewisf@over-blog.blabla','123456','Modestia','Jewis','1974-09-22','F','7082 Merry Road','2029','Medicare'),(28,'everbeekg@hhs.gov','123456','Ernie','Verbeek','1976-01-26','M','68 Sugar Drive','2066','Medicare'),(29,'kcolbridgeh@studiopress.blabla','123456','Kris','Colbridge','1973-05-05','M','5 Del Mar Terrace','2077','Private Health Insurance'),(30,'cvendittii@friendfeed.blabla','123456','Caralie','Venditti','1992-12-06','F','42 Gale Street','2088','Private Health Insurance'),(31,'gboageyj@ocn.n','123456','Garrett','Boagey','1987-12-21','M','24037 Hallows Crossing','2099','Private Health Insurance'),(32,'smcginnk@ted.blabla','123456','Sid','McGinn','1987-08-27','M','17 Gina Place','2000','Medicare'),(33,'ckefordl@imgur.blabla','123456','Catlaina','Keford','1987-11-30','F','4346 Katie Circle','2000','Medicare'),(34,'dlevesquem@posterous.blabla','123456','Damara','Levesque','1975-11-20','F','5 Mayer Way','2139','Medicare'),(35,'smandyn@walmart.blabla','123456','Stacia','Mandy','1982-02-06','F','5 Browning Plaza','2193','Medicare'),(36,'rdulakeo@mapy.c','123456','Rafe','Dulake','1995-08-05','M','107 Crownhardt Crossing','2157','Private Health Insurance'),(37,'byukhninip@skype.blabla','123456','Bernhard','Yukhnini','1977-12-18','M','76 Gerald Crossing','2075','Private Health Insurance'),(38,'tboyfieldq@squarespace.blabla','123456','Tuck','Boyfield','1980-06-14','M','503 Esker Drive','2085','Private Health Insurance'),(39,'mnovakr@time.blabla','123456','Maryellen','Novak','1980-10-14','F','5487 Dovetail Court','2095','Medicare'),(40,'cpratis@disqus.blabla','123456','Christiane','Prati','1999-05-30','F','2317 Westport Parkway','2020','Medicare'),(41,'hparnallt@soup.i','123456','Hilly','Parnall','1989-06-27','M','04294 Transport Center','2000','Medicare'),(42,'tdargavelu@1.com','123456','Tanny','Dargavel','1975-10-04','M','2 Hoffman Hill','2000','Medicare'),(43,'fgoodingsv@studiopress.blabla','123456','Farly','Goodings','1988-08-24','M','1 Parkside Crossing','2001','Medicare'),(44,'rossipenkow@1.com','123456','Ryley','Ossipenko','1981-04-27','M','689 Canary Plaza','2005','Private Health Insurance'),(45,'eluckesx@reverbnation.blabla','123456','Emmerich','Luckes','1983-11-22','M','2064 Hayes Junction','2007','Medicare'),(46,'zvanstoney@1.com','123456','Zacharias','Vanstone','1994-12-01','M','4555 Bashford Avenue','2009','Private Health Insurance'),(47,'pkiplingz@alexa.blabla','123456','Piotr','Kipling','1989-01-11','M','73409 Burning Wood Alley','2040','Private Health Insurance'),(48,'flodevick10@nydailynews.blabla','123456','Fallon','Lodevick','1973-10-26','F','94661 Sherman Trail','2050','Private Health Insurance'),(49,'smerryfield11@1.com','123456','Shay','Merryfield','1981-09-29','M','86 Westend Hill','2090','Medicare'),(50,'fahmed12@kickstarter.blabla','123456','Freddy','Ahmed','1997-04-12','M','63335 Prairie Rose Lane','2080','Medicare'),(51,'gpafford13@mapquest.blabla','123456','Georg','Pafford','1981-03-03','M','57 Park Meadow Circle','2070','Medicare'),(52,'rseldon14@networksolutions.blabla','123456','Rina','Seldon','1992-11-30','F','40 Dapin Plaza','2030','Private Health Insurance'),(53,'jjarrad15@elegantthemes.blabla','123456','Jamal','Jarrad','1988-04-16','M','3070 Stone Corner Junction','2046','Private Health Insurance'),(54,'kskippen16@google.blabla','123456','Katie','Skippen','1999-02-12','F','69 Dwight Street','2079','Medicare');
/*!40000 ALTER TABLE `server_patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-24  2:46:22
