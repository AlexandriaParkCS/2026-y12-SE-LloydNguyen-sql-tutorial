-- database: ../runtime/db/starwars.db

-- Practical 5: Multiple Tables and Relationships (Schema)
-- Student Name:
-- Date:
--
-- This script creates related tables with foreign keys

-- Create planets table
CREATE TABLE IF NOT EXISTS planets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    climate TEXT,
    terrain TEXT,
    population INTEGER
);

-- Create vehicles table
CREATE TABLE IF NOT EXISTS vehicles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    model TEXT,
    vehicle_class TEXT,
    manufacturer TEXT
);

-- Create character_vehicles junction table
CREATE TABLE IF NOT EXISTS character_vehicles (
character_id INTEGER NOT NULL, 
vehicle_id INTEGER NOT NULL,
PRIMARY KEY (character_id, vehicle_id),
FOREIGN KEY (character_id) REFERENCES characters(id),
FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);
-- Add homeworld_id column
ALTER TABLE characters ADD COLUMN homeworld_id INTEGER;

-- Add foreign key constraint (Note: SQLite has limited ALTER TABLE support)
-- In production, you'd recreated the table with FOREIGN KEY constraint



-- Insert planets 
INSERT INTO planets (name, climate, terrain, population) VALUES
('Tatooine', 'arid', 'desert', 200000),
('Alderaan', 'temperate', 'grasslands, mountains', 2000000000),
('Hoth', 'frozen', 'tundra, ice caves', NULL),
('Kashyyyk', 'tropical', 'jungle, forests', 45000000),
('Naboo', 'temperate', 'grassy hills, swaps', 4500000000),
('Corellia', 'temperate', 'plains, urban', 3000000000),
('Stewjon', 'temperate', 'grass', NULL),
('Unknown', NULL, NULL, NULL);

-- Update characters with homeworld_id
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Tatooine') WHERE homeworld = 'Tatooine';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Alderaan') WHERE homeworld = 'Alderaan';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Corellia') WHERE homeworld = 'Corellia';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Kashyyyk') WHERE homeworld = 'Kashyyyk';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Stewjon') WHERE homeworld = 'Stewjon';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Naboo') WHERE homeworld = 'Naboo';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Unknown') WHERE homeworld = 'Unknown';

-- Insert vehicles 
INSERT INTO vehicles (name, model, vehicle_class, manufacturer) VALUES
('X-wing', 'T-65 X-wing', 'Starfighter', 'Incom Corporation'),
('Millennium Falcon', 'YT-1300 light freighter', 'Light freighter', 'Corellian Engineering Corporation'),
('TIE Fighter', 'Twin Ion Engine Fighter', 'Starfighter', 'Sienar Fleet Systems'),
('Imperial Speeder Bike', '74-Z speeder bike', 'Speeder', 'Aratech Repulsor Company'),
('Snowspeeder', 'T-47 airspeeder', 'Airspeeder', 'Incom Corpoation'),
('Lambda Shittle', 'Lambda-class shuttle', 'Transport', 'Sienar Fleet Systems'),
('AT-AT', 'All Terrain Armoured Transport', 'Assault walker', 'Kuat Drive Yards'),
('Jedi Starfighter', 'Delta- 7 Aethersprite', 'Starfighter', 'Kuat Systems Engineering');

-- Link characters to vehicles (many-to-many relationship)
INSERT INTO character_vehicles (character_id, vehicle_id) VALUES
-- Luke flies X-wing, Snowspeeder
(1, 1),
(1, 5),
-- Han flies Millennium Falcon
(3, 2),
-- Chewbacca also flies Millennium Falcon
(4, 2),
-- Obi-Wan flies Jedi Starfighter
(5, 8),
-- Darth Vader flies TIE Fighter, Lambda Shuttle
(6, 3),
(6, 6),
-- Yoda flies... nothing (wise, he walks)
-- R2-D2 is IN X-wing and Jedi Starfighter
(8, 1),
(8, 8);

-- View all planets
SELECT * FROM planets;

-- View all vehicles
SELECT * FROM vehicles;

-- View character-vehicle links
SELECT * FROM character_vehicles;

-- View updated characters table
SELECT id, name, homeworld, homeworld_id FROM characters;

SELECT * FROM characters;

-- PRACTICE

-- Practice: Add more planets 
INSERT INTO planets (name, climate, terrain, population) VALUES
('Americano', 'hot', NULL, NULL),
('Alibaba', 'hot', NULL, NULL);

-- Practice: Add more vehivles
INSERT INTO vehicles (name, model, vehicle_class, manufacturer) VALUES
('A52', 'Abi ZZ52', 'transport', 'IDK'),
('Abitin', 'Abi ZZ52', 'transport', 'IDK');

-- Practice: Link vehicles to characters
INSERT INTO character_vehicles(character_id, vehicle_id) VALUES
-- Awaowa flies A52
(9, 9),
-- EJ-112 flies Abitin
(11, 10);

