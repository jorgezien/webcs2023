-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: rrhh
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nombre_empresa` varchar(30) NOT NULL,
  PRIMARY KEY (`id_empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (2,'Microsoft'),(3,'Apple'),(4,'Amazon'),(5,'Facebook'),(6,'Sony');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcajes`
--

DROP TABLE IF EXISTS `marcajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcajes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `tipo_marcaje` enum('E','S') NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `marcajes_usuarios_id_user_fk` (`id_usuario`),
  CONSTRAINT `marcajes_usuarios_id_user_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcajes`
--

LOCK TABLES `marcajes` WRITE;
/*!40000 ALTER TABLE `marcajes` DISABLE KEYS */;
INSERT INTO `marcajes` VALUES (1,'2023-05-22 15:15:39','E',1),(2,'2023-05-22 15:17:11','E',1),(3,'2023-05-22 15:33:11','E',8),(4,'2023-05-23 11:35:44','E',2),(5,'2023-05-23 11:36:00','S',2),(6,'2023-05-23 11:36:24','S',2),(7,'2023-05-23 11:37:28','S',2),(8,'2023-05-23 11:39:40','E',2),(9,'2023-05-23 11:42:25','E',2),(10,'2023-05-23 11:43:42','E',2),(11,'2023-05-23 11:43:43','E',2),(12,'2023-05-23 11:43:43','S',2),(13,'2023-05-23 11:43:44','E',2),(14,'2023-05-23 11:44:34','E',2),(15,'2023-05-23 11:44:35','S',2),(16,'2023-05-23 11:44:49','S',2),(17,'2023-05-23 11:44:53','S',2),(18,'2023-05-23 11:44:54','E',2),(19,'2023-05-23 11:44:55','S',2),(20,'2023-05-23 11:44:56','E',2),(21,'2023-05-26 11:55:25','E',2),(22,'2023-05-26 11:55:26','S',2),(23,'2023-05-26 12:19:42','E',2),(24,'2023-05-26 12:19:43','S',2),(25,'2023-05-26 12:59:49','S',2),(26,'2023-05-26 17:52:15','E',13),(27,'2023-05-26 17:52:16','S',13),(28,'2023-05-30 17:10:29','E',2),(29,'2023-05-30 17:10:33','S',2);
/*!40000 ALTER TABLE `marcajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyectos`
--

DROP TABLE IF EXISTS `proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyectos` (
  `id_proyecto` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_proyecto`),
  KEY `proyectos_empresa_id_empresa_fk` (`id_empresa`),
  CONSTRAINT `proyectos_empresa_id_empresa_fk` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyectos`
--

LOCK TABLES `proyectos` WRITE;
/*!40000 ALTER TABLE `proyectos` DISABLE KEYS */;
INSERT INTO `proyectos` VALUES (2,'Windows 11',2),(3,'iPhone 13',3),(4,'Amazon Prime Video',4),(5,'Facebook Horizon',5),(6,'PS5',6),(7,'Amazon Prime',4),(8,'AirPods',3),(9,'Surface Pro',2),(10,'MacBook',3),(11,'Windows 10',2);
/*!40000 ALTER TABLE `proyectos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellidos` varchar(30) NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  `tipo_usuario` enum('A','U') NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','admin','99999999Z','Admin','admin','2023-02-22 10:15:57',NULL,'A'),(2,'usuario','usuario','88888888T','usuario','demo','2023-02-22 10:25:20',NULL,'U'),(4,'marta89','clave123','12345678A','Marta','Gómez','2023-05-12 00:00:00',NULL,'U'),(5,'pablo92','segura456','98765432B','Pablo','Martínez','2023-05-11 00:00:00',NULL,'U'),(6,'ana82','contraseña1','56789012C','Ana','López','2023-05-10 00:00:00',NULL,'A'),(7,'carlos75','adminpass','24681357D','Carlos','Fernández','2023-05-09 00:00:00',NULL,'U'),(8,'laura87','pass123','13579246E','Laura','Rodríguez','2023-05-08 00:00:00',NULL,'U'),(9,'david91','seguridad567','98765432F','David','García','2023-05-07 00:00:00',NULL,'U'),(10,'isabel84','adminpass2','54321098G','Isabel','Pérez','2023-05-06 00:00:00',NULL,'A'),(11,'sergio88','claveadmin','24681357H','Sergio','Martín','2023-05-05 00:00:00',NULL,'U'),(12,'jorge','jorge','12345679C','Jorge','Martín','2004-03-01 00:00:00','1100-04-01 00:00:00','A'),(13,'carlos','carlos','12345678F','Carlos','Perez','4300-02-11 00:00:00','5000-02-20 00:00:00','U'),(14,'carlos','perez','12345678A','Carlos','Perez','4300-02-11 00:00:00','5000-02-20 00:00:00','U'),(15,'carlos','aaa','12345678A','Carlos','Perez','4300-02-11 00:00:00','5000-02-20 00:00:00','U'),(16,'juan','juan','87654321A','Carlos','Perez','2004-02-11 00:00:00','2010-02-20 00:00:00','U'),(17,'Roberto','roberto','19392233A','Roberto Mesa','Mesa','2004-04-11 00:00:00','2010-02-02 00:00:00','A'),(18,'raul','raul','12312344A','raul','calzada','2004-01-01 00:00:00','2005-04-01 00:00:00','A');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_proyectos`
--

DROP TABLE IF EXISTS `usuarios_proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_proyectos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_proyecto` int NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_baja` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usuarios_proyectos_proyectos_id_proyecto_fk` (`id_proyecto`),
  KEY `usuarios_proyectos___fk` (`id_user`),
  CONSTRAINT `usuarios_proyectos___fk` FOREIGN KEY (`id_user`) REFERENCES `usuarios` (`id_user`),
  CONSTRAINT `usuarios_proyectos_proyectos_id_proyecto_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `proyectos` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_proyectos`
--

LOCK TABLES `usuarios_proyectos` WRITE;
/*!40000 ALTER TABLE `usuarios_proyectos` DISABLE KEYS */;
INSERT INTO `usuarios_proyectos` VALUES (1,1,2,'2023-05-15 00:00:00','2024-01-01 00:00:00'),(2,2,3,'2023-05-14 00:00:00','2024-01-01 00:00:00'),(3,4,4,'2023-05-13 00:00:00','2024-01-01 00:00:00'),(4,5,5,'2023-05-12 00:00:00','2024-01-01 00:00:00'),(5,6,2,'2023-05-11 00:00:00','2024-01-01 00:00:00'),(6,7,3,'2023-05-10 00:00:00','2024-01-01 00:00:00'),(7,8,4,'2023-05-09 00:00:00','2024-01-01 00:00:00'),(8,9,5,'2023-05-08 00:00:00','2024-01-01 00:00:00'),(9,10,2,'2023-05-07 00:00:00','2024-01-01 00:00:00'),(10,11,3,'2023-05-06 00:00:00','2024-01-01 00:00:00'),(11,12,2,'2023-05-06 00:00:00','2024-01-01 00:00:00'),(12,13,7,'2023-05-08 12:44:00','2023-09-10 15:00:00'),(13,14,6,'2023-05-08 12:44:00','2023-09-10 15:00:00'),(14,15,8,'2023-05-08 12:44:00','2023-09-10 15:00:00');
/*!40000 ALTER TABLE `usuarios_proyectos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-31 12:17:28
