-- Insert Pokemon data
INSERT INTO `Pokemon` (`ID`, `Name`) VALUES
                                         (371, 'Bagon'),
                                         (372, 'Shelgon'),
                                         (373, 'Salamence'),
                                         (443, 'Gible'),
                                         (444, 'Gabite'),
                                         (445, 'Garchomp');
-- Insert Pokemon stats
INSERT INTO `PokemonStats` (`PokemonID`, `HP`, `Attack`, `Defense`, `SpAttack`, `SpDefense`, `Speed`) VALUES
                                                                                                          (371, 45, 75, 60, 40, 30, 50),
                                                                                                          (372, 65, 95, 100, 60, 50, 50),
                                                                                                          (373, 95, 135, 80, 110, 80, 100),
                                                                                                          (443, 58, 70, 45, 40, 45, 42),
                                                                                                          (444, 68, 90, 65, 50, 55, 82),
                                                                                                          (445, 108, 130, 95, 80, 85, 102);
-- Insert Pokemon evolutions
INSERT INTO `Pokemon_Evolutions` (`BasePokemonID`, `EvolvedPokemonID`) VALUES
                                                                           (371, 372),
                                                                           (372, 373),
                                                                           (443, 444),
                                                                           (444, 445);

-- Insert types with their respective colors
INSERT IGNORE INTO `Type` (`Name`, `Color`) VALUES
                                                ('Normal', '#A8A77A'),
                                                ('Fire', '#EE8130'),
                                                ('Water', '#6390F0'),
                                                ('Electric', '#F7D02C'),
                                                ('Grass', '#7AC74C'),
                                                ('Ice', '#96D9D6'),
                                                ('Fighting', '#C22E28'),
                                                ('Poison', '#A33EA1'),
                                                ('Ground', '#E2BF65'),
                                                ('Flying', '#A98FF3'),
                                                ('Psychic', '#F95587'),
                                                ('Bug', '#A6B91A'),
                                                ('Rock', '#B6A136'),
                                                ('Ghost', '#735797'),
                                                ('Dragon', '#6F35FC'),
                                                ('Dark', '#705746'),
                                                ('Steel', '#B7B7CE'),
                                                ('Fairy', '#D685AD');


-- Insert Pokemon types
INSERT INTO `Pokemon_Type` (`PokemonID`, `TypeID`) VALUES
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Bagon'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Dragon')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Shelgon'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Dragon')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Salamence'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Dragon')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Salamence'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Flying')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gible'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Dragon')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gible'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Ground')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gabite'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Dragon')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gabite'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Ground')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Garchomp'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Dragon')),
                                                       ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Garchomp'), (SELECT `ID` FROM `Type` WHERE `Name` = 'Ground'));
-- Insert abilities if not already present
INSERT IGNORE INTO `Ability` (`Name`, `Desc`) VALUES
                                                  ('Rock Head', 'Does not receive recoil damage from recoil-causing damages.'),
                                                  ('Sheer Force', 'Moves with a secondary effect are increased in power by 33% but lose their secondary effect.'),
                                                  ('Sand Veil', 'Raises the Pokémon’s evasion during a sandstorm by one level.'),
                                                  ('Rough Skin', 'The opponent is hurt by 1/16th of his maxium Hit Points of recoil when using an attack, that requires physical contact, against this Pokémon.'),
                                                  ('Overcoat', 'It will not take damage from weather effects.'),
                                                  ('Intimidate', 'Upon entering battle, the opponent’s Attack lowers one stage.'),
                                                  ('Moxie', 'Attack is raised by one stage when the Pokémon knocks out another Pokémon.');

-- Insert Pokemon abilities
INSERT INTO `Pokemon_Ability` (`PokemonID`, `AbilityID`) VALUES
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Bagon'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Rock Head')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Bagon'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Sheer Force')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Shelgon'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Rock Head')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Shelgon'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Overcoat')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Salamence'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Intimidate')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Salamence'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Moxie')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gible'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Sand Veil')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gible'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Rough Skin')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gabite'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Sand Veil')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gabite'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Rough Skin')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Garchomp'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Sand Veil')),
                                                             ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Garchomp'), (SELECT `ID` FROM `Ability` WHERE `Name` = 'Rough Skin'));

-- Insert regions
INSERT IGNORE INTO `Region` (`ID`, `Name`) VALUES
                                               (1, 'Kanto'),
                                               (2, 'Johto'),
                                               (3, 'Hoenn'),
                                               (4, 'Sevii Islands'),
                                               (5, 'Sinnoh'),
                                               (6, 'Unova'),
                                               (7, 'Kalos'),
                                               (8, 'Alola'),
                                               (9, 'Galar');


-- Insert routes for Unova
INSERT IGNORE INTO `Route` (`ID`, `Name`, `RegionID`) VALUES
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
-- Insert Pokemon routes
INSERT INTO `Pokemon_Route` (`PokemonID`, `RouteID`) VALUES
                                                         ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Bagon'), (SELECT `ID` FROM `Route` WHERE `Name` = 'White Forest')),
                                                         ((SELECT `ID` FROM `Pokemon` WHERE `Name` = 'Gible'), (SELECT `ID` FROM `Route` WHERE `Name` = 'Floccesy Town'));

-- Insert natures if not already present
INSERT IGNORE INTO `Nature` (`Name`, `IncreasedStat`, `DecreasedStat`) VALUES
                                                                           ('Adamant', 'Attack', 'Sp. Atk'),
                                                                           ('Bashful', 'Sp. Atk', 'Sp. Atk'),
                                                                           ('Bold', 'Defense', 'Attack'),
                                                                           ('Brave', 'Attack', 'Speed'),
                                                                           ('Calm', 'Sp. Def', 'Attack'),
                                                                           ('Careful', 'Sp. Def', 'Sp. Atk'),
                                                                           ('Docile', 'Defense', 'Defense'),
                                                                           ('Gentle', 'Sp. Def', 'Defense'),
                                                                           ('Hardy', 'Attack', 'Attack'),
                                                                           ('Hasty', 'Speed', 'Defense'),
                                                                           ('Impish', 'Defense', 'Sp. Atk'),
                                                                           ('Jolly', 'Speed', 'Sp. Atk'),
                                                                           ('Lax', 'Defense', 'Sp. Def'),
                                                                           ('Lonely', 'Attack', 'Defense'),
                                                                           ('Mild', 'Sp. Atk', 'Defense'),
                                                                           ('Modest', 'Sp. Atk', 'Attack'),
                                                                           ('Naive', 'Speed', 'Sp. Def'),
                                                                           ('Naughty', 'Attack', 'Sp. Def'),
                                                                           ('Quiet', 'Sp. Atk', 'Speed'),
                                                                           ('Quirky', 'Sp. Def', 'Sp. Def'),
                                                                           ('Rash', 'Sp. Atk', 'Sp. Def'),
                                                                           ('Relaxed', 'Defense', 'Speed'),
                                                                           ('Sassy', 'Sp. Def', 'Speed'),
                                                                           ('Serious', 'Speed', 'Speed'),
                                                                           ('Timid', 'Speed', 'Attack');