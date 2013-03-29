SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `grad_road` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `grad_road` ;

-- -----------------------------------------------------
-- Table `grad_road`.`members`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`members` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `username` TEXT NOT NULL ,
  `password` TEXT NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `profile` TINYTEXT NOT NULL ,
  `profile_picture` VARCHAR(80) NOT NULL ,
  `usertype` ENUM('norm', 'twitter', 'fb') NOT NULL ,
  `modify_date` TIMESTAMP NOT NULL ,
  `FID` VARCHAR(45) NOT NULL ,
  `points` TEXT NOT NULL ,
  PRIMARY KEY (`index`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`friends`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`friends` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `my_index` INT NOT NULL ,
  `friend_index` INT NOT NULL ,
  `status` ENUM('pending', 'rejected', 'accepted') NOT NULL ,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `news_type` SET('friends') NOT NULL DEFAULT 'friends' ,
  PRIMARY KEY (`index`) ,
  INDEX `fk_friends_members` (`my_index` ASC) ,
  INDEX `fk_friends_members1` (`friend_index` ASC) ,
  CONSTRAINT `fk_friends_members`
    FOREIGN KEY (`my_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_friends_members1`
    FOREIGN KEY (`friend_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`wall`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`wall` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `members_index` INT NOT NULL ,
  `timestamp` VARCHAR(45) NULL ,
  PRIMARY KEY (`index`) ,
  INDEX `fk_wall_members1` (`members_index` ASC) ,
  CONSTRAINT `fk_wall_members1`
    FOREIGN KEY (`members_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`privacy`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`privacy` (
  `members_index` INT NOT NULL ,
  `let_write_wall` ENUM('all','friends','only_me','hide') NOT NULL ,
  `let_see_profile` ENUM('all','friends','only_me') NOT NULL ,
  `let_see_schedule` ENUM('all','friends','only_me') NOT NULL ,
  PRIMARY KEY (`members_index`) ,
  INDEX `fk_privacy_members1` (`members_index` ASC) ,
  CONSTRAINT `fk_privacy_members1`
    FOREIGN KEY (`members_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`major`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`major` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `name` TEXT NOT NULL ,
  `description` TEXT NOT NULL ,
  `major_pic` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`index`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`member_has_major`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`member_has_major` (
  `index` INT(11) NOT NULL AUTO_INCREMENT ,
  `members_index` INT(11) NOT NULL ,
  `major_index` INT(11) NOT NULL ,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`index`) ,
  INDEX `fk_members_has_group_group1` (`major_index` ASC) ,
  INDEX `fk_members_has_group_members1` (`members_index` ASC) ,
  CONSTRAINT `fk_members_has_group_group1`
    FOREIGN KEY (`major_index` )
    REFERENCES `grad_road`.`major` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_members_has_group_members1`
    FOREIGN KEY (`members_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`chat`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`chat` (
  `index` INT(11) NOT NULL AUTO_INCREMENT ,
  `chat` VARCHAR(45) NOT NULL ,
  `wall_index` INT(11) NOT NULL ,
  `members_index` INT(11) NOT NULL ,
  `timestamp` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`index`) ,
  INDEX `fk_chat_wall1` (`wall_index` ASC) ,
  INDEX `fk_chat_members1` (`members_index` ASC) ,
  CONSTRAINT `fk_chat_members1`
    FOREIGN KEY (`members_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_chat_wall1`
    FOREIGN KEY (`wall_index` )
    REFERENCES `grad_road`.`wall` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`courses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`courses` (
  `index` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NOT NULL ,
  `description` TINYTEXT NOT NULL ,
  `register_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `season` TEXT NOT NULL ,
  `ccn` INT NOT NULL ,
  `prerequisites` TEXT NOT NULL ,
  `instructor` TEXT NOT NULL ,
  `location` TEXT NOT NULL ,
  `lat` TEXT NOT NULL ,
  `lng` TEXT NOT NULL ,
  `category` TEXT NOT NULL ,
  PRIMARY KEY (`index`) )
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`comment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`comment` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `comment` TINYTEXT NOT NULL ,
  `members_index` INT NOT NULL ,
  `courses_index` INT NOT NULL ,
  `timestamp` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`index`) ,
  INDEX `fk_comment_members1` (`members_index` ASC) ,
  INDEX `fk_comment_product1` (`courses_index` ASC) ,
  CONSTRAINT `fk_comment_members1`
    FOREIGN KEY (`members_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_product1`
    FOREIGN KEY (`courses_index` )
    REFERENCES `grad_road`.`courses` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`member_has_course`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`member_has_course` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `members_index` INT NOT NULL ,
  `course_index` INT(11) NOT NULL ,
  `season` VARCHAR(45) NOT NULL ,
  `year` INT NOT NULL ,
  PRIMARY KEY (`index`) ,
  INDEX `fk_member_has_meeting_members1` (`members_index` ASC) ,
  INDEX `fk_member_has_meeting_meeting1` (`course_index` ASC) ,
  CONSTRAINT `fk_member_has_meeting_members1`
    FOREIGN KEY (`members_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_member_has_meeting_meeting1`
    FOREIGN KEY (`course_index` )
    REFERENCES `grad_road`.`courses` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grad_road`.`major_has_courses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`major_has_courses` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `major_index` INT NOT NULL ,
  `courses_index` INT(11) NOT NULL ,
  INDEX `fk_group_has_meeting_group1` (`major_index` ASC) ,
  INDEX `fk_group_has_meeting_meeting1` (`courses_index` ASC) ,
  PRIMARY KEY (`index`) ,
  CONSTRAINT `fk_group_has_meeting_group1`
    FOREIGN KEY (`major_index` )
    REFERENCES `grad_road`.`major` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_group_has_meeting_meeting1`
    FOREIGN KEY (`courses_index` )
    REFERENCES `grad_road`.`courses` (`index` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grad_road`.`day`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`day` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`index`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`course_has_day`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`course_has_day` (
  `courses_index` INT(11) NOT NULL ,
  `day_index` INT NOT NULL ,
  PRIMARY KEY (`courses_index`, `day_index`) ,
  INDEX `fk_courses_has_day_of_week_day_of_week1` (`day_index` ASC) ,
  INDEX `fk_courses_has_day_of_week_courses1` (`courses_index` ASC) ,
  CONSTRAINT `fk_courses_has_day_of_week_courses1`
    FOREIGN KEY (`courses_index` )
    REFERENCES `grad_road`.`courses` (`index` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_has_day_of_week_day_of_week1`
    FOREIGN KEY (`day_index` )
    REFERENCES `grad_road`.`day` (`index` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`time`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`time` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `hour` INT NOT NULL ,
  `minute` INT NOT NULL ,
  `show` TEXT NOT NULL ,
  PRIMARY KEY (`index`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grad_road`.`day_has_time`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`day_has_time` (
  `day_index` INT NOT NULL ,
  `time_index` INT NOT NULL ,
  PRIMARY KEY (`day_index`, `time_index`) ,
  INDEX `fk_day_has_time_time1` (`time_index` ASC) ,
  INDEX `fk_day_has_time_day1` (`day_index` ASC) ,
  CONSTRAINT `fk_day_has_time_day1`
    FOREIGN KEY (`day_index` )
    REFERENCES `grad_road`.`day` (`index` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_day_has_time_time1`
    FOREIGN KEY (`time_index` )
    REFERENCES `grad_road`.`time` (`index` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `grad_road`.`has_semester`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `grad_road`.`has_semester` (
  `index` INT NOT NULL AUTO_INCREMENT ,
  `members_index` INT NOT NULL ,
  `table` TINYTEXT NOT NULL ,
  `year` TINYTEXT NOT NULL ,
  `season` TINYTEXT NOT NULL ,
  PRIMARY KEY (`index`) ,
  INDEX `fk_has_semester_members1` (`members_index` ASC) ,
  CONSTRAINT `fk_has_semester_members1`
    FOREIGN KEY (`members_index` )
    REFERENCES `grad_road`.`members` (`index` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Placeholder table for view `grad_road`.`members_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grad_road`.`members_view` (`index` INT, `username` INT, `profile_picture` INT);

-- -----------------------------------------------------
-- Placeholder table for view `grad_road`.`course_comment_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grad_road`.`course_comment_view` (`members_index` INT, `profile_picture` INT, `username` INT, `comment_index` INT, `comment_text` INT, `meeting_index` INT, `timestamp` INT);

-- -----------------------------------------------------
-- Placeholder table for view `grad_road`.`friends_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grad_road`.`friends_view` (`my_index` INT, `friend_index` INT, `status` INT, `timestamp` INT, `news_type` INT, `my_name` INT, `my_pic` INT, `friend_name` INT, `friend_pic` INT);

-- -----------------------------------------------------
-- Placeholder table for view `grad_road`.`wall_chat_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grad_road`.`wall_chat_view` (`chat_index` INT, `wall_index` INT, `chat_post` INT, `members_index` INT, `profile_picture` INT, `username` INT, `timestamp` INT);

-- -----------------------------------------------------
-- Placeholder table for view `grad_road`.`user_blurprint_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grad_road`.`user_blurprint_view` (`index` INT, `members_index` INT, `course_index` INT, `status` INT, `season` INT, `year` INT, `blueprint_insert` INT, `course_name` INT, `abbreviation` INT, `ccn` INT);

-- -----------------------------------------------------
-- View `grad_road`.`members_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grad_road`.`members_view`;
USE `grad_road`;
CREATE  OR REPLACE VIEW `meeting_meeting`.`members_view` AS


 select 

`meeting_meeting`.`members`.`index` AS `index`,

`meeting_meeting`.`members`.`username` AS `username`,

`meeting_meeting`.`members`.`profile_picture` AS `profile_picture`

from(`meeting_meeting`.`members`);

-- -----------------------------------------------------
-- View `grad_road`.`course_comment_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grad_road`.`course_comment_view`;
USE `grad_road`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER 

VIEW `grad_road`.`course_comment_view` AS select 

`grad_road`.`members`.`index` AS `members_index`,

`grad_road`.`members`.`profile_picture` AS `profile_picture`,

`grad_road`.`members`.`username` AS `username`,

`grad_road`.`comment`.`index` AS `comment_index`,

`grad_road`.`comment`.`comment` AS `comment_text`,

`grad_road`.`comment`.`courses_index` AS `meeting_index`,

`grad_road`.`comment`.`timestamp` AS `timestamp`



 from (`grad_road`.`members`) join (`grad_road`.`comment`) 

on(`grad_road`.`members`.`index` = `grad_road`.`comment`.`members_index`) 

;

-- -----------------------------------------------------
-- View `grad_road`.`friends_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grad_road`.`friends_view`;
USE `grad_road`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER 

VIEW `meeting_meeting`.`friends_view` AS select 

`meeting_meeting`.`friends`.`my_index` AS `my_index`,

`meeting_meeting`.`friends`.`friend_index` AS `friend_index`,

`meeting_meeting`.`friends`.`status` AS `status`,

`meeting_meeting`.`friends`.`timestamp` AS `timestamp`,

`meeting_meeting`.`friends`.`news_type` AS `news_type`,

`meeting_meeting`.`members`.`username` AS `my_name`,

`meeting_meeting`.`members`.`profile_picture` AS `my_pic`,

`meeting_meeting`.`members_view`.`username` AS `friend_name`,

`meeting_meeting`.`members_view`.`profile_picture` AS `friend_pic`

 from (`meeting_meeting`.`friends` 

left join (`meeting_meeting`.`members` join `meeting_meeting`.`members_view`) 

on(((`meeting_meeting`.`friends`.`my_index` = `meeting_meeting`.`members`.`index`) 

and (`meeting_meeting`.`friends`.`friend_index` = `meeting_meeting`.`members_view`.`index`))));

-- -----------------------------------------------------
-- View `grad_road`.`wall_chat_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grad_road`.`wall_chat_view`;
USE `grad_road`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER 

VIEW `grad_road`.`wall_chat_view` AS select 

`grad_road`.`chat`.`index` AS `chat_index`,

`grad_road`.`chat`.`wall_index` AS `wall_index`,

`grad_road`.`chat`.`chat` AS `chat_post`,

`grad_road`.`chat`.`members_index` AS `members_index`,



`grad_road`.`members`.`profile_picture` AS `profile_picture`,

`grad_road`.`members`.`username` AS `username`,

`grad_road`.`chat`.`timestamp` AS `timestamp`



 from (`grad_road`.`chat`) join (`grad_road`.`members`) 

on(`grad_road`.`members`.`index` = `grad_road`.`chat`.`members_index`) 

;

-- -----------------------------------------------------
-- View `grad_road`.`user_blurprint_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grad_road`.`user_blurprint_view`;
USE `grad_road`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER 

VIEW `grad_road`.`user_blurprint_view` AS select 



`grad_road`.`member_has_course`.`index` AS `index`,



`grad_road`.`member_has_course`.`members_index` AS `members_index`,

`grad_road`.`member_has_course`.`course_index` AS `course_index`,

`grad_road`.`member_has_course`.`status` AS `status`,

`grad_road`.`member_has_course`.`season` AS `season`,

`grad_road`.`member_has_course`.`year` AS `year`,

`grad_road`.`member_has_course`.`blueprint_insert` AS `blueprint_insert`,

`grad_road`.`courses`.`name` AS `course_name`,

`grad_road`.`courses`.`abbreviation` AS `abbreviation`,

`grad_road`.`courses`.`ccn` AS `ccn`



 from (`grad_road`.`member_has_course`) join (`grad_road`.`courses`) 

on(`grad_road`.`member_has_course`.`course_index` = `grad_road`.`courses`.`index`) 

;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
