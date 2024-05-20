-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2024 at 08:36 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `poke_db`
--
CREATE DATABASE IF NOT EXISTS `poke_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `poke_db`;

-- --------------------------------------------------------

--
-- Table structure for table `ability`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `ability`;
CREATE TABLE `ability` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Desc` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `ability`:
--

--
-- Dumping data for table `ability`
--

INSERT INTO `ability` (`ID`, `Name`, `Desc`) VALUES
(1, 'Rock Head', 'Does not receive recoil damage from recoil-causing damages.'),
(2, 'Sheer Force', 'Moves with a secondary effect are increased in power by 33% but lose their secondary effect.'),
(3, 'Sand Veil', 'Raises the Pokémon’s evasion during a sandstorm by one level.'),
(4, 'Rough Skin', 'The opponent is hurt by 1/16th of his maxium Hit Points of recoil when using an attack, that requires physical contact, against this Pokémon.'),
(5, 'Overcoat', 'It will not take damage from weather effects.'),
(6, 'Intimidate', 'Upon entering battle, the opponent’s Attack lowers one stage.'),
(7, 'Moxie', 'Attack is raised by one stage when the Pokémon knocks out another Pokémon.');

-- --------------------------------------------------------

--
-- Table structure for table `nature`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `nature`;
CREATE TABLE `nature` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Desc` text DEFAULT NULL,
  `IncreasedStat` varchar(255) NOT NULL,
  `DecreasedStat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `nature`:
--

--
-- Dumping data for table `nature`
--

INSERT INTO `nature` (`ID`, `Name`, `Desc`, `IncreasedStat`, `DecreasedStat`) VALUES
(1, 'Adamant', NULL, 'Attack', 'Sp. Atk'),
(2, 'Bashful', NULL, 'Sp. Atk', 'Sp. Atk'),
(3, 'Bold', NULL, 'Defense', 'Attack'),
(4, 'Brave', NULL, 'Attack', 'Speed'),
(5, 'Calm', NULL, 'Sp. Def', 'Attack'),
(6, 'Careful', NULL, 'Sp. Def', 'Sp. Atk'),
(7, 'Docile', NULL, 'Defense', 'Defense'),
(8, 'Gentle', NULL, 'Sp. Def', 'Defense'),
(9, 'Hardy', NULL, 'Attack', 'Attack'),
(10, 'Hasty', NULL, 'Speed', 'Defense'),
(11, 'Impish', NULL, 'Defense', 'Sp. Atk'),
(12, 'Jolly', NULL, 'Speed', 'Sp. Atk'),
(13, 'Lax', NULL, 'Defense', 'Sp. Def'),
(14, 'Lonely', NULL, 'Attack', 'Defense'),
(15, 'Mild', NULL, 'Sp. Atk', 'Defense'),
(16, 'Modest', NULL, 'Sp. Atk', 'Attack'),
(17, 'Naive', NULL, 'Speed', 'Sp. Def'),
(18, 'Naughty', NULL, 'Attack', 'Sp. Def'),
(19, 'Quiet', NULL, 'Sp. Atk', 'Speed'),
(20, 'Quirky', NULL, 'Sp. Def', 'Sp. Def'),
(21, 'Rash', NULL, 'Sp. Atk', 'Sp. Def'),
(22, 'Relaxed', NULL, 'Defense', 'Speed'),
(23, 'Sassy', NULL, 'Sp. Def', 'Speed'),
(24, 'Serious', NULL, 'Speed', 'Speed'),
(25, 'Timid', NULL, 'Speed', 'Attack');

-- --------------------------------------------------------

--
-- Table structure for table `pokemon`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `pokemon`;
CREATE TABLE `pokemon` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pokemon`:
--

--
-- Dumping data for table `pokemon`
--

INSERT INTO `pokemon` (`ID`, `Name`) VALUES
(371, 'Bagon'),
(444, 'Gabite'),
(445, 'Garchomp'),
(443, 'Gible'),
(373, 'Salamence'),
(372, 'Shelgon');

-- --------------------------------------------------------

--
-- Table structure for table `pokemonstats`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `pokemonstats`;
CREATE TABLE `pokemonstats` (
  `PokemonID` int(11) NOT NULL,
  `HP` int(11) NOT NULL,
  `Attack` int(11) NOT NULL,
  `Defense` int(11) NOT NULL,
  `SpAttack` int(11) NOT NULL,
  `SpDefense` int(11) NOT NULL,
  `Speed` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pokemonstats`:
--   `PokemonID`
--       `pokemon` -> `ID`
--

--
-- Dumping data for table `pokemonstats`
--

INSERT INTO `pokemonstats` (`PokemonID`, `HP`, `Attack`, `Defense`, `SpAttack`, `SpDefense`, `Speed`) VALUES
(371, 45, 75, 60, 40, 30, 50),
(372, 65, 95, 100, 60, 50, 50),
(373, 95, 135, 80, 110, 80, 100),
(443, 58, 70, 45, 40, 45, 42),
(444, 68, 90, 65, 50, 55, 82),
(445, 108, 130, 95, 80, 85, 102);

-- --------------------------------------------------------

--
-- Table structure for table `pokemon_ability`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `pokemon_ability`;
CREATE TABLE `pokemon_ability` (
  `PokemonID` int(11) NOT NULL,
  `AbilityID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pokemon_ability`:
--   `PokemonID`
--       `pokemon` -> `ID`
--   `AbilityID`
--       `ability` -> `ID`
--

--
-- Dumping data for table `pokemon_ability`
--

INSERT INTO `pokemon_ability` (`PokemonID`, `AbilityID`) VALUES
(371, 1),
(371, 2),
(372, 1),
(372, 5),
(373, 6),
(373, 7),
(443, 3),
(443, 4),
(444, 3),
(444, 4),
(445, 3),
(445, 4);

-- --------------------------------------------------------

--
-- Table structure for table `pokemon_evolutions`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `pokemon_evolutions`;
CREATE TABLE `pokemon_evolutions` (
  `BasePokemonID` int(11) NOT NULL,
  `EvolvedPokemonID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pokemon_evolutions`:
--   `BasePokemonID`
--       `pokemon` -> `ID`
--   `EvolvedPokemonID`
--       `pokemon` -> `ID`
--

--
-- Dumping data for table `pokemon_evolutions`
--

INSERT INTO `pokemon_evolutions` (`BasePokemonID`, `EvolvedPokemonID`) VALUES
(371, 372),
(372, 373),
(443, 444),
(444, 445);

-- --------------------------------------------------------

--
-- Table structure for table `pokemon_route`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `pokemon_route`;
CREATE TABLE `pokemon_route` (
  `PokemonID` int(11) NOT NULL,
  `RouteID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pokemon_route`:
--   `PokemonID`
--       `pokemon` -> `ID`
--   `RouteID`
--       `route` -> `ID`
--

--
-- Dumping data for table `pokemon_route`
--

INSERT INTO `pokemon_route` (`PokemonID`, `RouteID`) VALUES
(371, 91),
(443, 43);

-- --------------------------------------------------------

--
-- Table structure for table `pokemon_type`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `pokemon_type`;
CREATE TABLE `pokemon_type` (
  `PokemonID` int(11) NOT NULL,
  `TypeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pokemon_type`:
--   `PokemonID`
--       `pokemon` -> `ID`
--   `TypeID`
--       `type` -> `ID`
--

--
-- Dumping data for table `pokemon_type`
--

INSERT INTO `pokemon_type` (`PokemonID`, `TypeID`) VALUES
(371, 15),
(372, 15),
(373, 15),
(373, 10),
(443, 15),
(443, 9),
(444, 15),
(444, 9),
(445, 15),
(445, 9);

-- --------------------------------------------------------

--
-- Table structure for table `region`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Desc` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `region`:
--

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`ID`, `Name`, `Desc`) VALUES
(1, 'Kanto', NULL),
(2, 'Johto', NULL),
(3, 'Hoenn', NULL),
(4, 'Sevii Islands', NULL),
(5, 'Sinnoh', NULL),
(6, 'Unova', NULL),
(7, 'Kalos', NULL),
(8, 'Alola', NULL),
(9, 'Galar', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `route`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `route`;
CREATE TABLE `route` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `RegionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `route`:
--   `RegionID`
--       `region` -> `ID`
--

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`ID`, `Name`, `RegionID`) VALUES
(1, 'Route 1', 6),
(2, 'Route 2', 6),
(3, 'Route 3', 6),
(4, 'Route 4', 6),
(5, 'Route 5', 6),
(6, 'Route 6', 6),
(7, 'Route 7', 6),
(8, 'Route 8', 6),
(9, 'Route 9', 6),
(10, 'Route 10', 6),
(11, 'Route 11', 6),
(12, 'Route 12', 6),
(13, 'Route 13', 6),
(14, 'Route 14', 6),
(15, 'Route 15', 6),
(16, 'Route 16', 6),
(17, 'Route 17', 6),
(18, 'Route 18', 6),
(19, 'Route 19', 6),
(20, 'Route 20', 6),
(21, 'Route 21', 6),
(22, 'Route 22', 6),
(23, 'Abundant Shrine', 6),
(24, 'Accumula Town', 6),
(25, 'Anville Town', 6),
(26, 'Aspertia City', 6),
(27, 'Battle Subway', 6),
(28, 'Black City', 6),
(29, 'Castelia City', 6),
(30, 'Castelia Sewers', 6),
(31, 'Cave of Being', 6),
(32, 'Celestial Tower', 6),
(33, 'Challenger\'s Cave', 6),
(34, 'Chargestone Cave', 6),
(35, 'Clay Tunnel', 6),
(36, 'Cold Storage', 6),
(37, 'Desert Resort', 6),
(38, 'Dragonspiral Tower', 6),
(39, 'Dreamyard', 6),
(40, 'Driftveil City', 6),
(41, 'Driftveil Drawbridge', 6),
(42, 'Floccesy Ranch', 6),
(43, 'Floccesy Town', 6),
(44, 'Gear Station', 6),
(45, 'Giant Chasm', 6),
(46, 'High Link', 6),
(47, 'Humilau City', 6),
(48, 'Icirrus City', 6),
(49, 'Lacunosa Town', 6),
(50, 'Lentimas Town', 6),
(51, 'Liberty Island', 6),
(52, 'Lostlorn Forest', 6),
(53, 'Marine Tube', 6),
(54, 'Marvelous Bridge', 6),
(55, 'Mistralton Cave', 6),
(56, 'Mistralton City', 6),
(57, 'Moor of Icirrus', 6),
(58, 'N\'s Castle', 6),
(59, 'Nacrene City', 6),
(60, 'Nature Preserve', 6),
(61, 'Nature Sanctuary', 6),
(62, 'Nimbasa City', 6),
(63, 'Nuvema Town', 6),
(64, 'Opelucid City', 6),
(65, 'P2 Laboratory', 6),
(66, 'Pinwheel Forest', 6),
(67, 'Plasma Frigate', 6),
(68, 'Pledge Grove', 6),
(69, 'Pokémon League', 6),
(70, 'Pokémon World Tournament', 6),
(71, 'Relic Castle', 6),
(72, 'Relic Passage', 6),
(73, 'Reversal Mountain', 6),
(74, 'Roaming Unova', 6),
(75, 'Seaside Cave', 6),
(76, 'Skyarrow Bridge', 6),
(77, 'Strange House', 6),
(78, 'Striaton City', 6),
(79, 'Tubeline Bridge', 6),
(80, 'Twist Mountain', 6),
(81, 'Undella Bay', 6),
(82, 'Undella Town', 6),
(83, 'Underground Ruins', 6),
(84, 'Undersea Ruins', 6),
(85, 'Unity Tower', 6),
(86, 'Victory Road', 6),
(87, 'Village Bridge', 6),
(88, 'Virbank City', 6),
(89, 'Virbank Complex', 6),
(90, 'Wellspring Cave', 6),
(91, 'White Forest', 6);

-- --------------------------------------------------------

--
-- Table structure for table `type`
--
-- Creation: May 19, 2024 at 06:24 PM
-- Last update: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Color` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `type`:
--

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`ID`, `Name`, `Color`) VALUES
(1, 'Normal', '#A8A77A'),
(2, 'Fire', '#EE8130'),
(3, 'Water', '#6390F0'),
(4, 'Electric', '#F7D02C'),
(5, 'Grass', '#7AC74C'),
(6, 'Ice', '#96D9D6'),
(7, 'Fighting', '#C22E28'),
(8, 'Poison', '#A33EA1'),
(9, 'Ground', '#E2BF65'),
(10, 'Flying', '#A98FF3'),
(11, 'Psychic', '#F95587'),
(12, 'Bug', '#A6B91A'),
(13, 'Rock', '#B6A136'),
(14, 'Ghost', '#735797'),
(15, 'Dragon', '#6F35FC'),
(16, 'Dark', '#705746'),
(17, 'Steel', '#B7B7CE'),
(18, 'Fairy', '#D685AD');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--
-- Creation: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `ID` int(11) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `DisplayName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `JoinTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `user`:
--

-- --------------------------------------------------------

--
-- Table structure for table `user_pokemon`
--
-- Creation: May 19, 2024 at 06:24 PM
--

DROP TABLE IF EXISTS `user_pokemon`;
CREATE TABLE `user_pokemon` (
  `UserID` int(11) NOT NULL,
  `PokemonID` int(11) NOT NULL,
  `Nickname` varchar(255) DEFAULT NULL,
  `NatureID` int(11) DEFAULT NULL,
  `Shiny` tinyint(1) NOT NULL DEFAULT 0,
  `TimeAdded` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `user_pokemon`:
--   `UserID`
--       `trainer` -> `ID`
--   `PokemonID`
--       `pokemon` -> `ID`
--   `NatureID`
--       `nature` -> `ID`
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ability`
--
ALTER TABLE `ability`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `nature`
--
ALTER TABLE `nature`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `pokemon`
--
ALTER TABLE `pokemon`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `pokemonstats`
--
ALTER TABLE `pokemonstats`
  ADD PRIMARY KEY (`PokemonID`);

--
-- Indexes for table `pokemon_ability`
--
ALTER TABLE `pokemon_ability`
  ADD KEY `PokemonID` (`PokemonID`),
  ADD KEY `AbilityID` (`AbilityID`);

--
-- Indexes for table `pokemon_evolutions`
--
ALTER TABLE `pokemon_evolutions`
  ADD PRIMARY KEY (`BasePokemonID`,`EvolvedPokemonID`),
  ADD KEY `EvolvedPokemonID` (`EvolvedPokemonID`);

--
-- Indexes for table `pokemon_route`
--
ALTER TABLE `pokemon_route`
  ADD KEY `PokemonID` (`PokemonID`),
  ADD KEY `RouteID` (`RouteID`);

--
-- Indexes for table `pokemon_type`
--
ALTER TABLE `pokemon_type`
  ADD KEY `PokemonID` (`PokemonID`),
  ADD KEY `TypeID` (`TypeID`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `RegionID` (`RegionID`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`),
  ADD UNIQUE KEY `Color` (`Color`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `user_pokemon`
--
ALTER TABLE `user_pokemon`
  ADD PRIMARY KEY (`UserID`,`PokemonID`),
  ADD KEY `PokemonID` (`PokemonID`),
  ADD KEY `NatureID` (`NatureID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ability`
--
ALTER TABLE `ability`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `nature`
--
ALTER TABLE `nature`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `pokemon`
--
ALTER TABLE `pokemon`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=446;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `type`
--
ALTER TABLE `type`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pokemonstats`
--
ALTER TABLE `pokemonstats`
  ADD CONSTRAINT `pokemonstats_ibfk_1` FOREIGN KEY (`PokemonID`) REFERENCES `pokemon` (`ID`);

--
-- Constraints for table `pokemon_ability`
--
ALTER TABLE `pokemon_ability`
  ADD CONSTRAINT `pokemon_ability_ibfk_1` FOREIGN KEY (`PokemonID`) REFERENCES `pokemon` (`ID`),
  ADD CONSTRAINT `pokemon_ability_ibfk_2` FOREIGN KEY (`AbilityID`) REFERENCES `ability` (`ID`);

--
-- Constraints for table `pokemon_evolutions`
--
ALTER TABLE `pokemon_evolutions`
  ADD CONSTRAINT `pokemon_evolutions_ibfk_1` FOREIGN KEY (`BasePokemonID`) REFERENCES `pokemon` (`ID`),
  ADD CONSTRAINT `pokemon_evolutions_ibfk_2` FOREIGN KEY (`EvolvedPokemonID`) REFERENCES `pokemon` (`ID`);

--
-- Constraints for table `pokemon_route`
--
ALTER TABLE `pokemon_route`
  ADD CONSTRAINT `pokemon_route_ibfk_1` FOREIGN KEY (`PokemonID`) REFERENCES `pokemon` (`ID`),
  ADD CONSTRAINT `pokemon_route_ibfk_2` FOREIGN KEY (`RouteID`) REFERENCES `route` (`ID`);

--
-- Constraints for table `pokemon_type`
--
ALTER TABLE `pokemon_type`
  ADD CONSTRAINT `pokemon_type_ibfk_1` FOREIGN KEY (`PokemonID`) REFERENCES `pokemon` (`ID`),
  ADD CONSTRAINT `pokemon_type_ibfk_2` FOREIGN KEY (`TypeID`) REFERENCES `type` (`ID`);

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `route_ibfk_1` FOREIGN KEY (`RegionID`) REFERENCES `region` (`ID`);

--
-- Constraints for table `user_pokemon`
--
ALTER TABLE `user_pokemon`
  ADD CONSTRAINT `user_pokemon_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `trainer` (`ID`),
  ADD CONSTRAINT `user_pokemon_ibfk_2` FOREIGN KEY (`PokemonID`) REFERENCES `pokemon` (`ID`),
  ADD CONSTRAINT `user_pokemon_ibfk_3` FOREIGN KEY (`NatureID`) REFERENCES `nature` (`ID`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
