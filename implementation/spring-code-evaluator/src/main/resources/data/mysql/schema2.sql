-- MySQL Script generated by MySQL Workbench
-- Sat Oct 22 18:56:31 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema codeevaluator
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema codeevaluator
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `codeevaluator` DEFAULT CHARACTER SET utf8 ;
USE `codeevaluator` ;

-- -----------------------------------------------------
-- Table `codeevaluator`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`Account` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`Account` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `referenceId` VARCHAR(255) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT b'1',
  `credentialsexpired` BIT(1) NOT NULL DEFAULT b'0',
  `expired` BIT(1) NOT NULL DEFAULT b'0',
  `locked` BIT(1) NOT NULL DEFAULT b'0',
  `version` INT(10) UNSIGNED NOT NULL,
  `createdBy` VARCHAR(100) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedBy` VARCHAR(100) NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UQ_Account_ReferenceId` (`referenceId` ASC),
  UNIQUE INDEX `UQ_Account_Username` (`username` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`Role` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`Role` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `code` VARCHAR(50) NOT NULL,
  `label` VARCHAR(100) NOT NULL,
  `ordinal` INT(10) UNSIGNED NOT NULL,
  `effectiveAt` DATETIME NOT NULL,
  `expiresAt` DATETIME NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UQ_Role_Code` (`code` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`AccountRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`AccountRole` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`AccountRole` (
  `accountId` BIGINT(20) UNSIGNED NOT NULL,
  `roleId` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`accountId`, `roleId`),
  INDEX `FK_AccountRole_RoleId` (`roleId` ASC),
  CONSTRAINT `FK_AccountRole_AccountId`
    FOREIGN KEY (`accountId`)
    REFERENCES `codeevaluator`.`Account` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `FK_AccountRole_RoleId`
    FOREIGN KEY (`roleId`)
    REFERENCES `codeevaluator`.`Role` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`Exam`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`Exam` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`Exam` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `degree` VARCHAR(45) NOT NULL,
  `class` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'O',
  `progress` INT(100) NOT NULL DEFAULT '0',
  `nquestions` INT(10) NOT NULL DEFAULT '0',
  `referenceId` VARCHAR(45) NOT NULL,
  `version` INT(10) UNSIGNED NOT NULL,
  `createdBy` VARCHAR(100) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedBy` VARCHAR(100) NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `referenceId_UNIQUE` (`referenceId` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.Greeting`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `Greeting`;

CREATE TABLE `Greeting` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `referenceId` varchar(255) NOT NULL,
  `text` varchar(100) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `createdBy` varchar(100) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedBy` varchar(100) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY(`id`),
  CONSTRAINT `UQ_Greeting_ReferenceId` UNIQUE (`referenceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`Examiner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`Examiner` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`Examiner` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `accountId` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `accountId_UNIQUE` (`accountId` ASC),
  CONSTRAINT `FQ_Examiner_AccountId`
    FOREIGN KEY (`accountId`)
    REFERENCES `codeevaluator`.`Account` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`Exercise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`Exercise` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`Exercise` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `examinerId` BIGINT(20) UNSIGNED,
  `examId` BIGINT(20) UNSIGNED NOT NULL,
  `question` TEXT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'O',
  `progress` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `nsubmissions` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `weight` INT(10) NOT NULL,
  `command` TEXT NULL DEFAULT NULL,
  `path` VARCHAR(100) NULL DEFAULT '/',
  PRIMARY KEY (`id`),
  INDEX `FK_Exercise_ExamId_idx` (`examId` ASC),
  INDEX `FK_Exercise_ExaminerId_idx` (`examinerId` ASC),
  CONSTRAINT `FK_Exercise_ExamId`
    FOREIGN KEY (`examId`)
    REFERENCES `codeevaluator`.`Exam` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Exercise_ExaminerId`
    FOREIGN KEY (`examinerId`)
    REFERENCES `codeevaluator`.`Examiner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`ExerciseCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`ExerciseCriteria` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`ExerciseCriteria` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `exerciseId` BIGINT(20) UNSIGNED NOT NULL,
  `description` TEXT NOT NULL,
  `gama` INT(10) NOT NULL DEFAULT '0',
  `weight` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_ExerciseCriteria_idExercise_idx` (`exerciseId` ASC),
  CONSTRAINT `FK_ExerciseCriteria_idExercise`
    FOREIGN KEY (`exerciseId`)
    REFERENCES `codeevaluator`.`Exercise` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`Student` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`Student` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `number_UNIQUE` (`username` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`StudentExam`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`StudentExam` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`StudentExam` (
  `studentId` BIGINT(20) UNSIGNED NOT NULL,
  `examId` BIGINT(20) UNSIGNED NOT NULL,
  `grade` INT(10) NOT NULL DEFAULT '0',
  `status` VARCHAR(45) NOT NULL DEFAULT 'O',
  PRIMARY KEY (`studentId`, `examId`),
  INDEX `FK_StudentExam_ExamId_idx` (`examId` ASC),
  CONSTRAINT `FK_StudentExam_ExamId`
    FOREIGN KEY (`examId`)
    REFERENCES `codeevaluator`.`Exam` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_StudentExam_StudentId`
    FOREIGN KEY (`studentId`)
    REFERENCES `codeevaluator`.`Student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`Submission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`Submission` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`Submission` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `examId` BIGINT(20) UNSIGNED NOT NULL,
  `exerciseId` BIGINT(20) UNSIGNED NOT NULL,
  `studentId` BIGINT(20) UNSIGNED NOT NULL,
  `code` LONGTEXT NULL DEFAULT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'O',
  `grade` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `path` VARCHAR(100) NOT NULL DEFAULT '/',
  PRIMARY KEY (`id`),
  INDEX `FQ_Submission_ExamId_idx` (`examId` ASC),
  INDEX `FQ_Submission_StudentId_idx` (`studentId` ASC),
  INDEX `FQ_Submission_ExerciseId_idx` (`exerciseId` ASC),
  CONSTRAINT `FQ_Submission_ExamId`
    FOREIGN KEY (`examId`)
    REFERENCES `codeevaluator`.`Exam` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FQ_Submission_ExerciseId`
    FOREIGN KEY (`exerciseId`)
    REFERENCES `codeevaluator`.`Exercise` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FQ_Submission_StudentId`
    FOREIGN KEY (`studentId`)
    REFERENCES `codeevaluator`.`Student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `codeevaluator`.`SubmissionCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `codeevaluator`.`SubmissionCriteria` ;

CREATE TABLE IF NOT EXISTS `codeevaluator`.`SubmissionCriteria` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `submissionId` BIGINT(20) UNSIGNED NOT NULL,
  `exerciseCriteriaId` BIGINT(20) UNSIGNED NOT NULL,
  `grade` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `FK_SubmissionCriteria_SubmissionId_idx` (`submissionId` ASC),
  INDEX `FK_SubmissionCriteria_ExerciseCriteriaId_idx` (`exerciseCriteriaId` ASC),
  CONSTRAINT `FK_SubmissionCriteria_ExerciseCriteriaId`
    FOREIGN KEY (`exerciseCriteriaId`)
    REFERENCES `codeevaluator`.`ExerciseCriteria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SubmissionCriteria_SubmissionId`
    FOREIGN KEY (`submissionId`)
    REFERENCES `codeevaluator`.`Submission` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;