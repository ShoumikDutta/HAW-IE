-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.6.20


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema family
--

CREATE DATABASE IF NOT EXISTS family;
USE family;

--
-- Temporary table structure for view `granny`
--
DROP TABLE IF EXISTS `granny`;
DROP VIEW IF EXISTS `granny`;
CREATE TABLE `granny` (
  `granny` varchar(255),
  `child` varchar(255)
);

--
-- Definition of table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`,`name`) VALUES 
 (1,'Sugar BV'),
 (2,'HAW Hamburg'),
 (3,'NSA');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;


--
-- Definition of table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `dayOfDeath` date DEFAULT NULL,
  `Father` varchar(255) DEFAULT NULL,
  `Mother` varchar(255) DEFAULT NULL,
  `height` int(11) NOT NULL,
  `income` decimal(11,0) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_isFather` (`Father`),
  KEY `fk_isMother` (`Mother`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `fk_isFather` FOREIGN KEY (`Father`) REFERENCES `person` (`name`),
  CONSTRAINT `fk_isMother` FOREIGN KEY (`Mother`) REFERENCES `person` (`name`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person`
--

/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` (`name`,`birthday`,`dayOfDeath`,`Father`,`Mother`,`height`,`income`,`company_id`) VALUES 
 ('Bob','1965-11-11',NULL,'Rich','Sue',180,'4000',3),
 ('Ellen','1930-09-09',NULL,NULL,NULL,160,'600',1),
 ('Jane','2006-01-01',NULL,'Bob','Susan',170,'200',NULL),
 ('Joe','2007-02-02',NULL,'Bob','Susan',175,'200',NULL),
 ('Rich','1935-04-19',NULL,NULL,NULL,190,'1200',2),
 ('Sue','1940-05-19',NULL,NULL,NULL,166,'900',1),
 ('Susan','1966-08-08',NULL,'Walt','Ellen',170,'500',2),
 ('Walt','1930-03-10','2007-12-20',NULL,NULL,185,'0',NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;


--
-- Definition of view `granny`
--

DROP TABLE IF EXISTS `granny`;
DROP VIEW IF EXISTS `granny`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `granny` AS select `parent`.`Mother` AS `granny`,`child`.`name` AS `child` from (`person` `child` join `person` `parent`) where ((`child`.`Mother` = `parent`.`name`) or ((`child`.`Father` = `parent`.`name`) and (`parent`.`Mother` is not null)));



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
