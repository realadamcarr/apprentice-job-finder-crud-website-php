-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usertype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`usertype` ;

CREATE TABLE IF NOT EXISTS `mydb`.`usertype` (
  `usertypeNr` INT NOT NULL,
  `userTypeDescr` VARCHAR(45) NULL,
  PRIMARY KEY (`usertypeNr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`county`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`county` ;

CREATE TABLE IF NOT EXISTS `mydb`.`county` (
  `idcounty` INT NOT NULL,
  `countyName` VARCHAR(45) NULL,
  PRIMARY KEY (`idcounty`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`apprentice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`apprentice` ;

CREATE TABLE IF NOT EXISTS `mydb`.`apprentice` (
  `apprenticeID` INT NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `mobile` VARCHAR(45) NULL,
  `PassWord` VARCHAR(45) NULL,
  PRIMARY KEY (`apprenticeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `UserNr` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `PassWord` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `mobile` VARCHAR(45) NULL,
  `userID` VARCHAR(45) NULL,
  `county_idcounty` INT NOT NULL,
  `usertype_usertypeNr` INT NOT NULL,
  `apprentice_apprenticeID` INT NOT NULL,
  PRIMARY KEY (`UserNr`),
  INDEX `fk_user_county_idx` (`county_idcounty` ASC),
  INDEX `fk_user_usertype1_idx` (`usertype_usertypeNr` ASC),
  INDEX `fk_user_apprentice1_idx` (`apprentice_apprenticeID` ASC),
  CONSTRAINT `fk_user_county`
    FOREIGN KEY (`county_idcounty`)
    REFERENCES `mydb`.`county` (`idcounty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_usertype1`
    FOREIGN KEY (`usertype_usertypeNr`)
    REFERENCES `mydb`.`usertype` (`usertypeNr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_apprentice1`
    FOREIGN KEY (`apprentice_apprenticeID`)
    REFERENCES `mydb`.`apprentice` (`apprenticeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`job` ;

CREATE TABLE IF NOT EXISTS `mydb`.`job` (
  `JobID` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  `skills` VARCHAR(45) NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  PRIMARY KEY (`JobID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`apprentice_has_job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`apprentice_has_job` ;

CREATE TABLE IF NOT EXISTS `mydb`.`apprentice_has_job` (
  `apprentice_apprenticeID` INT NOT NULL,
  `job_JobID` INT NOT NULL,
  PRIMARY KEY (`apprentice_apprenticeID`, `job_JobID`),
  INDEX `fk_apprentice_has_job_job1_idx` (`job_JobID` ASC),
  INDEX `fk_apprentice_has_job_apprentice1_idx` (`apprentice_apprenticeID` ASC),
  CONSTRAINT `fk_apprentice_has_job_apprentice1`
    FOREIGN KEY (`apprentice_apprenticeID`)
    REFERENCES `mydb`.`apprentice` (`apprenticeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_apprentice_has_job_job1`
    FOREIGN KEY (`job_JobID`)
    REFERENCES `mydb`.`job` (`JobID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure AddUser
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddUser`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser`(
    IN p_name VARCHAR(45),
    IN p_email VARCHAR(45),
    IN p_password VARCHAR(45)
)
BEGIN
    INSERT INTO `user` (`name`, `email`, `password`) VALUES (p_name, p_email, p_password);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEvent
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEvent`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEvent`(
    IN p_event_id INT
)
BEGIN
    DELETE FROM `event` WHERE `event_id` = p_event_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetTicketsByUserID
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`GetTicketsByUserID`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTicketsByUserID`(
    IN p_user_id INT
)
BEGIN
    SELECT * FROM `ticket` WHERE `user_id` = p_user_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetVenueCapacity
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`GetVenueCapacity`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVenueCapacity`(
    IN p_venue_id INT,
    OUT p_capacity INT
)
BEGIN
    SELECT `capacity` INTO p_capacity FROM `venue` WHERE `venue_id` = p_venue_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateTicketPrice
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`UpdateTicketPrice`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateTicketPrice`(
    IN p_ticket_id INT,
    IN p_new_price DECIMAL(10, 2)
)
BEGIN
    UPDATE `ticket` SET `price` = p_new_price WHERE `ticket_id` = p_ticket_id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`usertype`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (1, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (2, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (3, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (4, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (5, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (6, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (7, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (8, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (9, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (10, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (11, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (12, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (13, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (14, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (15, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (16, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (17, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (18, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (19, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (20, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (21, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (22, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (23, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (24, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (25, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (26, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (27, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (28, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (29, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (30, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (31, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (32, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (33, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (34, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (35, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (36, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (37, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (38, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (39, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (40, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (41, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (42, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (43, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (44, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (45, 'manager');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (46, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (47, 'admin');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (48, 'apprentice');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (49, 'customer');
INSERT INTO `mydb`.`usertype` (`usertypeNr`, `userTypeDescr`) VALUES (50, 'apprentice');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`county`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (1, 'Galway');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (2, 'Donegal');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (3, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (4, 'Galway');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (5, 'Cork');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (6, 'Wicklow');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (7, 'Wicklow');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (8, 'Dublin');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (9, 'Donegal');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (10, 'Waterford');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (11, 'Mayo');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (12, 'Galway');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (13, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (14, 'Waterford');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (15, 'Kerry');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (16, 'Dublin');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (17, 'Galway');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (18, 'Wicklow');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (19, 'Wicklow');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (20, 'Wicklow');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (21, 'Limerick');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (22, 'Cork');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (23, 'Wicklow');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (24, 'Wicklow');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (25, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (26, 'Kerry');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (27, 'Mayo');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (28, 'Cork');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (29, 'Cork');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (30, 'Dublin');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (31, 'Galway');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (32, 'Galway');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (33, 'Cork');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (34, 'Waterford');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (35, 'Cork');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (36, 'Galway');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (37, 'Dublin');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (38, 'Dublin');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (39, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (40, 'Waterford');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (41, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (42, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (43, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (44, 'Limerick');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (45, 'Limerick');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (46, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (47, 'Limerick');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (48, 'Mayo');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (49, 'Kilkenny');
INSERT INTO `mydb`.`county` (`idcounty`, `countyName`) VALUES (50, 'Dublin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`apprentice`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (1, 'Suzann', 'Francescoccio', 'sfrancescoccio0@edublogs.org', '717-745-1087', 'jQ9#twgLM');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (2, 'Shea', 'Varfolomeev', 'svarfolomeev1@hugedomains.com', '845-927-4514', 'zZ6||ED=Bn');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (3, 'Pippa', 'Caplan', 'pcaplan2@scientificamerican.com', '314-408-5713', 'oF6|Z4R)JL%');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (4, 'Casey', 'Wotton', 'cwotton3@discovery.com', '367-296-6692', 'qD8@Wq2K');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (5, 'Tedda', 'Gibson', 'tgibson4@squarespace.com', '757-711-0681', 'xR4@EROy\"\'.50x');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (6, 'Dell', 'Chilcott', 'dchilcott5@about.me', '929-506-5774', 'cN5)VKC<K,');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (7, 'Jesse', 'Carletto', 'jcarletto6@toplist.cz', '726-960-2631', 'wX1&Pca&,}!Z\\');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (8, 'Carmela', 'Bonn', 'cbonn7@icio.us', '793-581-3465', 'zT1(Igo+~Y<');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (9, 'Yoko', 'Agastina', 'yagastina8@purevolume.com', '692-848-1030', 'tC8#k%SUtJy7');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (10, 'Vilhelmina', 'McMeeking', 'vmcmeeking9@ihg.com', '926-413-8189', 'kH8(#!EwnjD');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (11, 'Whit', 'Bowker', 'wbowkera@businesswire.com', '199-277-4178', 'xS4)?4n!Oz!k');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (12, 'Granthem', 'Paterson', 'gpatersonb@quantcast.com', '846-970-7427', 'hT4`/v}\\B@Ui');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (13, 'Davida', 'Reddick', 'dreddickc@moonfruit.com', '863-805-6523', 'iR5$=6nbV2');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (14, 'Aloysius', 'Chisolm', 'achisolmd@webeden.co.uk', '907-357-5711', 'lP8~EI<BbC');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (15, 'Oren', 'Kirkup', 'okirkupe@boston.com', '376-567-2844', 'aW6,iR\"X');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (16, 'Lonee', 'Garnsey', 'lgarnseyf@nytimes.com', '612-731-3537', 'kL3%yW\'x9');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (17, 'Kathi', 'Maginn', 'kmaginng@goo.ne.jp', '700-905-4730', 'eB5~pjUEw}');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (18, 'Goober', 'Exon', 'gexonh@friendfeed.com', '214-417-7043', 'qM1|xb!fD@/_k');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (19, 'Trenton', 'Thunnerclef', 'tthunnerclefi@rediff.com', '629-522-4772', 'jH9{9Q{44=\'HF0%');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (20, 'Clarey', 'O\'Kelly', 'cokellyj@kickstarter.com', '362-784-2312', 'bC0#Y/tw');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (21, 'Abelard', 'Miskimmon', 'amiskimmonk@slate.com', '523-485-6715', 'rC8,i`hc/%8A<p');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (22, 'Alejandra', 'Buddles', 'abuddlesl@digg.com', '613-414-5440', 'jP7}0yE*3r@E!@.\\');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (23, 'Reeva', 'Kretschmer', 'rkretschmerm@ucsd.edu', '928-853-1773', 'oA1,uHUK4');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (24, 'Kerrie', 'Slingsby', 'kslingsbyn@topsy.com', '133-381-4199', 'qX6%yQLo\'FE');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (25, 'Jacenta', 'Bullard', 'jbullardo@mozilla.org', '137-831-9401', 'qH0)zpQ<A{mOieE');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (26, 'Trip', 'Cullinan', 'tcullinanp@networksolutions.com', '115-241-6849', 'zH4)@Xn\'>j*.\'7\'R');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (27, 'Lauryn', 'Phlippsen', 'lphlippsenq@noaa.gov', '765-870-4356', 'nH8,6iPn');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (28, 'Derick', 'Hubert', 'dhubertr@ifeng.com', '440-536-9538', 'vW9_yc|}\\/c\'sPxl');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (29, 'Kahlil', 'Sagg', 'ksaggs@behance.net', '367-293-7174', 'wP8>.Q{s');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (30, 'Woody', 'Andrasch', 'wandrascht@wikipedia.org', '677-448-4899', 'tW8\"R!(zo,s');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (31, 'Elwyn', 'Skates', 'eskatesu@stanford.edu', '513-324-6901', 'gX8+G++sWui');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (32, 'Olympe', 'Savaage', 'osavaagev@drupal.org', '620-382-3929', 'mD5+o)X8`m\'');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (33, 'Lewie', 'Martschik', 'lmartschikw@cyberchimps.com', '708-355-2494', 'sF3)UQYZF');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (34, 'Milo', 'Lasham', 'mlashamx@whitehouse.gov', '664-518-9982', 'nO9#==.4u#\'|I{jm');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (35, 'Kissie', 'Baus', 'kbausy@soundcloud.com', '679-633-3963', 'fV5/v?sI&mrcnp');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (36, 'Karrah', 'Hullett', 'khullettz@facebook.com', '611-120-7185', 'hH5.#A\'&vgzX');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (37, 'Joann', 'Playle', 'jplayle10@blogger.com', '624-531-8152', 'jN1(Bi,3M,OEwu');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (38, 'Cathi', 'Cooke', 'ccooke11@a8.net', '697-494-1553', 'tO3%B1\\`c{qy');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (39, 'Sam', 'Reyburn', 'sreyburn12@linkedin.com', '799-709-8593', 'cM9$Q?mx/X');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (40, 'Virginie', 'Langstone', 'vlangstone13@biglobe.ne.jp', '411-924-9172', 'dO2#%4j!ov,');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (41, 'Etty', 'Dedenham', 'ededenham14@clickbank.net', '501-681-0310', 'zT3?R*y@.=');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (42, 'Vivien', 'Dafydd', 'vdafydd15@newyorker.com', '271-970-4650', 'bM0\"f}}lXQ\'uZ');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (43, 'Renae', 'McIlhatton', 'rmcilhatton16@google.ru', '694-863-1305', 'wP5!*Vg~y8g4DmAl');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (44, 'Caril', 'Howsam', 'chowsam17@redcross.org', '886-415-3308', 'iO7%aVgN%b3?tk');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (45, 'Emmie', 'Painswick', 'epainswick18@hao123.com', '168-533-7103', 'kL1!L#0W5V');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (46, 'Janel', 'Mil', 'jmil19@goo.ne.jp', '716-236-5937', 'sR7*NoX!');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (47, 'Joseph', 'Tague', 'jtague1a@microsoft.com', '102-577-3650', 'oX4,pCpUMM\\F');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (48, 'Findlay', 'Siddaley', 'fsiddaley1b@facebook.com', '483-171-5207', 'aH1>yLQ{h');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (49, 'Pen', 'Duffill', 'pduffill1c@creativecommons.org', '817-621-7877', 'oG7!=\"3v(F$OGR');
INSERT INTO `mydb`.`apprentice` (`apprenticeID`, `firstName`, `lastName`, `email`, `mobile`, `PassWord`) VALUES (50, 'Gideon', 'Parmley', 'gparmley1d@google.co.uk', '970-872-9595', 'zV9!_6!=WB,Fg7');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (1, 'Violette', 'Pallent', 'tN0*/7(/d', 'vpallent0@china.com.cn', '878-754-9156', '14-331-9367', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (2, 'Jacky', 'Drinkhill', 'mS3_<<+xAl(q', 'jdrinkhill1@psu.edu', '671-536-5474', '74-163-7511', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (3, 'Angie', 'Blakey', 'gB0.Y78o2', 'ablakey2@bigcartel.com', '883-201-6305', '84-997-9777', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (4, 'Sutherland', 'Dunnico', 'eU2>.(&`Xd{V', 'sdunnico3@dedecms.com', '165-488-0193', '97-515-6738', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (5, 'Jourdan', 'Syncke', 'vM1|_\"i?R?J(', 'jsyncke4@smugmug.com', '296-261-0665', '14-434-6108', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (6, 'Garvey', 'Grzelewski', 'vK1+&Cg@', 'ggrzelewski5@xinhuanet.com', '157-748-3188', '65-322-7671', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (7, 'Charmaine', 'Kubicek', 'vF7~\\L<R5#>', 'ckubicek6@mozilla.org', '411-112-3857', '06-976-9985', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (8, 'Sibella', 'Sacaze', 'mR7*}CNrQHjb', 'ssacaze7@51.la', '667-558-5859', '15-837-7391', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (9, 'Filmore', 'de Clerk', 'tL0)LU7I_{AGw', 'fdeclerk8@nbcnews.com', '464-582-5616', '21-680-4089', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (10, 'Lorene', 'Shemmin', 'aZ2?htuF\\1YAdh', 'lshemmin9@flavors.me', '332-703-3942', '49-120-4673', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (11, 'Isidora', 'Lovekin', 'yG0/F6$*Gf', 'ilovekina@goo.gl', '143-838-7342', '54-896-7702', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (12, 'Harper', 'Phebee', 'uM2`Hy\'W)`6G', 'hphebeeb@prnewswire.com', '517-263-6227', '70-723-1821', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (13, 'Maryellen', 'Mathet', 'zE5)6%0a*d%', 'mmathetc@artisteer.com', '805-747-2401', '26-179-2006', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (14, 'Jazmin', 'Beig', 'nZ1&cYoA3r%>', 'jbeigd@usgs.gov', '753-603-3329', '49-199-4820', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (15, 'Clerkclaude', 'MacDearmaid', 'zB5+1@|0/Qe\'(', 'cmacdearmaide@devhub.com', '855-535-1440', '13-414-2493', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (16, 'Junette', 'Giffaut', 'lR0`vqaFzp\'C', 'jgiffautf@sakura.ne.jp', '646-738-7844', '18-340-8892', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (17, 'Luisa', 'Leyrroyd', 'vE8}yq+.rcI?X7K', 'lleyrroydg@github.io', '612-895-9357', '88-836-7508', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (18, 'Thedric', 'Oglevie', 'qK6!g<\'E', 'toglevieh@jugem.jp', '878-537-9464', '00-092-7518', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (19, 'Noelani', 'Lilliman', 'kE2\\U>@Z`bk', 'nlillimani@yellowbook.com', '779-117-3529', '66-802-6183', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (20, 'Wernher', 'Prene', 'oT5*\'gZa1`33FpP', 'wprenej@scribd.com', '141-155-0030', '62-065-3537', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (21, 'Stepha', 'Le feaver', 'eQ4&M9.*%1', 'slefeaverk@loc.gov', '211-127-5934', '44-886-9648', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (22, 'Jeralee', 'Idell', 'dO4!&wot.b|?T*{R', 'jidelll@geocities.jp', '526-652-2537', '28-458-0599', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (23, 'Tally', 'Ren', 'pE3|9|P1ouV', 'trenm@yandex.ru', '199-825-9739', '80-364-5109', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (24, 'Yankee', 'Norkett', 'rO1`RSy=)2vl', 'ynorkettn@mlb.com', '975-774-4537', '04-561-2991', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (25, 'Clevie', 'Flarity', 'gX1)j*{)FuOTp8D{', 'cflarityo@bbc.co.uk', '481-615-6265', '67-451-2434', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (26, 'Shelby', 'Lathleiffure', 'kE7=L7\\M', 'slathleiffurep@statcounter.com', '504-916-8666', '39-428-1842', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (27, 'Juliane', 'Rackstraw', 'oE6{F?nwEy}', 'jrackstrawq@vinaora.com', '405-949-5126', '79-157-3903', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (28, 'Rockey', 'Pfaffel', 'tX1)<\"Ke', 'rpfaffelr@nature.com', '846-652-5589', '59-408-0821', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (29, 'Asia', 'Jerrim', 'lW0,U37\\I8C#R', 'ajerrims@artisteer.com', '562-281-2159', '25-594-4099', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (30, 'Kelley', 'Angus', 'qC5@QiPXbuQail)', 'kangust@fc2.com', '618-725-4381', '30-418-0617', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (31, 'Shepherd', 'Ullock', 'cW2&aX=$M/$', 'sullocku@tripod.com', '748-515-2401', '81-085-5320', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (32, 'Ethyl', 'Bycraft', 'sV5~?wqmhtGpBNH', 'ebycraftv@artisteer.com', '706-325-6455', '23-608-5123', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (33, 'Jeanelle', 'Foux', 'eB1@1(\"FR\\HUm', 'jfouxw@house.gov', '987-384-4247', '79-389-3081', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (34, 'Branden', 'Morot', 'tB4.GFNNkZ', 'bmorotx@goo.gl', '986-415-7244', '95-809-7025', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (35, 'Hobie', 'Brede', 'aR6=}~QK`2F,hH', 'hbredey@weather.com', '331-212-8614', '68-611-4559', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (36, 'Hurley', 'Wysome', 'jX5<V(~DNY', 'hwysomez@independent.co.uk', '882-890-9246', '53-269-2143', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (37, 'Webster', 'Laker', 'kL4+Zxc\'}u\"lL', 'wlaker10@last.fm', '221-312-5172', '53-865-9299', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (38, 'Holly', 'Elijah', 'zP2=+Qxr.g!<23', 'helijah11@illinois.edu', '289-474-4571', '74-567-6871', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (39, 'Lenora', 'Gillise', 'vA1|3\'.=0a', 'lgillise12@ucla.edu', '617-658-8886', '54-806-7328', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (40, 'Jolyn', 'Levin', 'zJ1!VJ.i+`i', 'jlevin13@bing.com', '874-422-8700', '31-492-0651', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (41, 'Reta', 'Presnell', 'rM2}i`Ge*', 'rpresnell14@msn.com', '305-203-2153', '79-688-1222', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (42, 'Francisco', 'Darth', 'oK7\',L*j', 'fdarth15@virginia.edu', '419-682-1352', '64-935-6933', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (43, 'Margarette', 'Kremer', 'xL7#rHd10F', 'mkremer16@squidoo.com', '949-395-4868', '77-263-8096', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (44, 'Matti', 'Labarre', 'gK4>kOy*', 'mlabarre17@rediff.com', '476-710-8064', '64-217-9745', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (45, 'Abbott', 'Fevers', 'dA0{1?@nW', 'afevers18@globo.com', '881-169-0719', '14-020-7240', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (46, 'Vanna', 'Ipgrave', 'rQ2!7BeAd$7QR', 'vipgrave19@unc.edu', '572-391-4876', '22-191-8073', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (47, 'Briant', 'Waddams', 'pX4`_DrLpE_`?iiH', 'bwaddams1a@samsung.com', '712-550-5729', '88-292-4597', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (48, 'Ailbert', 'Werny', 'zD4@{d}`', 'awerny1b@ted.com', '422-262-5078', '44-865-5693', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (49, 'Sidnee', 'De Beauchemp', 'iE3}~eEb\"Kyu5+Nc', 'sdebeauchemp1c@tumblr.com', '107-808-1705', '36-041-8519', , , );
INSERT INTO `mydb`.`user` (`UserNr`, `FirstName`, `LastName`, `PassWord`, `email`, `mobile`, `userID`, `county_idcounty`, `usertype_usertypeNr`, `apprentice_apprenticeID`) VALUES (50, 'Allyce', 'Shireff', 'qS3{HRz|rh', 'ashireff1d@myspace.com', '546-773-4102', '94-775-9277', , , );

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`job`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (1, 'Customer Service Representative', 'Taking on small projects', 'Galway', 'attention to detail', '9/30/2021', '11/26/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (2, 'Sales Associate', 'Taking on small projects', 'Wexford', 'communication', '10/29/2021', '11/5/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (3, 'Marketing Intern', 'Shadowing experienced professionals', 'Sligo', 'communication', '10/5/2021', '10/31/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (4, 'Graphic Design Assistant', 'Assisting with daily tasks', 'Sligo', 'attention to detail', '10/6/2021', '11/27/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (5, 'Sales Associate', 'Assisting with daily tasks', 'Wexford', 'communication', '10/28/2021', '11/13/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (6, 'Junior Developer', 'Taking on small projects', 'Derry', 'attention to detail', '9/30/2021', '12/22/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (7, 'Customer Service Representative', 'Shadowing experienced professionals', 'Donegal', 'time management', '10/2/2021', '10/26/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (8, 'Sales Associate', 'Taking on small projects', 'Sligo', 'communication', '10/7/2021', '11/22/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (9, 'Junior Developer', 'Assisting with daily tasks', 'Derry', 'teamwork', '10/16/2021', '10/10/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (10, 'Graphic Design Assistant', 'Shadowing experienced professionals', 'Cork', 'communication', '10/26/2021', '10/6/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (11, 'Junior Developer', 'Assisting with daily tasks', 'Sligo', 'communication', '10/14/2021', '12/5/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (12, 'Graphic Design Assistant', 'Assisting with daily tasks', 'Derry', 'attention to detail', '10/13/2021', '10/8/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (13, 'Junior Developer', 'Assisting with daily tasks', 'Wexford', 'teamwork', '10/6/2021', '10/5/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (14, 'Graphic Design Assistant', 'Assisting with daily tasks', 'Cork', 'problem-solving', '10/10/2021', '10/14/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (15, 'Marketing Intern', 'Learning new skills', 'Sligo', 'time management', '10/11/2021', '10/17/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (16, 'Customer Service Representative', 'Taking on small projects', 'Wexford', 'attention to detail', '10/13/2021', '11/9/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (17, 'Sales Associate', 'Assisting with daily tasks', 'Waterford', 'attention to detail', '10/4/2021', '11/27/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (18, 'Sales Associate', 'Learning new skills', 'Donegal', 'communication', '10/4/2021', '11/8/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (19, 'Junior Developer', 'Assisting with daily tasks', 'Derry', 'time management', '10/23/2021', '12/14/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (20, 'Junior Developer', 'Learning new skills', 'Derry', 'problem-solving', '10/20/2021', '10/29/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (21, 'Marketing Intern', 'Assisting with daily tasks', 'Dublin', 'communication', '10/18/2021', '10/20/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (22, 'Customer Service Representative', 'Assisting with daily tasks', 'Sligo', 'time management', '10/7/2021', '12/4/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (23, 'Sales Associate', 'Assisting with daily tasks', 'Dublin', 'time management', '10/28/2021', '11/20/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (24, 'Graphic Design Assistant', 'Taking on small projects', 'Wexford', 'attention to detail', '10/2/2021', '11/20/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (25, 'Graphic Design Assistant', 'Shadowing experienced professionals', 'Cork', 'teamwork', '10/26/2021', '12/29/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (26, 'Customer Service Representative', 'Assisting with daily tasks', 'Sligo', 'time management', '10/4/2021', '11/15/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (27, 'Marketing Intern', 'Assisting with daily tasks', 'Cork', 'attention to detail', '9/30/2021', '12/3/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (28, 'Marketing Intern', 'Learning new skills', 'Derry', 'time management', '10/2/2021', '10/10/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (29, 'Junior Developer', 'Assisting with daily tasks', 'Limerick', 'teamwork', '10/29/2021', '12/8/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (30, 'Customer Service Representative', 'Assisting with daily tasks', 'Dublin', 'problem-solving', '10/28/2021', '10/8/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (31, 'Marketing Intern', 'Taking on small projects', 'Waterford', 'problem-solving', '10/3/2021', '10/27/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (32, 'Marketing Intern', 'Taking on small projects', 'Wexford', 'problem-solving', '10/17/2021', '11/25/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (33, 'Marketing Intern', 'Taking on small projects', 'Sligo', 'communication', '10/11/2021', '12/25/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (34, 'Sales Associate', 'Learning new skills', 'Limerick', 'teamwork', '10/14/2021', '12/9/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (35, 'Marketing Intern', 'Shadowing experienced professionals', 'Kilkenny', 'time management', '10/9/2021', '10/25/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (36, 'Graphic Design Assistant', 'Taking on small projects', 'Kilkenny', 'teamwork', '10/9/2021', '12/30/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (37, 'Graphic Design Assistant', 'Shadowing experienced professionals', 'Kilkenny', 'teamwork', '10/11/2021', '11/20/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (38, 'Junior Developer', 'Assisting with daily tasks', 'Cork', 'problem-solving', '10/27/2021', '11/11/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (39, 'Graphic Design Assistant', 'Shadowing experienced professionals', 'Limerick', 'time management', '10/10/2021', '10/21/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (40, 'Junior Developer', 'Assisting with daily tasks', 'Cork', 'attention to detail', '10/23/2021', '10/21/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (41, 'Customer Service Representative', 'Shadowing experienced professionals', 'Kilkenny', 'communication', '10/12/2021', '11/23/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (42, 'Customer Service Representative', 'Learning new skills', 'Wexford', 'teamwork', '10/3/2021', '11/3/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (43, 'Customer Service Representative', 'Shadowing experienced professionals', 'Wexford', 'problem-solving', '10/12/2021', '12/11/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (44, 'Marketing Intern', 'Learning new skills', 'Sligo', 'attention to detail', '10/1/2021', '12/23/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (45, 'Marketing Intern', 'Assisting with daily tasks', 'Dublin', 'attention to detail', '10/15/2021', '12/7/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (46, 'Marketing Intern', 'Shadowing experienced professionals', 'Sligo', 'time management', '10/7/2021', '10/27/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (47, 'Marketing Intern', 'Learning new skills', 'Galway', 'teamwork', '10/3/2021', '12/18/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (48, 'Customer Service Representative', 'Shadowing experienced professionals', 'Galway', 'time management', '10/11/2021', '12/8/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (49, 'Customer Service Representative', 'Taking on small projects', 'Limerick', 'teamwork', '10/8/2021', '11/30/2021');
INSERT INTO `mydb`.`job` (`JobID`, `title`, `description`, `location`, `skills`, `startDate`, `endDate`) VALUES (50, 'Junior Developer', 'Taking on small projects', 'Sligo', 'attention to detail', '10/12/2021', '11/7/2021');

COMMIT;

