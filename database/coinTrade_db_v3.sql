-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cointrade_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cointrade_db` ;

-- -----------------------------------------------------
-- Schema cointrade_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cointrade_db` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `cointrade_db` ;

-- -----------------------------------------------------
-- Table `cointrade_db`.`user_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`user_status` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`user_status` (
  `usts_idStatus` INT NOT NULL AUTO_INCREMENT,
  `usts_name` VARCHAR(100) NOT NULL,
  `usts_description` VARCHAR(100) NULL,
  PRIMARY KEY (`usts_idStatus`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`user_rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`user_rol` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`user_rol` (
  `urol_idRol` INT NOT NULL AUTO_INCREMENT,
  `urol_name` VARCHAR(100) NOT NULL,
  `urol_description` VARCHAR(100) NULL,
  PRIMARY KEY (`urol_idRol`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`users` (
  `usu_idUser` INT NOT NULL AUTO_INCREMENT,
  `usu_name` VARCHAR(150) NOT NULL,
  `usu_middle_name` VARCHAR(250) NULL,
  `usu_lastname` VARCHAR(200) NULL,
  `usu_lastname2` VARCHAR(250) NULL,
  `usu_identity` VARCHAR(100) NULL,
  `usu_email` VARCHAR(100) NOT NULL,
  `usu_email2` VARCHAR(250) NULL,
  `usu_phone` VARCHAR(15) NULL,
  `usu_phone_local` VARCHAR(15) NULL,
  `usu_birth_date` DATE NULL,
  `usu_username` VARCHAR(100) NULL,
  `usu_pswd` LONGTEXT NULL,
  `usu_verification_code` VARCHAR(10) NULL,
  `usu_verification_code_pass` VARCHAR(10) NULL,
  `usu_mail_account` VARCHAR(250) NULL,
  `usu_isTerms` INT NULL DEFAULT 0,
  `usu_isAuthorized` INT NULL DEFAULT 0,
  `usu_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `usu_updated_date` DATETIME NULL,
  `usts_idStatus` INT NOT NULL DEFAULT 1,
  `urol_idRol` INT NOT NULL,
  `usu_isVerification` INT NULL DEFAULT 0,
  `usu_isVerificated` INT NULL DEFAULT 0,
  PRIMARY KEY (`usu_idUser`, `usts_idStatus`, `urol_idRol`),
  INDEX `fk_users_user_status_idx` (`usts_idStatus` ASC) VISIBLE,
  INDEX `fk_users_user_rol1_idx` (`urol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_users_user_status`
    FOREIGN KEY (`usts_idStatus`)
    REFERENCES `cointrade_db`.`user_status` (`usts_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_user_rol`
    FOREIGN KEY (`urol_idRol`)
    REFERENCES `cointrade_db`.`user_rol` (`urol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`product_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`product_status` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`product_status` (
  `psts_idStatus` INT NOT NULL AUTO_INCREMENT,
  `psts_name` VARCHAR(50) NULL,
  `psts_description` VARCHAR(100) NULL,
  PRIMARY KEY (`psts_idStatus`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`products` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`products` (
  `prod_idProducto` INT NOT NULL AUTO_INCREMENT,
  `prod_sku` VARCHAR(100) NOT NULL,
  `prod_name` VARCHAR(250) NULL,
  `prod_description` LONGTEXT NULL,
  `prod_country` VARCHAR(45) NULL,
  `prod_metal` VARCHAR(45) NULL,
  `prod_diameter` VARCHAR(45) NULL,
  `prod_condition` VARCHAR(45) NULL,
  `prod_date` VARCHAR(50) NULL,
  `prod_weight` VARCHAR(45) NULL,
  `prod_minting` VARCHAR(45) NULL,
  `prod_fineness` VARCHAR(45) NULL,
  `prod_serie` VARCHAR(45) NULL,
  `prod_denomination` VARCHAR(45) NULL,
  `prod_number` VARCHAR(45) NULL,
  `prod_rating` DOUBLE NULL DEFAULT 0,
  `prod_unit_cost` DOUBLE NULL,
  `prod_commission` DOUBLE NULL,
  `prod_total` DOUBLE NULL,
  `prod_stock` INT NULL,
  `prod_image_front` LONGTEXT NULL,
  `prod_image_back` LONGTEXT NULL,
  `usu_idUser` INT NOT NULL,
  `prod_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `prod_updated_date` DATETIME NULL,
  `prod_isActive` INT NULL DEFAULT 1,
  `prod_idType_product` INT NOT NULL,
  `prod_idGroup_product` INT NULL,
  `prod_idCategory_product` INT NULL,
  `prod_isAuthorized` INT NOT NULL DEFAULT 0,
  `prod_isTerms` INT NOT NULL DEFAULT 1,
  `psts_idStatus` INT NOT NULL,
  PRIMARY KEY (`prod_idProducto`, `usu_idUser`, `psts_idStatus`),
  INDEX `fk_products_users1_idx` (`usu_idUser` ASC) VISIBLE,
  INDEX `fk_products_product_status1_idx` (`psts_idStatus` ASC) VISIBLE,
  CONSTRAINT `fk_products_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_product_status1`
    FOREIGN KEY (`psts_idStatus`)
    REFERENCES `cointrade_db`.`product_status` (`psts_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`notifications` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`notifications` (
  `not_idNotification` INT NOT NULL AUTO_INCREMENT,
  `not_content` LONGTEXT NOT NULL,
  `not_isReaded` INT NOT NULL DEFAULT 0,
  `not_readed_date` DATETIME NULL,
  `not_isImportant` INT NOT NULL DEFAULT 0,
  `not_isDeleted` INT NOT NULL DEFAULT 0,
  `not_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `not_updated_date` DATETIME NULL,
  `usu_idUser` INT NOT NULL,
  `not_idUserDestination` INT NULL,
  PRIMARY KEY (`not_idNotification`, `usu_idUser`),
  INDEX `fk_notifications_users1_idx` (`usu_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_notifications_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`tickets` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`tickets` (
  `tck_idTicket` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tck_idTicket`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`valuation_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`valuation_status` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`valuation_status` (
  `vsta_idStatus` INT NOT NULL AUTO_INCREMENT,
  `vsta_name` VARCHAR(45) NOT NULL,
  `vsta_description` VARCHAR(45) NULL,
  PRIMARY KEY (`vsta_idStatus`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`valuations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`valuations` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`valuations` (
  `val_idValuations` INT NOT NULL,
  `val_valuation` VARCHAR(45) NOT NULL,
  `val_total` VARCHAR(45) NOT NULL,
  `val_date_valuation` VARCHAR(45) NOT NULL,
  `val_isPaid` INT NOT NULL DEFAULT 0,
  `val_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `val_updated_date` DATETIME NULL,
  `vtpe_idType` INT NOT NULL,
  `prod_idProducto` INT NOT NULL,
  `val_isActive` INT NULL DEFAULT 1,
  `val_idUserRequester` VARCHAR(45) NULL,
  PRIMARY KEY (`val_idValuations`, `vtpe_idType`, `prod_idProducto`),
  INDEX `fk_valuations_valuation_type1_idx` (`vtpe_idType` ASC) VISIBLE,
  INDEX `fk_valuations_products1_idx` (`prod_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_valuations_valuation_type1`
    FOREIGN KEY (`vtpe_idType`)
    REFERENCES `cointrade_db`.`valuation_status` (`vsta_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valuations_products1`
    FOREIGN KEY (`prod_idProducto`)
    REFERENCES `cointrade_db`.`products` (`prod_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`transactions` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`transactions` (
  `tran_idTransaction` INT NOT NULL,
  `tran_order` LONGTEXT NULL,
  `tran_description` DATETIME NULL,
  `tran_subtotal` DOUBLE NULL,
  `tran_iva` DOUBLE NULL,
  `tran_total` DOUBLE NULL,
  `tran_discount` DOUBLE NULL,
  `tran_date_order` DATETIME NULL,
  `tran_json` LONGTEXT NULL,
  `tran_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `tran_updated_time` DATETIME NULL,
  `tran_payment_type` VARCHAR(45) NULL,
  `tran_idUserSeller` INT NOT NULL,
  `tran_idUserBuyer` INT NOT NULL,
  PRIMARY KEY (`tran_idTransaction`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`shipment_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`shipment_status` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`shipment_status` (
  `ssts_idStatus` INT NOT NULL AUTO_INCREMENT,
  `ssts_name` VARCHAR(45) NOT NULL,
  `ssts_description` VARCHAR(45) NULL,
  PRIMARY KEY (`ssts_idStatus`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`shipments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`shipments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`shipments` (
  `ship_idShipment` INT NOT NULL AUTO_INCREMENT,
  `ship_tracking_number` VARCHAR(45) NOT NULL,
  `ship_created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ship_estimated_date` DATETIME NULL,
  `ship_recibedBy` VARCHAR(45) NULL,
  `ship_delivery_date` DATETIME NULL,
  `ssts_idStatus` INT NOT NULL,
  `ship_weight` VARCHAR(45) NULL,
  `tran_idTransaction` INT NOT NULL,
  PRIMARY KEY (`ship_idShipment`, `ssts_idStatus`, `tran_idTransaction`),
  INDEX `fk_shipments_shipment_status1_idx` (`ssts_idStatus` ASC) VISIBLE,
  INDEX `fk_shipments_transactions1_idx` (`tran_idTransaction` ASC) VISIBLE,
  CONSTRAINT `fk_shipments_shipment_status1`
    FOREIGN KEY (`ssts_idStatus`)
    REFERENCES `cointrade_db`.`shipment_status` (`ssts_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipments_transactions1`
    FOREIGN KEY (`tran_idTransaction`)
    REFERENCES `cointrade_db`.`transactions` (`tran_idTransaction`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`users_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`users_logs` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`users_logs` (
  `ulog_idLog` INT NOT NULL AUTO_INCREMENT,
  `ulog_date_access` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ulog_device` VARCHAR(100) NULL,
  `ulog_os` VARCHAR(100) NULL,
  `ulog_browser` VARCHAR(100) NULL,
  `ulog_isDesktop` VARCHAR(45) NULL,
  `ulog_isPhone` VARCHAR(45) NULL,
  `ulog_isRobot` VARCHAR(45) NULL,
  `ulog_ip` VARCHAR(100) NULL,
  `ulog_ip_city` VARCHAR(100) NULL,
  `ulog_ip_region` VARCHAR(500) NULL,
  `ulog_ip_region_code` VARCHAR(100) NULL,
  `ulog_ip_country_name` VARCHAR(100) NULL,
  `ulog_ip_country_code` VARCHAR(100) NULL,
  `ulog_ip_latitude` VARCHAR(50) NULL,
  `ulod_ip_longitude` VARCHAR(50) NULL,
  `ulog_created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ulog_updated_date` DATETIME NULL,
  `ulog_fingerprint` LONGTEXT NULL,
  `usu_idUser` INT NOT NULL,
  PRIMARY KEY (`ulog_idLog`, `usu_idUser`),
  INDEX `fk_users_logs_users1_idx` (`usu_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_users_logs_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`users_favorites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`users_favorites` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`users_favorites` (
  `ufav_idFavorite` INT NOT NULL AUTO_INCREMENT,
  `usu_idUser` INT NOT NULL,
  `prod_idProducto` INT NOT NULL,
  `ufav_isActive` INT NULL DEFAULT 0,
  `ufav_created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ufav_updated_date` DATETIME NULL,
  PRIMARY KEY (`ufav_idFavorite`, `usu_idUser`, `prod_idProducto`),
  INDEX `fk_favorites_users1_idx` (`usu_idUser` ASC) VISIBLE,
  INDEX `fk_favorites_products1_idx` (`prod_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_favorites_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorites_products1`
    FOREIGN KEY (`prod_idProducto`)
    REFERENCES `cointrade_db`.`products` (`prod_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`returns`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`returns` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`returns` (
  `ret_idReturn` INT NOT NULL,
  `ret_created_date` DATETIME NULL,
  `ret_return_date` DATETIME NULL,
  `ret_reason` LONGTEXT NULL,
  `ret_isUnpacked` INT NULL,
  `ret_comments` LONGTEXT NULL,
  `ret_isTerms` VARCHAR(45) NULL,
  `tran_idTransaction` INT NOT NULL,
  PRIMARY KEY (`ret_idReturn`, `tran_idTransaction`),
  INDEX `fk_returns_transactions1_idx` (`tran_idTransaction` ASC) VISIBLE,
  CONSTRAINT `fk_returns_transactions1`
    FOREIGN KEY (`tran_idTransaction`)
    REFERENCES `cointrade_db`.`transactions` (`tran_idTransaction`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`product_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`product_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`product_type` (
  `ptpe_idType` INT NOT NULL AUTO_INCREMENT,
  `ptpe_name` VARCHAR(45) NULL,
  `ptpe_description` VARCHAR(45) NULL,
  `ptpe_isActive` INT NULL,
  PRIMARY KEY (`ptpe_idType`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`product_certifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`product_certifications` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`product_certifications` (
  `pcert_idCertification` INT NOT NULL AUTO_INCREMENT,
  `pcert_name` LONGTEXT NULL,
  `pcert_description` LONGTEXT NULL,
  `pcert_image` LONGTEXT NULL,
  `prod_idProducto` INT NOT NULL,
  `pcert_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `pcert_updated_date` DATETIME NULL,
  PRIMARY KEY (`pcert_idCertification`, `prod_idProducto`),
  INDEX `fk_certifications_products1_idx` (`prod_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_certifications_products1`
    FOREIGN KEY (`prod_idProducto`)
    REFERENCES `cointrade_db`.`products` (`prod_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`users_shipping_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`users_shipping_address` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`users_shipping_address` (
  `usad_idAddress` INT NOT NULL AUTO_INCREMENT,
  `usad_country` VARCHAR(100) NOT NULL,
  `usad_state` VARCHAR(100) NOT NULL,
  `usad_city` VARCHAR(100) NOT NULL,
  `usad_address` VARCHAR(100) NOT NULL,
  `usad_cp` VARCHAR(10) NULL,
  `usad_isDefault` INT NULL,
  `usad_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `usad_updated_date` DATETIME NULL,
  `usu_idUser` INT NOT NULL,
  PRIMARY KEY (`usad_idAddress`, `usu_idUser`),
  INDEX `fk_users_shipment_address_users1_idx` (`usu_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_users_shipment_address_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`countries` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`countries` (
  `coun_iso_alpha2` VARCHAR(10) NOT NULL,
  `coun_name` VARCHAR(250) NOT NULL,
  `coun_iso_alpha3` VARCHAR(10) NOT NULL,
  `coun_iso_numerico` VARCHAR(10) NOT NULL,
  `coun_isActive` INT NOT NULL,
  PRIMARY KEY (`coun_iso_alpha2`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`states` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`states` (
  `sta_iso_alpha2` VARCHAR(10) NOT NULL,
  `sta_name` VARCHAR(250) NOT NULL,
  `sta_clave` VARCHAR(10) NOT NULL,
  `sta_iso_alpha3` VARCHAR(10) NOT NULL,
  `sta_renapo` VARCHAR(10) NOT NULL,
  `sta_abbreviation` VARCHAR(10) NOT NULL,
  `coun_iso_alpha2` VARCHAR(10) NOT NULL,
  `sta_isActive` INT NOT NULL,
  PRIMARY KEY (`sta_iso_alpha2`, `coun_iso_alpha2`),
  INDEX `fk_states_countries1_idx` (`coun_iso_alpha2` ASC) VISIBLE,
  CONSTRAINT `fk_states_countries1`
    FOREIGN KEY (`coun_iso_alpha2`)
    REFERENCES `cointrade_db`.`countries` (`coun_iso_alpha2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`users_fiscal_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`users_fiscal_data` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`users_fiscal_data` (
  `ufdt_idData` INT NOT NULL AUTO_INCREMENT,
  `ufdt_denomination` VARCHAR(150) NULL,
  `ufdt_rfc` VARCHAR(45) NULL,
  `ufdt_country` VARCHAR(45) NULL,
  `ufdt_state` VARCHAR(45) NULL,
  `ufdt_city` VARCHAR(45) NULL,
  `ufdt_address` VARCHAR(45) NULL,
  `ufdt_cp` VARCHAR(10) NULL,
  `ufdt_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `ufdt_updated_date` DATETIME NULL,
  `usu_idUser` INT NOT NULL,
  PRIMARY KEY (`ufdt_idData`, `usu_idUser`),
  INDEX `fk_users_fiscal_data_users1_idx` (`usu_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_users_fiscal_data_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`cities` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`cities` (
  `cit_clave` VARCHAR(45) NOT NULL,
  `cit_nombre` VARCHAR(500) NOT NULL,
  `sta_iso_alpha2` VARCHAR(10) NOT NULL,
  `cit_isActive` INT NULL,
  PRIMARY KEY (`cit_clave`, `sta_iso_alpha2`),
  INDEX `fk_cities_states1_idx` (`sta_iso_alpha2` ASC) VISIBLE,
  CONSTRAINT `fk_cities_states1`
    FOREIGN KEY (`sta_iso_alpha2`)
    REFERENCES `cointrade_db`.`states` (`sta_iso_alpha2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`product_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`product_group` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`product_group` (
  `pgrp_idGroup` INT NOT NULL AUTO_INCREMENT,
  `pgrp_name` VARCHAR(45) NULL,
  `pgrp_description` VARCHAR(45) NULL,
  `pgrp_isActive` INT NULL,
  `ptpe_idType` INT NOT NULL,
  PRIMARY KEY (`pgrp_idGroup`, `ptpe_idType`),
  INDEX `fk_product_group_product_type1_idx` (`ptpe_idType` ASC) VISIBLE,
  CONSTRAINT `fk_product_group_product_type1`
    FOREIGN KEY (`ptpe_idType`)
    REFERENCES `cointrade_db`.`product_type` (`ptpe_idType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`product_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`product_category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`product_category` (
  `pcat_idCategory` INT NOT NULL AUTO_INCREMENT,
  `pcat_name` VARCHAR(150) NULL,
  `pcat_description` VARCHAR(45) NULL,
  `pcat_isActive` INT NULL,
  `pgrp_idGroup` INT NOT NULL,
  PRIMARY KEY (`pcat_idCategory`, `pgrp_idGroup`),
  INDEX `fk_product_category_product_group1_idx` (`pgrp_idGroup` ASC) VISIBLE,
  CONSTRAINT `fk_product_category_product_group1`
    FOREIGN KEY (`pgrp_idGroup`)
    REFERENCES `cointrade_db`.`product_group` (`pgrp_idGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`estado` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`estado` (
  `d_codigo` LONGTEXT NOT NULL,
  `d_asenta` LONGTEXT NULL,
  `d_tipo_asenta` LONGTEXT NULL,
  `d_estado` LONGTEXT NULL,
  `d_ciudad` LONGTEXT NULL,
  `d_CP` LONGTEXT NULL,
  `c_estado` LONGTEXT NULL,
  `c_oficina` LONGTEXT NULL,
  `c_CP` LONGTEXT NULL,
  `c_tipo_asenta` LONGTEXT NULL,
  `c_mnpio` LONGTEXT NULL,
  `id_asenta_cpcons` LONGTEXT NULL,
  `d_zona` LONGTEXT NULL,
  `c_cve_ciudad` LONGTEXT NULL)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`payments_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`payments_status` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`payments_status` (
  `pyst_name_idStatus` INT NOT NULL AUTO_INCREMENT,
  `pyst_name` VARCHAR(100) NOT NULL,
  `pyst_description` VARCHAR(100) NULL,
  PRIMARY KEY (`pyst_name_idStatus`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`product_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`product_rating` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`product_rating` (
  `prat_idRating` INT NOT NULL AUTO_INCREMENT,
  `usu_idUser` INT NOT NULL,
  `prod_idProducto` INT NOT NULL,
  `prat_rating` DOUBLE NOT NULL,
  `prat_isActive` INT NULL DEFAULT 0,
  `prat_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `prat_updated_date` DATETIME NULL,
  PRIMARY KEY (`prat_idRating`, `usu_idUser`, `prod_idProducto`),
  INDEX `fk_product_rating_users1_idx` (`usu_idUser` ASC) VISIBLE,
  INDEX `fk_product_rating_products1_idx` (`prod_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_product_rating_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_rating_products1`
    FOREIGN KEY (`prod_idProducto`)
    REFERENCES `cointrade_db`.`products` (`prod_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`cart` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`cart` (
  `cart_idCart` INT NOT NULL AUTO_INCREMENT,
  `usu_idUser` INT NOT NULL,
  `cart_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_updated_date` DATETIME NULL,
  `cart_id_session` LONGTEXT NULL,
  PRIMARY KEY (`cart_idCart`, `usu_idUser`),
  INDEX `fk_cart_users1_idx` (`usu_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_cart_users1`
    FOREIGN KEY (`usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`cart_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`cart_items` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`cart_items` (
  `citm_idItem` INT NOT NULL AUTO_INCREMENT,
  `citm_quantity` INT NULL,
  `cart_idCart` INT NOT NULL,
  `prod_idProducto` INT NOT NULL,
  `citm_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `citm_updated_date` DATETIME NULL,
  `citm_isActive` INT NULL DEFAULT 1,
  PRIMARY KEY (`citm_idItem`, `cart_idCart`, `prod_idProducto`),
  INDEX `fk_cart_items_cart1_idx` (`cart_idCart` ASC) VISIBLE,
  INDEX `fk_cart_items_products1_idx` (`prod_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_cart_items_cart1`
    FOREIGN KEY (`cart_idCart`)
    REFERENCES `cointrade_db`.`cart` (`cart_idCart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_items_products1`
    FOREIGN KEY (`prod_idProducto`)
    REFERENCES `cointrade_db`.`products` (`prod_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`card_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`card_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`card_type` (
  `ctpe_idType` INT NOT NULL AUTO_INCREMENT,
  `ctpe_name` VARCHAR(100) NULL,
  `ctpe_description` VARCHAR(250) NULL,
  PRIMARY KEY (`ctpe_idType`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`user_finances`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`user_finances` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`user_finances` (
  `ufin_idFinance` INT NOT NULL AUTO_INCREMENT,
  `ufin_clabe` VARCHAR(100) NOT NULL,
  `ctpe_idType` INT NOT NULL,
  `users_usu_idUser` INT NOT NULL,
  PRIMARY KEY (`ufin_idFinance`, `ctpe_idType`, `users_usu_idUser`),
  INDEX `fk_user_finances_card_type1_idx` (`ctpe_idType` ASC) VISIBLE,
  INDEX `fk_user_finances_users1_idx` (`users_usu_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_user_finances_card_type1`
    FOREIGN KEY (`ctpe_idType`)
    REFERENCES `cointrade_db`.`card_type` (`ctpe_idType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_finances_users1`
    FOREIGN KEY (`users_usu_idUser`)
    REFERENCES `cointrade_db`.`users` (`usu_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cointrade_db`.`settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cointrade_db`.`settings` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cointrade_db`.`settings` (
  `set_idSetting` INT NOT NULL AUTO_INCREMENT,
  `set_name` VARCHAR(100) NOT NULL,
  `set_description` VARCHAR(250) NULL,
  `set_value` VARCHAR(100) NOT NULL,
  `set_created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `set_updated_date` DATETIME NULL,
  PRIMARY KEY (`set_idSetting`))
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `cointrade_db`.`user_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`user_status` (`usts_idStatus`, `usts_name`, `usts_description`) VALUES (DEFAULT, 'Activo', NULL);
INSERT INTO `cointrade_db`.`user_status` (`usts_idStatus`, `usts_name`, `usts_description`) VALUES (DEFAULT, 'Baja', NULL);
INSERT INTO `cointrade_db`.`user_status` (`usts_idStatus`, `usts_name`, `usts_description`) VALUES (DEFAULT, 'Suspendido', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`user_rol`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`user_rol` (`urol_idRol`, `urol_name`, `urol_description`) VALUES (DEFAULT, 'Administrador', NULL);
INSERT INTO `cointrade_db`.`user_rol` (`urol_idRol`, `urol_name`, `urol_description`) VALUES (DEFAULT, 'Vendedor', NULL);
INSERT INTO `cointrade_db`.`user_rol` (`urol_idRol`, `urol_name`, `urol_description`) VALUES (DEFAULT, 'Comprador', NULL);
INSERT INTO `cointrade_db`.`user_rol` (`urol_idRol`, `urol_name`, `urol_description`) VALUES (DEFAULT, 'Soporte', NULL);
INSERT INTO `cointrade_db`.`user_rol` (`urol_idRol`, `urol_name`, `urol_description`) VALUES (DEFAULT, 'Administrador de envíos', NULL);
INSERT INTO `cointrade_db`.`user_rol` (`urol_idRol`, `urol_name`, `urol_description`) VALUES (DEFAULT, 'Administrador de devoluciones', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`users` (`usu_idUser`, `usu_name`, `usu_middle_name`, `usu_lastname`, `usu_lastname2`, `usu_identity`, `usu_email`, `usu_email2`, `usu_phone`, `usu_phone_local`, `usu_birth_date`, `usu_username`, `usu_pswd`, `usu_verification_code`, `usu_verification_code_pass`, `usu_mail_account`, `usu_isTerms`, `usu_isAuthorized`, `usu_created_date`, `usu_updated_date`, `usts_idStatus`, `urol_idRol`, `usu_isVerification`, `usu_isVerificated`) VALUES (DEFAULT, 'Jacqueline', NULL, 'Lugo Lopez', NULL, 'LULJ9708324MHGGPC02', 'jacque_lugo801@hotmail.com', NULL, '7721607145', '7721607145', '1997-08-24', 'jlugo', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '343087', NULL, 'jacque_lugo801@hotmail.com', 1, 1, NULL, NULL, 1, 1, NULL, 1);
INSERT INTO `cointrade_db`.`users` (`usu_idUser`, `usu_name`, `usu_middle_name`, `usu_lastname`, `usu_lastname2`, `usu_identity`, `usu_email`, `usu_email2`, `usu_phone`, `usu_phone_local`, `usu_birth_date`, `usu_username`, `usu_pswd`, `usu_verification_code`, `usu_verification_code_pass`, `usu_mail_account`, `usu_isTerms`, `usu_isAuthorized`, `usu_created_date`, `usu_updated_date`, `usts_idStatus`, `urol_idRol`, `usu_isVerification`, `usu_isVerificated`) VALUES (DEFAULT, 'Jacqueline', NULL, 'Lugo Lopez', NULL, 'LULJ9708324MHGGPC02', 'jacque_lugo801_2@hotmail.com', NULL, '7721607145', '7721607145', '1997-08-24', 'jlugo2', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '343087', NULL, 'jacque_lugo801@hotmail.com', 1, 1, NULL, NULL, 1, 2, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`product_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`product_status` (`psts_idStatus`, `psts_name`, `psts_description`) VALUES (DEFAULT, 'Activo', NULL);
INSERT INTO `cointrade_db`.`product_status` (`psts_idStatus`, `psts_name`, `psts_description`) VALUES (DEFAULT, 'Pendiente', NULL);
INSERT INTO `cointrade_db`.`product_status` (`psts_idStatus`, `psts_name`, `psts_description`) VALUES (DEFAULT, 'Pausado', NULL);
INSERT INTO `cointrade_db`.`product_status` (`psts_idStatus`, `psts_name`, `psts_description`) VALUES (DEFAULT, 'Agotado', NULL);
INSERT INTO `cointrade_db`.`product_status` (`psts_idStatus`, `psts_name`, `psts_description`) VALUES (DEFAULT, 'Eliminado', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`products`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`products` (`prod_idProducto`, `prod_sku`, `prod_name`, `prod_description`, `prod_country`, `prod_metal`, `prod_diameter`, `prod_condition`, `prod_date`, `prod_weight`, `prod_minting`, `prod_fineness`, `prod_serie`, `prod_denomination`, `prod_number`, `prod_rating`, `prod_unit_cost`, `prod_commission`, `prod_total`, `prod_stock`, `prod_image_front`, `prod_image_back`, `usu_idUser`, `prod_created_date`, `prod_updated_date`, `prod_isActive`, `prod_idType_product`, `prod_idGroup_product`, `prod_idCategory_product`, `prod_isAuthorized`, `prod_isTerms`, `psts_idStatus`) VALUES (DEFAULT, 'MND1', 'Moneda Francisco I. Madero 20 centavos', '<p>La moneda de Chile de 8 Escudos de Fernando VI, acuñada en 1751, es una pieza de gran valor histórico y numismático. Esta moneda presenta en su anverso el retrato del rey Fernando VI, quien gobernó España y sus colonias durante ese período.</p><p>En el reverso, se puede apreciar el escudo real español con los símbolos de Castilla, León, Aragón y Granada, rodeado por el collar del Toisón de Oro. Esta moneda está acuñada en oro de alta pureza y tiene un diámetro considerable, lo que la convierte en una pieza impresionante y codiciada por los coleccionistas. Con su rica historia y su belleza artística, la moneda de Chile de 8 Escudos de Fernando VI - 1751 J es una verdadera joya numismática.</p>', 'MX', 'Plata', '37', NULL, NULL, '2903', '1751', '1999,9/1000 oro fino', NULL, 'Test', NULL, 0, 8550, 855, 9405, 3, '1710372462-Moneda-Anverso-De_Mexico-Mexico-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-Plata-1751.jpeg', '1710372462-Moneda-Reverso-De_Mexico-Mexico-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-Plata-1751.jpeg', 2, '2024-03-13 23:27:43', '2024-03-13 23:27:43', 1, 1, 3, 16, 1, 1, 1);
INSERT INTO `cointrade_db`.`products` (`prod_idProducto`, `prod_sku`, `prod_name`, `prod_description`, `prod_country`, `prod_metal`, `prod_diameter`, `prod_condition`, `prod_date`, `prod_weight`, `prod_minting`, `prod_fineness`, `prod_serie`, `prod_denomination`, `prod_number`, `prod_rating`, `prod_unit_cost`, `prod_commission`, `prod_total`, `prod_stock`, `prod_image_front`, `prod_image_back`, `usu_idUser`, `prod_created_date`, `prod_updated_date`, `prod_isActive`, `prod_idType_product`, `prod_idGroup_product`, `prod_idCategory_product`, `prod_isAuthorized`, `prod_isTerms`, `psts_idStatus`) VALUES (DEFAULT, 'BLE1', '1 Pound (Commonwealth Bank)', '<p>La moneda de Chile de 8 Escudos de Fernando VI, acuñada en 1751, es una pieza de gran valor histórico y numismático. Esta moneda presenta en su anverso el retrato del rey Fernando VI, quien gobernó España y sus colonias durante ese período.</p><p>En el reverso, se puede apreciar el escudo real español con los símbolos de Castilla, León, Aragón y Granada, rodeado por el collar del Toisón de Oro. Esta moneda está acuñada en oro de alta pureza y tiene un diámetro considerable, lo que la convierte en una pieza impresionante y codiciada por los coleccionistas. Con su rica historia y su belleza artística, la moneda de Chile de 8 Escudos de Fernando VI - 1751 J es una verdadera joya numismática.</p>', 'AU', NULL, NULL, 'Conmemorativo', '20/03/1925', NULL, NULL, NULL, 'YN14522558', NULL, '0264782', 0, 5575, 557.5, 6132.5, 3, '1710372790-Billete-Anverso-Del_Mundo-Australia-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', '1710372791-Billete-Reverso-Del_Mundo-Australia-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 2, '2024-03-13 23:33:11', '2024-03-13 23:33:11', 1, 2, 5, NULL, 1, 1, 1);
INSERT INTO `cointrade_db`.`products` (`prod_idProducto`, `prod_sku`, `prod_name`, `prod_description`, `prod_country`, `prod_metal`, `prod_diameter`, `prod_condition`, `prod_date`, `prod_weight`, `prod_minting`, `prod_fineness`, `prod_serie`, `prod_denomination`, `prod_number`, `prod_rating`, `prod_unit_cost`, `prod_commission`, `prod_total`, `prod_stock`, `prod_image_front`, `prod_image_back`, `usu_idUser`, `prod_created_date`, `prod_updated_date`, `prod_isActive`, `prod_idType_product`, `prod_idGroup_product`, `prod_idCategory_product`, `prod_isAuthorized`, `prod_isTerms`, `psts_idStatus`) VALUES (DEFAULT, 'BLE2', 'Billete 2 Pesos 1915-1919', '<p>La moneda de Chile de 8 Escudos de Fernando VI, acuñada en 1751, es una pieza de gran valor histórico y numismático. Esta moneda presenta en su anverso el retrato del rey Fernando VI, quien gobernó España y sus colonias durante ese período.</p><p>En el reverso, se puede apreciar el escudo real español con los símbolos de Castilla, León, Aragón y Granada, rodeado por el collar del Toisón de Oro. Esta moneda está acuñada en oro de alta pureza y tiene un diámetro considerable, lo que la convierte en una pieza impresionante y codiciada por los coleccionistas. Con su rica historia y su belleza artística, la moneda de Chile de 8 Escudos de Fernando VI - 1751 J es una verdadera joya numismática.</p>', 'CL', NULL, NULL, 'Conmemorativo', '20/03/1925', NULL, NULL, NULL, 'YN14522558', NULL, '0264782', 0, 5000, 500, 5500, 3, '1710372865-Billete-Anverso-Del_Mundo-Chile-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', '1710372866-Billete-Reverso-Del_Mundo-Chile-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 2, '2024-03-13 23:34:26', '2024-03-13 23:34:26', 1, 2, 5, NULL, 0, 1, 1);
INSERT INTO `cointrade_db`.`products` (`prod_idProducto`, `prod_sku`, `prod_name`, `prod_description`, `prod_country`, `prod_metal`, `prod_diameter`, `prod_condition`, `prod_date`, `prod_weight`, `prod_minting`, `prod_fineness`, `prod_serie`, `prod_denomination`, `prod_number`, `prod_rating`, `prod_unit_cost`, `prod_commission`, `prod_total`, `prod_stock`, `prod_image_front`, `prod_image_back`, `usu_idUser`, `prod_created_date`, `prod_updated_date`, `prod_isActive`, `prod_idType_product`, `prod_idGroup_product`, `prod_idCategory_product`, `prod_isAuthorized`, `prod_isTerms`, `psts_idStatus`) VALUES (DEFAULT, 'MND2', 'Moneda 1 dolar Estatua de la Libertad', '<p>La moneda de Chile de 8 Escudos de Fernando VI, acuñada en 1751, es una pieza de gran valor histórico y numismático. Esta moneda presenta en su anverso el retrato del rey Fernando VI, quien gobernó España y sus colonias durante ese período.</p><p>En el reverso, se puede apreciar el escudo real español con los símbolos de Castilla, León, Aragón y Granada, rodeado por el collar del Toisón de Oro. Esta moneda está acuñada en oro de alta pureza y tiene un diámetro considerable, lo que la convierte en una pieza impresionante y codiciada por los coleccionistas. Con su rica historia y su belleza artística, la moneda de Chile de 8 Escudos de Fernando VI - 1751 J es una verdadera joya numismática.</p>', 'US', 'Plata', '37', NULL, NULL, '2903', '1751', '1999,9/1000 oro fino', NULL, 'Test', NULL, 0, 5000, 500, 5500, 2, '1710372941-Moneda-Anverso-Del_Mundo-Estados_Unidos_de_America-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-Plata-1751.jpeg', '1710372941-Moneda-Reverso-Del_Mundo-Estados_Unidos_de_America-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-Plata-1751.jpeg', 2, '2024-03-13 23:35:42', '2024-03-13 23:35:42', 1, 1, 1, 1, 0, 1, 1);
INSERT INTO `cointrade_db`.`products` (`prod_idProducto`, `prod_sku`, `prod_name`, `prod_description`, `prod_country`, `prod_metal`, `prod_diameter`, `prod_condition`, `prod_date`, `prod_weight`, `prod_minting`, `prod_fineness`, `prod_serie`, `prod_denomination`, `prod_number`, `prod_rating`, `prod_unit_cost`, `prod_commission`, `prod_total`, `prod_stock`, `prod_image_front`, `prod_image_back`, `usu_idUser`, `prod_created_date`, `prod_updated_date`, `prod_isActive`, `prod_idType_product`, `prod_idGroup_product`, `prod_idCategory_product`, `prod_isAuthorized`, `prod_isTerms`, `psts_idStatus`) VALUES (DEFAULT, 'MND3', 'Moneda de 100 de los copihues', '<p>La moneda de Chile de 8 Escudos de Fernando VI, acuñada en 1751, es una pieza de gran valor histórico y numismático. Esta moneda presenta en su anverso el retrato del rey Fernando VI, quien gobernó España y sus colonias durante ese período.</p><p>En el reverso, se puede apreciar el escudo real español con los símbolos de Castilla, León, Aragón y Granada, rodeado por el collar del Toisón de Oro. Esta moneda está acuñada en oro de alta pureza y tiene un diámetro considerable, lo que la convierte en una pieza impresionante y codiciada por los coleccionistas. Con su rica historia y su belleza artística, la moneda de Chile de 8 Escudos de Fernando VI - 1751 J es una verdadera joya numismática.</p>', 'CL', 'Bronce', '37', NULL, NULL, '2903', '1751', '1999,9/1000 oro fino', NULL, 'Test', NULL, 0, 8700, 870, 9570, 1, '1710373018-Moneda-Anverso-Del_Mundo-Chile-Moneda_Chile_8_Escudos_Fernando_VI_1751_J- Bronce-1751.jpeg', '1710373018-Moneda-Reverso-Del_Mundo-Chile-Moneda_Chile_8_Escudos_Fernando_VI_1751_J- Bronce-1751.jpeg', 2, '2024-03-13 23:36:59', '2024-03-13 23:36:59', 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `cointrade_db`.`products` (`prod_idProducto`, `prod_sku`, `prod_name`, `prod_description`, `prod_country`, `prod_metal`, `prod_diameter`, `prod_condition`, `prod_date`, `prod_weight`, `prod_minting`, `prod_fineness`, `prod_serie`, `prod_denomination`, `prod_number`, `prod_rating`, `prod_unit_cost`, `prod_commission`, `prod_total`, `prod_stock`, `prod_image_front`, `prod_image_back`, `usu_idUser`, `prod_created_date`, `prod_updated_date`, `prod_isActive`, `prod_idType_product`, `prod_idGroup_product`, `prod_idCategory_product`, `prod_isAuthorized`, `prod_isTerms`, `psts_idStatus`) VALUES (DEFAULT, 'BLE3', 'Billete de 1 peso. Calendario Azteca', '<p>La moneda de Chile de 8 Escudos de Fernando VI, acuñada en 1751, es una pieza de gran valor histórico y numismático. Esta moneda presenta en su anverso el retrato del rey Fernando VI, quien gobernó España y sus colonias durante ese período.</p><p>En el reverso, se puede apreciar el escudo real español con los símbolos de Castilla, León, Aragón y Granada, rodeado por el collar del Toisón de Oro. Esta moneda está acuñada en oro de alta pureza y tiene un diámetro considerable, lo que la convierte en una pieza impresionante y codiciada por los coleccionistas. Con su rica historia y su belleza artística, la moneda de Chile de 8 Escudos de Fernando VI - 1751 J es una verdadera joya numismática.</p>', 'MX', NULL, NULL, 'Conmemorativo', '20/03/1925', NULL, NULL, NULL, 'YN14522558', NULL, '0264782', 0, 5000, 500, 5500, 3, '1710373079-Billete-Anverso-De_Mexico-Mexico-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', '1710373080-Billete-Reverso-De_Mexico-Mexico-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 2, '2024-03-13 23:38:00', '2024-03-13 23:38:00', 1, 2, 6, NULL, 1, 1, 1);
INSERT INTO `cointrade_db`.`products` (`prod_idProducto`, `prod_sku`, `prod_name`, `prod_description`, `prod_country`, `prod_metal`, `prod_diameter`, `prod_condition`, `prod_date`, `prod_weight`, `prod_minting`, `prod_fineness`, `prod_serie`, `prod_denomination`, `prod_number`, `prod_rating`, `prod_unit_cost`, `prod_commission`, `prod_total`, `prod_stock`, `prod_image_front`, `prod_image_back`, `usu_idUser`, `prod_created_date`, `prod_updated_date`, `prod_isActive`, `prod_idType_product`, `prod_idGroup_product`, `prod_idCategory_product`, `prod_isAuthorized`, `prod_isTerms`, `psts_idStatus`) VALUES (DEFAULT, 'BLE4', 'Billete de 5 pesos. Josefa Ortiz de Domínguez', '<p>La moneda de Chile de 8 Escudos de Fernando VI, acuñada en 1751, es una pieza de gran valor histórico y numismático. Esta moneda presenta en su anverso el retrato del rey Fernando VI, quien gobernó España y sus colonias durante ese período.</p><p>En el reverso, se puede apreciar el escudo real español con los símbolos de Castilla, León, Aragón y Granada, rodeado por el collar del Toisón de Oro. Esta moneda está acuñada en oro de alta pureza y tiene un diámetro considerable, lo que la convierte en una pieza impresionante y codiciada por los coleccionistas. Con su rica historia y su belleza artística, la moneda de Chile de 8 Escudos de Fernando VI - 1751 J es una verdadera joya numismática.</p>', 'MX', NULL, NULL, 'Conmemorativo', '20/03/1925', NULL, NULL, NULL, 'YN14522558', NULL, '0264782', 0, 5000, 500, 5500, 3, '1710373144-Billete-Anverso-De_Mexico-Mexico-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', '1710373144-Billete-Reverso-De_Mexico-Mexico-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 2, '2024-03-13 23:39:05', '2024-03-13 23:39:05', 1, 2, 6, NULL, 0, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`valuation_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`valuation_status` (`vsta_idStatus`, `vsta_name`, `vsta_description`) VALUES (DEFAULT, 'Favorable', NULL);
INSERT INTO `cointrade_db`.`valuation_status` (`vsta_idStatus`, `vsta_name`, `vsta_description`) VALUES (DEFAULT, 'No favorable', NULL);
INSERT INTO `cointrade_db`.`valuation_status` (`vsta_idStatus`, `vsta_name`, `vsta_description`) VALUES (DEFAULT, 'En progreso', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`product_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`product_type` (`ptpe_idType`, `ptpe_name`, `ptpe_description`, `ptpe_isActive`) VALUES (DEFAULT, 'Moneda', NULL, 1);
INSERT INTO `cointrade_db`.`product_type` (`ptpe_idType`, `ptpe_name`, `ptpe_description`, `ptpe_isActive`) VALUES (DEFAULT, 'Billete', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`product_certifications`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`product_certifications` (`pcert_idCertification`, `pcert_name`, `pcert_description`, `pcert_image`, `prod_idProducto`, `pcert_created_date`, `pcert_updated_date`) VALUES (DEFAULT, NULL, NULL, '1710372463-Moneda-Certificado-De_Mexico-Mexico-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-Plata-1751.jpeg', 1, '2024-03-13 23:27:43', '2024-03-13 23:27:43');
INSERT INTO `cointrade_db`.`product_certifications` (`pcert_idCertification`, `pcert_name`, `pcert_description`, `pcert_image`, `prod_idProducto`, `pcert_created_date`, `pcert_updated_date`) VALUES (DEFAULT, NULL, NULL, '1710372791-Billete-Certificado-Del_Mundo-Australia-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 2, '2024-03-13 23:33:11', '2024-03-13 23:33:11');
INSERT INTO `cointrade_db`.`product_certifications` (`pcert_idCertification`, `pcert_name`, `pcert_description`, `pcert_image`, `prod_idProducto`, `pcert_created_date`, `pcert_updated_date`) VALUES (DEFAULT, NULL, NULL, '1710372866-Billete-Certificado-Del_Mundo-Chile-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 3, '2024-03-13 23:34:26', '2024-03-13 23:34:26');
INSERT INTO `cointrade_db`.`product_certifications` (`pcert_idCertification`, `pcert_name`, `pcert_description`, `pcert_image`, `prod_idProducto`, `pcert_created_date`, `pcert_updated_date`) VALUES (DEFAULT, NULL, NULL, '1710372942-Moneda-Certificado-Del_Mundo-Estados_Unidos_de_America-Moneda_Chile_8_Escudos_Fernando_VI_1751_J-Plata-1751.jpeg', 4, '2024-03-13 23:35:42', '2024-03-13 23:35:42');
INSERT INTO `cointrade_db`.`product_certifications` (`pcert_idCertification`, `pcert_name`, `pcert_description`, `pcert_image`, `prod_idProducto`, `pcert_created_date`, `pcert_updated_date`) VALUES (DEFAULT, NULL, NULL, '1710373018-Moneda-Certificado-Del_Mundo-Chile-Moneda_Chile_8_Escudos_Fernando_VI_1751_J- Bronce-1751.jpeg', 5, '2024-03-13 23:36:59', '2024-03-13 23:36:59');
INSERT INTO `cointrade_db`.`product_certifications` (`pcert_idCertification`, `pcert_name`, `pcert_description`, `pcert_image`, `prod_idProducto`, `pcert_created_date`, `pcert_updated_date`) VALUES (DEFAULT, NULL, NULL, '1710373080-Billete-Certificado-De_Mexico-Mexico-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 6, '2024-03-13 23:38:00', '2024-03-13 23:38:00');
INSERT INTO `cointrade_db`.`product_certifications` (`pcert_idCertification`, `pcert_name`, `pcert_description`, `pcert_image`, `prod_idProducto`, `pcert_created_date`, `pcert_updated_date`) VALUES (DEFAULT, NULL, NULL, '1710373144-Billete-Certificado-De_Mexico-Mexico-Billete_Chile_8_Escudos_Fernando_VI_1751_J-YN14522558.jpeg', 7, '2024-03-13 23:39:05', '2024-03-13 23:39:05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`users_shipping_address`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`users_shipping_address` (`usad_idAddress`, `usad_country`, `usad_state`, `usad_city`, `usad_address`, `usad_cp`, `usad_isDefault`, `usad_created_date`, `usad_updated_date`, `usu_idUser`) VALUES (DEFAULT, 'MX', 'CH', '014', 'Pozo Grande', '42500', 1, NULL, NULL, 1);
INSERT INTO `cointrade_db`.`users_shipping_address` (`usad_idAddress`, `usad_country`, `usad_state`, `usad_city`, `usad_address`, `usad_cp`, `usad_isDefault`, `usad_created_date`, `usad_updated_date`, `usu_idUser`) VALUES (DEFAULT, 'MX', 'QT', '016', 'Pozo Grande', '42500', 1, NULL, NULL, 2);
INSERT INTO `cointrade_db`.`users_shipping_address` (`usad_idAddress`, `usad_country`, `usad_state`, `usad_city`, `usad_address`, `usad_cp`, `usad_isDefault`, `usad_created_date`, `usad_updated_date`, `usu_idUser`) VALUES (DEFAULT, 'MX', 'QT', '016', 'Pozo Grande', '42500', 0, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`countries`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AF', 'Afganistán', 'AFG', '4', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AL', 'Albania', 'ALB', '8', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('DE', 'Alemania', 'DEU', '276', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AD', 'Andorra', 'AND', '20', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AO', 'Angola', 'AGO', '24', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AI', 'Anguila', 'AIA', '660', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AQ', 'Antártida', 'ATA', '10', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AG', 'Antigua y Barbuda', 'ATG', '28', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SA', 'Arabia Saudita', 'SAU', '682', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('DZ', 'Argelia', 'DZA', '12', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AR', 'Argentina', 'ARG', '32', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AM', 'Armenia', 'ARM', '51', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AW', 'Aruba', 'ABW', '533', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AU', 'Australia', 'AUS', '36', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AT', 'Austria', 'AUT', '40', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AZ', 'Azerbaiyán', 'AZE', '31', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BS', 'Bahamas', 'BHS', '44', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BH', 'Bahrein', 'BHR', '48', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GG', 'Bailía de Guernsey', 'GGY', '831', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BD', 'Bangladesh', 'BGD', '50', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BB', 'Barbados', 'BRB', '52', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BY', 'Belarús', 'BLR', '112', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BE', 'Bélgica', 'BEL', '56', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BZ', 'Belice', 'BLZ', '84', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BJ', 'Benín', 'BEN', '204', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BM', 'Bermudas', 'BMU', '60', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BO', 'Bolivia', 'BOL', '68', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BA', 'Bosnia y Hercegovina', 'BIH', '70', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BW', 'Botsuana', 'BWA', '72', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BR', 'Brasil', 'BRA', '76', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BN', 'Brunéi', 'BRN', '96', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BG', 'Bulgaria', 'BGR', '100', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BF', 'Burkina Faso', 'BFA', '854', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BI', 'Burundi', 'BDI', '108', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BT', 'Bután', 'BTN', '64', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CV', 'Cabo Verde', 'CPV', '132', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KH', 'Camboya', 'KHM', '116', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CM', 'Camerún', 'CMR', '120', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CA', 'Canadá', 'CAN', '124', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BQ', 'Caribe Neerlandés', 'BES', '535', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('QA', 'Catar', 'QAT', '634', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TD', 'Chad', 'TCD', '148', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CZ', 'Chequia', 'CZE', '203', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CL', 'Chile', 'CHL', '152', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CN', 'China', 'CHN', '156', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CY', 'Chipre', 'CYP', '196', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('VA', 'Ciudad del Vaticano', 'VAT', '336', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CO', 'Colombia', 'COL', '170', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KM', 'Comores', 'COM', '174', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KP', 'Corea del Norte', 'PRK', '408', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KR', 'Corea del Sur', 'KOR', '410', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CI', 'Costa de Marfil', 'CIV', '384', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CR', 'Costa Rica', 'CRI', '188', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('HR', 'Croacia', 'HRV', '191', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CU', 'Cuba', 'CUB', '192', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CW', 'Curaçao', 'CUW', '531', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('DK', 'Dinamarca', 'DNK', '208', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('DM', 'Dominica', 'DMA', '212', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('EC', 'Ecuador', 'ECU', '218', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('EG', 'Egipto', 'EGY', '818', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SV', 'El Salvador', 'SLV', '222', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AE', 'Emiratos Árabes Unidos', 'ARE', '784', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ER', 'Eritrea', 'ERI', '232', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SK', 'Eslovaquia', 'SVK', '703', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SI', 'Eslovenia', 'SVN', '705', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ES', 'España', 'ESP', '724', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('FM', 'Estados Federados de Micronesia', 'FSM', '583', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('US', 'Estados Unidos de América', 'USA', '840', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('EE', 'Estonia', 'EST', '233', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SZ', 'Esuatini', 'SWZ', '748', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ET', 'Etiopía', 'ETH', '231', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PH', 'Filipinas', 'PHL', '608', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('FI', 'Finlandia', 'FIN', '246', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('FJ', 'Fiyi', 'FJI', '242', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('FR', 'Francia', 'FRA', '250', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GA', 'Gabón', 'GAB', '266', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GM', 'Gambia', 'GMB', '270', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GE', 'Georgia', 'GEO', '268', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GS', 'Georgia del Sur y las Islas Sandwich del Sur', 'SGS', '239', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GH', 'Ghana', 'GHA', '288', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GI', 'Gibraltar', 'GIB', '292', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GD', 'Granada', 'GRD', '308', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GR', 'Grecia', 'GRC', '300', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GL', 'Groenlandia', 'GRL', '304', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GP', 'Guadalupe', 'GLP', '312', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GU', 'Guam', 'GUM', '316', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GT', 'Guatemala', 'GTM', '320', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GY', 'Guayana', 'GUY', '328', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GF', 'Guayana Francesa', 'GUF', '254', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GN', 'Guinea', 'GIN', '324', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GQ', 'Guinea Ecuatorial', 'GNQ', '226', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GW', 'Guinea-Bissau', 'GNB', '624', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('HT', 'Haití', 'HTI', '332', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('HN', 'Honduras', 'HND', '340', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('HK', 'Hong Kong', 'HKG', '344', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('HU', 'Hungría', 'HUN', '348', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IN', 'India', 'IND', '356', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ID', 'Indonesia', 'IDN', '360', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IR', 'Irán', 'IRN', '364', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IQ', 'Iraq', 'IRQ', '368', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IE', 'Irlanda', 'IRL', '372', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BV', 'Isla Bouvet', 'BVT', '74', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IM', 'Isla de Man', 'IMN', '833', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CX', 'Isla de Navidad', 'CXR', '162', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MF', 'Isla de San Martín', 'MAF', '663', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MU', 'Isla Mauricio', 'MUS', '480', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NF', 'Isla Norfolk', 'NFK', '574', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IS', 'Islandia', 'ISL', '352', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AX', 'Islas Åland', 'ALA', '248', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KY', 'Islas Caimán', 'CYM', '136', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CC', 'Islas Cocos', 'CCK', '166', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CK', 'Islas Cook', 'COK', '184', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('FO', 'Islas Feroe', 'FRO', '234', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('HM', 'Islas Heard y McDonald', 'HMD', '334', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('FK', 'Islas Malvinas', 'FLK', '238', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MP', 'Islas Marianas del Norte', 'MNP', '580', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MH', 'Islas Marshall', 'MHL', '584', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PN', 'Islas Pitcairn', 'PCN', '612', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SB', 'Islas Salomón', 'SLB', '90', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TC', 'Islas Turcas y Caicos', 'TCA', '796', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('UM', 'Islas ultramarinas menores de los Estados Unidos', 'UMI', '581', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('VG', 'Islas Vírgenes (UK)', 'VGB', '92', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('VI', 'Islas Vírgenes Americanas', 'VIR', '850', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IL', 'Israel', 'ISR', '376', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IT', 'Italia', 'ITA', '380', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('JM', 'Jamaica', 'JAM', '388', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('JP', 'Japón', 'JPN', '392', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('JE', 'Jersey', 'JEY', '832', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('JO', 'Jordania', 'JOR', '400', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KZ', 'Kazajistán', 'KAZ', '398', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KE', 'Kenia', 'KEN', '404', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KG', 'Kirguistán', 'KGZ', '417', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KI', 'Kiribati', 'KIR', '296', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('XK', 'Kosovo', 'XXK', '412', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KW', 'Kuwait', 'KWT', '414', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LA', 'Laos', 'LAO', '418', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LS', 'Lesotho', 'LSO', '426', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LV', 'Letonia', 'LVA', '428', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LB', 'Líbano', 'LBN', '422', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LR', 'Liberia', 'LBR', '430', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LY', 'Libia', 'LBY', '434', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LI', 'Liechtenstein', 'LIE', '438', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LT', 'Lituania', 'LTU', '440', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LU', 'Luxemburgo', 'LUX', '442', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MO', 'Macao', 'MAC', '446', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MK', 'Macedonia del Norte', 'MKD', '807', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MG', 'Madagascar', 'MDG', '450', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MY', 'Malasia', 'MYS', '458', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MW', 'Malaui', 'MWI', '454', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MV', 'Maldivas', 'MDV', '462', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ML', 'Malí', 'MLI', '466', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MT', 'Malta', 'MLT', '470', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MA', 'Marruecos', 'MAR', '504', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MQ', 'Martinica', 'MTQ', '474', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MR', 'Mauritania', 'MRT', '478', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('YT', 'Mayotte', 'MYT', '175', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MX', 'México', 'MEX', '484', 1);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MD', 'Moldavia', 'MDA', '498', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MN', 'Mongolia', 'MNG', '496', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ME', 'Montenegro', 'MNE', '499', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MS', 'Montserrat', 'MSR', '500', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MZ', 'Mozambique', 'MOZ', '508', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MM', 'Myanmar', 'MMR', '104', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NA', 'Namibia', 'NAM', '516', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NR', 'Nauru', 'NRU', '520', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NP', 'Nepal', 'NPL', '524', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NI', 'Nicaragua', 'NIC', '558', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NE', 'Níger', 'NER', '562', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NG', 'Nigeria', 'NGA', '566', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NU', 'Niue', 'NIU', '570', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NO', 'Noruega', 'NOR', '578', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NC', 'Nueva Caledonia', 'NCL', '540', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NZ', 'Nueva Zelandia', 'NZL', '554', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('OM', 'Omán', 'OMN', '512', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('NL', 'Países Bajos', 'NLD', '528', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PK', 'Pakistán', 'PAK', '586', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PW', 'Palaos', 'PLW', '585', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PS', 'Palestina', 'PSE', '275', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PA', 'Panamá', 'PAN', '591', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PG', 'Papúa Nueva Guinea', 'PNG', '598', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PY', 'Paraguay', 'PRY', '600', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PE', 'Perú', 'PER', '604', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PF', 'Polinesia Francesa', 'PYF', '258', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PL', 'Polonia', 'POL', '616', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PT', 'Portugal', 'PRT', '620', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('MC', 'Principado de Mónaco', 'MCO', '492', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PR', 'Puerto Rico', 'PRI', '630', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('GB', 'Reino Unido', 'GBR', '826', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CF', 'República Centroafricana', 'CAF', '140', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CG', 'República del Congo', 'COG', '178', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CD', 'República Democrática del Congo', 'COD', '180', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('DO', 'República Dominicana', 'DOM', '214', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('RE', 'Reunión', 'REU', '638', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('RW', 'Ruanda', 'RWA', '646', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('RO', 'Rumania', 'ROU', '642', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('RU', 'Rusia', 'RUS', '643', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('EH', 'Sáhara Occidental', 'ESH', '732', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('WS', 'Samoa', 'WSM', '882', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('AS', 'Samoa Americana', 'ASM', '16', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('BL', 'San Bartolomé', 'BLM', '652', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('KN', 'San Cristóbal y Nieves', 'KNA', '659', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SM', 'San Marino', 'SMR', '674', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('PM', 'San Pedro y Miquelón', 'SPM', '666', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('VC', 'San Vicente y las Granadinas', 'VCT', '670', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SH', 'Santa Elena, Ascensión y Tristán de Acuña', 'SHN', '654', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LC', 'Santa Lucía', 'LCA', '662', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ST', 'Santo Tomé y Príncipe', 'STP', '678', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SN', 'Senegal', 'SEN', '686', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('RS', 'Serbia', 'SRB', '688', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SC', 'Seychelles', 'SYC', '690', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SL', 'Sierra Leona', 'SLE', '694', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SG', 'Singapur', 'SGP', '702', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SX', 'Sint Maarten', 'SXM', '534', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SY', 'Siria', 'SYR', '760', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SO', 'Somalia', 'SOM', '706', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('LK', 'Sri Lanka', 'LKA', '144', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ZA', 'Sudáfrica', 'ZAF', '710', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SD', 'Sudán', 'SDN', '729', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SS', 'Sudán del Sur', 'SSD', '728', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SE', 'Suecia', 'SWE', '752', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('CH', 'Suiza', 'CHE', '756', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SR', 'Surinam', 'SUR', '740', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('SJ', 'Svalbard y Jan Mayen', 'SJM', '744', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TH', 'Tailandia', 'THA', '764', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TW', 'Taiwán', 'TWN', '158', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TZ', 'Tanzania', 'TZA', '834', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TJ', 'Tayikistán', 'TJK', '762', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('IO', 'Territorio Británico del Océano Índico', 'IOT', '86', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TF', 'Territorios Australes y Antárticos Franceses', 'ATF', '260', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TL', 'Timor Oriental', 'TLS', '626', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TG', 'Togo', 'TGO', '768', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TK', 'Tokelau', 'TKL', '772', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TO', 'Tonga', 'TON', '776', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TT', 'Trinidad y Tobago', 'TTO', '780', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TN', 'Túnez', 'TUN', '788', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TM', 'Turkmenistán', 'TKM', '795', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TR', 'Turquía', 'TUR', '792', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('TV', 'Tuvalu', 'TUV', '798', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('UA', 'Ucrania', 'UKR', '804', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('UG', 'Uganda', 'UGA', '800', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('UY', 'Uruguay', 'URY', '858', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('UZ', 'Uzbekistán', 'UZB', '860', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('VU', 'Vanuatu', 'VUT', '548', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('VE', 'Venezuela', 'VEN', '862', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('VN', 'Vietnam', 'VNM', '704', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('WF', 'Wallis y Futuna', 'WLF', '876', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('YE', 'Yemen', 'YEM', '887', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('DJ', 'Yibuti', 'DJI', '262', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ZM', 'Zambia', 'ZMB', '894', 0);
INSERT INTO `cointrade_db`.`countries` (`coun_iso_alpha2`, `coun_name`, `coun_iso_alpha3`, `coun_iso_numerico`, `coun_isActive`) VALUES ('ZW', 'Zimbabue', 'ZWE', '716', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`states`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('AG', 'Aguascalientes', '01', 'AGU', 'AS', 'AGS', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('BC', 'Baja California', '02', 'BCN', 'BC', 'BC', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('BS', 'Baja California Sur', '03', 'BCS', 'BS', 'BCS', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('CM', 'Campeche', '04', 'CAM', 'CC', 'CAMP', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('CS', 'Chiapas', '05', 'CHP', 'CS', 'CHIS', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('CH', 'Chihuahua', '06', 'CHH', 'CH', 'CHIH', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('CX', 'Ciudad de México', '07', 'CMX', 'DF', 'CDMX', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('CO', 'Coahuila', '08', 'COA', 'CL', 'COAH', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('CL', 'Colima', '09', 'COL', 'CM', 'COL', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('DG', 'Durango', '10', 'DUR', 'DG', 'DGO', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('GT', 'Guanajuato', '11', 'GUA', 'GT', 'GTO', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('GR', 'Guerrero', '12', 'GRO', 'GR', 'GRO', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('HG', 'Hidalgo', '13', 'HID', 'HG', 'HGO', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('JC', 'Jalisco', '14', 'JAL', 'JC', 'JAL', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('EM', 'México', '15', 'MEX', 'MC', 'MEX', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('MI', 'Michoacán', '16', 'MIC', 'MN', 'MICH', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('MO', 'Morelos', '17', 'MOR', 'MS', 'MOR', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('NA', 'Nayarit', '18', 'NAY', 'NT', 'NAY', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('NL', 'Nuevo León', '19', 'NLE', 'NL', 'NL', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('OA', 'Oaxaca', '20', 'OAX', 'OC', 'OAX', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('PU', 'Puebla', '21', 'PUE', 'PL', 'PUE', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('QT', 'Querétaro', '22', 'QUE', 'QO', 'QRO', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('QR', 'Quintana Roo', '23', 'ROO', 'QR', 'QROO', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('SL', 'San Luis Potosí', '24', 'SLP', 'SP', 'SLP', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('SI', 'Sinaloa', '25', 'SIN', 'SL', 'SIN', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('SO', 'Sonora', '26', 'SON', 'SR', 'SON', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('TB', 'Tabasco', '27', 'TAB', 'TC', 'TAB', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('TM', 'Tamaulipas', '28', 'TAM', 'TS', 'TAMPS', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('TL', 'Tlaxcala', '29', 'TLA', 'TL', 'TLAX', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('VE', 'Veracruz', '30', 'VER', 'VZ', 'VER', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('YU', 'Yucatán', '31', 'YUC', 'YN', 'YUC', 'MX', 1);
INSERT INTO `cointrade_db`.`states` (`sta_iso_alpha2`, `sta_name`, `sta_clave`, `sta_iso_alpha3`, `sta_renapo`, `sta_abbreviation`, `coun_iso_alpha2`, `sta_isActive`) VALUES ('ZA', 'Zacatecas', '32', 'ZAC', 'ZS', 'ZAC', 'MX', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`users_fiscal_data`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`users_fiscal_data` (`ufdt_idData`, `ufdt_denomination`, `ufdt_rfc`, `ufdt_country`, `ufdt_state`, `ufdt_city`, `ufdt_address`, `ufdt_cp`, `ufdt_created_date`, `ufdt_updated_date`, `usu_idUser`) VALUES (DEFAULT, 'Jacqueline Lugo Lopez', 'LULJ970824MD6', 'MX', 'DG', '009', 'Pozo Grande', '42500', NULL, NULL, 1);
INSERT INTO `cointrade_db`.`users_fiscal_data` (`ufdt_idData`, `ufdt_denomination`, `ufdt_rfc`, `ufdt_country`, `ufdt_state`, `ufdt_city`, `ufdt_address`, `ufdt_cp`, `ufdt_created_date`, `ufdt_updated_date`, `usu_idUser`) VALUES (DEFAULT, 'Jacqueline Lugo Lopez', 'LULJ970824MD6', 'MX', 'TB', '010', 'Pozo Grande', '42500', NULL, NULL, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`cities`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Aguascalientes', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Asientos', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Calvillo', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Cosío', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Jesús María', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Pabellón de Arteaga', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Rincón de Romos', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'San José de Gracia', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Tepezalá', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'El Llano', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'San Francisco de los Romo', 'AG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Ensenada', 'BC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Mexicali', 'BC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Tecate', 'BC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Tijuana', 'BC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Playas de Rosarito', 'BC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'San Quintín', 'BC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'San Felipe', 'BC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Comondú', 'BS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Mulegé', 'BS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'La Paz', 'BS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Los Cabos', 'BS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Loreto', 'BS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Calkiní', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Campeche', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Carmen', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Champotón', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Hecelchakán', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Hopelchén', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Palizada', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Tenabo', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Escárcega', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Calakmul', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Candelaria', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Seybaplaya', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Dzitbalché', 'CM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acacoyagua', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acala', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Acapetahua', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Altamirano', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Amatán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Amatenango de la Frontera', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Amatenango del Valle', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Ángel Albino Corzo', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Arriaga', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Bejucal de Ocampo', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Bella Vista', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Berriozábal', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Bochil', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'El Bosque', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Cacahoatán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Catazajá', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Cintalapa de Figueroa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Coapilla', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Comitán de Domínguez', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'La Concordia', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Copainalá', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Chalchihuitán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Chamula', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Chanal', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Chapultenango', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Chenalhó', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Chiapa de Corzo', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Chiapilla', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Chicoasén', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Chicomuselo', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Chilón', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Escuintla', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Francisco León', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Frontera Comalapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Frontera Hidalgo', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'La Grandeza', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Huehuetán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Huixtán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Huitiupán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Huixtla', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'La Independencia', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Ixhuatán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Ixtacomitán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Ixtapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Ixtapangajoya', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Jiquipilas', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Jitotol', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Juárez', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Larráinzar', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'La Libertad', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Mapastepec', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Las Margaritas', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Mazapa de Madero', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Mazatán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Metapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Mitontic', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Motozintla', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Nicolás Ruíz', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Ocosingo', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Ocotepec', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Ocozocoautla de Espinosa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Ostuacán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Osumacinta', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Oxchuc', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Palenque', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Pantelhó', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Pantepec', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Pichucalco', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Pijijiapan', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'El Porvenir', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Villa Comaltitlán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Pueblo Nuevo Solistahuacán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Rayón', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Reforma', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Las Rosas', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'Sabanilla', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'Salto de Agua', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'San Cristóbal de las Casas', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'San Fernando', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Siltepec', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Simojovel', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Sitalá', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Socoltenango', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Solosuchiapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'Soyaló', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'Suchiapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'Suchiate', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'Sunuapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'Tapachula', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'Tapalapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'Tapilula', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'Tecpatán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'Tenejapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'Teopisca', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'Tila', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'Tonalá', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'Totolapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'La Trinitaria', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'Tumbalá', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'Tuxtla Gutiérrez', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'Tuxtla Chico', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'Tuzantán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'Tzimol', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'Unión Juárez', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'Venustiano Carranza', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('107', 'Villa Corzo', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('108', 'Villaflores', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('109', 'Yajalón', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('110', 'San Lucas', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('111', 'Zinacantán', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('112', 'San Juan Cancuc', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('113', 'Aldama', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('114', 'Benemérito de las Américas', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('115', 'Maravilla Tenejapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('116', 'Marqués de Comillas', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('117', 'Montecristo de Guerrero', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('118', 'San Andrés Duraznal', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('119', 'Santiago el Pinar', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('120', 'Capitán Luis Ángel Vidal', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('121', 'Rincón Chamula San Pedro', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('122', 'El Parral', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('123', 'Emiliano Zapata', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('124', 'Mezcalapa', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('125', 'Honduras de la Sierra', 'CS', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Ahumada', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Aldama', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Allende', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Aquiles Serdán', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Ascensión', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Bachíniva', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Balleza', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Batopilas de Manuel Gómez Morín', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Bocoyna', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Buenaventura', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Camargo', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Carichí', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Casas Grandes', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Coronado', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Coyame del Sotol', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'La Cruz', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Cuauhtémoc', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Cusihuiriachi', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Chihuahua', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Chínipas', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Delicias', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Dr. Belisario Domínguez', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Galeana', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Santa Isabel', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Gómez Farías', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Gran Morelos', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Guachochi', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Guadalupe', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Guadalupe y Calvo', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Guazapares', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Guerrero', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Hidalgo del Parral', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Huejotitán', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Ignacio Zaragoza', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Janos', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Jiménez', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Juárez', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Julimes', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'López', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Madera', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Maguarichi', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Manuel Benavides', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Matachí', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Matamoros', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Meoqui', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Morelos', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Moris', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Namiquipa', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Nonoava', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Nuevo Casas Grandes', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Ocampo', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Ojinaga', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Praxedis G. Guerrero', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Riva Palacio', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Rosales', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Rosario', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'San Francisco de Borja', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'San Francisco de Conchos', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'San Francisco del Oro', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Santa Bárbara', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Satevó', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Saucillo', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Temósachic', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'El Tule', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Urique', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Uruachi', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Valle de Zaragoza', 'CH', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Azcapotzalco', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Coyoacán', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Cuajimalpa de Morelos', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Gustavo A. Madero', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Iztacalco', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Iztapalapa', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'La Magdalena Contreras', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Milpa Alta', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Álvaro Obregón', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Tláhuac', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Tlalpan', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Xochimilco', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Benito Juárez', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Cuauhtémoc', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Miguel Hidalgo', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Venustiano Carranza', 'CX', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Abasolo', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acuña', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Allende', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Arteaga', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Candela', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Castaños', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Cuatro Ciénegas', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Escobedo', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Francisco I. Madero', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Frontera', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'General Cepeda', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Guerrero', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Hidalgo', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Jiménez', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Juárez', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Lamadrid', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Matamoros', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Monclova', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Morelos', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Múzquiz', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Nadadores', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Nava', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Ocampo', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Parras', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Piedras Negras', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Progreso', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Ramos Arizpe', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Sabinas', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Sacramento', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Saltillo', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'San Buenaventura', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'San Juan de Sabinas', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'San Pedro', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Sierra Mojada', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Torreón', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Viesca', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Villa Unión', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Zaragoza', 'CO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Armería', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Colima', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Comala', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Coquimatlán', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Cuauhtémoc', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Ixtlahuacán', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Manzanillo', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Minatitlán', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Tecomán', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Villa de Álvarez', 'CL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Canatlán', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Canelas', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Coneto de Comonfort', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Cuencamé', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Durango', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'General Simón Bolívar', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Gómez Palacio', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Guadalupe Victoria', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Guanaceví', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Hidalgo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Indé', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Lerdo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Mapimí', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Mezquital', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Nazas', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Nombre de Dios', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Ocampo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'El Oro', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Otáez', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Pánuco de Coronado', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Peñón Blanco', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Poanas', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Pueblo Nuevo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Rodeo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'San Bernardo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'San Dimas', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'San Juan de Guadalupe', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'San Juan del Río', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'San Luis del Cordero', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'San Pedro del Gallo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Santa Clara', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Santiago Papasquiaro', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Súchil', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Tamazula', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Tepehuanes', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Tlahualilo', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Topia', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Vicente Guerrero', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Nuevo Ideal', 'DG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Abasolo', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acámbaro', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'San Miguel de Allende', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Apaseo el Alto', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Apaseo el Grande', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Atarjea', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Celaya', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Manuel Doblado', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Comonfort', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Coroneo', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Cortazar', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Cuerámaro', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Doctor Mora', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Dolores Hidalgo Cuna de la Independencia Nacional', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Guanajuato', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Huanímaro', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Irapuato', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Jaral del Progreso', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Jerécuaro', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'León', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Moroleón', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Ocampo', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Pénjamo', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Pueblo Nuevo', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Purísima del Rincón', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Romita', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Salamanca', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Salvatierra', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'San Diego de la Unión', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'San Felipe', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'San Francisco del Rincón', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'San José Iturbide', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'San Luis de la Paz', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Santa Catarina', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Santa Cruz de Juventino Rosas', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Santiago Maravatío', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Silao de la Victoria', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Tarandacuao', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Tarimoro', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Tierra Blanca', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Uriangato', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Valle de Santiago', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Victoria', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Villagrán', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Xichú', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Yuriria', 'GT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acapulco de Juárez', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Ahuacuotzingo', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Ajuchitlán del Progreso', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Alcozauca de Guerrero', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Alpoyeca', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Apaxtla', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Arcelia', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Atenango del Río', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Atlamajalcingo del Monte', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Atlixtac', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Atoyac de Álvarez', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Ayutla de los Libres', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Azoyú', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Benito Juárez', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Buenavista de Cuéllar', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Coahuayutla de José María Izazaga', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Cocula', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Copala', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Copalillo', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Copanatoyac', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Coyuca de Benítez', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Coyuca de Catalán', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Cuajinicuilapa', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Cualác', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Cuautepec', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Cuetzala del Progreso', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Cutzamala de Pinzón', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Chilapa de Álvarez', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Chilpancingo de los Bravo', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Florencio Villarreal', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'General Canuto A. Neri', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'General Heliodoro Castillo', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Huamuxtitlán', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Huitzuco de los Figueroa', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Iguala de la Independencia', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Igualapa', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Ixcateopan de Cuauhtémoc', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Zihuatanejo de Azueta', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Juan R. Escudero', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Leonardo Bravo', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Malinaltepec', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Mártir de Cuilapan', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Metlatónoc', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Mochitlán', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Olinalá', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Ometepec', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Pedro Ascencio Alquisiras', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Petatlán', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Pilcaya', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Pungarabato', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Quechultenango', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'San Luis Acatlán', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'San Marcos', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'San Miguel Totolapan', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Taxco de Alarcón', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Tecoanapa', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Técpan de Galeana', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Teloloapan', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Tepecoacuilco de Trujano', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Tetipac', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Tixtla de Guerrero', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Tlacoachistlahuaca', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Tlacoapa', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Tlalchapa', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Tlalixtaquilla de Maldonado', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Tlapa de Comonfort', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Tlapehuala', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'La Unión de Isidoro Montes de Oca', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Xalpatláhuac', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'Xochihuehuetlán', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Xochistlahuaca', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Zapotitlán Tablas', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Zirándaro', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Zitlala', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Eduardo Neri', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'Acatepec', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'Marquelia', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Cochoapa el Grande', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'José Joaquín de Herrera', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Juchitán', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Iliatenco', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Las Vigas', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Ñuu Savi', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Santa Cruz del Rincón', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'San Nicolás', 'GR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acatlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acaxochitlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Actopan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Agua Blanca de Iturbide', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Ajacuba', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Alfajayucan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Almoloya', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Apan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'El Arenal', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Atitalaquia', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Atlapexco', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Atotonilco el Grande', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Atotonilco de Tula', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Calnali', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Cardonal', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Cuautepec de Hinojosa', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Chapantongo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Chapulhuacán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Chilcuautla', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Eloxochitlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Emiliano Zapata', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Epazoyucan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Francisco I. Madero', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Huasca de Ocampo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Huautla', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Huazalingo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Huehuetla', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Huejutla de Reyes', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Huichapan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Ixmiquilpan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Jacala de Ledezma', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Jaltocán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Juárez Hidalgo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Lolotla', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Metepec', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'San Agustín Metzquititlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Metztitlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Mineral del Chico', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Mineral del Monte', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'La Misión', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Mixquiahuala de Juárez', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Molango de Escamilla', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Nicolás Flores', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Nopala de Villagrán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Omitlán de Juárez', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'San Felipe Orizatlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Pacula', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Pachuca de Soto', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Pisaflores', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Progreso de Obregón', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Mineral de la Reforma', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'San Agustín Tlaxiaca', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'San Bartolo Tutotepec', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'San Salvador', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Santiago de Anaya', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Santiago Tulantepec de Lugo Guerrero', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Singuilucan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Tasquillo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Tecozautla', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Tenango de Doria', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Tepeapulco', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Tepehuacán de Guerrero', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Tepeji del Río de Ocampo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Tepetitlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Tetepango', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Villa de Tezontepec', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Tezontepec de Aldama', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Tianguistengo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Tizayuca', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'Tlahuelilpan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Tlahuiltepa', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Tlanalapa', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Tlanchinol', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Tlaxcoapan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Tolcayuca', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'Tula de Allende', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'Tulancingo de Bravo', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Xochiatipan', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Xochicoatlán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Yahualica', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Zacualtipán de Ángeles', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Zapotlán de Juárez', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Zempoala', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Zimapán', 'HG', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acatic', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acatlán de Juárez', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Ahualulco de Mercado', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Amacueca', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Amatitán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Ameca', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'San Juanito de Escobedo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Arandas', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'El Arenal', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Atemajac de Brizuela', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Atengo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Atenguillo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Atotonilco el Alto', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Atoyac', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Autlán de Navarro', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Ayotlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Ayutla', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'La Barca', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Bolaños', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Cabo Corrientes', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Casimiro Castillo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Cihuatlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Zapotlán el Grande', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Cocula', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Colotlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Concepción de Buenos Aires', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Cuautitlán de García Barragán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Cuautla', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Cuquío', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Chapala', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Chimaltitán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Chiquilistlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Degollado', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Ejutla', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Encarnación de Díaz', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Etzatlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'El Grullo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Guachinango', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Guadalajara', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Hostotipaquillo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Huejúcar', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Huejuquilla el Alto', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'La Huerta', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Ixtlahuacán de los Membrillos', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Ixtlahuacán del Río', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Jalostotitlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Jamay', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Jesús María', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Jilotlán de los Dolores', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Jocotepec', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Juanacatlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Juchitlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Lagos de Moreno', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'El Limón', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Magdalena', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Santa María del Oro', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'La Manzanilla de la Paz', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Mascota', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Mazamitla', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Mexticacán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Mezquitic', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Mixtlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Ocotlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Ojuelos de Jalisco', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Pihuamo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Poncitlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Puerto Vallarta', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Villa Purificación', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Quitupan', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'El Salto', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'San Cristóbal de la Barranca', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'San Diego de Alejandría', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'San Juan de los Lagos', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'San Julián', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'San Marcos', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'San Martín de Bolaños', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'San Martín Hidalgo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'San Miguel el Alto', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Gómez Farías', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'San Sebastián del Oeste', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Santa María de los Ángeles', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Sayula', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Tala', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Talpa de Allende', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'Tamazula de Gordiano', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'Tapalpa', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'Tecalitlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'Tecolotlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'Techaluta de Montenegro', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'Tenamaxtlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'Teocaltiche', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'Teocuitatlán de Corona', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'Tepatitlán de Morelos', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'Tequila', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('095', 'Teuchitlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'Tizapán el Alto', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'Tlajomulco de Zúñiga', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'San Pedro Tlaquepaque', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'Tolimán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'Tomatlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'Tonalá', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'Tonaya', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'Tonila', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'Totatiche', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'Tototlán', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'Tuxcacuesco', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('107', 'Tuxcueca', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('108', 'Tuxpan', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('109', 'Unión de San Antonio', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('110', 'Unión de Tula', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('111', 'Valle de Guadalupe', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('112', 'Valle de Juárez', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('113', 'San Gabriel', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('114', 'Villa Corona', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('115', 'Villa Guerrero', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('116', 'Villa Hidalgo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('117', 'Cañadas de Obregón', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('118', 'Yahualica de González Gallo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('119', 'Zacoalco de Torres', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('120', 'Zapopan', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('121', 'Zapotiltic', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('122', 'Zapotitlán de Vadillo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('123', 'Zapotlán del Rey', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('124', 'Zapotlanejo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('125', 'San Ignacio Cerro Gordo', 'JC', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acambay de Ruíz Castañeda', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acolman', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Aculco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Almoloya de Alquisiras', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Almoloya de Juárez', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Almoloya del Río', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Amanalco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Amatepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Amecameca', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Apaxco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Atenco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Atizapán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Atizapán de Zaragoza', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Atlacomulco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Atlautla', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Axapusco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Ayapango', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Calimaya', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Capulhuac', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Coacalco de Berriozábal', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Coatepec Harinas', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Cocotitlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Coyotepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Cuautitlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Chalco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Chapa de Mota', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Chapultepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Chiautla', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Chicoloapan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Chiconcuac', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Chimalhuacán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Donato Guerra', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Ecatepec de Morelos', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Ecatzingo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Huehuetoca', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Hueypoxtla', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Huixquilucan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Isidro Fabela', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Ixtapaluca', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Ixtapan de la Sal', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Ixtapan del Oro', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Ixtlahuaca', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Xalatlaco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Jaltenco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Jilotepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Jilotzingo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Jiquipilco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Jocotitlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Joquicingo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Juchitepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Lerma', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Malinalco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Melchor Ocampo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Metepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Mexicaltzingo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Morelos', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Naucalpan de Juárez', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Nezahualcóyotl', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Nextlalpan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Nicolás Romero', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Nopaltepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Ocoyoacac', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Ocuilan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'El Oro', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Otumba', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Otzoloapan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Otzolotepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Ozumba', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Papalotla', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'La Paz', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Polotitlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Rayón', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'San Antonio la Isla', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'San Felipe del Progreso', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'San Martín de las Pirámides', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'San Mateo Atenco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'San Simón de Guerrero', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Santo Tomás', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Soyaniquilpan de Juárez', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Sultepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Tecámac', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Tejupilco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Temamatla', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Temascalapa', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'Temascalcingo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'Temascaltepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'Temoaya', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'Tenancingo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'Tenango del Aire', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'Tenango del Valle', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'Teoloyucan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'Teotihuacán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'Tepetlaoxtoc', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'Tepetlixpa', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('095', 'Tepotzotlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'Tequixquiac', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'Texcaltitlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'Texcalyacac', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'Texcoco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'Tezoyuca', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'Tianguistenco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'Timilpan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'Tlalmanalco', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'Tlalnepantla de Baz', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'Tlatlaya', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'Toluca', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('107', 'Tonatico', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('108', 'Tultepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('109', 'Tultitlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('110', 'Valle de Bravo', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('111', 'Villa de Allende', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('112', 'Villa del Carbón', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('113', 'Villa Guerrero', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('114', 'Villa Victoria', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('115', 'Xonacatlán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('116', 'Zacazonapan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('117', 'Zacualpan', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('118', 'Zinacantepec', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('119', 'Zumpahuacán', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('120', 'Zumpango', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('121', 'Cuautitlán Izcalli', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('122', 'Valle de Chalco Solidaridad', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('123', 'Luvianos', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('124', 'San José del Rincón', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('125', 'Tonanitla', 'EM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acuitzio', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Aguililla', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Álvaro Obregón', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Angamacutiro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Angangueo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Apatzingán', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Aporo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Aquila', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Ario', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Arteaga', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Briseñas', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Buenavista', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Carácuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Coahuayana', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Coalcomán de Vázquez Pallares', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Coeneo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Contepec', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Copándaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Cotija', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Cuitzeo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Charapan', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Charo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Chavinda', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Cherán', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Chilchota', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Chinicuila', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Chucándiro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Churintzio', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Churumuco', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Ecuandureo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Epitacio Huerta', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Erongarícuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Gabriel Zamora', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Hidalgo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'La Huacana', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Huandacareo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Huaniqueo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Huetamo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Huiramba', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Indaparapeo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Irimbo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Ixtlán', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Jacona', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Jiménez', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Jiquilpan', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Juárez', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Jungapeo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Lagunillas', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Madero', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Maravatío', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Marcos Castellanos', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Lázaro Cárdenas', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Morelia', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Morelos', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Múgica', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Nahuatzen', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Nocupétaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Nuevo Parangaricutiro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Nuevo Urecho', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Numarán', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Ocampo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Pajacuarán', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Panindícuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Parácuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Paracho', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Pátzcuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Penjamillo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Peribán', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'La Piedad', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'Purépero', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Puruándiro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Queréndaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Quiroga', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Cojumatlán de Régules', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Los Reyes', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'Sahuayo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'San Lucas', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Santa Ana Maya', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Salvador Escalante', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Senguio', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Susupuato', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Tacámbaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Tancítaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Tangamandapio', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'Tangancícuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'Tanhuato', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'Taretan', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'Tarímbaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'Tepalcatepec', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'Tingambato', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'Tingüindín', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'Tiquicheo de Nicolás Romero', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'Tlalpujahua', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'Tlazazalca', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('095', 'Tocumbo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'Tumbiscatío', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'Turicato', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'Tuxpan', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'Tuzantla', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'Tzintzuntzan', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'Tzitzio', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'Uruapan', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'Venustiano Carranza', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'Villamar', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'Vista Hermosa', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'Yurécuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('107', 'Zacapu', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('108', 'Zamora', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('109', 'Zináparo', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('110', 'Zinapécuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('111', 'Ziracuaretiro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('112', 'Zitácuaro', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('113', 'José Sixto Verduzco', 'MI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Amacuzac', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Atlatlahucan', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Axochiapan', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Ayala', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Coatlán del Río', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Cuautla', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Cuernavaca', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Emiliano Zapata', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Huitzilac', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Jantetelco', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Jiutepec', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Jojutla', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Jonacatepec de Leandro Valle', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Mazatepec', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Miacatlán', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Ocuituco', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Puente de Ixtla', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Temixco', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Tepalcingo', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Tepoztlán', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Tetecala', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Tetela del Volcán', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Tlalnepantla', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Tlaltizapán de Zapata', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Tlaquiltenango', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Tlayacapan', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Totolapan', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Xochitepec', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Yautepec', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Yecapixtla', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Zacatepec', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Zacualpan de Amilpas', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Temoac', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Coatetelco', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Xoxocotla', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Hueyapan', 'MO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acaponeta', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Ahuacatlán', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Amatlán de Cañas', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Compostela', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Huajicori', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Ixtlán del Río', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Jala', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Xalisco', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Del Nayar', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Rosamorada', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Ruíz', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'San Blas', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'San Pedro Lagunillas', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Santa María del Oro', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Santiago Ixcuintla', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Tecuala', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Tepic', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Tuxpan', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'La Yesca', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Bahía de Banderas', 'NA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Abasolo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Agualeguas', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Los Aldamas', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Allende', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Anáhuac', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Apodaca', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Aramberri', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Bustamante', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Cadereyta Jiménez', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'El Carmen', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Cerralvo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Ciénega de Flores', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'China', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Doctor Arroyo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Doctor Coss', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Doctor González', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Galeana', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'García', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'San Pedro Garza García', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'General Bravo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'General Escobedo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'General Terán', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'General Treviño', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'General Zaragoza', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'General Zuazua', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Guadalupe', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Los Herreras', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Higueras', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Hualahuises', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Iturbide', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Juárez', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Lampazos de Naranjo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Linares', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Marín', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Melchor Ocampo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Mier y Noriega', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Mina', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Montemorelos', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Monterrey', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Parás', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Pesquería', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Los Ramones', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Rayones', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Sabinas Hidalgo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Salinas Victoria', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'San Nicolás de los Garza', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Hidalgo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Santa Catarina', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Santiago', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Vallecillo', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Villaldama', 'NL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Abejones', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acatlán de Pérez Figueroa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Asunción Cacalotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Asunción Cuyotepeji', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Asunción Ixtaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Asunción Nochixtlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Asunción Ocotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Asunción Tlacolulita', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Ayotzintepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'El Barrio de la Soledad', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Calihualá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Candelaria Loxicha', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Ciénega de Zimatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Ciudad Ixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Coatecas Altas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Coicoyán de las Flores', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'La Compañía', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Concepción Buenavista', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Concepción Pápalo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Constancia del Rosario', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Cosolapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Cosoltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Cuilápam de Guerrero', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Cuyamecalco Villa de Zaragoza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Chahuites', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Chalcatongo de Hidalgo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Chiquihuitlán de Benito Juárez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Heroica Ciudad de Ejutla de Crespo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Eloxochitlán de Flores Magón', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'El Espinal', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Tamazulápam del Espíritu Santo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Fresnillo de Trujano', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Guadalupe Etla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Guadalupe de Ramírez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Guelatao de Juárez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Guevea de Humboldt', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Mesones Hidalgo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Villa Hidalgo Yalálag', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Heroica Ciudad de Huajuapan de León', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Huautepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Huautla de Jiménez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Ixtlán de Juárez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Juchitán de Zaragoza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Loma Bonita', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Magdalena Apasco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Magdalena Jaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Santa Magdalena Jicotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Magdalena Mixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Magdalena Ocotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Magdalena Peñasco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Magdalena Teitipac', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Magdalena Tequisistlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Magdalena Tlacotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Magdalena Zahuatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Mariscala de Juárez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Mártires de Tacubaya', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Matías Romero Avendaño', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Mazatlán Villa de Flores', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Miahuatlán de Porfirio Díaz', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Mixistlán de la Reforma', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Monjas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Natividad', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Nazareno Etla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Nejapa de Madero', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Ixpantepec Nieves', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Santiago Niltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Oaxaca de Juárez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Ocotlán de Morelos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'La Pe', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'Pinotepa de Don Luis', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Pluma Hidalgo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'San José del Progreso', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Putla Villa de Guerrero', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Santa Catarina Quioquitani', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Reforma de Pineda', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'La Reforma', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'Reyes Etla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Rojas de Cuauhtémoc', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Salina Cruz', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'San Agustín Amatengo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'San Agustín Atenango', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'San Agustín Chayuco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'San Agustín de las Juntas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'San Agustín Etla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'San Agustín Loxicha', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'San Agustín Tlacotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'San Agustín Yatareni', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'San Andrés Cabecera Nueva', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'San Andrés Dinicuiti', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'San Andrés Huaxpaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'San Andrés Huayápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'San Andrés Ixtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'San Andrés Lagunas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'San Andrés Nuxiño', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('095', 'San Andrés Paxtlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'San Andrés Sinaxtla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'San Andrés Solaga', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'San Andrés Teotilálpam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'San Andrés Tepetlapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'San Andrés Yaá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'San Andrés Zabache', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'San Andrés Zautla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'San Antonino Castillo Velasco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'San Antonino el Alto', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'San Antonino Monte Verde', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'San Antonio Acutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('107', 'San Antonio de la Cal', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('108', 'San Antonio Huitepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('109', 'San Antonio Nanahuatípam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('110', 'San Antonio Sinicahua', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('111', 'San Antonio Tepetlapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('112', 'San Baltazar Chichicápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('113', 'San Baltazar Loxicha', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('114', 'San Baltazar Yatzachi el Bajo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('115', 'San Bartolo Coyotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('116', 'San Bartolomé Ayautla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('117', 'San Bartolomé Loxicha', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('118', 'San Bartolomé Quialana', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('119', 'San Bartolomé Yucuañe', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('120', 'San Bartolomé Zoogocho', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('121', 'San Bartolo Soyaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('122', 'San Bartolo Yautepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('123', 'San Bernardo Mixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('124', 'Heroica Villa de San Blas Atempa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('125', 'San Carlos Yautepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('126', 'San Cristóbal Amatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('127', 'San Cristóbal Amoltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('128', 'San Cristóbal Lachirioag', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('129', 'San Cristóbal Suchixtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('130', 'San Dionisio del Mar', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('131', 'San Dionisio Ocotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('132', 'San Dionisio Ocotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('133', 'San Esteban Atatlahuca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('134', 'San Felipe Jalapa de Díaz', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('135', 'San Felipe Tejalápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('136', 'San Felipe Usila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('137', 'San Francisco Cahuacuá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('138', 'San Francisco Cajonos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('139', 'San Francisco Chapulapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('140', 'San Francisco Chindúa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('141', 'San Francisco del Mar', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('142', 'San Francisco Huehuetlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('143', 'San Francisco Ixhuatán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('144', 'San Francisco Jaltepetongo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('145', 'San Francisco Lachigoló', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('146', 'San Francisco Logueche', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('147', 'San Francisco Nuxaño', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('148', 'San Francisco Ozolotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('149', 'San Francisco Sola', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('150', 'San Francisco Telixtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('151', 'San Francisco Teopan', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('152', 'San Francisco Tlapancingo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('153', 'San Gabriel Mixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('154', 'San Ildefonso Amatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('155', 'San Ildefonso Sola', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('156', 'San Ildefonso Villa Alta', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('157', 'San Jacinto Amilpas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('158', 'San Jacinto Tlacotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('159', 'San Jerónimo Coatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('160', 'San Jerónimo Silacayoapilla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('161', 'San Jerónimo Sosola', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('162', 'San Jerónimo Taviche', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('163', 'San Jerónimo Tecóatl', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('164', 'San Jorge Nuchita', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('165', 'San José Ayuquila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('166', 'San José Chiltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('167', 'San José del Peñasco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('168', 'San José Estancia Grande', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('169', 'San José Independencia', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('170', 'San José Lachiguiri', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('171', 'San José Tenango', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('172', 'San Juan Achiutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('173', 'San Juan Atepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('174', 'Ánimas Trujano', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('175', 'San Juan Bautista Atatlahuca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('176', 'San Juan Bautista Coixtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('177', 'San Juan Bautista Cuicatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('178', 'San Juan Bautista Guelache', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('179', 'San Juan Bautista Jayacatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('180', 'San Juan Bautista Lo de Soto', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('181', 'San Juan Bautista Suchitepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('182', 'San Juan Bautista Tlacoatzintepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('183', 'San Juan Bautista Tlachichilco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('184', 'San Juan Bautista Tuxtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('185', 'San Juan Cacahuatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('186', 'San Juan Cieneguilla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('187', 'San Juan Coatzóspam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('188', 'San Juan Colorado', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('189', 'San Juan Comaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('190', 'San Juan Cotzocón', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('191', 'San Juan Chicomezúchil', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('192', 'San Juan Chilateca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('193', 'San Juan del Estado', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('194', 'San Juan del Río', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('195', 'San Juan Diuxi', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('196', 'San Juan Evangelista Analco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('197', 'San Juan Guelavía', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('198', 'San Juan Guichicovi', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('199', 'San Juan Ihualtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('200', 'San Juan Juquila Mixes', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('201', 'San Juan Juquila Vijanos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('202', 'San Juan Lachao', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('203', 'San Juan Lachigalla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('204', 'San Juan Lajarcia', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('205', 'San Juan Lalana', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('206', 'San Juan de los Cués', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('207', 'San Juan Mazatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('208', 'San Juan Mixtepec -Dto. 08 -', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('209', 'San Juan Mixtepec -Dto. 26 -', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('210', 'San Juan Ñumí', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('211', 'San Juan Ozolotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('212', 'San Juan Petlapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('213', 'San Juan Quiahije', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('214', 'San Juan Quiotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('215', 'San Juan Sayultepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('216', 'San Juan Tabaá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('217', 'San Juan Tamazola', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('218', 'San Juan Teita', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('219', 'San Juan Teitipac', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('220', 'San Juan Tepeuxila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('221', 'San Juan Teposcolula', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('222', 'San Juan Yaeé', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('223', 'San Juan Yatzona', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('224', 'San Juan Yucuita', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('225', 'San Lorenzo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('226', 'San Lorenzo Albarradas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('227', 'San Lorenzo Cacaotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('228', 'San Lorenzo Cuaunecuiltitla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('229', 'San Lorenzo Texmelúcan', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('230', 'San Lorenzo Victoria', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('231', 'San Lucas Camotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('232', 'San Lucas Ojitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('233', 'San Lucas Quiaviní', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('234', 'San Lucas Zoquiápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('235', 'San Luis Amatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('236', 'San Marcial Ozolotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('237', 'San Marcos Arteaga', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('238', 'San Martín de los Cansecos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('239', 'San Martín Huamelúlpam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('240', 'San Martín Itunyoso', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('241', 'San Martín Lachilá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('242', 'San Martín Peras', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('243', 'San Martín Tilcajete', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('244', 'San Martín Toxpalan', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('245', 'San Martín Zacatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('246', 'San Mateo Cajonos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('247', 'Capulálpam de Méndez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('248', 'San Mateo del Mar', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('249', 'San Mateo Yoloxochitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('250', 'San Mateo Etlatongo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('251', 'San Mateo Nejápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('252', 'San Mateo Peñasco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('253', 'San Mateo Piñas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('254', 'San Mateo Río Hondo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('255', 'San Mateo Sindihui', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('256', 'San Mateo Tlapiltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('257', 'San Melchor Betaza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('258', 'San Miguel Achiutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('259', 'San Miguel Ahuehuetitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('260', 'San Miguel Aloápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('261', 'San Miguel Amatitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('262', 'San Miguel Amatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('263', 'San Miguel Coatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('264', 'San Miguel Chicahua', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('265', 'San Miguel Chimalapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('266', 'San Miguel del Puerto', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('267', 'San Miguel del Río', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('268', 'San Miguel Ejutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('269', 'San Miguel el Grande', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('270', 'San Miguel Huautla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('271', 'San Miguel Mixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('272', 'San Miguel Panixtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('273', 'San Miguel Peras', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('274', 'San Miguel Piedras', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('275', 'San Miguel Quetzaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('276', 'San Miguel Santa Flor', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('277', 'Villa Sola de Vega', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('278', 'San Miguel Soyaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('279', 'San Miguel Suchixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('280', 'Villa Talea de Castro', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('281', 'San Miguel Tecomatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('282', 'San Miguel Tenango', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('283', 'San Miguel Tequixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('284', 'San Miguel Tilquiápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('285', 'San Miguel Tlacamama', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('286', 'San Miguel Tlacotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('287', 'San Miguel Tulancingo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('288', 'San Miguel Yotao', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('289', 'San Nicolás', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('290', 'San Nicolás Hidalgo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('291', 'San Pablo Coatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('292', 'San Pablo Cuatro Venados', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('293', 'San Pablo Etla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('294', 'San Pablo Huitzo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('295', 'San Pablo Huixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('296', 'San Pablo Macuiltianguis', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('297', 'San Pablo Tijaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('298', 'San Pablo Villa de Mitla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('299', 'San Pablo Yaganiza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('300', 'San Pedro Amuzgos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('301', 'San Pedro Apóstol', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('302', 'San Pedro Atoyac', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('303', 'San Pedro Cajonos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('304', 'San Pedro Coxcaltepec Cántaros', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('305', 'San Pedro Comitancillo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('306', 'San Pedro el Alto', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('307', 'San Pedro Huamelula', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('308', 'San Pedro Huilotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('309', 'San Pedro Ixcatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('310', 'San Pedro Ixtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('311', 'San Pedro Jaltepetongo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('312', 'San Pedro Jicayán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('313', 'San Pedro Jocotipac', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('314', 'San Pedro Juchatengo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('315', 'San Pedro Mártir', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('316', 'San Pedro Mártir Quiechapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('317', 'San Pedro Mártir Yucuxaco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('318', 'San Pedro Mixtepec -Dto. 22 -', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('319', 'San Pedro Mixtepec -Dto. 26 -', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('320', 'San Pedro Molinos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('321', 'San Pedro Nopala', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('322', 'San Pedro Ocopetatillo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('323', 'San Pedro Ocotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('324', 'San Pedro Pochutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('325', 'San Pedro Quiatoni', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('326', 'San Pedro Sochiápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('327', 'San Pedro Tapanatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('328', 'San Pedro Taviche', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('329', 'San Pedro Teozacoalco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('330', 'San Pedro Teutila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('331', 'San Pedro Tidaá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('332', 'San Pedro Topiltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('333', 'San Pedro Totolápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('334', 'Villa de Tututepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('335', 'San Pedro Yaneri', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('336', 'San Pedro Yólox', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('337', 'San Pedro y San Pablo Ayutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('338', 'Villa de Etla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('339', 'San Pedro y San Pablo Teposcolula', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('340', 'San Pedro y San Pablo Tequixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('341', 'San Pedro Yucunama', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('342', 'San Raymundo Jalpan', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('343', 'San Sebastián Abasolo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('344', 'San Sebastián Coatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('345', 'San Sebastián Ixcapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('346', 'San Sebastián Nicananduta', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('347', 'San Sebastián Río Hondo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('348', 'San Sebastián Tecomaxtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('349', 'San Sebastián Teitipac', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('350', 'San Sebastián Tutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('351', 'San Simón Almolongas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('352', 'San Simón Zahuatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('353', 'Santa Ana', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('354', 'Santa Ana Ateixtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('355', 'Santa Ana Cuauhtémoc', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('356', 'Santa Ana del Valle', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('357', 'Santa Ana Tavela', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('358', 'Santa Ana Tlapacoyan', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('359', 'Santa Ana Yareni', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('360', 'Santa Ana Zegache', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('361', 'Santa Catalina Quierí', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('362', 'Santa Catarina Cuixtla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('363', 'Santa Catarina Ixtepeji', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('364', 'Santa Catarina Juquila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('365', 'Santa Catarina Lachatao', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('366', 'Santa Catarina Loxicha', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('367', 'Santa Catarina Mechoacán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('368', 'Santa Catarina Minas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('369', 'Santa Catarina Quiané', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('370', 'Santa Catarina Tayata', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('371', 'Santa Catarina Ticuá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('372', 'Santa Catarina Yosonotú', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('373', 'Santa Catarina Zapoquila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('374', 'Santa Cruz Acatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('375', 'Santa Cruz Amilpas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('376', 'Santa Cruz de Bravo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('377', 'Santa Cruz Itundujia', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('378', 'Santa Cruz Mixtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('379', 'Santa Cruz Nundaco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('380', 'Santa Cruz Papalutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('381', 'Santa Cruz Tacache de Mina', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('382', 'Santa Cruz Tacahua', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('383', 'Santa Cruz Tayata', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('384', 'Santa Cruz Xitla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('385', 'Santa Cruz Xoxocotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('386', 'Santa Cruz Zenzontepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('387', 'Santa Gertrudis', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('388', 'Santa Inés del Monte', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('389', 'Santa Inés Yatzeche', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('390', 'Santa Lucía del Camino', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('391', 'Santa Lucía Miahuatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('392', 'Santa Lucía Monteverde', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('393', 'Santa Lucía Ocotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('394', 'Santa María Alotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('395', 'Santa María Apazco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('396', 'Santa María la Asunción', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('397', 'Heroica Ciudad de Tlaxiaco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('398', 'Ayoquezco de Aldama', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('399', 'Santa María Atzompa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('400', 'Santa María Camotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('401', 'Santa María Colotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('402', 'Santa María Cortijo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('403', 'Santa María Coyotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('404', 'Santa María Chachoápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('405', 'Villa de Chilapa de Díaz', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('406', 'Santa María Chilchotla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('407', 'Santa María Chimalapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('408', 'Santa María del Rosario', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('409', 'Santa María del Tule', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('410', 'Santa María Ecatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('411', 'Santa María Guelacé', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('412', 'Santa María Guienagati', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('413', 'Santa María Huatulco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('414', 'Santa María Huazolotitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('415', 'Santa María Ipalapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('416', 'Santa María Ixcatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('417', 'Santa María Jacatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('418', 'Santa María Jalapa del Marqués', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('419', 'Santa María Jaltianguis', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('420', 'Santa María Lachixío', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('421', 'Santa María Mixtequilla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('422', 'Santa María Nativitas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('423', 'Santa María Nduayaco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('424', 'Santa María Ozolotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('425', 'Santa María Pápalo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('426', 'Santa María Peñoles', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('427', 'Santa María Petapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('428', 'Santa María Quiegolani', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('429', 'Santa María Sola', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('430', 'Santa María Tataltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('431', 'Santa María Tecomavaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('432', 'Santa María Temaxcalapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('433', 'Santa María Temaxcaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('434', 'Santa María Teopoxco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('435', 'Santa María Tepantlali', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('436', 'Santa María Texcatitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('437', 'Santa María Tlahuitoltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('438', 'Santa María Tlalixtac', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('439', 'Santa María Tonameca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('440', 'Santa María Totolapilla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('441', 'Santa María Xadani', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('442', 'Santa María Yalina', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('443', 'Santa María Yavesía', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('444', 'Santa María Yolotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('445', 'Santa María Yosoyúa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('446', 'Santa María Yucuhiti', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('447', 'Santa María Zacatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('448', 'Santa María Zaniza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('449', 'Santa María Zoquitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('450', 'Santiago Amoltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('451', 'Santiago Apoala', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('452', 'Santiago Apóstol', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('453', 'Santiago Astata', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('454', 'Santiago Atitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('455', 'Santiago Ayuquililla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('456', 'Santiago Cacaloxtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('457', 'Santiago Camotlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('458', 'Santiago Comaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('459', 'Villa de Santiago Chazumba', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('460', 'Santiago Choápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('461', 'Santiago del Río', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('462', 'Santiago Huajolotitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('463', 'Santiago Huauclilla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('464', 'Santiago Ihuitlán Plumas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('465', 'Santiago Ixcuintepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('466', 'Santiago Ixtayutla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('467', 'Santiago Jamiltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('468', 'Santiago Jocotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('469', 'Santiago Juxtlahuaca', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('470', 'Santiago Lachiguiri', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('471', 'Santiago Lalopa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('472', 'Santiago Laollaga', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('473', 'Santiago Laxopa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('474', 'Santiago Llano Grande', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('475', 'Santiago Matatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('476', 'Santiago Miltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('477', 'Santiago Minas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('478', 'Santiago Nacaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('479', 'Santiago Nejapilla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('480', 'Santiago Nundiche', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('481', 'Santiago Nuyoó', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('482', 'Santiago Pinotepa Nacional', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('483', 'Santiago Suchilquitongo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('484', 'Santiago Tamazola', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('485', 'Santiago Tapextla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('486', 'Villa Tejúpam de la Unión', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('487', 'Santiago Tenango', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('488', 'Santiago Tepetlapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('489', 'Santiago Tetepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('490', 'Santiago Texcalcingo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('491', 'Santiago Textitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('492', 'Santiago Tilantongo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('493', 'Santiago Tillo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('494', 'Santiago Tlazoyaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('495', 'Santiago Xanica', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('496', 'Santiago Xiacuí', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('497', 'Santiago Yaitepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('498', 'Santiago Yaveo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('499', 'Santiago Yolomécatl', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('500', 'Santiago Yosondúa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('501', 'Santiago Yucuyachi', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('502', 'Santiago Zacatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('503', 'Santiago Zoochila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('504', 'Nuevo Zoquiápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('505', 'Santo Domingo Ingenio', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('506', 'Santo Domingo Albarradas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('507', 'Santo Domingo Armenta', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('508', 'Santo Domingo Chihuitán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('509', 'Santo Domingo de Morelos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('510', 'Santo Domingo Ixcatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('511', 'Santo Domingo Nuxaá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('512', 'Santo Domingo Ozolotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('513', 'Santo Domingo Petapa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('514', 'Santo Domingo Roayaga', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('515', 'Santo Domingo Tehuantepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('516', 'Santo Domingo Teojomulco', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('517', 'Santo Domingo Tepuxtepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('518', 'Santo Domingo Tlatayápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('519', 'Santo Domingo Tomaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('520', 'Santo Domingo Tonalá', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('521', 'Santo Domingo Tonaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('522', 'Santo Domingo Xagacía', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('523', 'Santo Domingo Yanhuitlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('524', 'Santo Domingo Yodohino', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('525', 'Santo Domingo Zanatepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('526', 'Santos Reyes Nopala', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('527', 'Santos Reyes Pápalo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('528', 'Santos Reyes Tepejillo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('529', 'Santos Reyes Yucuná', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('530', 'Santo Tomás Jalieza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('531', 'Santo Tomás Mazaltepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('532', 'Santo Tomás Ocotepec', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('533', 'Santo Tomás Tamazulapan', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('534', 'San Vicente Coatlán', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('535', 'San Vicente Lachixío', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('536', 'San Vicente Nuñú', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('537', 'Silacayoápam', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('538', 'Sitio de Xitlapehua', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('539', 'Soledad Etla', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('540', 'Villa de Tamazulápam del Progreso', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('541', 'Tanetze de Zaragoza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('542', 'Taniche', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('543', 'Tataltepec de Valdés', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('544', 'Teococuilco de Marcos Pérez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('545', 'Teotitlán de Flores Magón', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('546', 'Teotitlán del Valle', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('547', 'Teotongo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('548', 'Tepelmeme Villa de Morelos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('549', 'Tezoatlán de Segura y Luna', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('550', 'San Jerónimo Tlacochahuaya', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('551', 'Tlacolula de Matamoros', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('552', 'Tlacotepec Plumas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('553', 'Tlalixtac de Cabrera', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('554', 'Totontepec Villa de Morelos', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('555', 'Trinidad Zaachila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('556', 'La Trinidad Vista Hermosa', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('557', 'Unión Hidalgo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('558', 'Valerio Trujano', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('559', 'San Juan Bautista Valle Nacional', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('560', 'Villa Díaz Ordaz', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('561', 'Yaxe', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('562', 'Magdalena Yodocono de Porfirio Díaz', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('563', 'Yogana', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('564', 'Yutanduchi de Guerrero', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('565', 'Villa de Zaachila', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('566', 'San Mateo Yucutindoo', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('567', 'Zapotitlán Lagunas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('568', 'Zapotitlán Palmas', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('569', 'Santa Inés de Zaragoza', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('570', 'Zimatlán de Álvarez', 'OA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acajete', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acateno', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Acatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Acatzingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Acteopan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Ahuacatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Ahuatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Ahuazotepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Ahuehuetitla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Ajalpan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Albino Zertuche', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Aljojuca', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Altepexi', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Amixtlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Amozoc', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Aquixtla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Atempan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Atexcal', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Atlixco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Atoyatempan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Atzala', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Atzitzihuacán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Atzitzintla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Axutla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Ayotoxco de Guerrero', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Calpan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Caltepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Camocuautla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Caxhuacan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Coatepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Coatzingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Cohetzala', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Cohuecan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Coronango', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Coxcatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Coyomeapan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Coyotepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Cuapiaxtla de Madero', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Cuautempan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Cuautinchán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Cuautlancingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Cuayuca de Andrade', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Cuetzalan del Progreso', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Cuyoaco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Chalchicomula de Sesma', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Chapulco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Chiautla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Chiautzingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Chiconcuautla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Chichiquila', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Chietla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Chigmecatitlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Chignahuapan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Chignautla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Chila', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Chila de la Sal', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Honey', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Chilchotla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Chinantla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Domingo Arenas', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Eloxochitlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Epatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Esperanza', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Francisco Z. Mena', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'General Felipe Ángeles', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Guadalupe', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Guadalupe Victoria', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Hermenegildo Galeana', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Huaquechula', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'Huatlatlauca', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Huauchinango', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Huehuetla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Huehuetlán el Chico', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Huejotzingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Hueyapan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'Hueytamalco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'Hueytlalpan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Huitzilan de Serdán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Huitziltepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Atlequizayan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Ixcamilpa de Guerrero', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Ixcaquixtla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Ixtacamaxtitlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Ixtepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'Izúcar de Matamoros', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'Jalpan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'Jolalpan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'Jonotla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'Jopala', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'Juan C. Bonilla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'Juan Galindo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'Juan N. Méndez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'Lafragua', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'Libres', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('095', 'La Magdalena Tlatlauquitepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'Mazapiltepec de Juárez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'Mixtla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'Molcaxac', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'Cañada Morelos', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'Naupan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'Nauzontla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'Nealtican', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'Nicolás Bravo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'Nopalucan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'Ocotepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'Ocoyucan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('107', 'Olintla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('108', 'Oriental', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('109', 'Pahuatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('110', 'Palmar de Bravo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('111', 'Pantepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('112', 'Petlalcingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('113', 'Piaxtla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('114', 'Puebla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('115', 'Quecholac', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('116', 'Quimixtlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('117', 'Rafael Lara Grajales', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('118', 'Los Reyes de Juárez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('119', 'San Andrés Cholula', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('120', 'San Antonio Cañada', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('121', 'San Diego la Mesa Tochimiltzingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('122', 'San Felipe Teotlalcingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('123', 'San Felipe Tepatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('124', 'San Gabriel Chilac', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('125', 'San Gregorio Atzompa', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('126', 'San Jerónimo Tecuanipan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('127', 'San Jerónimo Xayacatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('128', 'San José Chiapa', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('129', 'San José Miahuatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('130', 'San Juan Atenco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('131', 'San Juan Atzompa', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('132', 'San Martín Texmelucan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('133', 'San Martín Totoltepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('134', 'San Matías Tlalancaleca', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('135', 'San Miguel Ixitlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('136', 'San Miguel Xoxtla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('137', 'San Nicolás Buenos Aires', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('138', 'San Nicolás de los Ranchos', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('139', 'San Pablo Anicano', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('140', 'San Pedro Cholula', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('141', 'San Pedro Yeloixtlahuaca', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('142', 'San Salvador el Seco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('143', 'San Salvador el Verde', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('144', 'San Salvador Huixcolotla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('145', 'San Sebastián Tlacotepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('146', 'Santa Catarina Tlaltempan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('147', 'Santa Inés Ahuatempan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('148', 'Santa Isabel Cholula', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('149', 'Santiago Miahuatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('150', 'Huehuetlán el Grande', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('151', 'Santo Tomás Hueyotlipan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('152', 'Soltepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('153', 'Tecali de Herrera', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('154', 'Tecamachalco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('155', 'Tecomatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('156', 'Tehuacán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('157', 'Tehuitzingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('158', 'Tenampulco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('159', 'Teopantlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('160', 'Teotlalco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('161', 'Tepanco de López', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('162', 'Tepango de Rodríguez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('163', 'Tepatlaxco de Hidalgo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('164', 'Tepeaca', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('165', 'Tepemaxalco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('166', 'Tepeojuma', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('167', 'Tepetzintla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('168', 'Tepexco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('169', 'Tepexi de Rodríguez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('170', 'Tepeyahualco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('171', 'Tepeyahualco de Cuauhtémoc', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('172', 'Tetela de Ocampo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('173', 'Teteles de Ávila Castillo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('174', 'Teziutlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('175', 'Tianguismanalco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('176', 'Tilapa', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('177', 'Tlacotepec de Benito Juárez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('178', 'Tlacuilotepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('179', 'Tlachichuca', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('180', 'Tlahuapan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('181', 'Tlaltenango', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('182', 'Tlanepantla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('183', 'Tlaola', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('184', 'Tlapacoya', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('185', 'Tlapanalá', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('186', 'Tlatlauquitepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('187', 'Tlaxco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('188', 'Tochimilco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('189', 'Tochtepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('190', 'Totoltepec de Guerrero', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('191', 'Tulcingo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('192', 'Tuzamapan de Galeana', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('193', 'Tzicatlacoyan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('194', 'Venustiano Carranza', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('195', 'Vicente Guerrero', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('196', 'Xayacatlán de Bravo', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('197', 'Xicotepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('198', 'Xicotlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('199', 'Xiutetelco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('200', 'Xochiapulco', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('201', 'Xochiltepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('202', 'Xochitlán de Vicente Suárez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('203', 'Xochitlán Todos Santos', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('204', 'Yaonáhuac', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('205', 'Yehualtepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('206', 'Zacapala', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('207', 'Zacapoaxtla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('208', 'Zacatlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('209', 'Zapotitlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('210', 'Zapotitlán de Méndez', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('211', 'Zaragoza', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('212', 'Zautla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('213', 'Zihuateutla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('214', 'Zinacatepec', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('215', 'Zongozotla', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('216', 'Zoquiapan', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('217', 'Zoquitlán', 'PU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Amealco de Bonfil', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Pinal de Amoles', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Arroyo Seco', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Cadereyta de Montes', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Colón', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Corregidora', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Ezequiel Montes', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Huimilpan', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Jalpan de Serra', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Landa de Matamoros', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'El Marqués', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Pedro Escobedo', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Peñamiller', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Querétaro', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'San Joaquín', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'San Juan del Río', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Tequisquiapan', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Tolimán', 'QT', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Cozumel', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Felipe Carrillo Puerto', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Isla Mujeres', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Othón P. Blanco', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Benito Juárez', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'José María Morelos', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Lázaro Cárdenas', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Solidaridad', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Tulum', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Bacalar', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Puerto Morelos', 'QR', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Ahualulco del Sonido 13', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Alaquines', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Aquismón', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Armadillo de los Infante', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Cárdenas', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Catorce', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Cedral', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Cerritos', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Cerro de San Pedro', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Ciudad del Maíz', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Ciudad Fernández', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Tancanhuitz', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Ciudad Valles', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Coxcatlán', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Charcas', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Ebano', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Guadalcázar', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Huehuetlán', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Lagunillas', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Matehuala', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Mexquitic de Carmona', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Moctezuma', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Rayón', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Rioverde', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Salinas', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'San Antonio', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'San Ciro de Acosta', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'San Luis Potosí', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'San Martín Chalchicuautla', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'San Nicolás Tolentino', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Santa Catarina', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Santa María del Río', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Santo Domingo', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'San Vicente Tancuayalab', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Soledad de Graciano Sánchez', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Tamasopo', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Tamazunchale', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Tampacán', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Tampamolón Corona', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Tamuín', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Tanlajás', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Tanquián de Escobedo', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Tierra Nueva', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Vanegas', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Venado', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Villa de Arriaga', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Villa de Guadalupe', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Villa de la Paz', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Villa de Ramos', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Villa de Reyes', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Villa Hidalgo', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Villa Juárez', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Axtla de Terrazas', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Xilitla', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Zaragoza', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Villa de Arista', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Matlapa', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'El Naranjo', 'SL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Ahome', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Angostura', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Badiraguato', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Concordia', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Cosalá', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Culiacán', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Choix', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Elota', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Escuinapa', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'El Fuerte', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Guasave', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Mazatlán', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Mocorito', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Rosario', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Salvador Alvarado', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'San Ignacio', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Sinaloa', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Navolato', 'SI', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Aconchi', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Agua Prieta', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Álamos', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Altar', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Arivechi', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Arizpe', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Atil', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Bacadéhuachi', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Bacanora', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Bacerac', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Bacoachi', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Bácum', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Banámichi', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Baviácora', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Bavispe', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Benjamín Hill', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Caborca', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Cajeme', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Cananea', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Carbó', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'La Colorada', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Cucurpe', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Cumpas', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Divisaderos', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Empalme', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Etchojoa', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Fronteras', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Granados', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Guaymas', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Hermosillo', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Huachinera', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Huásabas', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Huatabampo', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Huépac', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Imuris', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Magdalena', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Mazatán', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Moctezuma', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Naco', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Nácori Chico', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Nacozari de García', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Navojoa', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Nogales', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Ónavas', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Opodepe', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Oquitoa', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Pitiquito', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Puerto Peñasco', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Quiriego', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Rayón', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Rosario', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Sahuaripa', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'San Felipe de Jesús', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'San Javier', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'San Luis Río Colorado', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'San Miguel de Horcasitas', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'San Pedro de la Cueva', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Santa Ana', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Santa Cruz', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Sáric', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Soyopa', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Suaqui Grande', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Tepache', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Trincheras', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Tubutama', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Ures', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Villa Hidalgo', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Villa Pesqueira', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Yécora', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'General Plutarco Elías Calles', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Benito Juárez', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'San Ignacio Río Muerto', 'SO', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Balancán', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Cárdenas', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Centla', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Centro', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Comalcalco', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Cunduacán', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Emiliano Zapata', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Huimanguillo', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Jalapa', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Jalpa de Méndez', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Jonuta', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Macuspana', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Nacajuca', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Paraíso', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Tacotalpa', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Teapa', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Tenosique', 'TB', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Abasolo', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Aldama', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Altamira', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Antiguo Morelos', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Burgos', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Bustamante', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Camargo', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Casas', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Ciudad Madero', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Cruillas', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Gómez Farías', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'González', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Güémez', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Guerrero', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Gustavo Díaz Ordaz', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Hidalgo', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Jaumave', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Jiménez', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Llera', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Mainero', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'El Mante', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Matamoros', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Méndez', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Mier', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Miguel Alemán', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Miquihuana', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Nuevo Laredo', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Nuevo Morelos', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Ocampo', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Padilla', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Palmillas', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Reynosa', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Río Bravo', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'San Carlos', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'San Fernando', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'San Nicolás', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Soto la Marina', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Tampico', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Tula', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Valle Hermoso', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Victoria', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Villagrán', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Xicoténcatl', 'TM', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Amaxac de Guerrero', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Apetatitlán de Antonio Carvajal', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Atlangatepec', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Atltzayanca', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Apizaco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Calpulalpan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'El Carmen Tequexquitla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Cuapiaxtla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Cuaxomulco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Chiautempan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Muñoz de Domingo Arenas', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Españita', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Huamantla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Hueyotlipan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Ixtacuixtla de Mariano Matamoros', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Ixtenco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Mazatecochco de José María Morelos', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Contla de Juan Cuamatzi', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Tepetitla de Lardizábal', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Sanctórum de Lázaro Cárdenas', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Nanacamilpa de Mariano Arista', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Acuamanala de Miguel Hidalgo', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Natívitas', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Panotla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'San Pablo del Monte', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Santa Cruz Tlaxcala', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Tenancingo', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Teolocholco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Tepeyanco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Terrenate', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Tetla de la Solidaridad', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Tetlatlahuca', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Tlaxcala', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Tlaxco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Tocatlán', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Totolac', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Ziltlaltépec de Trinidad Sánchez Santos', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Tzompantepec', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Xaloztoc', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Xaltocan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Papalotla de Xicohténcatl', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Xicohtzinco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Yauhquemehcan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Zacatelco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Benito Juárez', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Emiliano Zapata', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Lázaro Cárdenas', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'La Magdalena Tlaltelulco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'San Damián Texóloc', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'San Francisco Tetlanohcan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'San Jerónimo Zacualpan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'San José Teacalco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'San Juan Huactzinco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'San Lorenzo Axocomanitla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'San Lucas Tecopilco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Santa Ana Nopalucan', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Santa Apolonia Teacalco', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Santa Catarina Ayometla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Santa Cruz Quilehtla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Santa Isabel Xiloxoxtla', 'TL', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Acajete', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Acayucan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Actopan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Acula', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Acultzingo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Camarón de Tejeda', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Alpatláhuac', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Alto Lucero de Gutiérrez Barrios', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Altotonga', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Alvarado', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Amatitlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Naranjos Amatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Amatlán de los Reyes', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Angel R. Cabada', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'La Antigua', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Apazapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Aquila', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Astacinga', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Atlahuilco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Atoyac', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Atzacan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Atzalan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Tlaltetela', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Ayahualulco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Banderilla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Benito Juárez', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Boca del Río', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Calcahualco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Camerino Z. Mendoza', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Carrillo Puerto', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Catemaco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Cazones de Herrera', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Cerro Azul', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Citlaltépetl', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Coacoatzintla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Coahuitlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Coatepec', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Coatzacoalcos', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Coatzintla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Coetzala', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Colipa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Comapa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Córdoba', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Cosamaloapan de Carpio', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Cosautlán de Carvajal', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Coscomatepec', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Cosoleacaque', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Cotaxtla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Coxquihui', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Coyutla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Cuichapa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Cuitláhuac', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Chacaltianguis', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Chalma', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Chiconamel', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Chiconquiaco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Chicontepec', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Chinameca', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Chinampa de Gorostiza', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Las Choapas', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Chocamán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Chontla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Chumatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'Emiliano Zapata', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Espinal', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Filomeno Mata', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Fortín', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Gutiérrez Zamora', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'Hidalgotitlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Huatusco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Huayacocotla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Hueyapan de Ocampo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Huiloapan de Cuauhtémoc', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Ignacio de la Llave', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'Ilamatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'Isla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Ixcatepec', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Ixhuacán de los Reyes', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Ixhuatlán del Café', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Ixhuatlancillo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Ixhuatlán del Sureste', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Ixhuatlán de Madero', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Ixmatlahuacan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'Ixtaczoquitlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'Jalacingo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'Xalapa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'Jalcomulco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'Jáltipan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'Jamapa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'Jesús Carranza', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'Xico', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'Jilotepec', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'Juan Rodríguez Clara', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('095', 'Juchique de Ferrer', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'Landero y Coss', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'Lerdo de Tejada', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'Magdalena', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'Maltrata', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'Manlio Fabio Altamirano', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'Mariano Escobedo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'Martínez de la Torre', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'Mecatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'Mecayapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'Medellín de Bravo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'Miahuatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('107', 'Las Minas', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('108', 'Minatitlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('109', 'Misantla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('110', 'Mixtla de Altamirano', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('111', 'Moloacán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('112', 'Naolinco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('113', 'Naranjal', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('114', 'Nautla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('115', 'Nogales', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('116', 'Oluta', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('117', 'Omealca', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('118', 'Orizaba', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('119', 'Otatitlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('120', 'Oteapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('121', 'Ozuluama de Mascareñas', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('122', 'Pajapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('123', 'Pánuco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('124', 'Papantla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('125', 'Paso del Macho', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('126', 'Paso de Ovejas', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('127', 'La Perla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('128', 'Perote', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('129', 'Platón Sánchez', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('130', 'Playa Vicente', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('131', 'Poza Rica de Hidalgo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('132', 'Las Vigas de Ramírez', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('133', 'Pueblo Viejo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('134', 'Puente Nacional', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('135', 'Rafael Delgado', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('136', 'Rafael Lucio', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('137', 'Los Reyes', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('138', 'Río Blanco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('139', 'Saltabarranca', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('140', 'San Andrés Tenejapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('141', 'San Andrés Tuxtla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('142', 'San Juan Evangelista', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('143', 'Santiago Tuxtla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('144', 'Sayula de Alemán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('145', 'Soconusco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('146', 'Sochiapa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('147', 'Soledad Atzompa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('148', 'Soledad de Doblado', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('149', 'Soteapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('150', 'Tamalín', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('151', 'Tamiahua', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('152', 'Tampico Alto', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('153', 'Tancoco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('154', 'Tantima', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('155', 'Tantoyuca', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('156', 'Tatatila', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('157', 'Castillo de Teayo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('158', 'Tecolutla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('159', 'Tehuipango', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('160', 'Álamo Temapache', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('161', 'Tempoal', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('162', 'Tenampa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('163', 'Tenochtitlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('164', 'Teocelo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('165', 'Tepatlaxco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('166', 'Tepetlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('167', 'Tepetzintla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('168', 'Tequila', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('169', 'José Azueta', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('170', 'Texcatepec', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('171', 'Texhuacán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('172', 'Texistepec', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('173', 'Tezonapa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('174', 'Tierra Blanca', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('175', 'Tihuatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('176', 'Tlacojalpan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('177', 'Tlacolulan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('178', 'Tlacotalpan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('179', 'Tlacotepec de Mejía', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('180', 'Tlachichilco', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('181', 'Tlalixcoyan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('182', 'Tlalnelhuayocan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('183', 'Tlapacoyan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('184', 'Tlaquilpa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('185', 'Tlilapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('186', 'Tomatlán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('187', 'Tonayán', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('188', 'Totutla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('189', 'Tuxpan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('190', 'Tuxtilla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('191', 'Ursulo Galván', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('192', 'Vega de Alatorre', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('193', 'Veracruz', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('194', 'Villa Aldama', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('195', 'Xoxocotla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('196', 'Yanga', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('197', 'Yecuatla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('198', 'Zacualpan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('199', 'Zaragoza', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('200', 'Zentla', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('201', 'Zongolica', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('202', 'Zontecomatlán de López y Fuentes', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('203', 'Zozocolco de Hidalgo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('204', 'Agua Dulce', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('205', 'El Higo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('206', 'Nanchital de Lázaro Cárdenas del Río', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('207', 'Tres Valles', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('208', 'Carlos A. Carrillo', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('209', 'Tatahuicapan de Juárez', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('210', 'Uxpanapa', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('211', 'San Rafael', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('212', 'Santiago Sochiapan', 'VE', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Abalá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Acanceh', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Akil', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Baca', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Bokobá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Buctzotz', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Cacalchén', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Calotmul', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Cansahcab', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Cantamayec', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Celestún', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Cenotillo', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'Conkal', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'Cuncunul', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'Cuzamá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'Chacsinkín', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Chankom', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Chapab', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Chemax', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Chicxulub Pueblo', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Chichimilá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Chikindzonot', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Chocholá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Chumayel', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Dzan', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Dzemul', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Dzidzantún', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Dzilam de Bravo', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Dzilam González', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Dzitás', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Dzoncauich', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Espita', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Halachó', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Hocabá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Hoctún', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Homún', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Huhí', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Hunucmá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Ixil', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Izamal', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'Kanasín', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Kantunil', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Kaua', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Kinchil', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Kopomá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Mama', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Maní', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Maxcanú', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Mayapán', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Mérida', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Mocochá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Motul', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Muna', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Muxupip', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Opichén', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Oxkutzcab', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Panabá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Peto', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('059', 'Progreso', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('060', 'Quintana Roo', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('061', 'Río Lagartos', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('062', 'Sacalum', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('063', 'Samahil', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('064', 'Sanahcat', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('065', 'San Felipe', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('066', 'Santa Elena', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('067', 'Seyé', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('068', 'Sinanché', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('069', 'Sotuta', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('070', 'Sucilá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('071', 'Sudzal', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('072', 'Suma', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('073', 'Tahdziú', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('074', 'Tahmek', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('075', 'Teabo', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('076', 'Tecoh', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('077', 'Tekal de Venegas', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('078', 'Tekantó', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('079', 'Tekax', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('080', 'Tekit', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('081', 'Tekom', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('082', 'Telchac Pueblo', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('083', 'Telchac Puerto', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('084', 'Temax', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('085', 'Temozón', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('086', 'Tepakán', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('087', 'Tetiz', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('088', 'Teya', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('089', 'Ticul', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('090', 'Timucuy', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('091', 'Tinum', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('092', 'Tixcacalcupul', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('093', 'Tixkokob', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('094', 'Tixméhuac', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('095', 'Tixpéhual', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('096', 'Tizimín', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('097', 'Tunkás', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('098', 'Tzucacab', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('099', 'Uayma', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('100', 'Ucú', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('101', 'Umán', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('102', 'Valladolid', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('103', 'Xocchel', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('104', 'Yaxcabá', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('105', 'Yaxkukul', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('106', 'Yobaín', 'YU', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('001', 'Apozol', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('002', 'Apulco', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('003', 'Atolinga', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('004', 'Benito Juárez', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('005', 'Calera', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('006', 'Cañitas de Felipe Pescador', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('007', 'Concepción del Oro', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('008', 'Cuauhtémoc', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('009', 'Chalchihuites', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('010', 'Fresnillo', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('011', 'Trinidad García de la Cadena', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('012', 'Genaro Codina', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('013', 'General Enrique Estrada', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('014', 'General Francisco R. Murguía', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('015', 'El Plateado de Joaquín Amaro', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('016', 'General Pánfilo Natera', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('017', 'Guadalupe', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('018', 'Huanusco', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('019', 'Jalpa', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('020', 'Jerez', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('021', 'Jiménez del Teul', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('022', 'Juan Aldama', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('023', 'Juchipila', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('024', 'Loreto', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('025', 'Luis Moya', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('026', 'Mazapil', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('027', 'Melchor Ocampo', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('028', 'Mezquital del Oro', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('029', 'Miguel Auza', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('030', 'Momax', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('031', 'Monte Escobedo', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('032', 'Morelos', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('033', 'Moyahua de Estrada', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('034', 'Nochistlán de Mejía', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('035', 'Noria de Ángeles', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('036', 'Ojocaliente', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('037', 'Pánuco', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('038', 'Pinos', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('039', 'Río Grande', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('040', 'Sain Alto', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('041', 'El Salvador', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('042', 'Sombrerete', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('043', 'Susticacán', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('044', 'Tabasco', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('045', 'Tepechitlán', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('046', 'Tepetongo', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('047', 'Teúl de González Ortega', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('048', 'Tlaltenango de Sánchez Román', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('049', 'Valparaíso', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('050', 'Vetagrande', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('051', 'Villa de Cos', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('052', 'Villa García', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('053', 'Villa González Ortega', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('054', 'Villa Hidalgo', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('055', 'Villanueva', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('056', 'Zacatecas', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('057', 'Trancoso', 'ZA', 1);
INSERT INTO `cointrade_db`.`cities` (`cit_clave`, `cit_nombre`, `sta_iso_alpha2`, `cit_isActive`) VALUES ('058', 'Santa María de la Paz', 'ZA', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`product_group`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`product_group` (`pgrp_idGroup`, `pgrp_name`, `pgrp_description`, `pgrp_isActive`, `ptpe_idType`) VALUES (DEFAULT, 'del mundo', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_group` (`pgrp_idGroup`, `pgrp_name`, `pgrp_description`, `pgrp_isActive`, `ptpe_idType`) VALUES (DEFAULT, 'antiguas', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_group` (`pgrp_idGroup`, `pgrp_name`, `pgrp_description`, `pgrp_isActive`, `ptpe_idType`) VALUES (DEFAULT, 'de méxico', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_group` (`pgrp_idGroup`, `pgrp_name`, `pgrp_description`, `pgrp_isActive`, `ptpe_idType`) VALUES (DEFAULT, 'por metal', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_group` (`pgrp_idGroup`, `pgrp_name`, `pgrp_description`, `pgrp_isActive`, `ptpe_idType`) VALUES (DEFAULT, 'del mundo', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_group` (`pgrp_idGroup`, `pgrp_name`, `pgrp_description`, `pgrp_isActive`, `ptpe_idType`) VALUES (DEFAULT, 'de méxico', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_group` (`pgrp_idGroup`, `pgrp_name`, `pgrp_description`, `pgrp_isActive`, `ptpe_idType`) VALUES (DEFAULT, 'conmemorativos', NULL, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`product_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Ámerica', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Asia', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Europa', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Oceanía', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Medio Oriente', NULL, 1, 1);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'griegas', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'romanas', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'bizantinas', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'orientales', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'celtas', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'coloniales', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'islámicas', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'provinciales romanas', NULL, 1, 2);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'coloniales', NULL, 1, 3);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'del siglo XIX', NULL, 1, 3);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'del siglo XX', NULL, 1, 3);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'conmemorativas', NULL, 1, 3);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'de inversión', NULL, 1, 3);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Oro', NULL, 1, 4);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Plata', NULL, 1, 4);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, 'Niquel', NULL, 1, 4);
INSERT INTO `cointrade_db`.`product_category` (`pcat_idCategory`, `pcat_name`, `pcat_description`, `pcat_isActive`, `pgrp_idGroup`) VALUES (DEFAULT, ' Bronce', NULL, 1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`estado`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('d_codigo', 'd_asenta', 'd_tipo_asenta', 'D_mnpio', 'd_estado', 'd_ciudad', 'd_CP', 'c_estado', 'c_oficina', 'c_CP', 'c_tipo_asenta', 'c_mnpio', 'id_asenta_cpcons', 'd_zona');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20000', 'Aguascalientes Centro', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0001', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20010', 'Colinas del Rio', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0005', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20010', 'Olivares Santana', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0006', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20010', 'Las Brisas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0007', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20010', 'Ramon Romo Franco', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0008', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20010', 'San Cayetano', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0009', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20016', 'Colinas de San Ignacio', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0010', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20016', 'La Fundición', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0011', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20016', 'Fundición II', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0012', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20016', 'Los Sauces', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0013', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20018', 'Línea de Fuego', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0014', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20020', 'Buenos Aires', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0016', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20020', 'Circunvalación Norte', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0018', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20020', 'Las Arboledas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0019', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20020', 'Villas de San Francisco', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0020', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20029', 'Villas de La Universidad', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0021', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20030', 'El Sol', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0022', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20030', 'Gremial', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0023', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20030', 'Industrial', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0024', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20040', 'Altavista', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0026', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20040', 'Curtidores', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0027', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20040', 'La Concordia', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0029', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20040', 'Miravalle', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0030', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20040', 'Panorama', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0031', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20040', 'Residencial Guadalupe', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0367', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20049', 'Colinas del Poniente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0036', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20050', 'Bugambilias', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0037', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20050', 'Del Carmen', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0038', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20050', 'La Fe', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0039', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20050', 'Primavera', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0041', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20050', 'San Pablo', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0042', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20059', 'Guadalupe', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0043', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20059', 'Heliodoro Garcia', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0044', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20060', 'Gómez', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0045', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20060', 'Moderno', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0046', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20064', 'Valle del Rio San Pedro', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0048', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20070', 'Guadalupe Posada', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '31', '001', '0049', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20070', 'San Marcos', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0050', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20070', 'San Marcos', 'Barrio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '02', '001', '0051', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20078', 'San Marcos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0052', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20080', 'Modelo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0054', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20080', 'Residencial del Valle I', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0055', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20089', 'Residencial del Valle II', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0053', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20100', 'La Herradura', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0057', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20100', 'Club Campestre', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0058', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20100', 'Jardines del Campestre', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0061', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20100', 'Los Vergeles', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0062', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20100', 'Ciudad Universitaria', 'Equipamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '17', '001', '0426', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20100', 'Rancho San Antonio', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1284', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20110', 'Talamantes Ponce', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0064', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20110', 'Granjas del Campestre', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0065', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20110', 'Puerto las Hadas', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0066', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20110', 'Valle del Campestre', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0067', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20110', 'Villas de Montenegro', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0068', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20110', 'Las Cavas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1058', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20110', 'La Enramada', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1408', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'Trojes de Oriente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0069', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'Valle de las Trojes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0072', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'Villas de San Nicolás', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0073', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'San Telmo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0347', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'La Paloma', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1075', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'Barrio de Santiago', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1370', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'Villa de las Trojes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1383', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20115', 'Valle de Santa Teresa', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1409', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20116', 'La Troje', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0074', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20116', 'Trojes de Alonso', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0075', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20116', 'San Telmo Residencial', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0348', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20116', 'Santa Fe', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1380', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Las Trojes', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0077', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Misión del Campanario', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0078', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Trojes de Cristal', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0079', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Trojes del Sol', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0080', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Residencial Santa Clara', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0195', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Misión de Santiago', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0206', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Andora Residencial', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0433', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Cadaqués Residencial', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0434', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Valle del Campanario', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0986', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Los Calicantos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1011', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Las Misiones', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1132', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Los Jarales', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1133', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Cerrada El Molino', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1140', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Valle Real', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1282', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Terzetto', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1283', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Cerrada de La Misión', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1354', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Cerrada del Valle', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1371', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20118', 'Cerrada de la Mezquitera', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1402', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20119', 'Lomas del Campestre 2a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0081', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20119', 'Villas del Campestre', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0082', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20120', 'Jardines de la Concepción', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0083', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20120', 'Los Bosques', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0085', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20120', 'Rinconada los Bosques', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0086', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20123', 'La Perla Norte', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0392', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20123', 'Arroyo El Molino', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1029', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20124', 'Galerías', 'Zona comercial', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '33', '001', '1173', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20124', 'Residencial Altaria', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1373', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Constitución', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0090', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Libertad', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0091', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Pozo Bravo Norte', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0092', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Soberana Convención Revolucionaria', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0094', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa Montaña', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0238', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villas de Don Antonio', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0345', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Los Ángeles', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0353', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Capittala', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0375', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Recinto de la Macarena', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0376', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Nápoli', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0451', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'La Soledad', 'Rancho', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '48', '001', '0487', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Los Naranjos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0975', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa de Nuestra Señora de La Asunción Sector Guadalupe', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0979', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa Teresa', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0981', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Cartagena 1947', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1008', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villas de La Convención', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1043', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Lomas de La Asunción', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1045', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa de Nuestra Señora de La Asunción Sector Encino', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1046', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa de Nuestra Señora de La Asunción Sector Alameda', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1055', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'San José de Pozo Bravo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1057', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa de Nuestra Señora de La Asunción Sector San Marcos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1079', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa de Nuestra Señora de La Asunción Sector Estación', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1080', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Las Plazas', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1091', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'El Rosedal', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1124', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Natura', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1126', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Montebello Della Stanza', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1135', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa Notre Dame', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1166', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Privada Guadalupe', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1167', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Rinconada Pozo Bravo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1186', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Pozo Bravo Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1291', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villa Loma Dorada', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1384', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Jardines de Montebello', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1386', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Villas del Río', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1390', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'El Puertecito', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1391', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20126', 'Rinconada del Puertecito', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1394', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20127', 'Bosques del Prado Norte', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0095', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20128', 'Sartenejo', 'Rancho', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '48', '001', '0371', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20129', 'Lomas del Campestre 1a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0097', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Bosques del Prado Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0098', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'El Roble', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0099', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Fátima', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0101', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Independencia de México', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0102', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Nueva Rinconada', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0105', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Primo Verdad', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0106', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'San José del Arenal', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0107', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Unidad Ganadera', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0108', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'San Xavier', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0381', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Residencial del Real', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0382', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Puerta Navarra', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1062', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Residencial Campestre Club de Golf', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1121', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Palma Real', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1377', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20130', 'Muralia', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1378', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20135', 'Agropecuario', 'Zona comercial', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '33', '001', '0109', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20135', 'Centro Distribuidor de Básicos', 'Zona comercial', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '33', '001', '1064', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20136', 'La Rinconada', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0110', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20137', 'El Plateado', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0111', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20138', 'Residencial Pulgas Pandas Norte', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0112', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20138', 'Residencial Pulgas Pandas Sur', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0113', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20138', 'Villas del Vergel', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0114', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20138', 'Cerrada San Miguel', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1372', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20140', 'Las Hadas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0116', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20140', 'Morelos', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0117', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20140', 'Andrea', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1369', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20146', 'Los Arcos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0119', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20149', 'Industrial', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0120', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'Buenavista', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0121', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'C.T.M.', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0122', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'La Estrella', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0123', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'Macias Arellano', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0124', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'Trento', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0423', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'Nueva Andalucia Coto Residencial', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0435', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'Váltica', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0440', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20150', 'Lomas del Cobano', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '1012', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20157', 'La Higuerilla', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0125', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20157', 'Parras', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0126', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20158', 'El Cobano', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0127', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20158', 'Hacienda el Cobano', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0128', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20158', 'Trojes del Cobano', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0129', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20158', 'Villas del Cobano', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1342', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20159', 'Alianza Ferrocarrilera', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0130', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20159', 'Bosques del Prado Oriente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1335', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20160', 'Francisco Guel Jimenez', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0132', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20160', 'Las Viñas INFONAVIT', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '31', '001', '0133', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20164', 'Santa Anita 4a Sección', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '1018', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20169', 'Santa Anita', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0135', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'El Maguey', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0138', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'Las Cumbres', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0139', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'Lic Benito Juárez', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '31', '001', '0140', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'Nazario Ortiz Garza', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0141', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'Rodolfo Landeros Gallegos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0142', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'S.T.E.M.A.', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0143', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'Zona Militar', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0144', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20170', 'Villa Bonita', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1020', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20172', 'Lic Benito Palomino Dena', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0145', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20172', 'Anexo Benito Palomino Dena (Cumbres II)', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0152', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20172', 'La Florida l', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0359', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20172', 'La Florida ll', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0360', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20172', 'Claustros Loma Dorada', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1170', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20172', 'Cumbres III', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '1420', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Lomas de Bellavista', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0088', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Lomas de las Fuentes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0421', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Colinas de Oriente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0982', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Vista de las Cumbres', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1027', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Los Laureles', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1059', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Mirador de las Culturas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1072', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'El Rocío', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '29', '001', '1116', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Villas de la Loma', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1169', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Los Pericos', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '1188', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Paseos del Sol', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1357', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Miradores de Santa Elena', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1419', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20174', 'Villas de las Fuentes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1421', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20175', 'La Hojarasca', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0034', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20175', 'Ejido las Cumbres', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0147', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20175', 'J Refugio Esparza Reyes', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0148', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20175', 'Rinconadas las Cumbres', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0374', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20175', 'Lomas de Oriente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1054', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20177', 'C.N.O.P. Oriente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0149', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Las Cumbres', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0151', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Luis Ortega Douglas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0153', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Pensadores Mexicanos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0154', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Pintores Mexicanos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0155', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Progreso', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0156', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Santa Regina', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0361', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Cerro Alto', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1042', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20179', 'Santa Margarita', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1436', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20180', 'Del Trabajo', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0157', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20180', 'Ferronales', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0158', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20180', 'Luis Gómez Zepeda (ferronales)', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0159', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20180', 'Lomas de Santa Anita', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0160', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20180', 'Alameda', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0377', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20180', 'Bosques de La Alameda', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1175', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20180', 'Nueva Alameda', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1425', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20190', 'Héroes', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0162', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20190', 'La Hacienda', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0163', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20190', 'La Mancha', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '0164', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Ojocaliente I', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0166', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Ojocaliente INEGI', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '31', '001', '0169', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Solidaridad 1a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0170', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Sol Naciente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0281', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Villa de las Norias', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0344', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Camino Real', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0368', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Ribera del Sol', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0372', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Ambrosía', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0389', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Molino del Rey', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0448', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'El Polvorín (Mirador TV Azteca)', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0449', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Ojocaliente III', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0478', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'José Guadalupe Peralta Gámez', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0977', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Haciendas de Aguascalientes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0980', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Villerías', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1023', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Vistas de Oriente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1034', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Real de Haciendas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1063', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Valle de los Cactus', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1070', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Colinas de San Patricio', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1081', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Balcones de Oriente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1134', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Terra Nova', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1168', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'José Guadalupe Posada', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1288', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Comunidad el Rocío', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '1293', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Paseo de los Cactus', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1397', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Balcones del Valle', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1398', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20196', 'Real del Sol', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '1441', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20198', 'Ex Hacienda Ojocaliente', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0172', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20198', 'Ejido Ojocaliente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0173', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20198', 'Misión Alameda', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1061', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20199', 'El Riego', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '09', '001', '0174', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20199', 'Fidel Velázquez', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '31', '001', '0175', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20199', 'Municipio Libre', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '21', '001', '0176', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20199', 'Rinconada Alameda', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '10', '001', '1174', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Bellavista', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0177', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Loma Bonita', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0178', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Nueva Castilla', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0373', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Xenia Residencial', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0393', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Vergel de la Cantera', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0431', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Balandra', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0439', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Carmel', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0445', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Cantelli Residencial', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0475', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Villas de La Cantera', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0978', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Lic Manuel Gómez Morin', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1035', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Residencial San Nicolás', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1053', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Villas del Mediterráneo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1074', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Ex Hacienda La Cantera', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1138', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'José Vasconcelos Calderón', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1139', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Porta Canteras', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1171', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Veteranos de la Revolución', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '1326', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Fuentes del Lago', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1350', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'El Quelite', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1435', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20200', 'Olinda', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1442', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20205', 'Educación Álamos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0180', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20205', 'Nueva España', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0181', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20206', 'Lic. José López Portillo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0182', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20206', 'La Barranquilla', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0183', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20206', 'Barandales de San José', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0184', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20207', 'Canteras de San Javier', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0185', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20207', 'Capital City', 'Zona comercial', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '33', '001', '0349', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20207', 'Rinconada San José', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1313', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20208', 'Canteras de San José', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0186', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20210', 'Circunvalación Poniente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0187', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20210', 'España', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0188', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20210', 'La Barranca de Guadalupe', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0189', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20210', 'Pirules INFONAVIT', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0190', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20217', 'Residencial los Pirules', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0192', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Canteras de Santa Imelda', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0093', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Francisco Villa', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0193', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Jardines del Lago', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0194', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Tahona Residencial', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0437', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Santa Bárbara', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0446', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Privanza Lucerna', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0447', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Granna', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0462', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'San Martin de La Cantera', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '1017', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Canteras de San Agustin', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1065', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Santa Imelda', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1137', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Los Eucaliptos 2a. Sección', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1289', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'Los Eucaliptos', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1290', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20218', 'San Agustín', 'Rancho', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '48', '001', '1429', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20219', 'El Edén', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0196', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20219', 'Parque Industrial el Vergel', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0198', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20219', 'Misión Juan Pablo II', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1292', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20220', 'Las Flores', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0200', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20220', 'Vivienda Popular', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '1009', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20229', 'Las Torres', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0202', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20230', 'Las Américas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0203', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20230', 'Obraje', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0204', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20230', 'Santa Elena', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0205', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20234', 'Agricultura', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0207', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20235', 'Valle Dorado', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0211', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20235', 'Villa Jardín', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0212', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20235', 'El Dorado 1a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0209', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20235', 'El Dorado 2a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0210', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20236', 'Jardines de Santa Elena', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0214', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20237', 'Hermanos Carreón', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0215', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20237', 'Montebello', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0216', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20238', 'Santa Elena 2a Sección', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0217', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20239', 'La Fuente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0218', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'El Encino', 'Barrio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '02', '001', '0220', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'El Laurel', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0221', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'La Luna', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0222', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'La Salud', 'Barrio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '02', '001', '0223', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'Los Virreyes', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0224', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'El Llanito', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0225', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'Residencial el Encino', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0226', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'Triana', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0227', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'Residencial Cosío', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1076', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20240', 'Triana', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1316', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20247', 'San Fernando INFONAVIT', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0229', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20248', 'Jardines de Triana', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0230', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20249', 'Gámez', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0231', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20250', 'Jesús Gómez Portugal', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0232', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20250', 'Héroes de Aguascalientes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0233', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20250', 'Jardines de La Cruz', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0234', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20250', 'La Huerta', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0235', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20250', 'San Luis', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0236', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20250', 'Vivienda Militar', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0250', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20250', 'Villas de Kristal', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1022', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20255', 'Bona Gens', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0239', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20255', 'INFONAVIT Los Volcanes', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0240', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20256', 'FOVISSSTE Ojocaliente I', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0241', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20256', 'Ojocaliente FOVISSSTE II', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0242', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20256', 'Ojocaliente las Torres', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0243', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20256', 'Rinconada de La Cruz', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0958', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20256', 'Villas de Ojocaliente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1032', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20256', 'Parque y Presa del Cedazo', 'Equipamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '17', '001', '1432', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20257', 'Lázaro Cárdenas', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0244', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20259', 'La Estación', 'Barrio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '02', '001', '0245', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20259', 'La Purísima', 'Barrio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20001', '01', '20001', '', '02', '001', '0246', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20260', 'IV Centenario', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0247', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20260', 'Jesús Terán Peredo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0249', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20260', 'Ojo de Agua', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0251', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20260', 'Sidusa', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0252', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20260', 'Rinconada El Cedazo', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1089', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Agua Clara', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0253', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Balcones de Ojocaliente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0254', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Cielo Claro', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0255', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Lomas del Chapulín', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0256', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Ojo de Agua de Palmitas', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0257', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Salto de Ojocaliente', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0258', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Solidaridad 2a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0260', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Solidaridad 3a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0261', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Tierra Buena', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0262', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Rinconada San Antonio I', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0379', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Cima del Chapulín', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1030', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Cobano de Palmitas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1031', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'San Jorge', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1033', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'La Lomita', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1039', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Villa las Palmas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1041', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Bajío de las Palmas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1085', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Lomas del Gachupín', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1184', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'El Cedazo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1317', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'San Ángel', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1403', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20263', 'Villa Taurina', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1407', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20264', 'Morelos INFONAVIT', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0263', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20264', 'Vista del Sol 2a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0264', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20264', 'Vista del Sol 3a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0265', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20264', 'Vista del Sol 1a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0271', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20265', 'Ojo de Agua INFONAVIT', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0266', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20266', 'Jardines del Sol', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0268', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20266', 'La Cruz', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0269', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20266', 'Misión de Santa Fe', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0270', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20267', 'S.T.E.M.A.', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0273', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20267', 'Jardines de La Convención', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0274', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20267', 'Ojo de Agua FOVISSSTE 1a Sección', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0275', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20267', 'Lic Primo Verdad INEGI', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0276', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20268', 'Fuentes de La Asunción', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0277', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20269', 'Jardines de La Luz', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0278', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'Mesonero', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0208', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'Bulevar', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0279', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'El Caminero', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0280', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'Jardines de Aguascalientes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0282', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'Jardines de La Asunción', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0283', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'Las Canoas', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0284', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'Lindavista', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0285', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'México', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0286', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20270', 'Los Cedros', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1315', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20276', 'Jardines de las Bugambilias', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0288', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20276', 'Jardines del Parque', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0289', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20276', 'Jardines de Alejandría', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0369', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20277', 'Pirámides', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0290', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20277', 'Residencial del Parque', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0291', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20277', 'Rinconada del Parque', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0292', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20278', 'Jardines de las Fuentes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0294', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'San Pedro', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0303', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Torres de San Francisco', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0304', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Trojes del Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0305', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Australis', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0354', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Conjunto San Francisco', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0422', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Villas de San José', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0442', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Casasolida', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0295', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Central de Abastos', 'Zona comercial', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '33', '001', '0296', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Jardines del Sur', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0297', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Martinez Dominguez', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0299', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Prados de Villasunción', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0300', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'Prados del Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0301', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20280', 'San Francisco del Arenal', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0302', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20283', 'Kerarta', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0441', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20283', 'Parque Industrial Siglo XXI', 'Zona industrial', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '37', '001', '1325', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'La Casita', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0032', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'La Estancia', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0306', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'INFONAVIT Potreros del Oeste', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0307', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'Villas de Santa Rosa', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0308', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'Villas del Oeste', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0309', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'Vistas del Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0310', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'Rinconada del Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0380', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20284', 'Villas del Encino', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0436', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20285', 'Versalles 1a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0311', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20285', 'Versalles 2a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0312', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Bosque Real', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0237', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Rancho Santa Mónica', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0313', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Vicente Guerrero', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0314', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Villas del Pilar 1a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0315', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Barlovento', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0355', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Abadía', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0390', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Mangata', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0391', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Caranday', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0443', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Amura', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0444', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Luzia', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0450', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Villas San Antonio', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1123', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Providencia', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1318', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Rinconada Santa Mónica', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1343', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20286', 'Paseos de Santa Mónica', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1353', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20287', 'Insurgentes', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0316', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20288', 'Bulevares 1a. Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0317', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20288', 'Bulevares 2a. Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0318', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20289', 'Pilar Blanco INFONAVIT', 'Unidad habitacional', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '31', '001', '0320', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20290', 'Ciudad Industrial', 'Zona industrial', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '37', '001', '0321', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20290', 'Vista Alegre', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0323', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20290', 'Parque Industrial ALTEC', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1324', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20296', 'Rústicos Calpulli', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0328', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20296', 'Reserva San Matías', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '0432', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20296', 'Villas de Bonaterra', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1036', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20296', 'San Francisco de los Arteaga', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1071', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20296', 'Residencial San Javier', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1083', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20296', 'Villa Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1084', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20297', 'Casa Blanca', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0329', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20297', 'Jardines de Casablanca', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0331', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20297', 'Jardines de Casanueva', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0332', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Villas de Ajedrez', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '1021', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Lomas de Vistabella', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1037', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'San Sebastián', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1048', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Lomas del Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1082', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Lomas de Nueva York', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '1114', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Laureles del Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1129', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Lomas del Mirador', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1130', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Misión de Santa Lucía', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1185', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Lomas de Vistabella 2a. Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1319', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Lotes de Arellano', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1332', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Condominio La terraza', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1346', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Valle del Cedazo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1349', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Paseos de San Antonio', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1358', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Hacienda San Marcos', 'Condominio', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '10', '001', '1418', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Emiliano Zapata', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0333', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Morelos I', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0334', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Morelos 2a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0335', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Solidaridad 4a Sección', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0337', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Residencial Hacienda San Martín', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0362', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Viñedos del Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0370', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20298', 'Reserva Villa Sur', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0425', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Lomas del Ajedrez', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0341', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Mujeres Ilustres', 'Colonia', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '09', '001', '0342', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Periodistas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0343', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Villa del Chapulín', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0427', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Los Dolores', 'Granja', 'Aguascalientes', 'Aguascalientes', '', '20293', '01', '20293', '', '23', '001', '0496', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Fundadores', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '0964', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Lomas de San Jorge', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1038', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Reencuentro', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1127', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Villalta', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1176', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20299', 'Lunaria', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', 'Aguascalientes', '20293', '01', '20293', '', '21', '001', '1323', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20300', 'Panamericano', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0345', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20300', 'San Francisco de los Romos Centro', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0346', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20300', 'Revolución', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '21', '011', '0358', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20303', 'Hidalgo', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '21', '011', '0350', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20303', 'La Aurora', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0351', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20303', 'La Guadalupana', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0352', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20303', 'La Perla', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0354', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20303', 'Los Cedros', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0356', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20303', 'San José Buenavista', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0360', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20303', 'Cerrada San Francisco', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '21', '011', '1413', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', 'Fracción de la Trinidad II', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0364', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', 'La Escondida (El Salero)', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0365', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', 'Monserrat', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0367', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', 'San José del Barranco', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0368', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', 'San Juan', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0369', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', '28 de Abril', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0370', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', 'Santa Bárbara', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '21', '011', '1344', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20304', 'El Cardonal', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '21', '011', '1395', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'El Barranco', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0373', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'El Gigante', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0376', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'El Refugio', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0377', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'Santa Elena (Elena)', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0378', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'La Gloria', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0380', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'La Paz', 'Ranchería', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '29', '011', '0381', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'La Providencia', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '09', '011', '0382', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'La Trinidad', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0383', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'La Unión', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0384', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'Las Carmelitas', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0385', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'Los Lirios', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '21', '011', '0387', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'Sociedad Plan de los Sabinos', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0388', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'San Ángel', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0389', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'San Pedro Victoria de Arriba', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0391', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'Santa Anita', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0393', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20305', 'Zacatenco', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0397', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20306', 'Los Corrales (Los Corrales Blancos)', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0002', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20306', 'El Chamizal', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0363', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20306', 'Mary', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '23', '011', '0366', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20306', 'Villa de Guadalupe', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '0371', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20306', 'San Pablo', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', 'San Francisco de los Romo', '20671', '01', '20671', '', '48', '011', '1348', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20310', 'Los Negritos', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0398', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20310', 'Coyotes', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0399', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20310', 'Viñedos Valle Redondo', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0407', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20310', 'CERESO (Para Varones y Mujeres)', 'Zona federal', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '34', '001', '1093', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20310', 'La Loma de los Negritos', 'Pueblo', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '28', '001', '1110', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20310', 'Viñedos San Felipe', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '1113', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20313', 'Cuauhtémoc (Las Palomas)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0403', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20313', 'Hacienda Nueva', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0404', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20314', 'El Cariñán', 'Granja', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '23', '001', '0405', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20316', 'Santa Cruz de la Presa', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0409', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20316', 'Lomas del Picacho', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '21', '001', '1118', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20320', 'Estación Cañada Honda', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0411', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20320', 'General José María Morelos y Pavón (Cañada Honda)', 'Pueblo', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '28', '001', '0412', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20320', 'Las Cañadas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '21', '001', '1427', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20323', 'Santa María de Gallardo', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0417', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20324', 'Jaltomate', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0418', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Loretta', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0326', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Parque Industrial Tecnopolo 2 (PITP2)', 'Zona industrial', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '37', '001', '0351', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'La Aurora', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0356', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Bosque Sereno', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0358', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Cavalia', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0364', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Quinta los Olivos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0366', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Misión de San Jerónimo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0378', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Privada Los Olivos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0383', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Residencial Punta del Cielo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0384', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Portón San Ignacio', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0385', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Valle de San Ignacio (El Filso)', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '09', '001', '0388', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'San Ignacio', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '15', '001', '0419', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'La Trinidad', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0424', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Tamarindos', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0428', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Xaramá Entorno Residencial', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0429', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Hacienda Paraíso', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0468', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Albanta Norte', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0471', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Albanta Sur', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0472', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Belago Residence', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0473', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Paseos Loretta', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0474', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Puesta del Sol', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '1086', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'La Soledad', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '1087', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'La Rioja', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '1125', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Rinconada de San Ignacio', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1161', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'Ex-Hacienda de San Ignacio', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '29', '001', '1162', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'La Perla', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '09', '001', '1285', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'San Ignacio II', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '09', '001', '1286', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20326', 'San Ignacio III', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '09', '001', '1287', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20328', 'Los Fresnos', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '001', '0386', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20328', 'Terranza', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '001', '0387', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20328', 'Pocitos', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '001', '0420', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20328', 'Vista Castellana', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '001', '0469', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20328', 'Vista Piamonte', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '001', '0470', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20328', 'Reserva Residencial', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '001', '0476', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20328', 'Parque Industrial Tecnopolo Pocitos', 'Zona industrial', 'Aguascalientes', 'Aguascalientes', '', '20921', '01', '20921', '', '37', '001', '1066', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'Privada Andaluz', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '0325', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'Residencial Las Quintas', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0346', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'Coto Andaluz', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '0477', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'La Querencia', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1068', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'Rincón Andaluz', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1157', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'La Plazuela', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1158', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'Torres Residencial Campestre Santamaría', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '001', '1159', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'La Punta Campestre', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1160', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'Contadero', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1374', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'La Joya', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1375', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20329', 'Río Viejo', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '001', '1379', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'Crucero Ojo de Agua de Crucitas', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0002', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'Palo Alto', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0421', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'De Triana', 'Barrio', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '010', '1251', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'Palo Alto Centro', 'Colonia', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '010', '1252', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'Pobre', 'Barrio', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '010', '1253', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'Zaragoza', 'Barrio', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '010', '1254', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'De Abajo', 'Barrio', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '010', '1255', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'El Progreso', 'Barrio', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '010', '1256', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'El Salto', 'Barrio', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '010', '1257', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20330', 'El Saucito', 'Barrio', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '010', '1258', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'El Cotón', 'Rancho', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '010', '0422', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'El Milagro', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0423', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'Las Flores (El Cotón)', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0425', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'Licenciado Jesús Terán (El Muerto)', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0427', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'San Francisco de los Viveros', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0428', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'Sandovales (San Miguel de los Sandovales)', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0429', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'San Francisco de los Pedroza', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1259', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'El Barreno (Ampliación San Francisco)', 'Colonia', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '010', '1260', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'El Mocho', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1261', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'San Gerónimo', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1263', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20333', 'San José (San Antonio de Montoya)', 'Granja', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '23', '010', '1269', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20334', 'El Novillo', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0431', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20334', 'La Luz', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0432', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20335', 'El Puertecito', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0434', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20335', 'Ojo de Agua de Crucitas', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0435', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20336', 'El Terremoto', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0437', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20336', 'Francisco Sarabia (La Reforma)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0438', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20336', 'Los Conos', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0439', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20336', 'Montoya', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0440', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20336', 'Santa Rosa (El Huizache)', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0441', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20337', 'El Retoño', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0442', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20337', 'La Tinaja', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0443', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20337', 'El Rosario', 'Rancho', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '010', '1264', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'El Copetillo', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0445', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'El Tildío', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0446', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'La Unión (La Paz)', 'Ejido', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '010', '0449', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'Rancho Nuevo', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1265', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'El Chonguillo (El Chonguito)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1266', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'El Copetillo (El Moquete)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1267', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'Tanque el Coyote (El Coyote)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1268', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20338', 'Mirasoles', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1270', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'San José (San José de los Rodríguez)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0001', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'El Centenario', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0003', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'Santa Rita', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0004', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'La Primavera', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0448', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'Lomas del Refugio (La Loma)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '0450', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'Santa Elena', 'Colonia', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '010', '0451', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'El Llano [CERESO]', 'Zona federal', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '34', '010', '1092', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'Granja Temixco', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1271', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'El Paraíso (Santa Rita)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1272', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'Santa Rita Uno (Santa Rita)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1273', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'San Lorenzo', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1274', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'Santa Clara (Las Mieleras)', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1275', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'San Agustín de los Díaz', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1276', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'La Lucita', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1277', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'La Calavera', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1278', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'San Antonio de la Rosa', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1279', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20339', 'San Ramón', 'Ranchería', 'El Llano', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '010', '1280', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20340', 'Parque Industrial de Logística Automotriz (PILA)', 'Zona industrial', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '37', '001', '0002', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20340', 'Arellano', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0452', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20340', 'Buenavista de Peñuelas', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0453', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20340', 'Peñuelas (El Cienegal)', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0455', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20340', 'El Cedazo (Cedazo de San Antonio)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '1117', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20341', 'El Salto de los Salado', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0458', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20342', 'San Francisco', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20293', '01', '20293', '', '29', '001', '0459', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20342', 'San Gerardo', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20293', '01', '20293', '', '10', '001', '0460', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20342', 'Santa Gertrudis', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20293', '01', '20293', '', '29', '001', '0514', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20343', 'San José', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0519', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20344', 'La Rinconada (La Escondida)', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0414', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20344', 'Villa Licenciado Jesús Terán (Calvillito)', 'Pueblo', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '28', '001', '0463', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20345', 'Montoro (Mesa del Salto)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0464', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20346', 'Los Caños', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0465', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20347', 'Dolores', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0510', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20347', 'El Turicate', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0529', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20348', 'San Antonio de Peñuelas', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0466', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20349', 'Aguascalientes (Lic. Jesús Terán Peredo)', 'Aeropuerto', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '01', '001', '0467', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20350', 'Los Capricornios (La Biznaga)', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '23', '011', '0468', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20350', 'Loretito (Charco del Toro)', 'Ejido', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '011', '0469', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20350', 'Macario J Gómez', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '011', '0470', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20350', 'Medio Kilo', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '011', '1069', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'El Tirón (El Progreso)', 'Rancho', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '48', '011', '0349', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'María', 'Granja', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '23', '011', '0357', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'La Concepción', 'Pueblo', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '28', '011', '0379', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'Viñedos River', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '011', '0477', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'Parque Industrial San Francisco', 'Zona industrial', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '37', '011', '1026', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'Paseos de la Providencia', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '21', '011', '1028', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'Santa Fe', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '21', '011', '1396', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20355', 'Urbi Villa del Vergel', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '21', '011', '1399', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20356', 'Borrotes', 'Ranchería', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '011', '0478', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20356', 'Estación Chicalote', 'Paraje', 'San Francisco de los Romo', 'Aguascalientes', '', '20671', '01', '20671', '', '45', '011', '0479', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20357', 'Arellano', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '011', '0007', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20357', 'Amapolas del Río', 'Ejido', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '011', '0481', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20357', 'El Tepetate', 'Ranchería', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '011', '0482', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20357', 'Rancho Nuevo', 'Ejido', 'San Francisco de los Romo', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '011', '1094', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Monteverde', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '011', '0001', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Valle de Aguascalientes', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '011', '0003', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Reserva Quetzales', 'Condominio', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '011', '0004', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Rancho Seco', 'Ejido', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '15', '011', '0005', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Castelo San Francisco', 'Condominio', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '011', '0006', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Puertecito de la Virgen', 'Pueblo', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '28', '011', '0471', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Parque Industrial Valle de Aguascalientes', 'Zona industrial', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '37', '011', '0984', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Ex-Viñedos Guadalupe', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '09', '011', '1010', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Villas de San Felipe', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '011', '1056', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'La Casita', 'Colonia', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '09', '011', '1345', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'La Ribera', 'Fraccionamiento', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '21', '011', '1411', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20358', 'Sendero de los Quetzales', 'Condominio', 'San Francisco de los Romo', 'Aguascalientes', '', '20001', '01', '20001', '', '10', '011', '1439', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20363', 'San Antonio de los Pedroza', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0485', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20363', 'San José de la Ordeña', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0486', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20364', 'San Nicolás de Arriba', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0488', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20364', 'San Nicolás de en Medio', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0489', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20366', 'La Herrada', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0033', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20366', 'El Colorado (El Soyatal)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0490', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20366', 'El Conejal', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0491', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20367', '2 de Octubre', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0363', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20367', 'Che Guevara', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0394', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20367', 'Tanque el Trigo', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0494', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20367', 'Norias de Ojocaliente', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0495', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20369', 'El Malacate', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0497', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20370', 'Puerto de Nieto', 'Rancho', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '001', '0499', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20371', 'Santa Cruz de la Presa (La Tlacuacha)', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0396', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20371', 'Ciudad de los Niños', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0500', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20371', 'La Cotorra', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0501', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20372', 'Cabecita 3 Marías (Rancho Nuevo)', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0502', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20372', 'El Niágara', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0503', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20372', 'Ex-Hacienda de Agostaderito', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0520', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20372', 'Granjas Fátima', 'Rancho', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '001', '1115', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20372', 'Villa Campestre San José del Monte', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '21', '001', '1128', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20373', 'El Ocote', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0504', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20374', 'La Huerta (La Cruz)', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0457', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20375', 'El Tanque de los Jiménez', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0506', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20375', 'Campestre Bosques de Las Lomas', 'Condominio', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '10', '001', '1193', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20376', 'Centro de Arriba (El Taray)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0507', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20377', 'San Pedro Cieneguilla', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0509', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20378', 'Cieneguilla (La Lumbrera)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0454', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20378', 'Cieneguilla', 'Hacienda', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '24', '001', '0508', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20384', 'El Hotelito', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0146', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20384', 'Norias del Paso Hondo', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0352', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20384', 'Norias del Paso Hondo', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0512', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20384', 'Paso Hondo', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0513', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20386', 'El Duraznillo', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0515', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20388', 'Los Cuervos (Los Ojos de Agua)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0525', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20388', 'San Bartolo', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0526', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20389', 'Los Durón', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0517', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20389', 'Soledad de Abajo', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0518', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20389', 'Matamoros', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '1191', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20392', 'Campestre el Potrerillo', 'Fraccionamiento', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '21', '001', '0161', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20392', 'Gigante de los Arellano', 'Zona industrial', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '37', '001', '0350', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20392', 'El Gigante (Arellano)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0395', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20392', 'Norias de Cedazo (Cedazo Norias de Montoro)', 'Colonia', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '001', '0438', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20392', 'Montoro', 'Rancho', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '001', '0522', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20392', 'Universidad Autónoma de Aguascalientes  Campus Sur', 'Equipamiento', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '17', '001', '1440', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20393', 'Parque Industrial FINSA Aguascalientes', 'Zona industrial', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '37', '001', '0357', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20394', 'Lomas de Arellano', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0397', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20394', 'Tanque de Guadalupe', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0516', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20394', 'Cañada Grande de Cotorina', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0523', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20395', 'Cotorina (Coyotes)', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0365', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20396', 'El Refugio de Peñuelas', 'Ejido', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '001', '0527', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20396', 'Ex-Hacienda de Peñuelas', 'Ranchería', 'Aguascalientes', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '001', '0528', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20400', 'Rincón de Romos Centro', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0532', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20403', 'Rincón Real', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0010', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20403', 'Norte', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0939', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20403', 'Santa Elena', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0940', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20404', 'Valle del Real', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0007', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20404', 'San Rafael I [Potrero]', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0011', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20404', 'José Luis Macias', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0941', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20404', 'Estancia de Chora', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1144', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20404', 'Embajadores', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1212', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20405', 'El Chaveño', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0005', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20405', 'De Guadalupe', 'Barrio', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '02', '007', '0942', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20405', 'La Paz', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1200', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20406', 'Rinconada de las Piedras', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0001', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20406', 'Rinconada Alameda', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0006', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20406', 'De Chora', 'Barrio', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '02', '007', '0943', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20406', 'Santa Cruz', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0944', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20406', 'Lázaro Cárdenas', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1147', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20406', 'Fraternidad', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1196', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20406', 'Cerro del Gato', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '1206', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20410', 'Independencia', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0945', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20410', 'Magisterial', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0946', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20410', 'Magisterial II', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0947', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20410', 'Santa Anita', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0948', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20410', 'El Potrero', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1146', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20410', 'La Mezquitera', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1404', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20414', 'Villas de Jesús', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1199', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20415', 'Fundadores', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0009', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20415', 'San José', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0949', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20416', 'Presidentes de México', 'Colonia', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '09', '007', '0950', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20416', 'Solidaridad', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0951', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20417', 'Miguel Hidalgo', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '0952', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20417', 'Popular', 'Fraccionamiento', 'Rincón de Romos', 'Aguascalientes', 'Rincón de Romos', '20401', '01', '20401', '', '21', '007', '1197', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20420', 'Pablo Escaleras', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '007', '0531', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20420', 'El Saucillo', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '007', '0536', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20420', 'Presa de San Elías (José Muñoz)', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0537', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20420', 'El Bajío', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '007', '0539', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20420', 'Mar Negro', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0545', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20420', 'Estación Rincón de Romos', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0549', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20420', 'Potrero El Tarasco', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '1205', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20423', 'San Judas Tadeo (Santa Fe)', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '007', '0533', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20423', 'Candelaria', 'Granja', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '23', '007', '1208', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20424', 'Puerta del Muerto (El 15)', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0547', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20424', 'California', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0548', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20424', 'Bajío del Yerbaníz', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0550', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20424', 'Tanque Blanco', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '1204', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20425', 'San Jacinto', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '007', '0543', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20426', 'San Juan de la Natura', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '007', '0544', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20427', 'El Valle de las Delicias', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '007', '0538', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20427', '16 de Septiembre', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '007', '0546', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20427', 'Los Morales', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '007', '1201', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20427', 'San Isidro el Labrador', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '1202', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20430', 'La Misión', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0553', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20434', '18 de Marzo', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0555', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20435', 'El Salitrillo', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '007', '0530', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20435', 'El Barzón', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '1209', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20435', 'Las Norias', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '1210', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20435', 'Lupita', 'Granja', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '23', '007', '1211', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20436', 'El Milagro', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0551', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Constitución', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0002', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Héctor Hugo Olivares', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0003', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Lindavista', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0004', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Canal Grande', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '007', '0008', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Potrero San Isidro', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0012', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Las Antenas', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0013', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Pabellón de Hidalgo [Ejido Ex-Hacienda]', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '007', '0014', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Pabellón de Hidalgo Centro', 'Colonia', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '007', '0552', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'Estancia de Mosqueira', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '007', '0556', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20437', 'El Rosario', 'Granja', 'Rincón de Romos', 'Aguascalientes', '', '20671', '01', '20671', '', '23', '007', '0557', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20440', 'Morelos', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0568', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20444', 'Las Camas', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0567', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20444', 'Potrerillos', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0569', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20444', 'Túnel de Potrerillo', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '1207', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20450', 'El Panal', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '007', '0540', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20450', 'Fresnillo', 'Ejido', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '007', '0541', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20450', 'La Boquilla', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0565', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20450', 'Peña Blanca', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0566', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20454', 'El Ajiladero', 'Ranchería', 'Rincón de Romos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '007', '0535', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20460', 'Cosío Centro', 'Colonia', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '09', '004', '0570', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20462', 'Luis Donaldo Colosio', 'Fraccionamiento', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '21', '004', '0996', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20466', 'Villas del Potrerito', 'Fraccionamiento', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '21', '004', '1151', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20467', 'Popular', 'Fraccionamiento', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '21', '004', '0999', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20468', 'Santa Cruz', 'Colonia', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '09', '004', '0998', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20469', 'Mexiquito', 'Colonia', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '09', '004', '0997', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20469', 'Coplamar', 'Colonia', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '09', '004', '1149', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20469', 'Vista Hermosa', 'Colonia', 'Cosío', 'Aguascalientes', 'Cosío', '20401', '01', '20401', '', '09', '004', '1150', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20470', 'Soledad de Abajo [Estación de Adames]', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0577', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20470', 'Zacatequillas', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0578', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20470', 'Soledad de Arriba', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0579', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20472', 'El Durazno', 'Colonia', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '004', '0574', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20472', 'La Punta', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0575', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20472', 'La Esperanza (El Salerito)', 'Ranchería', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '004', '1107', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20472', 'El Durazno', 'Ranchería', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '004', '1295', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20472', 'Los Nava', 'Rancho', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '48', '004', '1296', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20476', 'El Salero', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0571', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20478', 'El Refugio de Agua Zarca', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0572', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20478', 'El Refugio de Providencia (Providencia)', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0573', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20478', 'Guadalupito', 'Colonia', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '004', '0580', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20478', 'Santa María de la Paz', 'Pueblo', 'Cosío', 'Aguascalientes', '', '20401', '01', '20401', '', '28', '004', '0581', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20500', 'San José de Gracia', 'Pueblo', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '28', '008', '0582', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20500', 'El Jocoqui', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0583', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20503', 'Cieneguita', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0584', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20503', 'El Toril', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0585', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20504', 'Santa Elena de la Cruz (Capadero)', 'Colonia', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '008', '0586', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20504', 'Las Amarillas', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0588', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20508', 'Túnel de Potrerillo', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0001', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20508', 'Tortugas', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0589', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20508', 'Potrerillo', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '1249', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20510', 'Ciénega de Alcorcha', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0590', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20516', 'Boca del Túnel de Potrerillo', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0591', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20520', 'La Congoja', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0592', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20534', 'El Cepo', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0595', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20538', 'Antrialgo', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0596', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20538', 'Sierra Hermosa (Los Alamitos)', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '1250', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20540', 'Paredes', 'Ejido', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '008', '0597', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20545', 'San Antonio de los Ríos', 'Ejido', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '008', '0598', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20563', 'Guajolotes (Huijolotes)', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0607', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20563', 'Santa Rosa de Lima', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0608', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20564', 'Rancho Viejo', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0601', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20567', 'Potrero de los López', 'Ejido', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '008', '0602', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20567', 'Paso del Sauz', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0606', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20570', 'El Tecongo', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0603', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20574', 'Estancia de San Marcos', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0604', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20575', 'El Taray', 'Ranchería', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '008', '0609', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20576', 'Club Náutico San José', 'Equipamiento', 'San José de Gracia', 'Aguascalientes', '', '20671', '01', '20671', '', '17', '008', '0605', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20600', 'Tepezalá Centro', 'Colonia', 'Tepezalá', 'Aguascalientes', 'Tepezalá', '20401', '01', '20401', '', '09', '009', '0611', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20602', 'Cholula', 'Barrio', 'Tepezalá', 'Aguascalientes', 'Tepezalá', '20401', '01', '20401', '', '02', '009', '1001', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20603', 'San Rafael', 'Colonia', 'Tepezalá', 'Aguascalientes', 'Tepezalá', '20401', '01', '20401', '', '09', '009', '1002', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20607', 'Del Socorro', 'Barrio', 'Tepezalá', 'Aguascalientes', 'Tepezalá', '20401', '01', '20401', '', '02', '009', '1003', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20607', 'Luis Ortega Douglas', 'Colonia', 'Tepezalá', 'Aguascalientes', 'Tepezalá', '20401', '01', '20401', '', '09', '009', '1005', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20607', 'Felipe González González', 'Colonia', 'Tepezalá', 'Aguascalientes', 'Tepezalá', '20401', '01', '20401', '', '09', '009', '1006', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20607', 'Los Arcos', 'Colonia', 'Tepezalá', 'Aguascalientes', 'Tepezalá', '20401', '01', '20401', '', '09', '009', '1300', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20610', 'El Realengo', 'Colonia', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '009', '0003', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20610', 'El Chayote', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0615', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20610', 'El Barranco', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0619', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20614', 'Los Alamitos', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0620', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20614', 'Luz de San Antonio (La Luz)', 'Ranchería', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '009', '0621', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20614', 'Ampliación los Hornos (el Lagunazo)', 'Colonia', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '09', '009', '1095', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20615', 'El Progreso (La Tira)', 'Ranchería', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '009', '0622', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20615', 'El Porvenir', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0623', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20615', 'El Carmen', 'Ranchería', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '009', '0625', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20616', 'San Antonio', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0624', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20620', 'Mesillas', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0612', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20622', 'Ojo de Agua de los Montes', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0610', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20634', 'La Victoria', 'Ranchería', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '009', '0626', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20635', 'El Águila', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0630', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20637', 'Los Tres Reyes', 'Ranchería', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '009', '0618', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20637', 'El Gigante', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0627', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20650', 'Puerto de la Concepción', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0631', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20656', 'Carboneras', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '009', '0001', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20656', 'El Refugio', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '009', '0633', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20657', 'Arroyo Hondo', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '009', '0634', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20658', 'Berrendos', 'Rancho', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '48', '009', '0002', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20658', 'El Tepozán', 'Ranchería', 'Tepezalá', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '009', '0635', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20659', 'Caldera', 'Ejido', 'Tepezalá', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '009', '0636', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20663', 'El Refugio', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '0966', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20663', 'El Gigante', 'Granja', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '23', '006', '0973', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20665', 'Emiliano Zapata', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '006', '0968', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20665', 'El Pedernal Segundo', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1239', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20665', 'San Agustín de los Puentes', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1244', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20665', 'El Pilar', 'Granja', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '23', '006', '1246', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20665', 'Los Contreras', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1247', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20666', 'El Garabato', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '0974', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20666', 'Campestre San Carlos', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '21', '006', '1412', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20667', 'Santiago', 'Ejido', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '006', '0965', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20667', 'El Canal', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1334', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20668', 'El Pedregal', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '0007', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20668', 'El Milagro', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '0008', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20668', 'Puerta del Milagro', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '0967', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20668', 'San Luis de Letras', 'Ejido', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '006', '0969', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20668', 'Miguel Alemán [Secadora]', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1238', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20668', 'Ampliación Ejido Garabato', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1242', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20670', 'Pabellón de Arteaga Centro', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0926', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20673', 'FOVISSSTE', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '0927', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20673', 'Jardines de Pabellón', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '0928', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20673', 'Haciendas de Pabellón', 'Conjunto habitacional', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '12', '006', '1142', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20673', 'Barrio Industrial', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '1235', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20674', 'Río San Pedro', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0011', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20674', 'Francisco Villa', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0929', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20674', 'Villas de Pabellón', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0930', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20674', 'Trojes de San Pedro', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '1136', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20675', 'Carboneras', 'Barrio', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '02', '006', '0931', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20675', 'Palo Alto', 'Barrio', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '02', '006', '0932', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20676', '5 de Mayo', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0933', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20676', 'Cosmos', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '0934', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20676', 'Popular', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '0935', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20677', 'Plutarco Elías Calles', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0936', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20677', 'Progreso Sur', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0937', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20678', 'Bosques de Pabellón', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '0010', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20678', 'Progreso Norte', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '09', '006', '0938', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20678', 'Vergel del Valle', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '1141', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20678', 'Valle del Vivero', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '1192', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20678', 'Villas de Guadalupe', 'Conjunto habitacional', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '12', '006', '1329', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20678', 'Valle del Vivero II', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', 'Pabellón de Arteaga', '20671', '01', '20671', '', '21', '006', '1401', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20680', 'Las Ánimas', 'Pueblo', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '28', '006', '0001', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20680', 'Santa Isabel', 'Fraccionamiento', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '21', '006', '0002', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20680', 'Las Ánimas', 'Rancho', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '48', '006', '0971', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20683', 'El Mezquite (Ojo de Agua del Mezquite)', 'Ejido', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '006', '0005', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20683', 'El Mezquite', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '006', '0006', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20683', 'El Mezquite', 'Hacienda', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '24', '006', '0972', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20683', 'Los Lira', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1237', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20684', 'Ojo Zarco', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '006', '0003', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20684', 'Ojo Zarco', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '0970', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20684', 'Ojo Zarco (La Loma)', 'Ejido', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '006', '1096', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20684', 'El Rayo', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '006', '1236', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20686', 'Gámez Orozco (Puerta de Carboneras)', 'Colonia', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '006', '1243', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20686', 'San Pedro', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '1245', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20687', 'El Cerrito', 'Ranchería', 'Pabellón de Arteaga', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '006', '0009', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'Guadalupe', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0001', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'Loma Bonita', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0002', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'Agua Nueva', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0003', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'Álamos', 'Fraccionamiento', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '21', '002', '0004', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'La Sierra', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0005', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'Arboledas', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0006', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'El Tule', 'Pueblo', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '28', '002', '0649', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'Villa Juárez Centro', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0651', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'La Loma', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '1311', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20700', 'El Rascón', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '1312', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20704', 'Viudas de Poniente', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0653', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20705', 'Charco Azul', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0654', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20706', 'El Llavero', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0689', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20708', 'Amarillas de Esparza', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0655', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20709', 'Jilotepec', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0656', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20709', 'La Dichosa', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0657', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20709', 'San Vicente', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0690', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20710', 'Asientos Centro', 'Colonia', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '09', '002', '0658', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20710', 'Santa Cruz', 'Barrio', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '02', '002', '1299', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20712', 'De Peñitas', 'Barrio', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '02', '002', '0990', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20712', 'Real Minero', 'Fraccionamiento', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '21', '002', '1148', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20713', 'Los Tepetates', 'Barrio', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '02', '002', '0991', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20713', 'Del CECYTE', 'Barrio', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '02', '002', '1297', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20714', 'De Guadalupe', 'Barrio', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '02', '002', '0993', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20715', 'INFONAVIT', 'Colonia', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '09', '002', '0994', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20715', 'Del Tepozán', 'Barrio', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '02', '002', '0995', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20715', 'Juventud', 'Barrio', 'Asientos', 'Aguascalientes', 'Asientos', '20401', '01', '20401', '', '02', '002', '1298', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Guadalupe de Atlas', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0659', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Bimbaletes Aguascalientes (El Álamo)', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0661', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Bimbaletes Atlas (Tanque de la Vieja)', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0664', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Crisóstomos', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0665', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Estación San Gil', 'Paraje', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '45', '002', '0667', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'La Divina Providencia', 'Rancho', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '002', '1304', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Alvarado', 'Rancho', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '002', '1305', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Licenciado Adolfo López Mateos', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '1306', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Los Posada [Sociedad]', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '1307', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Sector de Producción Número 3', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '1308', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20720', 'Sector de Producción Número 2', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '1309', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20721', 'Plutarco Elías Calles', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20401', '01', '20401', '', '29', '002', '0668', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20722', 'Ciénega Grande', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0669', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20723', 'Noria del Borrego (Norias)', 'Ejido', 'Asientos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '002', '0660', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20723', 'Jarillas', 'Ejido', 'Asientos', 'Aguascalientes', '', '20401', '01', '20401', '', '15', '002', '0663', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20724', 'Gómez Portugal', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0671', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20727', 'Pino Suárez (Rancho Viejo)', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0672', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20729', 'Clavellinas', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0674', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20730', 'Molinos', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0675', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20734', 'Los Encinos', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0676', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20734', 'Lázaro Cárdenas', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0677', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20736', 'La Gloria', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0678', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20737', 'Santuario del Tepozán', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '1303', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20739', 'La Soledad', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0679', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20739', 'San Pedro', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0680', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20740', 'El Polvo', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0681', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20741', 'Caldera', 'Ejido', 'Asientos', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '002', '0682', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20742', 'Licenciado Adolfo López Mateos', 'Ejido', 'Asientos', 'Aguascalientes', '', '20671', '01', '20671', '', '15', '002', '0683', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20742', 'Charco Prieto (El Palomar)', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '002', '1301', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20742', 'El Fénix', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '002', '1302', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20744', 'San Antonio de los Martínez', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0684', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20746', 'Gorriones', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0685', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20748', 'Ojo de Agua de Rosales', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0686', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20749', 'El Tepetatillo', 'Rancho', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '002', '0687', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20750', 'San José del Río', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0688', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20768', 'El Águila', 'Rancho', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '002', '0691', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20770', 'Emancipación (Borunda)', 'Colonia', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '002', '0692', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20773', 'Tanque Viejo', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0693', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20773', 'Las Adjuntas', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0694', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20773', 'La Tinajuela', 'Barrio', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '002', '1331', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20780', 'San Rafael de Ocampo', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0698', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20780', 'San José del Tulillo', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '1310', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20782', 'San Isidro', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0699', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20785', 'El Chonguillo', 'Rancho', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '002', '0700', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20790', 'Francisco Villa', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0701', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20795', 'La Esperanza', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0650', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20795', 'Ojo de Agua de los Sauces', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0697', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20795', 'Pilotos', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0704', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20796', 'Tanque de Guadalupe', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0695', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20796', 'Las Joyas', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0696', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20796', 'El Epazote', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0702', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20796', 'Las Fraguas', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0703', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20796', 'El Salitre', 'Ranchería', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '002', '0705', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20796', 'El Bajío de los Campos', 'Barrio', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '02', '002', '1330', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20799', 'Las Negritas', 'Ejido', 'Asientos', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '002', '0707', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20800', 'Calvillo Centro', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0708', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Unión Antorchista', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '0022', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'El Mirador', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '0710', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Independencia', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '0711', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'López Mateos', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0712', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Las Paseras', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '0714', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Vista Hermosa', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '0715', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Campo Militar 14 CINE', 'Zona militar', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '47', '003', '0716', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'El Guayabo', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0800', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Benito Juárez', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '1227', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Los Cerritos', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '1228', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20802', 'Loma de Fundadores', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '1229', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20803', 'Benito Juárez', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '21', '003', '0017', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20803', 'Lomas de Huejúcar', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0717', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20803', 'San Nicolás', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0718', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20803', 'El Llano (El Llano de San Rafael)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '1213', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20803', 'San Rafael', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '1218', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20803', 'Rincón de Baltazares', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '1221', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20803', 'José Landeros', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '1222', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Ejidal', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0719', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Liberal', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0720', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Rincón de Baltazares', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0721', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Valle de Santiago', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0722', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Arroyo de Los Caballos', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '1220', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Del Carmen', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '1223', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Azteca', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '1224', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20804', 'Morelos', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '1225', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20805', 'Cerrito Alto', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0002', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20805', 'Emiliano Zapata', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0723', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20805', 'Las Flores', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0724', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20805', 'Martínez', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '21', '003', '0725', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20805', 'Valle de Huejúcar', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0726', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20805', 'Los Angeles', 'Colonia', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '09', '003', '0957', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20805', 'Chicago', 'Barrio', 'Calvillo', 'Aguascalientes', 'Calvillo', '20801', '01', '20801', '', '02', '003', '1226', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20810', 'El Terrero de la Labor', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0727', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20810', 'Palo Alto', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0728', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20810', 'Junta de los Ríos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0756', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'El Sauz de la Labor', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0731', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'El Zapote de la Labor', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0732', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'Las Cuevas de la Labor', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0733', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'Las Rubias', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0734', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'Piedras Chinas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0735', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'El Jagüey', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0737', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'Los Lazos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0741', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20816', 'Puerta de Fragua (Presa la Codorniz)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0831', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'La Pochota', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0736', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'El Mirador', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0738', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'San Tadeo', 'Pueblo', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '28', '003', '0739', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'El Potrerito', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0763', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'La Teresa', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0803', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'Mezquitillos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0805', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'La Primavera', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0821', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'Jardines de San Isidro (Colonia Limón)', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '1108', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20820', 'Solidaridad', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '21', '003', '1214', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20823', 'Los Arellano', 'Rancho', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '48', '003', '0021', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20823', 'Presa Ordeña Vieja', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0822', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20823', 'El Tepozán', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0825', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20830', 'El Morancillo (Los Arcos)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0020', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20830', 'Chiquihuitero (San Isidro)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0745', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20830', 'La Panadera', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0746', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20830', 'Las Víboras (Viborillas)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0747', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20830', 'Villas del Laurel', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '21', '003', '1433', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20832', 'El Maguey', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0751', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20832', 'El Sauz', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0752', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20832', 'La Joya', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0817', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Potrero de los López', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0003', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Las Huertas', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0004', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'La Pila', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0005', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'La Alberca', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0006', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'La Españita', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0007', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Los Baños', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0008', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Los Esparza', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0009', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'La Placita', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0010', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'La Casa Grande', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0011', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Azoteyita', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0012', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Bajío de Colomos', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0015', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'El Llano de López', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0016', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Colomos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0744', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Catana', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0754', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'El Cuervero (Cuerveros)', 'Pueblo', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '28', '003', '0755', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Malpaso', 'Pueblo', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '28', '003', '0757', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Ojocaliente', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0758', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Potrero de los López', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0759', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Tepezalilla de Abajo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0777', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'La Fragua', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0792', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'El Jaralito', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0824', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'La Fortuna', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0953', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Los Arcos', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0954', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20834', 'Magisterial', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0955', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20835', 'Río Gil', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0753', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20835', 'Río Gil de Arriba', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0760', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20836', 'El Capulín', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0740', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20836', 'Montoro', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0742', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20836', 'Mesa de los Pozos (La Laguna)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0770', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20840', 'Los Mirasoles', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0762', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20842', 'Las Joyas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0765', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20842', 'San José de los Laureles', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0769', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20844', 'Chimaltitán', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0768', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20850', 'Crucero las Pilas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0772', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20850', 'Las Moras', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0774', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20850', 'Mesa Grande', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0775', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20850', 'El Refugio (Las Praderas)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0776', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20850', 'Pozo de los Artistas', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '1233', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20852', 'Ejido Calvillo (El Polvorín Sector Benito Juárez)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0018', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20852', 'Ejido Calvillo (Sector Emiliano Zapata)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0019', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20852', 'Los Adobes', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0778', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20852', 'Arroyo Ojocalientillo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '1232', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20854', 'Parque Industrial Calvillo', 'Zona industrial', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '37', '003', '0001', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20854', 'El Tepetate de Arriba', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0013', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20854', 'La Calixtina', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0773', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20854', 'El Tepetate de Abajo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0779', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20854', 'Ojo de Agua', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0781', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20854', 'Barranca del Roble', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0782', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20854', 'El Taray', 'Rancho', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '48', '003', '1234', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20855', 'Los Alisos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0780', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20855', 'El Garruño', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '1219', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20856', 'El Güencho', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0783', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20856', 'Jaltiche de Arriba', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0784', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20856', 'Mesa del Roble', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0962', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20860', 'Cerro Blanco', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0785', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20860', 'El Salitre', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0786', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20860', 'Las Ánimas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0787', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20860', 'Las Pilas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0788', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20860', 'Michoacanejo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0789', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20860', 'El Tepalcate', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0815', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20862', 'Norias Cuatas', 'Rancho', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '48', '003', '0014', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20862', 'Salitrillo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0790', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20862', 'Jaltiche de Abajo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0791', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20862', 'La Media Luna', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0793', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20862', 'La Rinconada', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0794', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20862', 'Las Tinajas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0795', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20864', 'El Caracol', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0796', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20864', 'El Terrero del Refugio', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0797', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20864', 'Presa de los Serna', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0799', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'Arboledas de Calvillo', 'Fraccionamiento', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '21', '003', '0023', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'El Papantón', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0801', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'El Rodeo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0802', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'Los Patos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0804', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'San José', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0807', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'Santos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0808', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'Vaquerías', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0809', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20870', 'Barranca de Portales', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0810', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20872', 'Peña Blanca', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0806', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20872', 'El Tigre', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0812', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20872', 'Miguel Hidalgo (El Huarache)', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0813', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20872', 'Presa de los Bajíos', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0829', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20874', 'El Ocote [Banco de Tierra]', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0814', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20874', 'Las Trojes', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0818', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20874', 'Tanque de los Serna', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0819', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20874', 'La Ciénega', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0828', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20880', 'La Labor', 'Colonia', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '09', '003', '0820', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20880', 'Temazcal', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0823', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20880', 'Paredes', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '1215', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20880', 'La Hiedra', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '1216', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20880', 'Ventanillas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '1231', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20880', 'El Salitrillo', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '1336', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20882', 'Manguillas', 'Ranchería', 'Calvillo', 'Aguascalientes', '', '20801', '01', '20801', '', '29', '003', '0827', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Santo Domingo', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0002', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Puerta Norte', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0015', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Residencial Misión de San José', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0017', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Residencial Campestre Ingles', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0018', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Camino Real', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0050', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Corral de Barrancos', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0837', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Maravillas', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0839', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Los Olivos', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1047', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Rinconada Maravillas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1049', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Residencial Villa Campestre', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1090', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Valle Escondido', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1183', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'Las Pérgolas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1362', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20900', 'La Nogalera', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1422', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20901', 'El Maguey', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0842', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20901', 'Las Jaulas', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '1098', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20901', 'La Loma de Valladolid', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '1099', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20901', 'La Chaveña', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '1179', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20903', 'Villas de Montecassino', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0032', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20903', 'Residencial Santa Paulina', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0052', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20903', 'Margaritas', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0845', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20903', 'La Florida', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0861', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20904', 'El Barreno', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0045', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20904', 'Los Ramírez', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0846', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20904', 'Los Vázquez', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0847', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20905', 'Miravalle', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0848', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20905', 'Paso Blanco', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0849', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20905', 'Los Arenales', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '1100', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20905', 'La Lomita de Paso Blanco (Las Canoas)', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '1103', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20905', 'Los Sauces', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '1434', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Viñedos Casa Leal', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0016', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Santa Elena', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0028', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Viñedos Eva (Fraccionamiento Paso Blanco)', 'Zona industrial', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '37', '005', '0067', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Viñedos Frutilandia', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0853', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Paseos de Aguascalientes', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0985', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Arboledas de Paso Blanco', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1052', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Central de Abastos Viñedos San Marcos', 'Zona comercial', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '33', '005', '1067', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Paseos del Country', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '1178', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Residencial Campo Real', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1356', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20907', 'Jardines de Campo Real', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1438', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Mayorazgo San Cristóbal', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0005', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Belmondo', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0006', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Residencial Marcellana', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0007', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Rinconada Cuauhtémoc', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0011', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Catania Spazio', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0012', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Punta Norte', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0023', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Los Gavilanes', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0030', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Nura', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0033', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Santa Isabel Tola', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0035', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Bosques de los Ciprés', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0038', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Bosques del Paraíso I', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0043', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Bosques del Paraíso II', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0044', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Augusta', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0046', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Bosques del Paraíso VI', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0049', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Bosques del Paraíso III', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0053', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Bosques del Paraíso IV', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0054', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Vivanta', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0058', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Zibá', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0061', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Porta Vitta Residencial', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0070', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Cartagena', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0071', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'San Mateo', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0072', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Villas de San Pedro', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0073', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Viña Real', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0074', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Tepetates', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0852', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Trojes de San Cristóbal', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1051', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Quintas de Monticello', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1088', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Viña Antigua', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1119', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Villas del Molino', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1143', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Porta Real', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '1177', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Residencial Cedros', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1187', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Rancho San Miguel Residencial', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1360', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Alcázar Residencial', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1368', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Reserva San Cristóbal', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1382', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'La Arborada', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1406', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Privanza Gratamira', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '1426', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Tierraverde (Habitat Gran Clase)', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1428', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20908', 'Andares', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1437', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'INFONAVIT Margaritas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0010', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Villas del Sol', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0019', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Valle de Margaritas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0020', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Saturnino Herran', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0021', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Los Vázquez', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0022', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Santa Fe Tecnopark', 'Zona industrial', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '37', '005', '0041', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Alea Park', 'Zona industrial', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '37', '005', '0057', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Jesús Gómez Portugal (Margaritas)', 'Pueblo', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '28', '005', '0854', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'El Zapato', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0855', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Paseos Gómez Portugal', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0983', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'La Guayana (Rancho Seco)', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '15', '005', '1097', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20909', 'Paso de Argenta', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1152', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20910', 'San Antonio de los Horcones', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0840', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20910', 'Brownsville', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '1106', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20913', 'Valladolid', 'Pueblo', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '28', '005', '0841', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20913', 'El Refugio', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '15', '005', '0843', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20913', 'El Aurero', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '1101', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20913', 'Villas de Guadalupe (La Malobra)', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '1102', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20913', 'El Cenizo', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '1104', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20914', 'La Granjita (Los Palillos)', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0858', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20915', 'Nueva', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20671', '01', '20671', '', '09', '005', '0069', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20916', 'Parque Industrial Chichimeco', 'Zona industrial', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '37', '005', '0014', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20916', 'El Chichimeco', 'Hacienda', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '24', '005', '0859', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20916', 'Paseos de las Haciendas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1393', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20916', 'La Cartuja', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1417', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20917', 'Pedernal Segundo', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20671', '01', '20671', '', '29', '005', '0857', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20920', 'Jesús María Centro', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0891', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20922', 'Bellavista', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0025', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20922', 'La Troje', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0026', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20922', 'El Calvario', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0892', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20922', 'La Escalera', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0893', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Rinconada Jesús María', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0004', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Real Campestre', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0008', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'La Villa Residencial', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0009', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Los Álamos', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '0013', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'La Misión', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0036', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Flores Magón', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0894', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'La Cardona', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0895', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'La Cuesta', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0896', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Los Arroyitos', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0898', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'San Miguelito', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0899', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Rinconada San Miguelito', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0903', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Ruiseñores', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '1327', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20923', 'Residencial Jesús María', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1363', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20924', 'Cielo Claro', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0024', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20924', 'Agua Clara', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0900', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20924', 'Jacarandas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0901', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20924', 'Deportiva', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0912', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20924', 'Rancho San Pedro', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1339', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20924', 'Palma Dorada', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1410', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Arroyo del Bosque', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0040', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Misantla', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0047', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Villas Tec', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0055', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'La Loma de Maravillas', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0066', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Arroyo San Emilión Residencial', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0080', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Agua Zarca', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0904', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Benigno Chávez', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0905', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Lomas de Jesús María', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0906', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Vista del Sauz', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0907', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20925', 'Puerta Grande', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '1352', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Rincón del Pilar', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0001', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'La Palma', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0034', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Quintas Miguel Jerónimo', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0048', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Las Palmas', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0056', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Porta Arvena', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '0060', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Abada Residencial', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '0078', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Lomas de San José', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0082', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Arboledas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0908', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Chicahuales', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0910', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Lomas del Valle', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0914', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Martínez Andrade', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0915', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Solidaridad', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0916', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Vista Hermosa', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0917', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Manantiales del Pinar', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1077', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'La Loma', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1078', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'La Piedra', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '1163', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Lomas de los Vergeles', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1164', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Rinconada Bugambilias', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '1165', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Misión de Santa María', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '1338', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Yalta Campestre', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '1351', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Residencial Tres Arroyos', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1367', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Mirabrujas', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1387', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20926', 'Tulipanes Residencial', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1405', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20927', 'Pozo la Palma (La Viznaga)', 'Ranchería', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '29', '005', '0062', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20927', 'Ayuntamiento', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0918', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20927', 'La Cañada', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0919', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20927', 'Ampliación La Cañada', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0920', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20927', 'Ojos de Agua', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0921', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'Luis Donaldo Colosio', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0027', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'Las Terrazas', 'Condominio', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '10', '005', '0079', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'Ejidal', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0922', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'El Torito', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0923', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'Las Palmas', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '0924', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'Plan Benito Juárez', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0925', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'El Mezquital', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '0976', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'El Chaveño', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '1365', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'Buenavista', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '21', '005', '1366', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20928', 'Solar de Jonacatique', 'Colonia', 'Jesús María', 'Aguascalientes', 'Jesús María', '20921', '01', '20921', '', '09', '005', '1423', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20933', 'Unión de Ladrilleros', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0029', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20934', 'San Lorenzo', 'Hacienda', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '24', '005', '0882', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20943', 'Buenos Aires', 'Rancho', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '48', '005', '0064', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20943', 'Los Muñoz', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0862', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20943', 'Milpillas de Abajo', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '005', '0863', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20943', 'Ex-hacienda de Milpillas', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '005', '0864', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20947', 'Gracias a Dios', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '005', '0865', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20947', 'El Zapote', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0866', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20953', 'Agronómica (Las Tres Almas)', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '005', '0063', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20953', 'Cañada el Rodeo', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0867', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20954', 'El Conejo (Puerta del Llano)', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0880', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20955', 'La Mesa del Contadero (El Contadero)', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0868', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20955', 'San Rafael', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0871', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20956', 'Piedras Negras', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0873', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20957', 'Lomas de San Isidro', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0860', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20957', 'Pedernal Primero', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0869', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20957', 'El Rincón de la Virgen (El Rincón)', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0870', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20970', 'Tapias Viejas', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '005', '0874', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20970', 'Puente de Villalpando (El Puente)', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0881', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20974', 'Puentes Cuates', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0875', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'Real del Molino', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0031', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'Mezquital del Country', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0051', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'Marabella Residencial', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0081', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'El Llano', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0878', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'Trojes del Pedregal', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1025', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'Residencial Trojes del Norte', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1180', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'Residencial Trojes del Norte II', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '1189', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20983', 'Residencial Antiguo Country', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '1364', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20984', 'Villa Natty Residencial', 'Fraccionamiento', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '21', '005', '0037', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20984', 'Andrea', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0059', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20984', 'Providencia', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '09', '005', '0879', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20990', 'General Ignacio Zaragoza (Venadero)', 'Pueblo', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '28', '005', '0876', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20990', 'Buenavista', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0877', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20994', 'Cieneguitas', 'Pueblo', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '28', '005', '0003', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20994', 'Villas de Montegrande', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '005', '0039', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20994', 'La Tomatina', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '005', '0887', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20995', 'Agua Zarca', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0883', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20996', 'Jesús María', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '005', '0042', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20996', 'El Refugio de los Arquitos', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0065', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20996', 'Los Arquitos', 'Ejido', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '15', '005', '0885', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20996', 'El Chacho', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '29', '005', '0886', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20996', 'La Primavera', 'Colonia', 'Jesús María', 'Aguascalientes', '', '20999', '01', '20999', '', '09', '005', '1105', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20997', 'La Providencia (Sector 6)', 'Ranchería', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '29', '005', '0068', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20997', 'St Ángelo Residence', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0075', 'Urbano');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20997', 'Vista Florencia', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0076', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20997', 'Vista San Isidro', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '0077', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20997', 'Ruscello', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '1389', 'Rural');
INSERT INTO `cointrade_db`.`estado` (`d_codigo`, `d_asenta`, `d_tipo_asenta`, `d_estado`, `d_ciudad`, `d_CP`, `c_estado`, `c_oficina`, `c_CP`, `c_tipo_asenta`, `c_mnpio`, `id_asenta_cpcons`, `d_zona`, `c_cve_ciudad`) VALUES ('20997', 'Q Campestre Residencial', 'Condominio', 'Jesús María', 'Aguascalientes', '', '20921', '01', '20921', '', '10', '005', '1400', 'Rural');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`payments_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`payments_status` (`pyst_name_idStatus`, `pyst_name`, `pyst_description`) VALUES (DEFAULT, 'Pagada', NULL);
INSERT INTO `cointrade_db`.`payments_status` (`pyst_name_idStatus`, `pyst_name`, `pyst_description`) VALUES (DEFAULT, 'Cancelada', NULL);
INSERT INTO `cointrade_db`.`payments_status` (`pyst_name_idStatus`, `pyst_name`, `pyst_description`) VALUES (DEFAULT, 'No pagada', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`card_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`card_type` (`ctpe_idType`, `ctpe_name`, `ctpe_description`) VALUES (DEFAULT, 'Débito', NULL);
INSERT INTO `cointrade_db`.`card_type` (`ctpe_idType`, `ctpe_name`, `ctpe_description`) VALUES (DEFAULT, 'Crédito', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cointrade_db`.`settings`
-- -----------------------------------------------------
START TRANSACTION;
USE `cointrade_db`;
INSERT INTO `cointrade_db`.`settings` (`set_idSetting`, `set_name`, `set_description`, `set_value`, `set_created_date`, `set_updated_date`) VALUES (DEFAULT, 'valuation_cost', NULL, '6000', NULL, NULL);
INSERT INTO `cointrade_db`.`settings` (`set_idSetting`, `set_name`, `set_description`, `set_value`, `set_created_date`, `set_updated_date`) VALUES (DEFAULT, 'comission_cost', NULL, '5000', NULL, NULL);

COMMIT;

