-- Drop the existing database if it exists
DROP DATABASE IF EXISTS `poke_db`;

-- Create the database
CREATE DATABASE IF NOT EXISTS `poke_db`;
USE `poke_db`;

-- Create the Pokemon table
CREATE TABLE `Pokemon` (
                           `ID` INT AUTO_INCREMENT PRIMARY KEY,
                           `Name` VARCHAR(255) UNIQUE NOT NULL
);

-- Create the PokemonStats table
CREATE TABLE `PokemonStats` (
                                `PokemonID` INT PRIMARY KEY,
                                `HP` INT NOT NULL,
                                `Attack` INT NOT NULL,
                                `Defense` INT NOT NULL,
                                `SpAttack` INT NOT NULL,
                                `SpDefense` INT NOT NULL,
                                `Speed` INT NOT NULL,
                                FOREIGN KEY (`PokemonID`) REFERENCES `Pokemon`(`ID`)
);

-- Create the Pokemon_Evolutions table
CREATE TABLE `Pokemon_Evolutions` (
                                      `BasePokemonID` INT,
                                      `EvolvedPokemonID` INT,
                                      PRIMARY KEY (`BasePokemonID`, `EvolvedPokemonID`),
                                      FOREIGN KEY (`BasePokemonID`) REFERENCES `Pokemon`(`ID`),
                                      FOREIGN KEY (`EvolvedPokemonID`) REFERENCES `Pokemon`(`ID`)
);

-- Create the Region table
CREATE TABLE `Region` (
                          `ID` INT AUTO_INCREMENT PRIMARY KEY,
                          `Name` VARCHAR(255) NOT NULL,
                          `Desc` TEXT DEFAULT NULL
);

-- Create the Route table
CREATE TABLE `Route` (
                         `ID` INT AUTO_INCREMENT PRIMARY KEY,
                         `Name` VARCHAR(255) NOT NULL,
                         `RegionID` INT NOT NULL,
                         FOREIGN KEY (`RegionID`) REFERENCES `Region`(`ID`)
);

-- Create the Pokemon_Route table
CREATE TABLE `Pokemon_Route` (
                                 `PokemonID` INT NOT NULL,
                                 `RouteID` INT NOT NULL,
                                 FOREIGN KEY (`PokemonID`) REFERENCES `Pokemon`(`ID`),
                                 FOREIGN KEY (`RouteID`) REFERENCES `Route`(`ID`)
);

-- Create the Type table
CREATE TABLE `Type` (
                        `ID` INT AUTO_INCREMENT PRIMARY KEY,
                        `Name` VARCHAR(255) UNIQUE NOT NULL,
                        `Color` VARCHAR(255) UNIQUE NOT NULL
);

-- Create the Pokemon_Type table
CREATE TABLE `Pokemon_Type` (
                                `PokemonID` INT NOT NULL,
                                `TypeID` INT NOT NULL,
                                FOREIGN KEY (`PokemonID`) REFERENCES `Pokemon`(`ID`),
                                FOREIGN KEY (`TypeID`) REFERENCES `Type`(`ID`)
);

-- Create the Ability table
CREATE TABLE `Ability` (
                           `ID` INT AUTO_INCREMENT PRIMARY KEY,
                           `Name` VARCHAR(255) UNIQUE NOT NULL,
                           `Desc` TEXT DEFAULT NULL
);

-- Create the Pokemon_Ability table
CREATE TABLE `Pokemon_Ability` (
                                   `PokemonID` INT NOT NULL,
                                   `AbilityID` INT NOT NULL,
                                   FOREIGN KEY (`PokemonID`) REFERENCES `Pokemon`(`ID`),
                                   FOREIGN KEY (`AbilityID`) REFERENCES `Ability`(`ID`)
);

-- Create the User table
CREATE TABLE `User` (
                        `ID` INT AUTO_INCREMENT PRIMARY KEY,
                        `Email` VARCHAR(255) UNIQUE NOT NULL,
                        `DisplayName` VARCHAR(255) NOT NULL,
                        `Password` VARCHAR(255) NOT NULL,
                        `FirstName` VARCHAR(255) DEFAULT NULL,
                        `LastName` VARCHAR(255) DEFAULT NULL,
                        `JoinTime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the User_Pokemon table
CREATE TABLE `User_Pokemon` (
                                `UserID` INT NOT NULL,
                                `PokemonID` INT NOT NULL,
                                `Nickname` VARCHAR(255) DEFAULT NULL,
                                `NatureID` INT DEFAULT NULL,
                                `Shiny` BOOLEAN DEFAULT FALSE NOT NULL,
                                `TimeAdded` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                PRIMARY KEY (`UserID`, `PokemonID`),
                                FOREIGN KEY (`UserID`) REFERENCES `Trainer`(`ID`),
                                FOREIGN KEY (`PokemonID`) REFERENCES `Pokemon`(`ID`),
                                FOREIGN KEY (`NatureID`) REFERENCES `Nature`(`ID`)
);

-- Create the Nature table
CREATE TABLE `Nature` (
                          `ID` INT AUTO_INCREMENT PRIMARY KEY,
                          `Name` VARCHAR(255) UNIQUE NOT NULL,
                          `Desc` TEXT DEFAULT NULL,
                          `IncreasedStat` VARCHAR(255) NOT NULL,
                          `DecreasedStat` VARCHAR(255) NOT NULL
);



