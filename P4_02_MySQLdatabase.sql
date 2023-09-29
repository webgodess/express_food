-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Set the database name

-- -----------------------------------------------------
-- Schema express_food
-- -----------------------------------------------------
-- Drop the addresses table if it exists


DROP TABLE IF EXISTS `express_food`.`OrderHistory`;
DROP TABLE IF EXISTS `express_food`.`users_roles`;
DROP TABLE IF EXISTS `express_food`.`menuitems`;

-- -----------------------------------------------------
-- Schema express_food
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `express_food` DEFAULT CHARACTER SET utf8mb3 ;
USE `express_food` ;

-- -----------------------------------------------------
-- Table `express_food`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `express_food`.`users`;
CREATE TABLE IF NOT EXISTS `express_food`.`users` (
  `users_ID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `role` VARCHAR(15) NOT NULL,
  `create_time` TIMESTAMP NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`users_ID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `express_food`.`addresses`;
CREATE TABLE IF NOT EXISTS `express_food`.`addresses` (
  `Address_ID` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(100) NOT NULL,
  `Postal_Code` VARCHAR(10) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `users_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`Address_ID`, `users_ID`),
  INDEX `fk_Address_users1_idx` (`users_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Address_users1`
    FOREIGN KEY (`users_ID`)
    REFERENCES `express_food`.`users` (`users_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `express_food`.`categories`;
CREATE TABLE IF NOT EXISTS `express_food`.`categories` (
  `category_ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`category_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`orderhistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `express_food`.`orderhistory`;
CREATE TABLE IF NOT EXISTS `express_food`.`orderhistory` (
  `OrderHistory_ID` INT NOT NULL AUTO_INCREMENT,
  `Order_Date` DATETIME NULL DEFAULT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  `users_ID` INT NOT NULL,
  PRIMARY KEY (`OrderHistory_ID`, `users_ID`),
  INDEX `fk_orderhistory_users1_idx` (`users_ID` ASC) VISIBLE,
  CONSTRAINT `fk_orderhistory_users1`
    FOREIGN KEY (`users_ID`)
    REFERENCES `express_food`.`users` (`users_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`delivery_manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `express_food`.`delivery_manager`;
CREATE TABLE IF NOT EXISTS `express_food`.`delivery_manager` (
  `delivery_manager_id` INT NOT NULL AUTO_INCREMENT,
  `start_time` DATETIME NULL DEFAULT NULL,
  `end_time` DATETIME NULL DEFAULT NULL,
  `users_ID` INT NOT NULL,
  `Address_ID` INT NOT NULL,
  `OrderHistory_ID` INT NOT NULL,
  PRIMARY KEY (`delivery_manager_id`, `users_ID`, `Address_ID`, `OrderHistory_ID`),
  INDEX `fk_delivery_manager_Users1_idx` (`users_ID` ASC) VISIBLE,
  INDEX `fk_delivery_manager_Addresses1_idx` (`Address_ID` ASC) VISIBLE,
  INDEX `fk_delivery_manager_orderhistory1_idx` (`OrderHistory_ID` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_manager_Addresses1`
    FOREIGN KEY (`Address_ID`)
    REFERENCES `express_food`.`addresses` (`Address_ID`),
  CONSTRAINT `fk_delivery_manager_Users1`
    FOREIGN KEY (`users_ID`)
    REFERENCES `express_food`.`users` (`users_ID`),
  CONSTRAINT `fk_delivery_manager_orderhistory1`
    FOREIGN KEY (`OrderHistory_ID`)
    REFERENCES `express_food`.`orderhistory` (`OrderHistory_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `express_food`.`menuitems` (
  `MenuItem_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Price` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItem_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`menu_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `express_food`.`menu_schedule` (
  `Menu_schedule_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `MenuItem_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`Menu_schedule_id`, `MenuItem_ID`),
  INDEX `fk_Menu_schedule_MenuItem1_idx` (`MenuItem_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_schedule_MenuItem1`
    FOREIGN KEY (`MenuItem_ID`)
    REFERENCES `express_food`.`menuitems` (`MenuItem_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`menuitem_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `express_food`.`menuitem_categories` (
  `MenuItem_categories_ID` INT NOT NULL AUTO_INCREMENT,
  `category_ID` INT NOT NULL,
  `MenuItem_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItem_categories_ID`, `category_ID`, `MenuItem_ID`),
  INDEX `fk_categories_has_MenuItem_MenuItem1_idx` (`MenuItem_ID` ASC) VISIBLE,
  INDEX `fk_categories_has_MenuItem_categories1_idx` (`category_ID` ASC) VISIBLE,
  CONSTRAINT `fk_categories_has_MenuItem_categories1`
    FOREIGN KEY (`category_ID`)
    REFERENCES `express_food`.`categories` (`category_ID`),
  CONSTRAINT `fk_categories_has_MenuItem_MenuItem1`
    FOREIGN KEY (`MenuItem_ID`)
    REFERENCES `express_food`.`menuitems` (`MenuItem_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`menuitem_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `express_food`.`menuitem_order` (
  `MenuItem_Order_ID` INT NOT NULL AUTO_INCREMENT,
  `Quantity` INT NOT NULL,
  `MenuItem_ID` INT NOT NULL,
  `OrderHistory_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItem_Order_ID`, `MenuItem_ID`, `OrderHistory_ID`),
  INDEX `fk_MenuItem_Order_MenuItem1_idx` (`MenuItem_ID` ASC) VISIBLE,
  INDEX `fk_MenuItem_Order_OrderHistory1_idx` (`OrderHistory_ID` ASC) VISIBLE,
  CONSTRAINT `fk_MenuItem_Order_MenuItem1`
    FOREIGN KEY (`MenuItem_ID`)
    REFERENCES `express_food`.`menuitems` (`MenuItem_ID`),
  CONSTRAINT `fk_MenuItem_Order_OrderHistory1`
    FOREIGN KEY (`OrderHistory_ID`)
    REFERENCES `express_food`.`orderhistory` (`OrderHistory_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `express_food`.`roles` (
  `roles_ID` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`roles_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `express_food`.`users_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `express_food`.`users_roles` (
  `users_roles_ID` INT NOT NULL AUTO_INCREMENT,
  `users_ID` INT NOT NULL,
  `roles_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`users_roles_ID`, `users_ID`, `roles_ID`),
  INDEX `fk_users_has_roles_roles1_idx` (`roles_ID` ASC) VISIBLE,
  INDEX `fk_users_has_roles_users1_idx` (`users_ID` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_roles_roles1`
    FOREIGN KEY (`roles_ID`)
    REFERENCES `express_food`.`roles` (`roles_ID`),
  CONSTRAINT `fk_users_has_roles_users1`
    FOREIGN KEY (`users_ID`)
    REFERENCES `express_food`.`users` (`users_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `express_food`.`users` ( `firstName`, `lastName`, `phone_number`, `email`, `password`, `role`, `create_time`, `update_time`)
VALUES
('Simon', 'Meister', '123-456-7890', 'simon.meister@example.com', 'password123', 'DeliveryPerson', NOW(), NULL),
('Martin', 'Buri', '243-547-9990', 'martin.buri@example.com', 'password456', 'DeliveryPerson', NOW(), NULL),
('Rohnny', 'Kohli', '987-654-3210', 'rohnny.kohli@example.com', 'password789', 'DeliveryPerson', NOW(), NULL),
('Kurt', 'Jakob', '768-436-1605', 'kurt.jakob@example.com', 'password101', 'DeliveryPerson', NOW(), NULL),
('Lanz', 'Thomas', '0797474964', 'th.lanz@hotmail.ch', 'clientpass1', 'Client', NOW(), NULL),
('Dahler', 'Martin', '0793432342', 'martin.daehler@gmail.com', 'clientpass2', 'Client', NOW(), NULL),
('Kernen', 'Anton', '0796427808', 'kernen.bio@hotmail.com', 'clientpass3', 'Client', NOW(), NULL),
('Rieben-Wirz', 'Arthur', '0796561007', 'arthur.rieben@bluewin.ch', 'clientpass4', 'Client', NOW(), NULL),
('Ryser', 'Sonja', '0792237133', 'sonja.ryser@gmx.ch', 'clientpass5', 'Client', NOW(), NULL);

-- Insert data into the `Addresses` table
INSERT INTO `express_food`.`Addresses` (`Street`, `Postal_Code`, `City`, `users_ID`, `create_time`, `update_time`)
VALUES
('Birkenweg 17', '3661', 'Uetendorf', 1, NOW(), NULL),
('Dengel 336', '3662', 'Seftigen', 2, NOW(), NULL),
('Egg 406', '3754', 'Diemtigen', 3, NOW(), NULL),
('Grubbenstrasse 19', '3780', 'Gstaad', 4, NOW(), NULL),
('Stelle 224', '3557', 'Fankhaus', 5, NOW(), NULL),
('Alpenstrasse 42', '3700', 'Spiez', 6, NOW(), NULL),
('Sonnenweg 3', '3612', 'Steffisburg', 7, NOW(), NULL),
('Feldstrasse 8', '3613', 'Steffisburg', 8, NOW(), NULL),
('Bergweg 15', '3604', 'Thun', 9, NOW(), NULL);

-- Insert data into the `Roles` table
INSERT INTO `express_food`.`Roles` (`role`, `create_time`, `update_time`)
VALUES
('DeliveryPerson', NOW(), NULL),
('Client', NOW(), NULL),
('Chef', NOW(), NULL),
('Admin', NOW(), NULL);

-- Insert data into the `categories` table
INSERT INTO `express_food`.`categories` (`name`, `create_time`, `update_time`)
VALUES
('Main', NOW(), NULL),
('Dessert', NOW(), NULL);







-- Insert data into the `MenuItems` table
INSERT INTO `express_food`.`MenuItems` (`Name`, `Price`, `create_time`, `update_time`)
VALUES
('Chicken curry and mashed peas', 750, NOW(), NULL),
('Fish and chips', 699, NOW(), NULL),
('Pineapple cake', 460, NOW(), NULL),
('Cherry cake', 299, NOW(), NULL),
('Sauerkraut and bratwurst', 470, NOW(), NULL),
('Shepherds pie', 560, NOW(), NULL),
('Peach clafoutis', 325, NOW(), NULL),
('Strawberry tart', 300, NOW(), NULL),
('Caesar salad', 400, NOW(), NULL),
('Meat pie and sausages', 515, NOW(), NULL),
('Chocolate mud cake', 325, NOW(), NULL),
('Apple crumble', 345, NOW(), NULL),
('Chicken curry and mashed potatoes', 600, NOW(), NULL),
('Meatloaf', 700, NOW(), NULL),
('Cheesecake', 440, NOW(), NULL),
('Exotic fruit salad', 288, NOW(), NULL),
('Tacos', 500, NOW(), NULL),
('Chicken Fritadelle', 615, NOW(), NULL),
('Apple pie and custard', 250, NOW(), NULL),
('Strawberry cheesecake', 350, NOW(), NULL);



-- Insert data into the `MenuItem_categories` table
INSERT INTO `express_food`.`MenuItem_categories` (`category_ID`, `MenuItem_ID`, `create_time`, `update_time`)
VALUES
(1, 1, NOW(), NULL),   -- Chicken curry and mashed peas in Main category
(1, 2, NOW(), NULL),   -- Fish and chips in Main category
(2, 3, NOW(), NULL),   -- Pineapple cake in Dessert category
(2, 4, NOW(), NULL),   -- Cherry cake in Dessert category
(1, 5, NOW(), NULL),   -- Sauerkraut and bratwurst in Main category
(1, 6, NOW(), NULL),  -- Shepherds pie in Main category
(2, 7, NOW(), NULL),  -- Peach clafoutis in Dessert category
(2, 8, NOW(), NULL),  -- Strawberry tart in Dessert category
(1, 9, NOW(), NULL),  -- Caesar salad in Main category
(1, 10, NOW(), NULL),  -- Meat pie and sausages in Main category
(2, 11, NOW(), NULL),  -- Chocolate mud cake in Dessert category
(2, 12, NOW(), NULL),  -- Apple crumble in Dessert category
(1, 13, NOW(), NULL),  -- Chicken curry and mashed potatoes in Main category
(1, 14, NOW(), NULL),  -- Meatloaf in Main category
(2, 15, NOW(), NULL),  -- Cheesecake in Dessert category
(2, 16, NOW(), NULL),  -- Exotic fruit salad in Dessert category
(1, 17, NOW(), NULL),  -- Tacos in Main category
(1, 18, NOW(), NULL),  -- Chicken Fritadelle in Main category
(2, 19, NOW(), NULL),  -- Apple pie and custard in Dessert category
(2, 20, NOW(), NULL);  -- Strawberry cheesecake in Dessert category

-- Insert data into the OrderHistory table with create_time and update_time
INSERT INTO `express_food`.`OrderHistory` (`Order_Date`, `create_time`, `update_time`, `users_ID`)
VALUES
('2023-08-20 13:14:07', NOW(), NULL, 5),
('2023-08-20 11:04:17', NOW(), NULL, 6),
('2023-08-21 17:14:27', NOW(), NULL, 7),
('2023-08-21 20:20:57', NOW(), NULL, 8),
('2023-08-21 18:06:06', NOW(), NULL, 9);


-- Insert data into the `delivery_manager` table
INSERT INTO `express_food`.`delivery_manager` (`start_time`, `end_time`, `users_ID`, `Address_ID`, `OrderHistory_ID`)
VALUES
('2023-08-20 13:00:00', '2023-08-20 22:00:00', 1, 1, 1),
('2023-08-20 12:00:00', '2023-08-20 21:00:00', 2, 2, 2),
('2023-08-20 11:00:00', '2023-08-20 20:00:00', 3, 3, 3),
('2023-08-20 10:00:00', '2023-08-20 19:00:00', 4, 4, 4);




SELECT *
FROM users
WHERE role = 'Client';


SELECT *
FROM users
WHERE role = 'DeliveryPerson';

SELECT * 
FROM MenuItems;

select * 
from OrderHistory;

