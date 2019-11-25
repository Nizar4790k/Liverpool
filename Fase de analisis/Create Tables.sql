-- MySQL Script generated by MySQL Workbench
-- Mon 25 Nov 2019 10:38:47 AM AST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `direccion` VARCHAR(1000) NULL,
  `fecha_nacimiento` DATE NULL,
  `correo_electronico` VARCHAR(100) NOT NULL,
  `contrasena` VARCHAR(100) NULL,
  PRIMARY KEY (`correo_electronico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TelefonoUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TelefonoUsuario` (
  `cadena` VARCHAR(45) NOT NULL,
  `Usuario_correo_electronico` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cadena`, `Usuario_correo_electronico`),
  INDEX `fk_TelefonoUsuario_Usuario1_idx` (`Usuario_correo_electronico` ASC),
  CONSTRAINT `fk_TelefonoUsuario_Usuario1`
    FOREIGN KEY (`Usuario_correo_electronico`)
    REFERENCES `mydb`.`Usuario` (`correo_electronico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `codigo_postal` VARCHAR(15) NULL,
  `Usuario_correo_electronico` VARCHAR(100) NOT NULL,
  `idCliente` INT NOT NULL,
  INDEX `fk_Cliente_Usuario1_idx` (`Usuario_correo_electronico` ASC),
  PRIMARY KEY (`idCliente`),
  CONSTRAINT `fk_Cliente_Usuario1`
    FOREIGN KEY (`Usuario_correo_electronico`)
    REFERENCES `mydb`.`Usuario` (`correo_electronico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(1500) NULL,
  `precioActual` DOUBLE(10,4) NULL,
  `foto` VARCHAR(10000) NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_solicitado` DATETIME NULL,
  `Cliente_idCliente` INT NOT NULL,
  `fecha_despachado` DATETIME NULL,
  `fecha_entregado` DATETIME NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido_has_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido_has_Producto` (
  `Factura_idFactura` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `precioProducto` DECIMAL(10,4) NULL,
  `itbis` DECIMAL(10,4) NULL,
  PRIMARY KEY (`Factura_idFactura`, `Producto_idProducto`),
  INDEX `fk_Factura_has_Producto_Producto1_idx` (`Producto_idProducto` ASC),
  INDEX `fk_Factura_has_Producto_Factura1_idx` (`Factura_idFactura` ASC),
  CONSTRAINT `fk_Factura_has_Producto_Factura1`
    FOREIGN KEY (`Factura_idFactura`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_has_Producto_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Sucursal_idSucursal` INT NOT NULL,
  `sueldo` VARCHAR(45) NULL,
  `posicion` VARCHAR(45) NULL,
  `Usuario_correo_electronico` VARCHAR(100) NOT NULL,
  `supervisior` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_Empleado_Sucursal1_idx` (`Sucursal_idSucursal` ASC),
  INDEX `fk_Empleado_Usuario1_idx` (`Usuario_correo_electronico` ASC),
  INDEX `fk_Empleado_Empleado1_idx` (`supervisior` ASC),
  CONSTRAINT `fk_Empleado_Sucursal1`
    FOREIGN KEY (`Sucursal_idSucursal`)
    REFERENCES `mydb`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Usuario1`
    FOREIGN KEY (`Usuario_correo_electronico`)
    REFERENCES `mydb`.`Usuario` (`correo_electronico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Empleado1`
    FOREIGN KEY (`supervisior`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(150) NULL,
  `supervisor` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_Sucursal_Empleado1_idx` (`supervisor` ASC),
  CONSTRAINT `fk_Sucursal_Empleado1`
    FOREIGN KEY (`supervisor`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sucursal_has_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sucursal_has_Producto` (
  `Producto_idProducto` INT NOT NULL,
  `Sucursal_idSucursal` INT NOT NULL,
  `cantidad_producto` INT NULL,
  PRIMARY KEY (`Producto_idProducto`, `Sucursal_idSucursal`),
  INDEX `fk_Producto_has_Sucursal_Sucursal1_idx` (`Sucursal_idSucursal` ASC),
  INDEX `fk_Producto_has_Sucursal_Producto1_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_Producto_has_Sucursal_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Sucursal_Sucursal1`
    FOREIGN KEY (`Sucursal_idSucursal`)
    REFERENCES `mydb`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EmpleadoEntregaPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EmpleadoEntregaPedido` (
  `Pedido_idPedido` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Empleado_idEmpleado`),
  INDEX `fk_Pedido_has_Empleado_Empleado1_idx` (`Empleado_idEmpleado` ASC),
  INDEX `fk_Pedido_has_Empleado_Pedido1_idx` (`Pedido_idPedido` ASC),
  CONSTRAINT `fk_Pedido_has_Empleado_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Empleado_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TelefonoSucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TelefonoSucursal` (
  `cadena` VARCHAR(100) NOT NULL COMMENT 'k',
  `Sucursal_idSucursal` INT NOT NULL,
  PRIMARY KEY (`cadena`, `Sucursal_idSucursal`),
  INDEX `fk_TelefonoSucursal_Sucursal1_idx` (`Sucursal_idSucursal` ASC),
  CONSTRAINT `fk_TelefonoSucursal_Sucursal1`
    FOREIGN KEY (`Sucursal_idSucursal`)
    REFERENCES `mydb`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
