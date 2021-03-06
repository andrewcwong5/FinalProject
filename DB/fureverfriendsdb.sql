-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fureverfriendsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `fureverfriendsdb` ;

-- -----------------------------------------------------
-- Schema fureverfriendsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fureverfriendsdb` DEFAULT CHARACTER SET utf8 ;
USE `fureverfriendsdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NOT NULL,
  `street2` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  `state_abbr` VARCHAR(2) NULL,
  `zip` INT NOT NULL DEFAULT 00000,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account` ;

CREATE TABLE IF NOT EXISTS `account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(455) NOT NULL,
  `role` VARCHAR(50) NOT NULL,
  `active` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shelter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shelter` ;

CREATE TABLE IF NOT EXISTS `shelter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(25) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `website_url` TEXT NULL,
  `email` VARCHAR(100) NULL,
  `address_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_shelter_address1_idx` (`address_id` ASC),
  INDEX `fk_shelter_account1_idx` (`account_id` ASC),
  CONSTRAINT `fk_shelter_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shelter_account1`
    FOREIGN KEY (`account_id`)
    REFERENCES `account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `fname` VARCHAR(50) NOT NULL,
  `lname` VARCHAR(50) NOT NULL,
  `age` INT NULL,
  `phone` VARCHAR(25) NULL,
  `address_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_address1_idx` (`address_id` ASC),
  INDEX `fk_user_account1_idx` (`account_id` ASC),
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_account1`
    FOREIGN KEY (`account_id`)
    REFERENCES `account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trait`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trait` ;

CREATE TABLE IF NOT EXISTS `trait` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `species`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `species` ;

CREATE TABLE IF NOT EXISTS `species` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `breed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `breed` ;

CREATE TABLE IF NOT EXISTS `breed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `hypoallergenic` TINYINT NOT NULL DEFAULT 0,
  `hair_type` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `species_id` INT NOT NULL,
  `size` VARCHAR(25) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_breed_species1_idx` (`species_id` ASC),
  CONSTRAINT `fk_breed_species1`
    FOREIGN KEY (`species_id`)
    REFERENCES `species` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pet` ;

CREATE TABLE IF NOT EXISTS `pet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `size` VARCHAR(45) NULL,
  `weight` INT NULL,
  `age` INT NULL,
  `color` VARCHAR(45) NULL,
  `fixed` TINYINT NULL,
  `special_conditions` TEXT NULL,
  `bio` TEXT NULL,
  `adopted` TINYINT NULL,
  `shelter_id` INT NOT NULL,
  `breed_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pet_shelter1_idx` (`shelter_id` ASC),
  INDEX `fk_pet_breed1_idx` (`breed_id` ASC),
  CONSTRAINT `fk_pet_shelter1`
    FOREIGN KEY (`shelter_id`)
    REFERENCES `shelter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_breed1`
    FOREIGN KEY (`breed_id`)
    REFERENCES `breed` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image` ;

CREATE TABLE IF NOT EXISTS `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_trait`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pet_trait` ;

CREATE TABLE IF NOT EXISTS `pet_trait` (
  `pet_id` INT NOT NULL,
  `trait_id` INT NOT NULL,
  PRIMARY KEY (`pet_id`, `trait_id`),
  INDEX `fk_pet_has_traits_traits1_idx` (`trait_id` ASC),
  INDEX `fk_pet_has_traits_pet_idx` (`pet_id` ASC),
  CONSTRAINT `fk_pet_has_traits_pet`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_traits_traits1`
    FOREIGN KEY (`trait_id`)
    REFERENCES `trait` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pet_image` ;

CREATE TABLE IF NOT EXISTS `pet_image` (
  `image_id` INT NOT NULL,
  `pet_id` INT NOT NULL,
  PRIMARY KEY (`image_id`, `pet_id`),
  INDEX `fk_pet_images_has_pet_pet1_idx` (`pet_id` ASC),
  INDEX `fk_pet_images_has_pet_pet_images1_idx` (`image_id` ASC),
  CONSTRAINT `fk_pet_images_has_pet_pet_images1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_images_has_pet_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foster`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foster` ;

CREATE TABLE IF NOT EXISTS `foster` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `max_foster` INT NOT NULL DEFAULT 1,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_foster_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_foster_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foster_breed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foster_breed` ;

CREATE TABLE IF NOT EXISTS `foster_breed` (
  `foster_id` INT NOT NULL,
  `breed_id` INT NOT NULL,
  PRIMARY KEY (`foster_id`, `breed_id`),
  INDEX `fk_foster_has_breed_breed1_idx` (`breed_id` ASC),
  INDEX `fk_foster_has_breed_foster1_idx` (`foster_id` ASC),
  CONSTRAINT `fk_foster_has_breed_foster1`
    FOREIGN KEY (`foster_id`)
    REFERENCES `foster` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_foster_has_breed_breed1`
    FOREIGN KEY (`breed_id`)
    REFERENCES `breed` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foster_trait`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foster_trait` ;

CREATE TABLE IF NOT EXISTS `foster_trait` (
  `trait_id` INT NOT NULL,
  `foster_id` INT NOT NULL,
  PRIMARY KEY (`trait_id`, `foster_id`),
  INDEX `fk_traits_has_foster_foster1_idx` (`foster_id` ASC),
  INDEX `fk_traits_has_foster_traits1_idx` (`trait_id` ASC),
  CONSTRAINT `fk_traits_has_foster_traits1`
    FOREIGN KEY (`trait_id`)
    REFERENCES `trait` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_traits_has_foster_foster1`
    FOREIGN KEY (`foster_id`)
    REFERENCES `foster` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foster_pet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foster_pet` ;

CREATE TABLE IF NOT EXISTS `foster_pet` (
  `foster_id` INT NOT NULL,
  `pet_id` INT NOT NULL,
  `id` INT NOT NULL,
  `date_requested` DATETIME NULL,
  `active` TINYINT NULL,
  `notes` TEXT NULL,
  `date_completed` DATETIME NULL,
  INDEX `fk_foster_has_pet_pet1_idx` (`pet_id` ASC),
  INDEX `fk_foster_has_pet_foster1_idx` (`foster_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_foster_has_pet_foster1`
    FOREIGN KEY (`foster_id`)
    REFERENCES `foster` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_foster_has_pet_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fost_reputation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fost_reputation` ;

CREATE TABLE IF NOT EXISTS `fost_reputation` (
  `id` INT NOT NULL,
  `foster_id` INT NOT NULL,
  `content` TEXT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reputation_foster1_idx` (`foster_id` ASC),
  CONSTRAINT `fk_reputation_foster1`
    FOREIGN KEY (`foster_id`)
    REFERENCES `foster` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `skill` ;

CREATE TABLE IF NOT EXISTS `skill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteer_skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteer_skill` ;

CREATE TABLE IF NOT EXISTS `volunteer_skill` (
  `skill_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`skill_id`, `user_id`),
  INDEX `fk_volunteer_has_skills_skills1_idx` (`skill_id` ASC),
  INDEX `fk_volunteer_skill_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_volunteer_has_skills_skills1`
    FOREIGN KEY (`skill_id`)
    REFERENCES `skill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_volunteer_skill_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shelter_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shelter_image` ;

CREATE TABLE IF NOT EXISTS `shelter_image` (
  `shelter_id` INT NOT NULL,
  `image_id` INT NOT NULL,
  PRIMARY KEY (`shelter_id`, `image_id`),
  INDEX `fk_shelter_has_images_images1_idx` (`image_id` ASC),
  INDEX `fk_shelter_has_images_shelter1_idx` (`shelter_id` ASC),
  CONSTRAINT `fk_shelter_has_images_shelter1`
    FOREIGN KEY (`shelter_id`)
    REFERENCES `shelter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shelter_has_images_images1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `species_foster`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `species_foster` ;

CREATE TABLE IF NOT EXISTS `species_foster` (
  `species_id` INT NOT NULL,
  `foster_id` INT NOT NULL,
  PRIMARY KEY (`species_id`, `foster_id`),
  INDEX `fk_species_has_foster_foster1_idx` (`foster_id` ASC),
  INDEX `fk_species_has_foster_species1_idx` (`species_id` ASC),
  CONSTRAINT `fk_species_has_foster_species1`
    FOREIGN KEY (`species_id`)
    REFERENCES `species` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_species_has_foster_foster1`
    FOREIGN KEY (`foster_id`)
    REFERENCES `foster` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_adoption`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pet_adoption` ;

CREATE TABLE IF NOT EXISTS `pet_adoption` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_requested` DATETIME NULL,
  `accepted_date` DATETIME NULL,
  `meet_date` DATETIME NULL,
  `meet_req_date` DATETIME NULL,
  `meet_notes` TEXT NULL,
  `accepted` TINYINT NULL,
  `reason_denied` TEXT NULL,
  `user_id` INT NOT NULL,
  `pet_id` INT NOT NULL,
  INDEX `fk_pet_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_pet_has_user_pet1_idx` (`pet_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pet_has_user_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_shelter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_shelter` ;

CREATE TABLE IF NOT EXISTS `user_shelter` (
  `shelter_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`shelter_id`, `user_id`),
  INDEX `fk_shelter_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_shelter_has_user_shelter1_idx` (`shelter_id` ASC),
  CONSTRAINT `fk_shelter_has_user_shelter1`
    FOREIGN KEY (`shelter_id`)
    REFERENCES `shelter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shelter_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_image` ;

CREATE TABLE IF NOT EXISTS `user_image` (
  `user_id` INT NOT NULL,
  `image_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `image_id`),
  INDEX `fk_user_has_image_image1_idx` (`image_id` ASC),
  INDEX `fk_user_has_image_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_image_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_image_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS fureverfriend@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'fureverfriend'@'localhost' IDENTIFIED BY 'fureverfriend';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'fureverfriend'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (1, '13883 E. 104th place', NULL, 'Commerce City', 'CO', 80022);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (2, '2129 W Chenango Ave', 'Unit A', 'Littleton', 'CO', 80120);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (3, '1543 Euclid Cir', NULL, 'Lafayette', 'CO', 80026);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (4, '1005 Galapago St, Denver, CO 80204', NULL, 'Denver', 'CO', 80204);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (5, '2390 S Delaware St', NULL, 'Denver', 'CO', 80223);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (6, '3535 S Allison St', NULL, 'Lakewood', 'CO', 80235);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (7, '2540 Youngfield Street', NULL, 'Lakewood', 'CO', 80215);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (8, '20 Stewart court', NULL, 'Erie', 'CO', 80516);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (9, '9701 pearl street', 'Apartment 7208', 'Thornton', 'CO', 80229);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (10, '11011 Kendall Way', NULL, 'Broomfield', 'CO', 80020);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_abbr`, `zip`) VALUES (11, '13883 E. 124th place', NULL, 'Arvada', 'CO', 80113);

COMMIT;


-- -----------------------------------------------------
-- Data for table `account`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (1, 'testUser', '$2a$10$4/uOpqYJAuFaGdV8NEAPbemjP83BxDOlHl7HtHR56nG5/VYlnjO/W', 'user', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (2, 'secondUser', '$2a$10$7mTrbTc/mW2F8kI8QWnOOOpjN/5wrp12yfHPjQnUaTExA0FBILxim', 'admin', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (3, 'bakaie', '$2a$10$3XsGXUjbMqOXwe4xr7.aeeuDrJX8tjDrGrOj7jD3GvT94lsa/mFEy', 'user', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (4, 'Vint3r', '$2a$10$Boq8TvC/FHax/Qv99MP/2OdE32WldKh0ehB8IW./F1RqwOPn6l0VS', 'user', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (5, 'shawn', '$2a$10$oLHOtibKwe1vDmkxR5fF2OCEgayErFwNR91IKuH7RMvjnxDTCsuxi', 'user', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (6, 'u', '$2a$10$SXrc2yoMtn61aS6nBePqXOeOqHDju/RYvehyrYnq.3aZqcLyj6gYC', 'user', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (7, 'testShelter', '$2a$10$gPAwMyKSpYyOki4xMV0mSOkn6EmrzDR8yODMT2repEsnHhNyEzRD', 'shelter', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (8, 'maxFund', '$2a$10$2/GbjHwqsMpC2jPIM.X0cOoTsRy1A72ubbHBrnM8ie3fE/Zn97asa', 'shelter', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (9, 'felineRescue', '$2a$10$JNScNr0HWwZgtg3Yj/Q8gu2JIiRutUm8fTZZDT24gcD0AJbgRU32O', 'shelter', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (10, 's', '$2a$10$3m2RLZsNS66R4Tct78t.yOEbqJoMSBSEhplmxOEON6SMaERNof2Ne', 'shelter', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (11, 'angelsWithPaws', '$2a$10$9WwG3v4TACP6EetrrDucU.GG8Y.CRaBHExZon0C7DcpS2HvRqNXRa', 'shelter', 1);
INSERT INTO `account` (`id`, `username`, `password`, `role`, `active`) VALUES (12, 'testbob', '$2a$10$iyWklXC1EIk3O33PnIVdF.trkp4vLleCanhvEUvgN2z9mTQHtBfvW', 'user', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `shelter`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `shelter` (`id`, `phone`, `name`, `website_url`, `email`, `address_id`, `account_id`) VALUES (1, '3037032938', 'Humane Society Of The South Platte Valley', 'hsspv.org', 'info@hsspv.org', 2, 7);
INSERT INTO `shelter` (`id`, `phone`, `name`, `website_url`, `email`, `address_id`, `account_id`) VALUES (2, '3035954917', 'MaxFund Dog Shelter', 'https://maxfund.org/locationhours/', 'N/A', 4, 8);
INSERT INTO `shelter` (`id`, `phone`, `name`, `website_url`, `email`, `address_id`, `account_id`) VALUES (3, '3037446076', 'Rocky Mountain Feline Rescue', 'https://www.rmfr-colorado.org/', 'N/A', 5, 9);
INSERT INTO `shelter` (`id`, `phone`, `name`, `website_url`, `email`, `address_id`, `account_id`) VALUES (4, '7203360770', 'Life Is Better Rescue', 'https://lifeisbetterrescue.org/', 'info@lifeisbetterrescue.org', 6, 10);
INSERT INTO `shelter` (`id`, `phone`, `name`, `website_url`, `email`, `address_id`, `account_id`) VALUES (5, '3032742264', 'Angels With Paws', 'http://www.angelswithpaws.net/', 'angelswithpaws@yahoo.com', 7, 11);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `user` (`id`, `email`, `fname`, `lname`, `age`, `phone`, `address_id`, `account_id`) VALUES (1, 'test.email@gmail.com', 'bob', 'boberson', 35, '3033598941', 1, 1);
INSERT INTO `user` (`id`, `email`, `fname`, `lname`, `age`, `phone`, `address_id`, `account_id`) VALUES (2, 'test2.email@gmail.com', 'Liam', 'Wilbur', 24, '3037562190', 3, 2);
INSERT INTO `user` (`id`, `email`, `fname`, `lname`, `age`, `phone`, `address_id`, `account_id`) VALUES (3, 'brian@gmail.com', 'Brian', 'Norris', 45, '3035038314', 8, 3);
INSERT INTO `user` (`id`, `email`, `fname`, `lname`, `age`, `phone`, `address_id`, `account_id`) VALUES (4, 'david@gmail.com', 'David', 'Norris', 25, '3033623031', 8, 4);
INSERT INTO `user` (`id`, `email`, `fname`, `lname`, `age`, `phone`, `address_id`, `account_id`) VALUES (5, 'shawn@gmail.com', 'Shawn', 'Benyak', 26, '3037568901', 9, 5);
INSERT INTO `user` (`id`, `email`, `fname`, `lname`, `age`, `phone`, `address_id`, `account_id`) VALUES (6, 'tester@gmail.com', 'User', 'McUserson', 24, '7209807543', 10, 6);
INSERT INTO `user` (`id`, `email`, `fname`, `lname`, `age`, `phone`, `address_id`, `account_id`) VALUES (7, 'person.email@gmail.com', 'Test', 'Person', 55, '3033598941', 11, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trait`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `trait` (`id`, `description`) VALUES (1, 'Intelligent');
INSERT INTO `trait` (`id`, `description`) VALUES (2, 'Playful');
INSERT INTO `trait` (`id`, `description`) VALUES (3, 'Gentle');
INSERT INTO `trait` (`id`, `description`) VALUES (4, 'Alert');
INSERT INTO `trait` (`id`, `description`) VALUES (5, 'Confident');
INSERT INTO `trait` (`id`, `description`) VALUES (6, 'Faithful');
INSERT INTO `trait` (`id`, `description`) VALUES (7, 'Outgoing');
INSERT INTO `trait` (`id`, `description`) VALUES (8, 'Cuddly');
INSERT INTO `trait` (`id`, `description`) VALUES (9, 'Reserved');
INSERT INTO `trait` (`id`, `description`) VALUES (10, 'Affectionate');
INSERT INTO `trait` (`id`, `description`) VALUES (11, 'Quite');
INSERT INTO `trait` (`id`, `description`) VALUES (12, 'Adventurous');

COMMIT;


-- -----------------------------------------------------
-- Data for table `species`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `species` (`id`, `name`) VALUES (1, 'Dog');
INSERT INTO `species` (`id`, `name`) VALUES (2, 'Cat');

COMMIT;


-- -----------------------------------------------------
-- Data for table `breed`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (1, 'Shiba Inu', 0, 'Double-coat short', 'The Shiba Inu is a Japanese breed of hunting dog. A small-to-medium breed, it is the smallest of the six original and distinct spitz breeds of dog native to Japan.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (2, 'Siberian Huskey', 0, 'Double-coat Medium', 'The Siberian Husky is a medium-sized working dog breed. The breed belongs to the spitz genetic family. It is recognizable by its thickly furred double coat, erect triangular ears, and distinctive markings, and is smaller than a very similar-looking dog, the Alaskan Malamute.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (3, 'Maine Coon', 0, 'Long', 'The Maine Coon is the largest domesticated cat breed. It has a distinctive physical appearance and valuable hunting skills. It is one of the oldest natural breeds in North America, specifically native to the state of Maine, where it is the official state cat.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (4, 'Yorkshire Terrier', 1, 'Long', 'Beneath the dainty, glossy, floor-length coat of a Yorkshire Terrier beats the heart of a feisty, old-time terrier. Yorkies earned their living as ratters in mines and mills long before they became the beribboned lapdogs of Victorian ladies.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (5, 'Airedale Terrier', 1, 'Short', 'His size, strength, and unflagging spirit have earned the Airedale Terrier the nickname “The King of Terriers.” The Airedale stands among the world’s most versatile dog breeds and has distinguished himself as hunter, athlete, and companion.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (6, 'Akita', 0, 'Double-coat short', 'Akitas are muscular, double-coated dogs of ancient Japanese lineage famous for their dignity, courage, and loyalty. In their native land, they are venerated as family protectors and symbols of good health, happiness, and long life.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (7, 'Alaskan Malamute', 0, 'Double-coat long', 'An immensely strong, heavy-duty worker of spitz type, the Alaskan Malamute is an affectionate, loyal, and playful but dignified dog recognizable by his well-furred plumed tail carried over the back, erect ears, and substantial bone.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (8, 'American Bulldog ', 0, 'Short', 'Kind but courageous, friendly but dignified, the Bulldog is a thick-set, low-slung, well-muscled bruiser whose “sourmug” face is the universal symbol of courage and tenacity. These docile, loyal companions adapt well to town or country.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (9, 'American Bully (Standard)', 0, 'Short', 'The American Bully should give the impression of great strength for its size. It is a compact and medium/large size dog with a muscular body and blocky head. The American Bully should have the appearance of heavy bone structure with a bulky build and look.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (10, 'American Eskimo Dog (Standard)', 0, 'Double-coat long', 'The American Eskimo Dog combines striking good looks with a quick and clever mind in a total brains-and-beauty package. Neither shy nor aggressive, Eskies are always alert and friendly, though a bit conservative when making new friends.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (11, 'Am. Staffordshire Terrier', 0, 'Short', 'The American Staffordshire Terrier, known to their fans as AmStaffs, are smart, confident, good-natured companions. Their courage is proverbial. A responsibly bred, well-socialized AmStaff is a loyal, trustworthy friend to the end.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (12, 'American Pit Bull Terrier', 0, 'Short', 'The American Pit Bull Terrier is a companion and family dog breed. Originally bred to “bait” bulls, the breed evolved into all-around farm dogs, and later moved into the house to become “nanny dogs” because they were so gentle around children. Their tenacity, gameness, and courage make them popular competitors in the sports of weight pulling, agility, and obedience competition.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (13, 'Australian Cattle Dog (Heeler)', 0, 'Double-coat short', 'The compact but muscular Australian Cattle Dog, also called Blue Heeler or Queensland Heeler, is related to Australia’s famous wild dog, the Dingo. These resilient herders are intelligent enough to routinely outsmart their owners.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (14, 'Australian Kelpie', 0, 'Short', 'The Australian Kelpie is a lithe, active dog, capable of untiring work. He is extremely intelligent, alert, and eager with unlimited energy.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (15, 'Australian Shepherd', 0, 'Medium', 'The Australian Shepherd, a lean, tough ranch dog, is one of those “only in America” stories: a European breed perfected in California by way of Australia. Fixtures on the rodeo circuit, they are closely associated with the cowboy life.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (17, 'Austrialian Terrier', 0, 'Medium', 'The diminutive Australian Terrier is plucky, spirited, and smart—how did they fit so much dog into such a bitty package? Upbeat and lively, the self-assured Aussie approaches life with plenty of the old-time terrier curiosity and grit.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (18, 'Barbet', 0, 'Long', 'An archetypic water dog of France, the Barbet is a rustic breed of medium size and balanced proportions who appears in artwork as early as the 16th century. In profile, the Barbet is slightly rectangular with a substantial head and long, sweeping tail. He has a long, dense covering of curly hair and a distinctive beard. An agile athlete, the Barbet has been used primarily to locate, flush, and retrieve birds. He has a cheerful disposition and is very social and loyal.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (19, 'Basenji', 1, 'Short', 'The Basenji, Africa’s “Barkless Dog,” is a compact, sweet-faced hunter of intelligence and poise. They are unique and beguiling pets, best for owners who can meet their exercise needs and the challenge of training this catlike canine.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (20, 'Basset Hound', 0, 'Short', 'Among the most appealing of the AKC breeds, the endearing and instantly recognizable Basset Hound is a perennial favorite of dog lovers all over the world. This low-slung and low-key hound can be sometimes stubborn, but is always charming.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (21, 'Beagle', 0, 'Short', 'Not only is the Beagle an excellent hunting dog and loyal companion, it is also happy-go-lucky, funny, and—thanks to its pleading expression—cute. They were bred to hunt in packs, so they enjoy company and are generally easygoing.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (22, 'Beauceron', 0, 'Short', 'The Beauceron is imposing and powerful, but also remarkably smart, spirited, and a versatile herder—imagine a Border Collie’s brain in a 100-pound body. They are especially beloved by women as a dashing but sensitive companion and protector.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (23, 'Bedlington Terrier', 1, 'Short', 'Graceful terriers in sheep’s clothing, Bedlington Terriers, named for the English mining shire where they were first bred, are genial housemates, alert watchdogs, versatile athletes, and irresistibly cuddly TV-time companions.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (24, 'Belgian Malinois', 0, 'Short', 'The smart, confident, and versatile Belgian Malinois is a world-class worker who forges an unbreakable bond with his human partner. To deny a Mal activity and the pleasure of your company is to deprive him of his very reasons for being.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (25, 'Belgian Tervuren', 0, 'Long', 'The elegant, agile Belgian Tervuren is a bright and self-assured herding dog of medium size, known to be affectionate and possessive with loved ones. Lots of hard work and challenging play is heaven for this tireless, do-it-all dog.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (26, 'Bernese Mountain Dog', 0, 'Double-coat Long', 'Big, powerful, and built for hard work, the Bernese Mountain Dog is also strikingly beautiful and blessed with a sweet, affectionate nature. Berners are generally placid but are always up for a romp with the owner, whom they live to please.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (27, 'Bichon Frise', 1, 'Double-coat medium', 'The small but sturdy and resilient Bichon Frise stands among the world’s great “personality dogs.” Since antiquity, these irresistible canine comedians have relied on charm, beauty, and intelligence to weather history’s ups and downs.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (28, 'Black and Tan Coonhound', 0, 'Short', 'Large, athletic hunters who work nights, Black and Tan Coonhounds are friendly, easygoing hounds who love company. They are snoozy by the fireside but tenacious when on the trail of the wily raccoon. The B&T is a real American original.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (29, 'Bloodhound', 0, 'Short', 'The world famous “Sleuth Hound” does one thing better than any creature on earth: find people who are lost or hiding. An off-duty Bloodhound is among the canine kingdom’s most docile citizens, but he’s relentless and stubborn on scent.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (30, 'Bluetick Coonhound', 0, 'Short', 'The sleekly beautiful Bluetick Coonhound is a sweet and affectionate charmer who might enjoy snoozing in the shade, but in pursuit of quarry he is relentless, bold, and single-minded. His off-the-charts prey drive must be channeled.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (31, 'Boerboel', 0, 'Short', 'Boerboels are intimidating but discerning guardians of home and family who learned their trade while protecting remote South African homesteads from ferocious predators. They are dominant and confident, also bright and eager to learn.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (32, 'Border Collie', 0, 'Double-coat medium', 'A remarkably bright workaholic, the Border Collie is an amazing dog—maybe a bit too amazing for owners without the time, energy, or means to keep it occupied. These energetic dogs will settle down for cuddle time when the workday is done.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (33, 'Border Terrier', 0, 'Double-coat short', 'Admirers of the upbeat and agile Border Terrier cherish their breed’s reputation as a tough, no-frills working terrier. These plucky, happy, and affectionate dogs are popular pets in town and country. The wiry coat is an easy keeper.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (34, 'Boston Terrier', 0, 'Short', 'The Boston Terrier is a lively little companion recognized by his tight tuxedo jacket, sporty but compact body, and the friendly glow in his big, round eyes. His impeccable manners have earned him the nickname “The American Gentleman.”', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (35, 'Bouvier des Flandres', 0, 'Double-coat medium', 'They don’t build ’em like this anymore. Burly and barrel-chested, the tousle-coated dog of Flandres is from a time and place where a dog had to work like … well, a dog. These smart and steady all-purpose workers make excellent watchdogs.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (36, 'Boxer', 0, 'Short', 'Loyalty, affection, intelligence, work ethic, and good looks: Boxers are the whole doggy package. Bright and alert, sometimes silly, but always courageous, the Boxer has been among America’s most popular dog breeds for a very long time.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (37, 'Boykin Spaniel', 0, 'Double-coat medium', 'A medium-sized flushing and retrieving dog known for its rich brown coat, the Boykin Spaniel is avid, eager, merry, and trainable. This mellow housedog and tenacious bird dog was once South Carolina’s best-kept secret.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (38, 'Bracco Italiano ', 0, 'Short', 'The Bracco Italiano is one of the oldest of the pointing breeds. It was introduced into the United States in the 1990s and has remained true to its heritage as a versatile gun dog. It is gentle in the home and tireless in the field.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (39, 'Briard', 0, 'Long', 'The Briard packs so much loyalty, love, and spirit into its ample frame that it\'s often described as a \"heart wrapped in fur.\" The dashing good looks of these muscular Frenchmen radiate a distinct aura of Gallic romance and elegance.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (40, 'Brittany', 0, 'Medium', 'Sportsmen on both sides of the Atlantic cherish the agile, energetic Brittany as a stylish and versatile gundog. Bright and eager at home, and tireless afield, Brittanys require a lot of exercises, preferably with their favorite humans.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (41, 'Bull Terrier (Standard)', 0, 'Short', 'Among the most comical and mischievous citizens of dogdom, the Bull Terrier is playful and endearing, sometimes stubborn, but always devoted. These unique “eggheads” are exuberant, muscular companions who thrive on affection and exercise.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (42, 'Bull Terrier (Miniature)', 0, 'Short', 'In most every way the Miniature Bull Terrier is a Bull Terrier, only smaller. These upbeat, mischievous dogs come equipped with terrier fire and fearlessness. If ever a dog could claim the title “Clown Prince of Dogdom,” it’s the Mini.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (43, 'Bulldog', 0, 'Short', 'Kind but courageous, friendly but dignified, the Bulldog is a thick-set, low-slung, well-muscled bruiser whose “sourmug” face is the universal symbol of courage and tenacity. These docile, loyal companions adapt well to town or country.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (44, 'Bullmastiff', 0, 'Short', 'Fearless at work, docile at home, the Bullmastiff is a large, muscular guarder who pursued and held poachers in Merry Old England—merry, we suppose, for everyone but poachers. Bullmastiffs are the result of Bulldog and Mastiff crosses.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (45, 'Cairn Terrier', 1, 'Double-coat medium', 'Cairn Terriers are happy, busy little earthdogs originally bred to fearlessly root out foxes and other small, furred prey in the rocky Scottish countryside. Curious and alert, Cairns like having a place where they can explore and dig.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (46, 'Cane Corso', 0, 'Short', 'Smart, trainable, and of noble bearing, the assertive and confident Cane Corso is a peerless protector. The Corso’s lineage goes back to ancient Roman times, and the breed’s name roughly translates from the Latin as “bodyguard dog.”', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (47, 'Cardigan Welsh Corgi', 0, 'Double-coat short', 'The Cardigan Welsh Corgi is a masterpiece of the breeder’s art: Every aspect of its makeup is perfectly suited to moving cattle, and yet it is so congenial and sweet-faced that it would be a cherished companion even if it never did a day’s work.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (48, 'Catahoula Leopard Dog', 0, 'Short', 'The Catahoula Leopard Dog is a multi-purpose working dog that is well-muscled and powerful, but with a sense of agility and endurance. They are serious while working and playful at home.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (49, 'Caucasian Shepherd (Ovcharka)', 0, 'Double-coat long', 'The Caucasian Shepherd dog is a serious guardian breed and should never be taken lightly. The Caucasian is bold, fearless, self-confident and fierce when a threat is present, but he is soft, devoted, kind and endearing to his family, including other family pets.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (50, 'Cavalier King Charles Spaniel', 0, 'Medium', 'The Cavalier King Charles Spaniel wears his connection to British history in his breed’s name. Cavaliers are the best of two worlds, combining the gentle attentiveness of a toy breed with the verve and athleticism of a sporting spaniel.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (51, 'Chesapeake Bay Retriever', 0, 'Double-coat medium', 'The Chesapeake Bay Retriever, peerless duck dog of the Mid-Atlantic, is an American original who embodies the classic traits of a good retriever: loyal, upbeat, affectionate, and tireless. The Chessie is famous for his waterproof coat.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (52, 'Chihuahua (Long hair)', 0, 'Long', 'The Chihuahua is a tiny dog with a huge personality. A national symbol of Mexico, these alert and amusing \"purse dogs\" stand among the oldest breeds of the Americas, with a lineage going back to the ancient kingdoms of pre-Columbian times.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (53, 'Chihuahua (Smooth)', 0, 'Short', 'The Chihuahua is a tiny dog with a huge personality. A national symbol of Mexico, these alert and amusing \"purse dogs\" stand among the oldest breeds of the Americas, with a lineage going back to the ancient kingdoms of pre-Columbian times.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (54, 'Chinese Crested', 1, 'Short', 'With their spotted pink skin, spiky “crested” hairdo, furry socks and feathery tail, you can’t mistake the sweet and slender Chinese Crested for any other breed. This frolicsome, ultra-affectionate companion dog is truly a breed apart.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (55, 'Chinese Shar-Pei', 0, 'Short', 'This fascinating but challenging breed of ancient pedigree is steadfastly loyal to family, but standoffish with strangers. The Chinese Shar-Pei has physical characteristics that make him a one-of-a-kind companion and guardian dog.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (56, 'Chinook', 0, 'Double-coat medium', 'The pride of Wonalancet, New Hampshire, the Chinook is a rugged working dog and devoted family pet known for intelligence, patience, and eagerness to please. Once on the verge of extinction, the Chinook is among the scarcest AKC breeds.\nThe pride of Wonalancet, New Hampshire, the Chinook is a rugged working dog and devoted family pet known for intelligence, patience, and eagerness to please. Once on the verge of extinction, the Chinook is among the scarcest AKC breeds.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (57, 'Chow Chow', 0, 'Double-coat long', 'The Chow Chow, an all-purpose dog of ancient China, presents the picture of a muscular, deep-chested aristocrat with an air of inscrutable timelessness. Dignified, serious-minded, and aloof, the Chow Chow is a breed of unique delights.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (58, 'Clumber Spaniel', 0, 'Double-coat medium', 'A dignified and mellow hunting companion of kings, the Clumber Spaniel is the largest of the AKC flushing spaniels. For those who can handle some shedding and drooling, the amiable Clumber is an amusing best friend and a gentlemanly housemate.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (59, 'Cocker Spaniel (American)', 0, 'Long', 'The merry and frolicsome Cocker Spaniel, with his big, dreamy eyes and impish personality, is one of the world’s best-loved breeds. They were developed as hunting dogs, but Cockers gained their wide popularity as all-around companions.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (60, 'Cocker Spaniel (English)', 0, 'Medium', 'English Cocker Spaniel lovers often use the word “merry” to describe their breed. Upbeat in the field and mellow at home, this compact, silky-coated bird dog is widely admired for his delightful personality and irresistible good looks.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (61, 'Collie (Smooth)', 0, 'Double-coat short', 'The majestic Collie, thanks to a hundred years as a pop-culture star, is among the world’s most recognizable and beloved dog breeds. The full-coated “rough” Collie is the more familiar variety, but there is also a sleek “smooth” Collie.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (62, 'Collie (Rough)', 0, 'Double-coat medium', 'The majestic Collie, thanks to a hundred years as a pop-culture star, is among the world’s most recognizable and beloved dog breeds. The full-coated “rough” Collie is the more familiar variety, but there is also a sleek “smooth” Collie.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (63, 'Coton De Tulear', 1, 'Medium', 'The Coton de Tulear, “Royal Dog of Madagascar,” is a bright, happy-go-lucky companion dog whose favorite activities include clowning, cavorting, and following their special human around the house. The Coton is small but robustly sturdy.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (64, 'Dachshund (smooth)', 0, 'Short', 'The famously long, low silhouette, ever-alert expression, and bold, vivacious personality of the Dachshund have made him a superstar of the canine kingdom. Dachshunds come in two sizes and in three coat types of various colors and patterns.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (65, 'Dachshund (wire/long haired)', 0, 'Long', 'The famously long, low silhouette, ever-alert expression, and bold, vivacious personality of the Dachshund have made him a superstar of the canine kingdom. Dachshunds come in two sizes and in three coat types of various colors and patterns.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (66, 'Dalmatian', 0, 'Short', 'The dignified Dalmatian, dogdom\'s citizen of the world, is famed for his spotted coat and unique job description. During their long history, these \"coach dogs\" have accompanied the horse-drawn rigs of nobles, gypsies, and firefighters.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (67, 'Doberman Pinscher', 0, 'Short', 'Sleek and powerful, possessing both a magnificent physique and keen intelligence, the Doberman Pinscher is one of dogkind\'s noblemen. This incomparably fearless and vigilant breed stands proudly among the world\'s finest protection dogs.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (68, 'Dogo Argentino', 0, 'Short', 'The Dogo Argentino is a pack-hunting dog, bred for the pursuit of big-game such as wild boar and puma, and possesses the strength, intelligence and quick responsiveness of a serious athlete. His short, plain and smooth coat is completely white, but a dark patch near the eye is permitted as long as it doesn\'t cover more than 10% of the head.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (69, 'Dutch Shepherd', 0, 'Short', 'The Dutch Shepherd is a lively, athletic, alert and intelligent breed, and has retained its herding instinct for which it was originally developed. Having an independent nature, it can be slightly obstinate and have a mind of its own. Since its original duties were to keep flocks of sheep in a particular location, it is able to run all day, and that is reflected in its physique and structure.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (70, 'English Setter', 0, 'Long', 'The English Setter is a medium-sized sporting dog of sweet temper and show-stopping good looks. It is one of the AKC’s four British setters created to work on the distinctly different terrains of England, Ireland, and Scotland.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (71, 'English Shepherd', 0, 'Medium', 'The English Shepherd is a herding dog who loves to work but will also curl up at your feet at the end of the day. These dogs can get a little bossy, too. Their instinct tells them to chase and try to herd everyone they come across.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (72, 'English Springer Spaniel', 0, 'Medium', 'The English Springer Spaniel is a sweet-faced, lovable bird dog of great energy, stamina, and brains. Sport hunters cherish the duality of working Springers: handsome, mannerly pets during the week, and trusty hunting buddies on weekends.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (73, 'English Toy Spaniel', 0, 'Long', 'The merry English Toy Spaniel was bred to be the companion of kings. But ETS are spaniels first and pampered lapdogs second, and beneath the patrician exterior beats the heart of a real doggy dog—bright, loving, and willing to please.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (74, 'English Toy Terrier', 0, 'Short', 'Perhaps the oldest of Britain\'s native toy breeds, the English Toy Terrier is a descendent of the Old English Black and Tan Terrier and the larger Manchester Terrier. Traditionally a town dog in the 1800s, the English Toy Terrier was a frequenter in the rat-fighting pits and was commonly used to catch vermin within the Victorian home. From this period onwards, the English Toy Terrier has enjoyed great popularity as a domestic companion for its non-aggressive and affectionate nature.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (75, 'Eurasier', 0, 'Double-coat medium', 'The Eurasier is a medium-sized dog with a thick, medium-long coat that can come in a variety of colors. Confident, calm, and well-balanced, he is loyal to the entire family, but reserved towards strangers. He must live in close contact with his family, as he is not suited to be kept in kennels or tied up outside.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (76, 'Field Spaniel', 0, 'Long', 'The sweet and sensitive Field Spaniel is famously docile, but vigorous and game for anything when at play or in the field. These close cousins to Cocker Spaniels and Springer Spaniels may be small in number, but their charm is enormous.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (77, 'Finnish Lapphund', 0, 'Double-coat Long', 'The weatherproof Finnish Lapphund is a tough and substantial reindeer herder from north of the Arctic Circle. This remarkably empathetic breed is among the friendliest of all dogs—once he’s satisfied that you aren’t a reindeer rustler.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (78, 'Finnish Spitz', 0, 'Double-coat short', 'The lively Finnish Spitz, the flame-colored, foxy-faced breed from the “Land of 60,000 Lakes,” is a small but fearless hunting dog whose unique style of tracking and indicating quarry has earned him the nickname the “Barking Bird Dog.”', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (79, 'Flat Coat Retriever', 0, 'Medium', 'The Peter Pan of the Sporting Group, the forever-young Flat-Coated Retriever is a gundog of relatively recent origin. Happy, self-assured, and willing to please, a good Flat-Coat will retrieve a duck or a show ribbon with equal aplomb.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (80, 'French Bulldog', 0, 'Short', 'The one-of-a-kind French Bulldog, with his large bat ears and even disposition, is one of the world’s most popular small-dog breeds, especially among city dwellers. The Frenchie is playful, alert, adaptable, and completely irresistible.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (81, 'German Pinscher', 0, 'Short', 'The sleek, no-frills German Pinscher is among Germany’s oldest breeds and the prototype of other pinscher breeds. This energetic, super-intelligent dog was at first used as a rat catcher but can be trained for all types of canine work.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (82, 'German Shepherd Dog', 0, 'Double-coat medium', 'Generally considered dogkind’s finest all-purpose worker, the German Shepherd Dog is a large, agile, muscular dog of noble character and high intelligence. Loyal, confident, courageous, and steady, the German Shepherd is truly a dog lover’s delight.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (83, 'German Shorthaired Pointer', 0, 'Short', 'The versatile, medium-sized German Shorthaired Pointer is an enthusiastic gundog of all trades who thrives on vigorous exercise, positive training, and a lot of love. GSP people call their aristocratic companions the “perfect pointer.”', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (84, 'Giant Schnauzer', 1, 'Double-coat medium', 'The Giant Schnauzer is a larger and more powerful version of the Standard Schnauzer, and he should, as the breed standard says, be a “bold and valiant figure of a dog.” Great intelligence and loyalty make him a stellar worker and companion.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (85, 'Glen of Imaal Terrier', 0, 'Medium', 'Gentler, less excitable than most terriers, but still bold and spirited, the double-coated Glen of Imaal Terrier is named for one of Ireland\'s most remote locales. The brave but docile Glen is a strong, no-fuss dog built for hard work.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (86, 'Golden Retriever', 0, 'Medium', 'The Golden Retriever, an exuberant Scottish gundog of great beauty, stands among America’s most popular dog breeds. They are serious workers at hunting and field work, as guides for the blind, and in search-and-rescue, enjoy obedience and other competitive events, and have an endearing love of life when not at work.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (87, 'Gordon Setter', 0, 'Long', 'The Gordon Setter, the black avenger of the Highlands, is a substantial bird dog named for a Scottish aristocrat. Athletic and outdoorsy, Gordons are bold, confident, and resolute in the field, and sweetly affectionate by the fireside.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (88, 'Great Dane', 0, 'Short', 'The easygoing Great Dane, the mighty “Apollo of Dogs,” is a total joy to live with—but owning a dog of such imposing size, weight, and strength is a commitment not to be entered into lightly. This breed is indeed great, but not a Dane.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (89, 'Great Pyrenees', 0, 'Double-coat long', 'The Great Pyrenees is a large, thickly coated, and immensely powerful working dog bred to deter sheep-stealing wolves and other predators on snowy mountaintops. Pyrs today are mellow companions and vigilant guardians of home and family.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (90, 'Greyhound', 0, 'Short', 'The champion sprinter of dogdom, the Greyhound is a gentle, noble, and sweet-tempered companion with an independent spirit. For thousands of years these graceful hounds have been an object of fascination for artists, poets, and kings.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (91, 'Harrier', 0, 'Short', 'The Harrier is a swift, prey-driven pack hound of medium size first bred in medieval England to chase hare. Outgoing and friendly, the Harrier is much larger than the Beagle but smaller than another close relative, the English Foxhound.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (92, 'Havanese', 1, 'Long', 'Havanese, the only dog breed native to Cuba, are cheerful little dogs with a spring in their step and a gleam in their big, brown eyes. These vivacious and sociable companions are becoming especially popular with American city dwellers.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (93, 'Irish Setter', 0, 'Medium', 'The Irish Setter is a high-spirited gundog known for grace, swiftness, and a flashy red coat. They are famously good family dogs: sweet-tempered companions for the folks, and rollicking playmates and tennis-ball fetchers for the children.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (94, 'Irish Terrier', 0, 'Medium', 'The Irish Terrier, “Daredevil” of the Emerald Isle, is a bold, dashing, and courageous terrier of medium size. Known for his fiery red coat and a temperament to match, the Irish Terrier is stouthearted at work and tenderhearted at home.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (95, 'Irish Wolfhound', 0, 'Medium', 'The calm, dignified, and kindly Irish Wolfhound is the tallest of all AKC breeds. Once fearless big-game hunters capable of dispatching a wolf in single combat, Wolfhounds today are the most serene and agreeable of companions.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (96, 'Italian Greyhound', 1, 'Short', 'A true Greyhound in miniature, the elegant Italian Greyhound is an alert, playful, and highly affectionate toy companion. IGs make decorative couch dogs, but at heart they are flash-and-dash coursing hounds with an instinct for pursuit.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (97, 'Japanese Chin', 0, 'Short', 'The Japanese Chin is a charming toy companion of silky, profuse coat and an unmistakably aristocratic bearing. Often described as a distinctly “feline” breed, this bright and amusing lapdog is fastidious, graceful, and generally quiet.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (98, 'Japanese Spitz', 0, 'Long', 'The Japanese Spitz are little comedians who want to make you happy and laugh. They are very loyal and smart and make wonderful companions. Game for adventures, they will tag along on a hike, a car ride, or a trip to the beach or lake. They love their humans and just enjoy being with them.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (99, 'Keeshond', 0, 'Double-coat long', 'The amiable Keeshond is a medium-sized spitz dog of ample coat, famous for the distinctive “spectacles” on his foxy face. Once a fixture on the canal barges of his native Holland, the Kees was, and remains, a symbol of Dutch patriotism.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (100, 'Komondor', 1, 'Long', 'A powerfully large Hungarian flock guardian covered in profuse white cords from head to tail, the Komondor is among the world’s most recognizable breeds. The independent and protective Kom requires a firm, experienced hand at training.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (101, 'Kooikerhondje', 0, 'Medium', 'The Nederlandse Kooikerhondje is lively, agile, self-confident, good-natured and alert. The breed is faithful, easy-going and friendly in the home. Outdoors he is a true sporting dog being keen, swift, tough, attentive and energetic. With sufficient perseverance and stamina, he enjoys working and does so with a cheerful character.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (102, 'Kuvasz', 0, 'Long', 'The snow-white Kuvasz is Hungary\'s majestic guardian of flocks and companion of kings. A working dog of impressive size and strength, the imposing and thickly coated Kuvasz is a beautiful, smart, profoundly loyal, but challenging breed.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (103, 'Labrador Retriever', 0, 'Double-coat short', 'The sweet-faced, lovable Labrador Retriever is America’s most popular dog breed. Labs are friendly, outgoing, and high-spirited companions who have more than enough affection to go around for a family looking for a medium-to-large dog.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (104, 'Lagotto Romagnolo', 1, 'Medium', 'The Lagotto Romagnolo, Italy’s adorable “truffle dog,” sports a curly coat and lavish facial furnishings. Despite their plush-toy looks, Lagotti are durable workers of excellent nose who root out truffles, a dainty and pricey delicacy.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (105, 'Leonberger', 0, 'Double-coat medium', 'The Leonberger is a lush-coated giant of German origin. They have a gentle nature and serene patience and they relish the companionship of the whole family.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (106, 'Lhasa Apso', 1, 'Long', 'The lavishly coated Lhasa Apso is a thousand-year-old breed who served as sentinels at palaces and monasteries isolated high in the Himalayas. Smart, confident, and complex, Lhasas are family comedians but regally aloof with strangers.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (107, 'Maltese', 1, 'Long', 'The tiny Maltese, “Ye Ancient Dogge of Malta,” has been sitting in the lap of luxury since the Bible was a work in progress. Famous for their show-stopping, floor-length coat, Maltese are playful, charming, and adaptable toy companions.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (108, 'Miniature American Shepherd', 0, 'Double-coat medium', 'The Miniature American Shepherd resembles a small Australian Shepherd. True herders in spite of their compact size, Minis are bright, self-motivated workers and endearingly loyal and lively companion dogs who have an affinity for horses.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (109, 'Miniature Pinscher', 0, 'Short', 'The leggy Miniature Pinscher is known to fans as the “King of Toys.” This proud, fearless, fun-loving toy breed of lustrous coat and a compact, wedge-shaped physique is a true personality dog, known for a high-stepping “hackney” gait.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (110, 'Miniature Schnauzer', 1, 'Double-coat long', 'The Miniature Schnauzer, the smallest of the three Schnauzer breeds, is a generally healthy, long-lived, and low-shedding companion. Add an outgoing personality, a portable size, and sporty good looks, and you’ve got an ideal family dog.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (111, 'Newfoundland', 0, 'Double-coat long', 'The massive Newfoundland is a strikingly large, powerful working dog of heavy bone and dignified bearing. The sweet-tempered Newfie is a famously good companion and has earned a reputation as a patient and watchful “nanny dog” for kids.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (112, 'Norfolk Terrier', 0, 'Medium', 'Norfolk Terriers are little, cute, and loyal, and they will gladly curl up in your lap, but don’t dare call them lapdogs. Norfolks, despite their toyish qualities, are genuine terriers—feisty, confident, sturdy, and game for adventure.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (113, 'Norwich Terrier', 0, 'Double-coat long', 'Norwich Terriers are plucky little earthdogs named for their hometown in England. The old cliché “a big dog in a small package” was coined for breeds like the Norwich, who can be oblivious to the fact that they are just 10 inches tall.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (114, 'Nova Scotia Duck Tolling Retriever', 0, 'Double-coat medium', 'The smallest of the AKC’s retrievers, the Nova Scotia Duck Tolling Retriever is intelligent, affectionate, and eager to please. Play fetch with a tireless Toller until your right arm falls off, and he will ask you to throw left-handed.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (115, 'Olde English Bulldogge', 0, 'Short', 'Olde English Bulldogges are sturdy, muscular and big-boned — yet, somewhat nimble and athletic. Their powerful, bulky heads have broad muzzles and furrowed brows. Their ears can be perky or hanging. They have thick, powerful necks and stocky legs — creating a somewhat “cobby” body. Old English Bulldogges have short, coarse coats that can come in white with patches of red, gray and brindle; or solid colors of fawn, red, black or black & white.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (116, 'Old English Sheepdog', 0, 'Double-coat long', 'The Old English Sheepdog is the archetypical shaggy dog, famous for his profuse coat and peak-a-boo hairdo, a distinctive bear-like gait, and a mellow, agreeable nature. The OES is a big, agile dog who enjoys exploring and a good romp.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (117, 'Papillon', 0, 'Long', 'The quick, curious Papillon is a toy dog of singular beauty and upbeat athleticism. Despite his refined appearance, the Pap is truly a “doggy dog” blessed with a hardy constitution. Papillon fanciers describe their breed as happy, alert, and friendly.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (118, 'Parson Russell Terrier', 0, 'Short', 'The Parson Russell Terrier is a bold and clever terrier, swift enough to run with horses and fearless enough to dig in and flush a fox from his lair. Independent problem solvers, PRTs can have their own ideas on how to go about things.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (119, 'Patterdale Terrier (Smooth or Broken)', 0, 'Short', 'Patterdale Terriers have small, compact, sturdy frames covered in smooth, broken or rough coats that come in red, black, brown, and black and tan. Their strong heads have tapered muzzles, keen dark eyes and V-shaped ears that fold forward. Their tails are carried high without curling over the back. Overall, Patterdale Terriers have a tough but friendly look.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (120, 'Patterdale Terrier (Rough)', 0, 'Long', 'Patterdale Terriers have small, compact, sturdy frames covered in smooth, broken or rough coats that come in red, black, brown, and black and tan. Their strong heads have tapered muzzles, keen dark eyes and V-shaped ears that fold forward. Their tails are carried high without curling over the back. Overall, Patterdale Terriers have a tough but friendly look.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (121, 'Pekingese', 0, 'Long', 'The Pekingese, a compact toy companion of regal bearing and a distinctive rolling gait, is one of several breeds created for the ruling classes of ancient China. These are sophisticated dogs of undying loyalty and many subtle delights.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (122, 'Pembroke Welsh Corgi', 0, 'Double-coat short', 'Among the most agreeable of all small housedogs, the Pembroke Welsh Corgi is a strong, athletic, and lively little herder who is affectionate and companionable without being needy. They are one of the world\'s most popular herding breeds.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (123, 'Pharaoh Hound', 0, 'Short', 'The Pharaoh Hound, ancient \"Blushing Dog\" of Malta, is an elegant but rugged sprinting hound bred to course small game over punishing terrain. Quick and tenacious on scent, these friendly, affectionate hounds settle down nicely at home.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (124, 'Plott', 0, 'Double-coat short', 'The Plott Hound, a hound with a curious name and a unique history, is a rugged, relentless hunting dog who is a mellow gentleman at home but fearless, implacable, and bold at work. This eye-catching scenthound is North Carolina\'s state dog.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (125, 'Pointer (English)', 0, 'Short', 'The Pointer is the ultimate expression of canine power and grace. The breed’s name is its job description: Pointers point game birds, and they have been pointing for centuries. The high-energy Pointer is an excellent runner’s companion.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (126, 'Pomeranian', 0, 'Double-coat long', 'The tiny Pomeranian, long a favorite of royals and commoners alike, has been called the ideal companion. The glorious coat, smiling, foxy face, and vivacious personality have helped make the Pom one of the world\'s most popular toy breeds.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (127, 'Poodle (Miniature)', 1, 'Medium', 'Whether Standard, Miniature, or Toy, and either black, white, or apricot, the Poodle stands proudly among dogdom’s true aristocrats. Beneath the curly, low-allergen coat is an elegant athlete and companion for all reasons and seasons.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (128, 'Poodle (Standard)', 1, 'Medium', 'Whether Standard, Miniature, or Toy, and either black, white, or apricot, the Poodle stands proudly among dogdom’s true aristocrats. Beneath the curly, low-allergen coat is an elegant athlete and companion for all reasons and seasons.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (129, 'Poodle (Toy)', 1, 'Medium', 'Whether Standard, Miniature, or Toy, and either black, white, or apricot, the Poodle stands proudly among dogdom’s true aristocrats. Beneath the curly, low-allergen coat is an elegant athlete and companion for all reasons and seasons.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (130, 'Portugese Water Dog', 1, 'Long', 'The bright and biddable Portuguese Water Dog was bred to be an all-around fisherman’s helper. The robust, medium-sized body is covered by a coat of tight, low-shedding curls. PWDs are eager and athletic companions built for water work.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (131, 'Presa Canario', 0, 'Short', 'The Perro de Presa Canario has a calm appearance and attentive expression. He is especially suited to guarding and traditionally used for herding cattle.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (132, 'Pug', 0, 'Short', 'Once the mischievous companion of Chinese emperors, and later the mascot of Holland’s royal House of Orange, the small but solid Pug is today adored by his millions of fans around the world. Pugs live to love and to be loved in return.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (133, 'Puli', 0, 'Long', 'No other breed can be mistaken for the Puli, a compact but powerful herder covered from head to tail with profuse, naturally occurring cords. Bred to work closely with humans, these agile and faithful little dynamos are quick learners.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (134, 'Pumi', 0, 'Medium', 'A compact, nimble-footed herder of Hungarian origin, the Pumi is easily recognized by a corkscrew-curled coat, two-thirds erect ears, and distinctive whimsical expression. The breed is famed for its intelligence, agility, and boldness.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (135, 'Rat Terrier', 0, 'Short', 'An American original, with a breed name said to be coined by Teddy Roosevelt, the Rat Terrier is a compact, tough, smooth-coated exterminator dog. RTs come in two size varieties and are happy-go-lucky, playful, and portable companions.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (136, 'Redbone Coonhound', 0, 'Short', 'The streamlined Redbone Coonhound, an American original, is even-tempered, mellow, and kindly at home but a tiger on the trail. Vigorous activities like hunting and swimming between long periods of rest is the rhythm of coonhound life.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (137, 'Rhodesian Ridgeback', 0, 'Short', 'The Rhodesian Ridgeback is an all-purpose “Renaissance hound” whose hallmark is the ridge, or stripe of backward-growing hair, on his back. Though the breed was made famous in its native Africa for its skill at tracking and baying – but never, ever killing – lions, today Ridgebacks are cherished family dogs whose owners must be prepared to deal with their independence and strong prey drive.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (138, 'Rottweiler', 0, 'Double-coat medium', 'The Rottweiler is a robust working breed of great strength descended from the mastiffs of the Roman legions. A gentle playmate and protector within the family circle, the Rottie observes the outside world with a self-assured aloofness.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (139, 'Russian Toy', 0, 'Short', 'The Russian Toy is a small, elegant, lively dog with long legs, fine bones and lean muscles. They are active and cheerful, possessing keen intelligence and a desire to please. This breed loves to snuggle and be close to their human companions, although sometimes slightly aloof to strangers. They are neither cowardly nor aggressive.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (140, 'Saluki', 0, 'Long', 'Among the world’s oldest breeds, the slim but rugged Saluki was the hunting hound of kings for thousands of years. Salukis are swift and agile sprinters who love a good chase. They make gentle, dignified, and independent but loyal pets.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (141, 'Samoyed', 0, 'Double-coat long', 'The Samoyed is a substantial but graceful dog standing anywhere from 19 to a bit over 23 inches at the shoulder. Powerful, tireless, with a thick all-white coat impervious to cold—Sammies are perfectly beautiful but highly functional. Even their most delightful feature, a perpetual smile, has a practical function: The upturned corners of the mouth keep Sammies from drooling, preventing icicles from forming on the face.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (142, 'Schipperke', 0, 'Double-coat medium', 'The Schipperke, Belgium\'s \"little captain,\" is the traditional barge dog of the Low Countries. Curious, lively, and intense but mischievous, this little black dog is a robust, long-lived companion for whom there is never a dull moment.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (143, 'Scottish Deerhound', 0, 'Long', 'The crisply coated Scottish Deerhound, “Royal Dog of Scotland,” is a majestically large coursing hound struck from the ancient Greyhound template. Among the tallest of dog breeds, the Deerhound was bred to stalk the giant wild red deer.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (144, 'Scottish Terrier', 1, 'Double-coat long', 'A solidly compact dog of vivid personality, the Scottish Terrier is an independent, confident companion of high spirits. Scotties have a dignified, almost-human character. Their terrier persistence has earned the breed the nickname “the Diehard.”', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (145, 'Shetland Sheepdog (Sheltie)', 0, 'Double-coat long', 'The Shetland Sheepdog, also known as the Sheltie, is an extremely intelligent, quick, and obedient herder from Scotland’s remote and rugged Shetland Islands. Shelties bear a strong family resemblance to their bigger cousin, the Collie.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (146, 'Shih Tzu', 1, 'Double-coat long', 'That face! Those big dark eyes looking up at you with that sweet expression! It’s no surprise that Shih Tzu owners have been so delighted with this little “Lion Dog” for a thousand years. Where Shih Tzu go, giggles and mischief follow.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (147, 'Shiloh Shepherd', 0, 'Double-coat long', 'The Shiloh Shepherd is a true contemporary breed developed to fill the need for a Shepherd from the past, a protector, a best friend, a part of the family. Shiloh Shepherds are dogs of giant size, incredible intelligence and wholesome beauty. Shilohs portray a distinctive impression of nobility with superior intelligence, strength of character and a heart of gold.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (148, 'Silky Terrier', 0, 'Long', 'A charming member of the AKC Toy Group, the compact, glossy-coated Silky Terrier is nonetheless a true terrier of energetic high spirits. The Silky, a native of Sydney, Australia, is larger than his close cousin, the Yorkshire Terrier.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (149, 'Smooth Fox Terrier', 0, 'Medium', 'The Smooth Fox Terrier, called the “gentleman of the terrier world,” is a lively, gregarious terrier with a devil-may-care attitude, originally developed for Britain’s traditional foxhunts. They are close relatives to Wire Fox Terriers.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (150, 'Soft Coated Wheaten Terrier', 1, 'Long', 'The Soft Coated Wheaten Terrier, an exuberant Irish farm dog, is happy, friendly, deeply devoted, and just stubborn enough to remind you he’s a terrier. The unique wheaten coat is low-shedding but needs diligent care to avoid matting.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (151, 'Spanish Water Dog', 0, 'Long', 'The inexhaustible Spanish Water Dog is a dual-purpose breed whose hallmark is a coat of wooly curls. Used as both a herder and waterfowl retriever in his homeland, this rustic charmer is a lively family companion and vigilant watchdog.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (152, 'Spinone Italiano', 0, 'Medium', 'The Spinone Italiano, a densely-coated hunting dog, is sociable, docile, and patient, sometimes stubborn but always endearing. Of ancient Italian lineage, the Spinone is among the field dogs of Continental Europe famed for versatility.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (153, 'St. Bernard', 0, 'Short', 'The Saint Bernard does not rank very high in AKC registrations, but the genial giant of the Swiss Alps is nonetheless among the world’s most famous and beloved breeds. Saints are famously watchful, patient, and careful with children.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (154, 'Staffordshire Bull Terrier', 0, 'Short', 'From his brawling past, the muscular but agile Staffordshire Bull Terrier retains the traits of courage and tenacity. Happily, good breeding transformed this former gladiator into a mild, playful companion with a special feel for kids.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (155, 'Standard Schnauzer', 0, 'Double-coat long', 'The bold, bewhiskered Standard Schnauzer is a high-spirited farm dog from Germany. They are the sometimes-willful but ever reliable medium-sized members of the Schnauzer family of breeds. The Standard\'s sporty look is a canine classic.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (156, 'Swedish Vallhund ', 0, 'Double-coat medium', 'The long and low Swedish Vallhund, Viking Dog of ancient legend, is a smart and sociable herder of dense coat and boundless energy. These rugged cattle dogs are known for their zest for life, unique vocalizations, and cheerful demeanor.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (157, 'Thai Ridgeback', 0, 'Short', 'The Thai Ridgeback is tough and active, with an excellent jumping ability. He is highly intelligent, has a strong survival instinct, and is a loyal family dog.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (158, 'Tibetan Mastiff', 0, 'Double-coat long', 'Watchful, aloof, imposing, and intimidating: The ancient Tibetan Mastiff is the guardian dog supreme. These densely-coated giants are mellow and calm around the house, sweetly devoted to family, and aloof and territorial with strangers.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (159, 'Tibetan Spaniel', 0, 'Double-coat long', 'The frisky and curious Tibetan Spaniel was bred ages ago for sentinel work on the walls of Tibetan monasteries. Known for a flat, silky coat and “lion’s mane” around the neck, the Tibbie forms a tight, worshipful bond with their humans.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (160, 'Tibetan Terrier', 0, 'Long', 'The Tibetan Terrier, “Holy Dog of Tibet,” is an ancient watchdog and companion long associated with Buddhist monasteries. A profusely coated, small-to-medium-sized dog with “snowshoe” feet, the TT is affectionate, sensitive, and clever.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (161, 'Toy Fox Terrier', 0, 'Short', 'A diminutive satin-coated terrier with an amusing toy-dog personality, the Toy Fox Terrier is, as breed fanciers say, “truly a toy and a terrier.” They began as barnyard ratters but are today beguiling companions with a big personality.', 1, 'Toy');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (162, 'Treeing Walker Coonhound', 0, 'Short', 'A smart, brave, and sensible hunter, the Treeing Walker Coonhound is a genuine American favorite, nicknamed \"The People’s Choice.\" Don’t let the name fool you—Walkers are runners and are capable of covering a lot of ground in a hurry.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (163, 'Vizsla', 0, 'Short', 'The Vizsla is a versatile, red-coated gundog built for long days in the field. For centuries, these rugged but elegant athletes have been the pride of Hungarian sportsmen and their popularity in America increases with each passing year.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (164, 'Weimaraner', 0, 'Short', 'The Weimaraner, Germany’s sleek and swift “Gray Ghost,” is beloved by hunters and pet owners alike for their friendliness, obedience, and beauty. They enjoy exercise, and plenty of it, along with lots of quality time with their humans.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (165, 'Welsh Springer Spaniel', 0, 'Medium', 'The Welsh Springer Spaniel is a vigorous, medium-sized bird dog of happy disposition, known for versatility in the field, companionability at home, and dashing good looks anywhere. The Welshie is among Britain\'s oldest sporting breeds.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (166, 'West Highland White Terrier', 1, 'Double-coat long', 'Smart, confident, and always entertaining at play, the adorable West Highland White Terrier (Westie, for short) has charmed owners for over 300 years. This diminutive but sturdy earthdog is among the most popular of the small terriers.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (167, 'Whippet', 0, 'Short', 'The sleek, sweet-faced Whippet, the “Poor Man’s Racehorse,” is lightning quick. He is an amiable, dignified, and gentle soul, but give him something to chase and he’s all business. The name Whippet is synonymous with streamlined grace.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (168, 'White Shepherd ', 0, 'Double-coat long', 'The White Shepherd emerged from white-coat lines of the German Shepherd dog in Canada and the United States and from European imports.  The German Shepherd and the white German Shepherd are the same dog, though their coat colors vary.  The White Shepherd breed was officially recognized by the United Kennel Club on April 14, 1999.', 1, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (169, 'Wire Fox Terrier', 0, 'Long', 'The Wire Fox Terrier breed standard says they should be “on the tip-toe of expectation at the slightest provocation.” Once a mainstay of traditional British foxhunts, today’s Wire is a handsome and amusing companion and master show dog.', 1, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (170, 'Wirehaired Pointing Griffon', 0, 'Double-coat long', 'The hardworking Wirehaired Pointing Griffon, renowned as the “supreme gundog,” is known for the harsh, low-shedding coat the breed is named for. Outgoing, eager, and quick-witted, Griffs are incomparable in the field and loving at home.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (171, 'Xoloitzcuintli', 0, 'Short', 'The 3,000-year-old Xoloitzcuintli (pronounced \"show-low-eats-QUEENT-lee\"), the ancient Aztec dog of the gods, is today a loving companion and vigilant watchdog. The alert and loyal Xolo comes in three sizes, and in either hairless or coated varieties.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (172, 'Afghan Hound', 1, 'Long', 'Among the most eye-catching of all dog breeds, the Afghan Hound is an aloof and dignified aristocrat of sublime beauty. Despite his regal appearance, the Afghan can exhibit an endearing streak of silliness and a profound loyalty.', 1, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (173, 'Mixed breed dog', 0, 'Unknown', 'N/A', 1, 'Unknown');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (174, 'Abyssinian', 0, 'Short', 'The Aby, as he’s nicknamed, is unlike any other cat. Smart, silly, and impressively athletic, he stays in constant motion—jumping, climbing, and exploring. In other words, this is no lap cat. He also has a unique ticked coat, giving him the appearance of a wildcat.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (175, 'American Bobtail', 0, 'Long', 'The American Bobtail is generally medium to large cat, with a naturally occurring bobbed tail. The American Bobtail is athletic and usually well-muscled with a sometimes powerful look. They possess a natural hunting gaze that combined with their body type, give American Bobtail a distinctive wild appearance.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (176, 'American Curl', 0, 'Long', 'The signature characteristic of the Curl is his unusual ears, which curl backward instead of standing up and coming to a point. The American Curl is a medium-size cat weighing five to 10 pounds, with an average lifespan of more than 13 years.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (177, 'American Shorthair', 0, 'Short', 'The American Shorthair is the pedigreed version of the well-known and beloved domestic shorthair. This versatile cat can be bred for any number of colors and patterns, including the popular silver tabby.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (178, 'American Wirehair', 0, 'Medium', 'The American Wirehair is a medium-size cat with regular features and a sweet expression. This cat\'s wiry coat, right down to the whiskers, is thick, hard and springy. It has been described as resembling steel wool. His unusual coat comes in almost any color or pattern.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (179, 'Balinese', 1, 'Long', 'The primary difference between the Balinese and the Siamese is coat length, with the Balinese having long, silky hair and a plumed tail. The Balinese shares the svelte but muscular body of the Siamese, as well as his wedge-shaped head, blue eyes, large triangular ears and striking color points.', 2, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (180, 'Bengal', 1, 'Short', 'If you love a cat with an exotic look but without the size and danger of a wild cat, the Bengal was developed with you in mind. Created by crossing small Asian Leopard Cats with domestic cats, this large-boned, shorthaired cat stands out for his spotted or marbled coat of many colors.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (181, 'Birman', 0, 'Long', 'His piercing, sapphire-blue eyes stare deep into your soul, and his semi-long coat -- ideally misted with gold -- is silky to the touch. The white-gloved Birman may look elegant, but his appearance belies a powerful, muscular body and a strong love of play.', 2, 'Long');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (182, 'Bombay', 0, 'Short', 'The Bombay is calm, gentle and affectionate. This solid, medium-size cat was created in the 1950s by crossing sable Burmese with black American Shorthairs. His short, velvety coat is easy to care for.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (183, 'British Shorthair', 0, 'Short', 'The British Shorthair is solid and muscular with an easygoing personality. As befits his British heritage, he is slightly reserved, but once he gets to know someone he’s quite affectionate. His short, dense coat comes in many colors and patterns and should be brushed two or three times a week to remove dead hair.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (184, 'Burmese', 1, 'Short', 'Burmese are compact but heavy, often described as bricks wrapped in silk. That doesn’t preclude them from being active and acrobatic. Their short, fine, silky coat comes in the original dark sable brown as well as dilute colors: champagne (light brown), blue and platinum (lilac).Burmese are compact but heavy, often described as bricks wrapped in silk. That doesn’t preclude them from being active and acrobatic. Their short, fine, silky coat comes in the original dark sable brown as well as dilute colors: champagne (light brown), blue and platinum (lilac).', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (185, 'Burmilla', 0, 'Medium', 'The medium-size Burmilla has a sweet expression, a laid-back but mischievous personality and two coat types. He’s generally family friendly, with a coat that’s easy to groom, albeit somewhat prone to matting.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (186, 'Chartreux', 0, 'Double-coat medium', 'The Chartreux is a sturdy, shorthaired French breed coveted in antiquity for its hunting prowess and its dense, water repellent fur. This breed’s husky, robust type is sometimes termed primitive, neither cobby nor classic. Though amply built, Chartreux are extremely supple and agile cats; refined, never coarse nor clumsy.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (187, 'Colorpoint Shorthair', 1, 'Short', 'The Colorpoint Shorthair is a Siamese of a different color—non-traditional colors, that is.  The breed was developed using Siamese as the foundation and then crossing it with a red American Shorthair to bring in a new color. That was successful and attractive, and the cats became the basis for a new breed: the Colorpoint Shorthair.  Eventually, other non-traditional colors were created. The breed was recognized by the Cat Fanciers Association in 1964. The International Cat Association considers the Colorpoint a variety of Siamese, not a separate breed.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (188, 'Cornish Rex', 1, 'Short', 'The playful, affectionate Cornish Rex is a small to medium-size cat with an extraordinary appearance, from his egg-shaped head and curly whiskers to his short coat with bent hairs. The unusual wavy coat comes in many colors and patterns, including bicolor (one color and white) and tortoiseshell.', 2, 'Short');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (189, 'Devon Rex', 1, 'Short', 'With his high cheekbones, big eyes, long legs, slender body, and unusual hairstyle, the Devon Rex looks like the feline incarnation of waiflike model Kate Moss. Like his cousin, the Cornish Rex, the Devon has a wavy coat, but his has a looser curl than that of the Cornish.', 2, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (190, 'Egyptian Mau', 0, 'Short', 'The gentle Egyptian Mau is a feline track star. He has been clocked at 30 miles per hour and is possessed of what seem to be springs for legs, which catapult him to high places. He is the only domesticated cat with a naturally occurring spotted coat.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (191, 'European Burmese', 0, 'Short', 'The European Burmese is a very affectionate, intelligent, and loyal cat. They thrive on companionship and will want to be with you, participating in everything you do. While they might pick a favorite family member, chances are that they will interact with everyone in the home, as well as any visitors that come to call. They are inquisitive and playful, even as adults. Expect them to be in your lap whenever you sit down and snuggle up next to you in bed. They become fast friends to other cats and even dogs, making them the perfect addition to your family.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (192, 'Exotic', 0, 'Long', 'While Persians and their relatives have a laid-back, mellow personality, Exotics are also playful and enjoy a good game of catching the catnip mouse between bouts of catching a few ZZZs. Because of the American Shorthair influence, Exotics are reported to be somewhat livelier than Persians. Undoubtedly, the Exotic personality is, if not identical, very much like the Persian’s—laidback, loyal, sweet, and affectionate. They want to be involved in their favorite humans’ lives and will quietly follow them from room to room just to see what they are doing. They also enjoy hugs and cuddles, and lavish their humans with purrs and licks of affection until the thick coat drives them away to lounge on cool kitchen linoleum or cold fireplace bricks. Because of the short coat, their guardians can spend more time playing with their Exotics than grooming them.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (193, 'Havana Brown', 0, 'Medium', 'More distinctive than the muzzle, ears, or mink-like coat is the Havana Brown’s personality. Although still quite rare, Havanas have built an enthusiastic following. Havana Browns are affectionate, gentle, highly intelligent, and, unlike their Siamese compatriots, quiet. They are remarkably adaptable and agreeable cats, and adjust to almost any situation with poise and confidence. Havanas must have human interaction if they are to live happy, healthy lives. They crave attention from their human companions and are not content unless they can be by your side, helping you with your household tasks. Havanas love to reach out and touch their favorite humans; they often nudge their human friends with an out-stretched paw as if asking for attention. Fetch is a favorite Havana game, and they can often be found carrying toys and stray objects around in their mouths. If you’ve misplaced a sock or some other small, easily carried object, check your Havana’s cat bed. You might find that it has magically found its way there.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (194, 'Japanese Bobtail', 0, 'Medium', 'This fun-loving cat brings good luck to everyone who is fortunate enough to live with him — or so it’s believed in his homeland of Japan. It must be true, because who wouldn’t enjoy spending time with a happy, playful cat who makes friends with everyone. His coat can be short or long and comes in calico as well as other colors and patterns.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (195, 'Khao Manee', 0, 'Short', 'Built for warm weather, the Khao Manee is a lithe, muscular, athletic cat of medium boning. They are devoted to their owners and are curious, intelligent cats who have an enduring sense of naughtiness. They are quite the inquisitive cat and love to play a good game of fetch before curling up with you for a warm nap. Known as the “White Gem”, the Khao Manee was rumored to be highly coveted by Thai royalty is thought to bring good luck to those forunate enough to have one.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (196, 'Korat', 0, 'Short', 'In his home country of Thailand, the Korat is a living symbol of luck and prosperity. He is quieter than the Siamese, to whom he is related, but he definitely will let you know what he’s thinking. His compact, muscular body wears a short, easy-care coat in bluish-gray tipped with silver.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (197, 'LaPerm', 0, 'Medium', 'LaPerms are gentle, people-oriented cats that are affectionate without being overly demanding or clingy. They adore human companionship and adapt well to indoor or apartment living as long as they get the requisite amount of playing and pampering. Like most cats, LaPerms develop the closest bond with their human friends when they get regular human interaction and affection. LaPerms are agile and active. Like their barn cat ancestors, they enjoy a good game of chase, and love pouncing on the catnip mouse.', 2, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (198, 'Lykoi', 0, 'Short', 'The Lykoi cat is considered to be a partially hairless cat. There is no true undercoat, and parts of the body, such as the eyes, chin, nose, muzzle and behind the ears are commonly hairless. The exposed skin, ears and nose feel similar to leather, and although the skin is normally pink, it can darken with exposure to sun. Most cats will molt some or all of their coat, occasionally leaving them to appear even more naked than usual. This is normal for Lykoi cats, and not associated with a disease process.', 2, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (199, 'Manx', 0, 'Double-coat short', 'The friendly, affectionate Manx, who hails from the Isle of Man, is best known for his taillessness. He has a solid body, round head, widely spaced ears, large, round eyes and a thick coat that comes in many colors and patterns, including tabby, tortoiseshell and calico. The Cymric (pronounced kim-rick) is the longhaired variety of the Manx. Other than coat length, the two breeds are identical.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (200, 'Norwegian Forest Cat', 0, 'Double-coat long', 'Despite the wild years in the forests of Norway—or perhaps because of it—they would much rather cuddle than prowl. Perhaps, because of years spent in Norway’s harsh climate, nothing fazes them much, either. They take new people and new situations in stride; as cats go, Forest Cats are the strong, silent types. They are conversely great purrers, particularly when perched beside their favorite humans. Outgoing and gregarious, they tend not to bond with one person, but rather love everyone unconditionally and enthusiastically.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (201, 'Ocicat', 1, 'Short', 'Ocicats may look like they walk on the wild side, but they are affectionate, adaptable, curious, and playful, and possess strong devotion to their human companions. Highly intelligent, active, and social, Ocicats quickly learn to respond to their names and can be taught a variety of tricks, including coming on command. Begging for food is another trick that Ocicats master with very little prompting.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (202, 'Oriental', 1, 'Medium', 'Do not get an Oriental if living with a chatty busybody would drive you insane. On the other hand, if you enjoy having someone to talk to throughout the day, an Oriental can be your best friend. Just be sure you have time to spend with this demanding and social cat. Orientals do not like being left alone for long periods, and if you work during the day it can be smart to get two of them so they can keep each other company.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (203, 'Persian', 0, 'Long', 'If you want your cats bouncing around like hyperactive popcorn, don’t adopt a Persian. Persians are perfect companions, if you like placid, sweet-tempered cats. Don’t count on using your Persian pal as a furry doorstop, however. They love to play between periods of regal lounging on your favorite davenport. Proponents say that Persians do not deserve their furniture-with-fur reputation; they are intelligent, just not as inquisitive as some breeds, and not as active.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (204, 'Ragamuffin', 0, 'Long', 'Don’t confuse the longhaired Ragamuffin with his cousin the Ragdoll. The two are separate breeds, although they are similar in temperament and appearance. Large and affectionate, this is a classic lap cat who loves being cuddled. The Ragamuffin is a big kitty who comes in more colors and patterns than the Ragdoll, although not all of them are accepted by every cat breed association.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (205, 'Ragdoll', 0, 'Long', 'The Ragdoll is a well-balanced cat with no extreme features. They are a medium to large, moderately longhaired, blue-eyed pointed cats. The point markings may be covered by a range of white overlay patterns. Ragdolls are slow maturing, reaching full coat and color at about three years of age. The Ragdoll is an affectionate and intelligent cat, giving the impression of graceful movement and subdued power, striking in appearance.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (206, 'Russian Blue', 1, 'Double-coat short', 'Russian Blues are known to be quiet, gentle, genteel cats, and are usually reserved or absent when strangers come to call. When they’re with their own beloved and trusted humans, however, they are playful and affectionate. Russian Blues are active but not overly so. They like nothing better than to spend time pouncing on a favorite toy or chasing sunbeams. They willingly entertain themselves, but prefer games in which their preferred people take an active role. When you’re home, they follow you around, unobtrusive but ever-present companions.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (207, 'Scottish Fold', 0, 'Long', 'Scottish Folds are typically intelligent, sweet-tempered, soft-spoken, and easily adaptable to new people and situations. They are loyal and tend to bond with one person in the household. While they will usually allow others to cuddle and pet them, their primary attachment becomes quickly clear as they single out their chosen human. They thrive on attention, but it must be on their own terms. Despite their devotion, they are not clingy, demanding cats and usually prefer to be near you rather than on your lap. They enjoy a good game of catch the catnip mouse now and then as well, and keep their playful side well into adulthood.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (208, 'Selkirk Rex', 0, 'Long', 'One may be at first attracted to the Selkirk’s cute and curly exterior, but these cats also make champion companions. Selkirks can be mellow cats with a generous measure of love and affection for their human companions. Very people-oriented, they stay loyal and loving all their lives. They are people-oriented cats that enjoy spending time with their preferred persons.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (209, 'Siamese', 1, 'Short', 'Siamese Cats are incredibly social, intelligent and vocal—they’ll talk to anyone who wants to listen, and even those who don’t. They also play well with other cats, dogs and children. In fact, they thrive on companionship, so it’s a good idea to get them a playmate to interact with throughout the day. Although they’re active and curious, they also love curling up on their human’s lap or snuggling up next to them in bed.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (210, 'Siberian', 1, 'Triple-coat Long', 'Siberians are affectionate cats with a good dose of personality and playfulness. They are amenable to handling, and it is noted that Siberians have a fascination with water, often dropping toys into their water dishes or investigating bathtubs before they’re dry. Siberians seem very intelligent, with the ability to problem-solve to get what they want.', 2, 'Large');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (211, 'Singapura', 0, 'Short', 'At home in any situation, Puras love to be the center of attention, and they don’t seem to know the word stranger; they’re at the door with you to welcome anyone, whether they’re friends and family, or door to door salespeople. They’re curious, people-oriented, and remain playful well into old age. Their voices are quiet and unobtrusive, and they trust their humans implicitly.', 2, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (212, 'Somali', 0, 'Long', 'Like the Abyssinian, the Somali is vigorous and animated, has a keen sense of feline humor, and a real need for play. Everything is a game to a Somali; some will play fetch, but many prefer to chase that ball down the hall and then bat it up and down, around and around, until it rolls back to your feet for you to throw again—and again. If it rolls under something from which they can’t retrieve it, then back they’ll come and give you a wide-eyed stare or a gentle tap so you’ll get up and put the ball back in play. Wands and fishing poles with feathers are a huge hit; you’ll need a lockable cupboard for when playtime is over.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (213, 'Sphynx', 1, 'Bald', 'To say Sphynxes are lively is an understatement; they perform monkey-like aerialist feats from the top of doorways and bookshelves. Very devoted and loyal, they follow their humans around, wagging their tails doggy fashion, kneading with their padded toes, and purring with delight at the joy of being near their beloved humans. They demand your unconditional attention and are as mischievous (and lovable) as children. And despite all that and their alien appearance, they are still entirely cats, with all the mystery and charm that has fascinated humankind for thousands of years. While the Sphynx may not be for everyone, its unique appearance and charming temperament has won it an active, enthusiastic following.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (214, 'Tonkinese', 0, 'Short', 'The Tonkinese craves, and returns, affection and companionship. Unlike the rest of your busy family, this cat will always join you for dinner. Tonks have an unflagging enthusiasm for life and life’s pleasures, and love interactive toys, such as human fingers and the tails of its cat companions. It makes every close encounter a game.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (215, 'Toybob', 0, 'Short', 'Toybob are small cats, no bigger than a 3-6 month old kitten of a normally developed domestic cat, with a short strong and muscular body, short bobbed tail consisting of several kinked vertebras. Toybobs are very affectionate and obedient to their human companions with an even temperament. Despite its small size, they are also very active, playful and agile.', 2, 'Small');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (216, 'Turkish Angora', 0, 'Medium', 'Angoras seem to invoke strong responses in their humans with their symmetry, intelligence, and devotion. Angoras bond with their owners completely; an Angora is not happy unless they are right in the middle of whatever you’re doing. They enjoy a good conversation and can keep up their end of the discussion with the best of them.', 2, 'Medium');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (217, 'Turkish Van', 0, 'Medium', 'While you might be drawn to the Van for its fascination with water, you’ll fall in love with this cat for its other qualities. Vans are energetic, agile, and intelligent. They are extremely healthy and “get along with people swimmingly,” notes one Van owner. You may need a few months of working out to keep up with them, however; Vans are famous for their action-packed temperaments. They are talkative, demand attention from their humans, and show great gusto at dinnertime. Vans are known for their deep attachment to their preferred people, and sometimes that makes transferring a Van from one household to another difficult. They tend to pick out one or two people in the household, usually the ones who deal with them initially, and bond with them forever.', 2, 'Long');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (218, 'Javanese', 1, 'Medium', 'Javanese cats, like their Balinese relatives, are playful, devoted, and always eager to tell you their views on life, love, and what you’ve served them for dinner. Javanese (and their Siamese relatives) have a fascination with food, and, while some will burn off the extra calories in playful antics, care must be taken that the less active don’t turn into butterballs.', 2, 'Short');
INSERT INTO `breed` (`id`, `name`, `hypoallergenic`, `hair_type`, `description`, `species_id`, `size`) VALUES (219, 'Mixed cat breed', 0, 'Unknown', 'N/A', 2, 'Unknown');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pet`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (1, 'Leeloo', 'Average', 20, 4, 'Golden', 1, 'None', '1', 1, 1, 1);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (2, 'Yuki', 'Large', 55, 8, 'Red and white', 1, 'Needs heart worm pills', '1', 1, 5, 2);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (3, 'Meeko', 'Average', 15, 2, 'Black and brown', 0, 'None', '0', 0, 4, 3);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (4, 'Canis', 'Small', 45, 4, 'Black and White', 1, 'None', '1', 1, 2, 2);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (5, 'Parker', 'Average', 43, 2, 'Black and White', 1, 'Prefers a home without children, and without cats', 'Hi there my name is Parker! I am a handsome guy with a vibrant personality. I have energy to spare so I am looking for an active family that wants to keep me on the go. I am going to need exercise, training, socialization, and affection. I look forward to going for runs, trips to the park, and hiking. My adoption fee includes my neuter, a microchip, vaccines, and a fourteen day limited health guarantee through Redstone Animal Hospital! Come and visit me today!', 0, 1, 2);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (6, 'Bo', 'Average', 42, 2, 'Red Roan', 1, 'Prefers a home without children. May be cautious around men.', 'Hello, My name is Bo and I am a handsome young man. I am very happy and excited my butt never stops wiggling! I am looking for a family that will provide me with daily exercise and training. I LOVE squeaky toys and will throw them around in my kennel! I am eager to please and would love to be your part of your family. I\'m affectionate and cuddly but not sure about men still, and need help learning how to socialize with them. If I sound like the right fit please come down and see me today.', 0, 1, 13);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (7, 'Cartmen', 'Average', 14, 5, 'Brown tabby and White', 1, 'Has Fiv+ needs a home without other cats or is in a house with other Fiv+ cats', 'Hi there my name is Cartmen! I am FIV+ so I will need to be in a home as either the only cat, or with other FIV+ cats.\nI am such a handsome guy with a fun demeanor. I am easy going and laid back. I am looking for a home where I will be an indoor cat with a window to sunbathe, scratching posts, and a cozy bed. I enjoy getting affection, eating, and lounging around. I do have feline aids so I am looking for a home either with other cats that have the same virus or as an only cat in the household. My adoption fee includes my neuter, a microchip, vaccines, and a fourteen day limited health guarantee through Redstone Animal Hospital! Come and visit me today!', 0, 1, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (8, 'Banana', 'Average', 7, 3, 'Orange Tabby', 1, 'None', 'Hi there my name is Banana! I am a beautiful lady with a kind heart. I can be a bit bashful, but with a soft voice and gentle touch I warm up. I am looking for a calm quiet home where I will be an indoor kitty. I hope to find a family that will be patient with me as I come out of my shell. My adoption fee includes my spay, a microchip, vaccines, and a fourteen day limited health guarantee through Redstone Animal Hospital! Come and visit me today!', 0, 1, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (9, 'Penny', 'Small', 15, 14, 'White and Copper', 1, 'Has Cushing\'s disease, needs daily pills costing about 50 dollars a month.', 'Hi there, my name is Penny. My volunteer friends like to say \"pretty as a penny\" because I am so adorable. I am a sweet-faced 14-year-old, white and beige Lhasa Apso and Shih Tzu mix. I am a small girl, weighing 15 lbs. I found myself at MaxFund after being surrendered through no fault of my own: my previous owner had to move and could not bring me along. I am a mellow and sweet girl, who does well with other fur babies. I lived in a home with two other dogs and I was well-behaved so I could fit in at just about any household. Make sure to bring your dogs in to meet me to make sure we get along great! It is unknown how I do with cats, but the staff could get me tested to make sure I will behave myself around cats. I would love to bond with you and become lifelong pals. I also do well with kids, but remember I am an older lady so they must be gentle with me please! Another advantage to adopting an older dog is that I have basic knowledge of commands and I am housebroken! Since I am on the older side, this comes with changes in my body as well. I do have a condition called Cushing\'s disease which is a hormonal imbalance that requires I take medication every day. This would cost my owner about $50 a month. That is a small price to pay compared to all the love and joy I will bring into your life. I am a very cute and unique looking girl, I do have a head tilt that makes me look like I\'m questioning you all the time, but promise I\'m not a judgy girl. I\'m taking getting older like a champ and would love to spend the rest of my days in a comfortable and loving home where I can give and receive tons of love and attention. Would you like to spend my retirement time with me? I hope I am lucky enough to find my forever very soon. I am currently in a foster home, but you can still visit with me! Provide your information to the front desk and they can let you know how to meet with me! Have you ever considered helping save the life of an older dog through adoption? Today could be the day you reach that goal!', 0, 2, 146);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (10, 'Jazzy', 'Small', 14, 5, 'Tan and White', 1, 'None', 'What\'s up, people! My name is Jazzy, nice to meet you! I am a cute, tan and white chihuahua mix. I am a 5-year-old, small sized girl who weighs 14 lbs. Not too teeny, but not too large either. I am just the perfect size! I found my way to MaxFund after making a long journey from New Mexico, where the shelter I was at no longer had room for me. Thankfully, I was able to make it to Colorado where I can start my new life in this beautiful state.\nWhen I first arrived, I was very nervous. After some time, I have started to show more of my personality to my staff and volunteer friends. I am quite the sweet, little girl! I love to be pet, especially on my tummy! I also love to show off my hand-shaking skills, I can prop myself up and shake both paws with you at the same time! I am a character, that is for sure!\nIt is unknown how I get along with other dogs, since I haven\'t had a ton of interaction with other dogs while at MaxFund. If I will potentially be gaining fur siblings, make sure to bring them in to meet me and see how great we can get along. If my sibling might be a cat, the staff here at the shelter can get me a cat test. Just ask the front desk!\nI would love to go to a home where I can be someone\'s best friend and companion. I am a great lap dog, just ask my volunteer friends! I would love to chill out at home and enjoy each other\'s company. Do I sound like the perfect lady for you? I hope I am lucky enough to find my forever home very soon. I am patiently waiting to show all my love to my new family. Please meet with me today! See you very soon!', 0, 2, 53);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (11, 'Nika', 'Large', 55, 7, 'Black', 1, 'Scared of vets, needs Trazadone to calm down before visits, costs $15-$20 per bottle, also needs Proin everyday for incontinence costing $50 for a 3 month supply', 'Hello, folks! My name is Nika and I am a part of the very special Old Lady Club we have here at Maxfund. I am a beautiful, 7-year old, black Labrador and Akita mix. I am a large gal, weighing in at about 55 lbs. I found my way to MaxFund after being surrendered through no fault of my own. My previous owner just did not have any time to care for me.\nAlthough I am older and my face has already started to go grey, I have the spirit of a pup! Do you know what the best thing about adopting an older dog is? Well, I\'ll tell ya! I already know all of my manners and basic commands. I am even already crate trained! I am ready to go to a home and behave while still bringing some fun into your life.\nThere are a few unique things that should be considered when adopting a senior dog like me as well. I\'m not as physically young as I used to be so my body has gone through some changes. I do have a little bit of urinary incontinence which is very well maintained when I take Proin everyday. It is an easy chewable to give me, and costs about $50 for a three month supply.\nI am not a huge fan of going to the vet, this makes me very nervous. Who likes to get poked and examined, anyway? Because of this, I have one other medication that I take when I am supposed to visit the vet. I\'m given Trazadone to help ease my nerves. This med costs about $15-$20 a bottle which would last quite a while given that I only have to go to the vet a few times a year.\nI am a very sweet girl who loves to bond with my human companions. I love humans of all sizes and ages! Being pet is my absolute favorite thing. I would love to snuggle up on the couch and enjoy each other\'s company this holiday season. If you\'re looking to play around and run around outside, I am also your gal! I am up for just about anything.\nI am more picky with my dog friends, so make sure to bring your fur babies with you to see we get along. The staff is unsure of how I react to cats, but I can be tested at our cat shelter upon request. Let the front desk know!\nAre you looking for the perfect balance of excitement and mellow in your life? I may just be the perfect match for you. Please visit with me today so I can show off for the Old Ladies here. I will be waiting for ya!', 0, 2, 103);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (12, 'Moses', 'Average', 50, 5, 'Grey and White', 1, 'Might be scared of other dogs, prefers female and smaller dogs', 'Hiya! I hope you\'re looking for a pup to bring you lots of joy! I have one contagious smile that will have you falling in love with me! I\'m Moses and I\'m 5-year-old, energetic, 50 lbs. boy that is on the lookout for his forever home. I\'m a very strong fella that would be a great addition to an athletic family/person. Because of my size and energy, I would do better in a home that has a yard. I am crate trained, potty trained and just a well behaved boy overall. I can be 50/50 with some other dogs (I prefer females) so I do ask that you bring in any potential future sibling to make sure we get along. I do great with smaller dogs, cats, and children! If you think that I would make a great fit with you and your family, come by to the MaxFund and meet me in person! I\'ll be waiting for ya!', 0, 2, 173);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (13, 'Alley Houston', 'Average', 10, 4, 'Black Tabby', 1, 'None', 'None', 0, 3, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (14, 'Cleo Houston', 'Average', 8, 2, 'Black', 1, 'None', 'None', 0, 3, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (15, 'Cholula Houston', 'Average', 9, 2, 'Tabico', 1, 'None', 'None', 0, 3, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (16, 'Lisa Aztec', 'Average', 9, 2, 'Chocolate Point', 1, 'None', 'None', 0, 3, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (17, 'Shadow Dakota', 'Average', 9, 5, 'Grey', 1, 'FeLV+ cat.', 'None', 0, 3, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (18, 'Forester', 'Average', 65, 2, 'Brown', 1, 'Possible obedience training needed (House trained, general commands, etc.)', 'Forester is a 2 year old lab mix that was saved from death row. Forester is a nice dog who just needed a chance out of the shelter environment in order to flourish and be ready for adoption. He has been neutered, vaccinated, microchipped, and has been dewormed. Forester is working on all the obedience items (house training, crate training, general commands, etc.) and would love to be part of a family that keep him occupied as part of daily routine.', 0, 4, 103);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (19, 'Mona', 'Large', 70, 4, 'Brown', 1, 'Protein allergy to certain foods, will recieve a meal plan that needs to be followed upon adoption', 'Mona was part of a cruelty investigation because she has protein allergies and it was affecting her health to the point that her old owner could not afford to care for her. She needs to be on a prescription diet and we will provide the script for the food. She is house trained, great with cats, and if she has the right environment and owner with proper introductions, does well with dogs. Mona is a sweet girl who is ready for a forever home. Mona is spayed, pexied, dewormed, microchipped with registration, and fully vaccinated.', 0, 4, 173);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (20, 'Candice', 'Small', 20, 1, 'White', 1, 'Obedience training in progress (House trained, General commands, etc.)', 'Candice is a 4 month old lab/heeler mix that was saved from death row. Candice is a nice dog who just needed a chance out of the shelter environment in order to flourish and be ready for adoption. She has been spayed, vaccinated, microchipped, and has been dewormed. Candice is working on all the obedience items (house training, crate training, general commands, etc.) and would love to be part of a family that keep her occupied as part of daily routine.', 0, 4, 103);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (21, 'Cambria', 'Small', 10, 1, 'Black and White', 1, 'Obedience training in progress (House trained, General commands, etc.)', 'Cambria is a 9 week old heeler mix that was saved from death row. Cambria is a nice dog who just needed a chance out of the shelter environment in order to flourish and be ready for adoption. She has been spayed, vaccinated, microchipped, and has been dewormed. Cambria is working on all the obedience items (house training, crate training, general commands, etc.) and would love to be part of a family that keep her occupied as part of daily routine.', 0, 4, 173);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (22, 'Miss Mattie', 'Average', 10, 10, 'White and Black', 1, 'Has kidney issues, requires a special diet to accomidate this. Will be given to those who adopt her. Does not do well with young loud children, ok with older and more mature kids.', 'Pretty white with black markings short haired senior femalePretty Mattie is hungry for affection. She is 10 yrs old and is such a sweet lady. She has a little bit of kidney issues why she\'s listed as Special Needs. She requires Kidney Diet food. She can be a bit shy off the bat, but is very sweet once she gets to know you a little. She came to us after losing her owner. She\'ll need a calm home and some time and patience. She does not do well with young or loud children, but would be OK with calm, older children who\'d be gentle with her. She is said to like men or their low voices that sound rather purrrr like but responds to all once she gets to know you a little. She does fine with women. She would be so lucky to find a lasting home in her golden years.', 0, 5, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (23, 'Tux', 'Average', 8, 2, 'Black and White', 1, 'Does not do well with younger kids. Also is a bit dominant around other cats.', 'Short haired Black and White Tuxedo Adult Neutered MaleTux is always well dressed and very handsome in his permanent tuxedo. He is a 2 year old Domestic short Hair black and white Neutered Male. He craves attention but can be a bit nippy so he\'ll need an adopter who understands him and can deal with that and gently help with this behavior. He came to us with an injured leg which is doing very well. He does fine with his feline roommates but can be a bit dominant around them. He would do better as the only cat or with more laid back cats. We don\'t know about dogs. He\'d be OK with older children who\'d know to give him space when he needs it, but shouldn\'t be around younger children. Come meet this handsome young man to see if you have the safe, lasting home with some patience and willingness to work with him that he needs.', 0, 5, 219);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (24, 'Lizzy', 'Small', 7, 2, 'Orange Tabby', 1, 'Has Fiv+ needs a home without other cats or is in a house with other Fiv+ cats', 'American Short Hair/DSH Orange Tabby Spayed FemaleLizzy would like to \'kizzy\' you face!. Lizzy is a very pretty young 2 year old American Shorthair/Domestic Short hair mixed orange tabby spayed female. She is very sweet, frienldy and craves attention. She would love to be on your lap, near you or playing with you as much as possible. She gets along well with her feline roommates. She is FIV+ which is the Feline Immunodeficiency Virus. It is only contagious to other kitties through deep bite wounds. It means her immune system is just slightly lower than normal kitties, but most cats with FIV live long, healthy lives if they are in a safe, indoor only, calm environment. They have been adopted with other FIV+ cats as long as both are non aggressive. She is not aggressive and as long as any other kitties in the home are not, she should be fine with non-FIV cats. Please discuss with a veterinarian who is well educated and up to date on the latest info about FIV to help you decide. She has been fine with the children she\'s met so far. We don\'t know about dogs. Come meet this sweet and pretty young lady to see if you have the safe and lasting home she is looking for.', 0, 5, 177);
INSERT INTO `pet` (`id`, `name`, `size`, `weight`, `age`, `color`, `fixed`, `special_conditions`, `bio`, `adopted`, `shelter_id`, `breed_id`) VALUES (25, 'Evie', 'Average', 10, 2, 'Orange and White', 1, 'Does not do well with other cats besides Cali.', 'Short-haired Orange and White Young FemaleEvie means life and our sweet little creamsicle, Evie, is hoping for a good life in a good home. Evie is a young, 2 year old orange and white short -haired spayed female. She is sweet and enjoys attention on her terms. She can get a little nervous in new environments so she\'ll need some time to adjust to a new home. She doesn\'t really care for other cats, and was returned for not getting along with one in her previous home. She only seems to get along with her current feline roommate, Cali, a white cat who needs a special diet, so she\'d be OK with her, but would prefer to be the only cat if they aren\'t adopted together. She doesn\'t care for really young, loud or over-active children, but should be OK with older, calm children who would give her space when she needs it and be gentle with her. We don\'t know about dogs. Come meet this sweet young lady to see if you have the calm, safe and lasting home she needs.', 0, 5, 219);

COMMIT;


-- -----------------------------------------------------
-- Data for table `image`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `image` (`id`, `image_url`) VALUES (1, 'https://www.westparkanimalhospital.com/wp-content/uploads/2019/05/WestPark_iStock-600994082-1024x706-1.webp');
INSERT INTO `image` (`id`, `image_url`) VALUES (2, 'https://www.thehappycatsite.com/wp-content/uploads/2018/02/Maine-Coon-Cats-HC-long-1024x555.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpWMHkB5cJ4BXvDQOSCEC6DnY8fm588FZnJw6AJemp95zdBALhHA&s');
INSERT INTO `image` (`id`, `image_url`) VALUES (4, 'https://journalism.missouri.edu/wp-content/uploads/2019/07/douglas-wilbur-2015-768x1024-300x400.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (5, 'https://www.animalleague.org/wp-content/uploads/2019/02/logo-humane-society-south-platte.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (6, 'https://d3926qxcw0e1bh.cloudfront.net/post_photos/7e/88/7e88f84df638febec7e91529dd0446be.jpg.max578.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (7, 'http://photos.petfinder.com/photos/pets/46682490/1/?bust=1576522781&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (8, 'http://photos.petfinder.com/photos/pets/46682490/2/?bust=1576522781&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (9, 'http://photos.petfinder.com/photos/pets/46682490/3/?bust=1576522779&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (10, 'http://photos.petfinder.com/photos/pets/46511245/1/?bust=1576115132&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (11, 'http://photos.petfinder.com/photos/pets/46511245/2/?bust=1576115136&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (12, 'http://photos.petfinder.com/photos/pets/46511245/3/?bust=1576115136&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (13, 'http://photos.petfinder.com/photos/pets/46510803/1/?bust=1575997714&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (14, 'http://photos.petfinder.com/photos/pets/46510803/2/?bust=1575997715&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (15, 'http://photos.petfinder.com/photos/pets/46327502/1/?bust=1575997719&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (16, 'http://photos.petfinder.com/photos/pets/46327502/2/?bust=1575997719&width=300&-pn.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (17, 'http://lifeisbetterrescue.org/images/large/cambriaDogLg2.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (18, 'http://lifeisbetterrescue.org/images/large/candiceDogLg.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (19, 'http://lifeisbetterrescue.org/images/large/monaDogLg.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (20, 'http://lifeisbetterrescue.org/images/large/foresterDogLg.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (21, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/42131883/1/?bust=1556716062&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (22, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/42131883/2/?bust=1556716065&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (23, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/42131883/3/?bust=1556716066&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (24, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/45133008/1/?bust=1563736637&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (25, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44908866/1/?bust=1576099560&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (26, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44908866/2/?bust=1576099565&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (27, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46436477/1/?bust=1575827719&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (28, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44574495/1/?bust=1576099565&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (29, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44574495/2/?bust=1576099564&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (30, 'https://g.petango.com/photos/2241/f88071d1-3272-4271-afaf-8d41bcbafe0a.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (31, 'https://g.petango.com/photos/2241/10042a39-f3ea-4d3b-9d2b-7788c54e3c86.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (32, 'https://g.petango.com/photos/2241/1f60a9b6-06c3-4662-ae1d-125b468d5d65.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (33, 'https://g.petango.com/photos/2241/4491b06d-adc8-4eda-a446-2246782116e6.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (34, 'https://g.petango.com/photos/2241/a371f67d-cc1b-4124-a418-e562431478f3.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (35, 'https://g.petango.com/photos/2241/95bfd48c-628c-4565-a864-9293132996cc.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (36, 'https://g.petango.com/photos/2241/0a3b8f4d-9f91-4eef-bfe5-98b32cda1603.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (37, 'https://g.petango.com/photos/2241/5cb5dc9a-0375-4c4c-95f8-bd824924dc16.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (38, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46578655/1/?bust=1573771266&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (39, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46835646/1/?bust=1576203049&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (40, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46511291/1/?bust=1576275038&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (41, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46511291/2/?bust=1576275043&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (42, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46873194/1/?bust=1576612517&width=1080');
INSERT INTO `image` (`id`, `image_url`) VALUES (43, 'https://scontent.fapa1-2.fna.fbcdn.net/v/t1.0-9/13307427_124250251327750_3410414215689454906_n.jpg?_nc_cat=109&_nc_ohc=ULefPg8rf68AQk_p09YdnHw3vR9XJI41UCtviJvHq9o_Q5Anqn0Pw1Z5w&_nc_ht=scontent.fapa1-2.fna&oh=45af73dd0d4b1d17d3e53d4c86c7f473&oe=5E6E160D');
INSERT INTO `image` (`id`, `image_url`) VALUES (44, 'https://dare.org/wp-content/uploads/2019/08/MaxFund-Logo.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (45, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKlz59_k3wWnIGp3qHOjfMlR5_EQA7II8fCpdT02Gvy7V8mL4I&s');
INSERT INTO `image` (`id`, `image_url`) VALUES (46, 'https://s3fs.bestfriends.org/s3fs-public/styles/mobile_full_width/public/partners/rmfr-logo.jpg?itok=c04BkxDk');
INSERT INTO `image` (`id`, `image_url`) VALUES (47, 'https://static.wixstatic.com/media/f4a573_2d90639a6e5749bf820322fdf2459ded~mv2.jpg/v1/fill/w_560,h_158,al_c,q_80,usm_0.66_1.00_0.01/f4a573_2d90639a6e5749bf820322fdf2459ded~mv2.webp');
INSERT INTO `image` (`id`, `image_url`) VALUES (48, 'http://lifeisbetterrescue.org/images/store/lipbalmCloseupLg.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (49, 'https://i.ytimg.com/vi/vFs-YM9cpn0/maxresdefault.jpg');
INSERT INTO `image` (`id`, `image_url`) VALUES (50, 'data:image/jpeg;base64,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');
INSERT INTO `image` (`id`, `image_url`) VALUES (51, 'data:image/jpeg;base64,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');
INSERT INTO `image` (`id`, `image_url`) VALUES (52, 'https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half-caption/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=0hb44OrI');
INSERT INTO `image` (`id`, `image_url`) VALUES (53, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpWMHkB5cJ4BXvDQOSCEC6DnY8fm588FZnJw6AJemp95zdBALhHA&s');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pet_trait`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (1, 4);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (1, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (1, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (2, 9);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (2, 1);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (2, 6);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (3, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (3, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (3, 3);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (4, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (4, 8);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (5, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (5, 12);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (6, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (6, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (6, 8);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (7, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (7, 11);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (8, 3);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (8, 11);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (9, 11);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (9, 9);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (10, 9);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (10, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (11, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (11, 8);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (12, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (12, 5);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (12, 12);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (18, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (19, 3);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (19, 9);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (20, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (20, 4);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (21, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (21, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (22, 9);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (22, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (23, 5);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (23, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (24, 2);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (24, 8);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (25, 10);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (25, 11);
INSERT INTO `pet_trait` (`pet_id`, `trait_id`) VALUES (25, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pet_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (1, 3);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (2, 3);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (7, 22);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (8, 22);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (9, 22);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (10, 23);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (11, 23);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (12, 23);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (13, 24);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (14, 24);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (15, 25);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (16, 25);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (17, 21);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (18, 20);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (19, 19);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (20, 18);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (21, 17);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (22, 17);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (23, 17);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (24, 16);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (25, 15);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (26, 15);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (27, 14);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (28, 13);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (29, 13);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (30, 12);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (31, 12);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (32, 12);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (33, 11);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (34, 10);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (35, 10);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (36, 10);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (37, 9);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (38, 8);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (39, 7);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (40, 6);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (41, 6);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (42, 5);
INSERT INTO `pet_image` (`image_id`, `pet_id`) VALUES (43, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `foster`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `foster` (`id`, `max_foster`, `user_id`) VALUES (1, 4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `foster_breed`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `foster_breed` (`foster_id`, `breed_id`) VALUES (1, 1);
INSERT INTO `foster_breed` (`foster_id`, `breed_id`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `foster_trait`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `foster_trait` (`trait_id`, `foster_id`) VALUES (2, 1);
INSERT INTO `foster_trait` (`trait_id`, `foster_id`) VALUES (10, 1);
INSERT INTO `foster_trait` (`trait_id`, `foster_id`) VALUES (3, 1);
INSERT INTO `foster_trait` (`trait_id`, `foster_id`) VALUES (7, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `foster_pet`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `foster_pet` (`foster_id`, `pet_id`, `id`, `date_requested`, `active`, `notes`, `date_completed`) VALUES (1, 1, 1, '2019-12-05', false, NULL, '2020-01-22');

COMMIT;


-- -----------------------------------------------------
-- Data for table `fost_reputation`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `fost_reputation` (`id`, `foster_id`, `content`, `rating`) VALUES (1, 1, 'SOOOOOO GOOOD!!', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `skill`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `skill` (`id`, `name`) VALUES (1, 'Grooming');
INSERT INTO `skill` (`id`, `name`) VALUES (2, 'Training');
INSERT INTO `skill` (`id`, `name`) VALUES (3, 'General pet care');
INSERT INTO `skill` (`id`, `name`) VALUES (4, 'Vet');
INSERT INTO `skill` (`id`, `name`) VALUES (5, 'Customer Service');
INSERT INTO `skill` (`id`, `name`) VALUES (6, 'General Maintenance & Repair');

COMMIT;


-- -----------------------------------------------------
-- Data for table `volunteer_skill`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `volunteer_skill` (`skill_id`, `user_id`) VALUES (1, 2);
INSERT INTO `volunteer_skill` (`skill_id`, `user_id`) VALUES (2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `shelter_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (1, 5);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (1, 6);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (2, 44);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (2, 45);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (3, 46);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (3, 47);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (4, 48);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (4, 49);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (5, 50);
INSERT INTO `shelter_image` (`shelter_id`, `image_id`) VALUES (5, 51);

COMMIT;


-- -----------------------------------------------------
-- Data for table `species_foster`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `species_foster` (`species_id`, `foster_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pet_adoption`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `pet_adoption` (`id`, `date_requested`, `accepted_date`, `meet_date`, `meet_req_date`, `meet_notes`, `accepted`, `reason_denied`, `user_id`, `pet_id`) VALUES (1, '2019-12-15', NULL, '2019-12-17', '2019-12-17', 'Liam canceled the meeting, adopted another dog', false, 'Liam canceled the meeting, adopted another dog', 2, 2);
INSERT INTO `pet_adoption` (`id`, `date_requested`, `accepted_date`, `meet_date`, `meet_req_date`, `meet_notes`, `accepted`, `reason_denied`, `user_id`, `pet_id`) VALUES (2, '2019-12-16', '2019-12-18', '2019-12-18', '2019-12-18', 'Went well, Brian loved the dog, and has adopted yuki.', true, NULL, 3, 2);
INSERT INTO `pet_adoption` (`id`, `date_requested`, `accepted_date`, `meet_date`, `meet_req_date`, `meet_notes`, `accepted`, `reason_denied`, `user_id`, `pet_id`) VALUES (3, '2019-12-15', '2019-12-17', '2019-12-17', '2019-12-17', 'David loved Canis, and she seemed really happy with her new owner.', true, NULL, 4, 4);
INSERT INTO `pet_adoption` (`id`, `date_requested`, `accepted_date`, `meet_date`, `meet_req_date`, `meet_notes`, `accepted`, `reason_denied`, `user_id`, `pet_id`) VALUES (4, '2019-11-30', '2019-12-05', '2019-12-05', '2019-12-05', 'Shawn met leeloo, both got along well. Shawn needed light instructioning on how to raise a dog.', true, NULL, 5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_shelter`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `user_shelter` (`shelter_id`, `user_id`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `fureverfriendsdb`;
INSERT INTO `user_image` (`user_id`, `image_id`) VALUES (1, 3);
INSERT INTO `user_image` (`user_id`, `image_id`) VALUES (2, 4);
INSERT INTO `user_image` (`user_id`, `image_id`) VALUES (6, 52);
INSERT INTO `user_image` (`user_id`, `image_id`) VALUES (7, 53);

COMMIT;

