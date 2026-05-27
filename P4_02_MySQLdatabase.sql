
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `express_food` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `express_food`;

-- Drop child tables first because of foreign keys
DROP TABLE IF EXISTS `delivery_manager`;
DROP TABLE IF EXISTS `users_roles`;
DROP TABLE IF EXISTS `menuitem_order`;
DROP TABLE IF EXISTS `menuitem_categories`;
DROP TABLE IF EXISTS `menu_schedule`;
DROP TABLE IF EXISTS `addresses`;
DROP TABLE IF EXISTS `orderhistory`;
DROP TABLE IF EXISTS `menuitems`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `users`;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE TABLE `users` (
  `users_ID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `role` VARCHAR(15) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`users_ID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `addresses`
-- -----------------------------------------------------
CREATE TABLE `addresses` (
  `Address_ID` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(100) NOT NULL,
  `Postal_Code` VARCHAR(10) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `users_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`Address_ID`, `users_ID`),
  INDEX `fk_addresses_users_idx` (`users_ID` ASC),
  CONSTRAINT `fk_addresses_users`
    FOREIGN KEY (`users_ID`)
    REFERENCES `users` (`users_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `categories`
-- -----------------------------------------------------
CREATE TABLE `categories` (
  `category_ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`category_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `orderhistory`
-- -----------------------------------------------------
CREATE TABLE `orderhistory` (
  `OrderHistory_ID` INT NOT NULL AUTO_INCREMENT,
  `Order_Date` DATETIME NULL DEFAULT NULL,
  `DeliveryTime` DATETIME NULL DEFAULT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  `users_ID` INT NOT NULL,
  PRIMARY KEY (`OrderHistory_ID`, `users_ID`),
  INDEX `fk_orderhistory_users_idx` (`users_ID` ASC),
  CONSTRAINT `fk_orderhistory_users`
    FOREIGN KEY (`users_ID`)
    REFERENCES `users` (`users_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `menuitems`
-- -----------------------------------------------------
CREATE TABLE `menuitems` (
  `MenuItem_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Price` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItem_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `menu_schedule`
-- -----------------------------------------------------
CREATE TABLE `menu_schedule` (
  `Menu_schedule_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `MenuItem_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`Menu_schedule_id`, `MenuItem_ID`),
  INDEX `fk_menu_schedule_menuitems_idx` (`MenuItem_ID` ASC),
  CONSTRAINT `fk_menu_schedule_menuitems`
    FOREIGN KEY (`MenuItem_ID`)
    REFERENCES `menuitems` (`MenuItem_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `menuitem_categories`
-- -----------------------------------------------------
CREATE TABLE `menuitem_categories` (
  `MenuItem_categories_ID` INT NOT NULL AUTO_INCREMENT,
  `category_ID` INT NOT NULL,
  `MenuItem_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItem_categories_ID`, `category_ID`, `MenuItem_ID`),
  INDEX `fk_menuitem_categories_menuitems_idx` (`MenuItem_ID` ASC),
  INDEX `fk_menuitem_categories_categories_idx` (`category_ID` ASC),
  CONSTRAINT `fk_menuitem_categories_categories`
    FOREIGN KEY (`category_ID`)
    REFERENCES `categories` (`category_ID`),
  CONSTRAINT `fk_menuitem_categories_menuitems`
    FOREIGN KEY (`MenuItem_ID`)
    REFERENCES `menuitems` (`MenuItem_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `menuitem_order`
-- -----------------------------------------------------
CREATE TABLE `menuitem_order` (
  `MenuItem_Order_ID` INT NOT NULL AUTO_INCREMENT,
  `Quantity` INT NOT NULL,
  `MenuItem_ID` INT NOT NULL,
  `OrderHistory_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItem_Order_ID`, `MenuItem_ID`, `OrderHistory_ID`),
  INDEX `fk_menuitem_order_menuitems_idx` (`MenuItem_ID` ASC),
  INDEX `fk_menuitem_order_orderhistory_idx` (`OrderHistory_ID` ASC),
  CONSTRAINT `fk_menuitem_order_menuitems`
    FOREIGN KEY (`MenuItem_ID`)
    REFERENCES `menuitems` (`MenuItem_ID`),
  CONSTRAINT `fk_menuitem_order_orderhistory`
    FOREIGN KEY (`OrderHistory_ID`)
    REFERENCES `orderhistory` (`OrderHistory_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
CREATE TABLE `roles` (
  `roles_ID` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`roles_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `users_roles`
-- -----------------------------------------------------
CREATE TABLE `users_roles` (
  `users_roles_ID` INT NOT NULL AUTO_INCREMENT,
  `users_ID` INT NOT NULL,
  `roles_ID` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`users_roles_ID`, `users_ID`, `roles_ID`),
  INDEX `fk_users_roles_roles_idx` (`roles_ID` ASC),
  INDEX `fk_users_roles_users_idx` (`users_ID` ASC),
  CONSTRAINT `fk_users_roles_roles`
    FOREIGN KEY (`roles_ID`)
    REFERENCES `roles` (`roles_ID`),
  CONSTRAINT `fk_users_roles_users`
    FOREIGN KEY (`users_ID`)
    REFERENCES `users` (`users_ID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `delivery_manager`
-- -----------------------------------------------------
CREATE TABLE `delivery_manager` (
  `delivery_manager_id` INT NOT NULL AUTO_INCREMENT,
  `start_time` DATETIME NULL DEFAULT NULL,
  `end_time` DATETIME NULL DEFAULT NULL,
  `users_ID` INT NOT NULL,
  `Address_ID` INT NOT NULL,
  `OrderHistory_ID` INT NOT NULL,
  PRIMARY KEY (`delivery_manager_id`, `users_ID`, `Address_ID`, `OrderHistory_ID`),
  INDEX `fk_delivery_manager_users_idx` (`users_ID` ASC),
  INDEX `fk_delivery_manager_addresses_idx` (`Address_ID` ASC),
  INDEX `fk_delivery_manager_orderhistory_idx` (`OrderHistory_ID` ASC),
  CONSTRAINT `fk_delivery_manager_addresses`
    FOREIGN KEY (`Address_ID`)
    REFERENCES `addresses` (`Address_ID`),
  CONSTRAINT `fk_delivery_manager_users`
    FOREIGN KEY (`users_ID`)
    REFERENCES `users` (`users_ID`),
  CONSTRAINT `fk_delivery_manager_orderhistory`
    FOREIGN KEY (`OrderHistory_ID`)
    REFERENCES `orderhistory` (`OrderHistory_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Data inserts
-- -----------------------------------------------------

INSERT INTO `users`
(`firstName`, `lastName`, `phone_number`, `email`, `password`, `role`, `create_time`, `update_time`)
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

INSERT INTO `roles` (`role`, `create_time`, `update_time`)
VALUES
('DeliveryPerson', NOW(), NULL),
('Client', NOW(), NULL),
('Chef', NOW(), NULL),
('Admin', NOW(), NULL);

INSERT INTO `users_roles` (`users_ID`, `roles_ID`, `create_time`, `update_time`)
VALUES
(1, 1, NOW(), NULL),
(2, 1, NOW(), NULL),
(3, 1, NOW(), NULL),
(4, 1, NOW(), NULL),
(5, 2, NOW(), NULL),
(6, 2, NOW(), NULL),
(7, 2, NOW(), NULL),
(8, 2, NOW(), NULL),
(9, 2, NOW(), NULL);

INSERT INTO `addresses` (`Street`, `Postal_Code`, `City`, `users_ID`, `create_time`, `update_time`)
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

INSERT INTO `categories` (`name`, `create_time`, `update_time`)
VALUES
('Main', NOW(), NULL),
('Dessert', NOW(), NULL);

INSERT INTO `menuitems` (`Name`, `Price`, `create_time`, `update_time`)
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

INSERT INTO `menuitem_categories` (`category_ID`, `MenuItem_ID`, `create_time`, `update_time`)
VALUES
(1, 1, NOW(), NULL),
(1, 2, NOW(), NULL),
(2, 3, NOW(), NULL),
(2, 4, NOW(), NULL),
(1, 5, NOW(), NULL),
(1, 6, NOW(), NULL),
(2, 7, NOW(), NULL),
(2, 8, NOW(), NULL),
(1, 9, NOW(), NULL),
(1, 10, NOW(), NULL),
(2, 11, NOW(), NULL),
(2, 12, NOW(), NULL),
(1, 13, NOW(), NULL),
(1, 14, NOW(), NULL),
(2, 15, NOW(), NULL),
(2, 16, NOW(), NULL),
(1, 17, NOW(), NULL),
(1, 18, NOW(), NULL),
(2, 19, NOW(), NULL),
(2, 20, NOW(), NULL);

-- Example daily menus: 2 main dishes and 2 desserts per date
INSERT INTO `menu_schedule` (`date`, `MenuItem_ID`, `create_time`, `update_time`)
VALUES
('2023-08-20', 1, NOW(), NULL),
('2023-08-20', 2, NOW(), NULL),
('2023-08-20', 3, NOW(), NULL),
('2023-08-20', 4, NOW(), NULL),
('2023-08-21', 5, NOW(), NULL),
('2023-08-21', 6, NOW(), NULL),
('2023-08-21', 7, NOW(), NULL),
('2023-08-21', 8, NOW(), NULL),
('2023-08-22', 9, NOW(), NULL),
('2023-08-22', 10, NOW(), NULL),
('2023-08-22', 11, NOW(), NULL),
('2023-08-22', 12, NOW(), NULL);

INSERT INTO `orderhistory`
(`Order_Date`, `DeliveryTime`, `create_time`, `update_time`, `users_ID`)
VALUES
('2023-08-20 13:14:07', '2023-08-20 13:28:17', NOW(), NULL, 5),
('2023-08-20 11:04:17', '2023-08-20 11:24:47', NOW(), NULL, 6),
('2023-08-21 17:14:27', '2023-08-21 17:30:27', NOW(), NULL, 7),
('2023-08-21 20:20:57', '2023-08-21 20:39:57', NOW(), NULL, 8),
('2023-08-21 18:06:06', '2023-08-21 18:16:56', NOW(), NULL, 9),
('2023-08-22 11:37:45', '2023-08-22 11:49:55', NOW(), NULL, 5),
('2023-08-22 22:34:00', '2023-08-22 22:48:08', NOW(), NULL, 6),
('2023-08-23 20:08:20', '2023-08-23 20:25:28', NOW(), NULL, 7),
('2023-08-23 15:03:02', '2023-08-23 15:20:00', NOW(), NULL, 8),
('2023-08-23 12:12:12', '2023-08-23 12:29:02', NOW(), NULL, 9),
('2023-08-24 16:44:47', '2023-08-24 16:54:57', NOW(), NULL, 5),
('2023-08-24 13:24:27', '2023-08-24 13:39:37', NOW(), NULL, 6),
('2023-08-25 14:22:09', '2023-08-25 14:40:09', NOW(), NULL, 7);

INSERT INTO `menuitem_order` (`Quantity`, `MenuItem_ID`, `OrderHistory_ID`, `create_time`, `update_time`)
VALUES
(1, 1, 1, NOW(), NULL),
(2, 3, 1, NOW(), NULL),
(1, 2, 2, NOW(), NULL),
(1, 4, 2, NOW(), NULL),
(2, 5, 3, NOW(), NULL),
(1, 7, 3, NOW(), NULL),
(1, 6, 4, NOW(), NULL),
(2, 8, 4, NOW(), NULL),
(1, 9, 5, NOW(), NULL),
(1, 11, 5, NOW(), NULL),
(2, 10, 6, NOW(), NULL),
(1, 12, 6, NOW(), NULL),
(1, 13, 7, NOW(), NULL),
(1, 15, 7, NOW(), NULL);

INSERT INTO `delivery_manager`
(`start_time`, `end_time`, `users_ID`, `Address_ID`, `OrderHistory_ID`)
VALUES
('2023-08-20 13:15:00', '2023-08-20 13:28:17', 1, 5, 1),
('2023-08-20 11:05:00', '2023-08-20 11:24:47', 2, 6, 2),
('2023-08-21 17:15:00', '2023-08-21 17:30:27', 3, 7, 3),
('2023-08-21 20:21:00', '2023-08-21 20:39:57', 4, 8, 4),
('2023-08-21 18:07:00', '2023-08-21 18:16:56', 1, 9, 5),
('2023-08-22 11:38:00', '2023-08-22 11:49:55', 2, 5, 6),
('2023-08-22 22:35:00', '2023-08-22 22:48:08', 3, 6, 7),
('2023-08-23 20:09:00', '2023-08-23 20:25:28', 4, 7, 8),
('2023-08-23 15:04:00', '2023-08-23 15:20:00', 1, 8, 9),
('2023-08-23 12:13:00', '2023-08-23 12:29:02', 2, 9, 10),
('2023-08-24 16:45:00', '2023-08-24 16:54:57', 3, 5, 11),
('2023-08-24 13:25:00', '2023-08-24 13:39:37', 4, 6, 12),
('2023-08-25 14:23:00', '2023-08-25 14:40:09', 1, 7, 13);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SHOW TABLES;
SELECT * FROM `users`;
SELECT * FROM `menuitems`;
SELECT * FROM `orderhistory`;
SELECT * FROM `delivery_manager`;