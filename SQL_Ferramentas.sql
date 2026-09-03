-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ferramentas_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ferramentas_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ferramentas_bd` DEFAULT CHARACTER SET utf8 ;
USE `ferramentas_bd` ;

-- -----------------------------------------------------
-- Table `ferramentas_bd`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferramentas_bd`.`Categoria` (
  `id_categoria` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferramentas_bd`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferramentas_bd`.`Produtos` (
  `id_produto` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(45) NULL,
  `textura` VARCHAR(45) NULL,
  `peso` DECIMAL(2) NOT NULL,
  `unidade_medida` VARCHAR(45) NOT NULL,
  `aplicacao` VARCHAR(100) NOT NULL,
  `validade` DATE NOT NULL,
  `preco` DECIMAL(2) NOT NULL,
  `estoque_minimo` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `fk_Produtos_Categoria_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_Categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `ferramentas_bd`.`Categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferramentas_bd`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferramentas_bd`.`Usuarios` (
  `id_usuario` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferramentas_bd`.`Movimentacao_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferramentas_bd`.`Movimentacao_Estoque` (
  `id_movimentacao` INT NOT NULL,
  `tipo_movimentacao` VARCHAR(45) NOT NULL,
  `quantidade` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id_movimentacao`),
  INDEX `fk_Movimentacao_Estoque_Usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_Movimentacao_Estoque_Produtos1_idx` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `fk_Movimentacao_Estoque_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ferramentas_bd`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimentacao_Estoque_Produtos1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `ferramentas_bd`.`Produtos` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
