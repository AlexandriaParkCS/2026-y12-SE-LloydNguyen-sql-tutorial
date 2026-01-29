-- database: ../runtime/db/starwars.db

-- Practical 8: Advanced Queries with Subqueries
-- Student Name:
-- Date:
--
-- This script demonstrates subqueries and advanced query techniques

-- Query 1: Find all characters from the same planet as Luke Skywalker

-- First, let's see what planet Luke is from
SELECT homeworld_id FROM characters WHERE name = 'Luke Skywalker';

-- Now use that in a subquery
SELECT name, species
FROM characters
WHERE homeworld_id = (SELECT homeworld_id FROM characters WHERE name = 'Luke Skywalker');

-- Query 2: Find characters taller than the average height
SELECT name, height
FROM characters 
WHERE height > (SELECT AVG(height) FROM characters)
ORDER BY height DESC;

-- Query 3: Find characters from planets with "desert" terrain
SELECT name, species
FROM characters
WHERE homeworld_id IN (
    SELECT id
    FROM planets
    WHERE terrain LIKE '%desert%'
);

-- Query 4: Find characters NOT from Tatooine or Alderaan
SELECT name, species
FROM characters
WHERE homeworld_id NOT IN (
    SELECT id
    FROM planets
    WHERE name IN ('Tatooine', 'Alderaan')
);

-- Query 5: Find characters from planets with above-average popilation
SELECT c.name, p.name AS homeworld, p.population
FROM characters c 
JOIN planets p ON c.homeworld_id = p.id 
WHERE p.population > (
    SELECT AVG(population)
    FROM planets
    WHERE population IS NOT NULL
)
ORDER BY p.population DESC;

-- Query 6: Find characters who pilot at least one vehicle
SELECT name, species
FROM characters c 
WHERE EXISTS (
    SELECT 1
    FROM character_vehicles cv
    WHERE cv.character_id = c.id
);

-- Query 7: Find characters who DON'T pilot any vehicles
SELECT name, species
FROM characters c 
WHERE NOT EXISTS (
    SELECT 1
    FROM character_vehicles cv
    WHERE cv.character_id = c.id 
);

-- Query 8: Find planets that have at least one human character
SELECT p.name AS planet_name, p.climate
FROM planets p 
WHERE EXISTS (
    SELECT 1
    FROM characters c 
    WHERE c.homeworld_id = p.id 
    AND c.species = 'Human'
);

-- Query 9: Find characters who pilot the same type of vehicle as Luke
SELECT DISTINCT c.name
FROM characters c 
WHERE EXISTS (
    SELECT 1
    FROM character_vehicles cv1
    JOIN vehicles v1 ON cv1.vehicle_id = v1.id
    WHERE cv1.character_id = c.id 
    AND v1.vehicle_class IN (
        SELECT v2.vehicle_class
        FROM character_vehicles cv2
        JOIN vehicles v2 ON cv2.vehicle_id = v2.id
        JOIN characters c2 ON cv2.character_id = c2.id 
        WHERE c2.name = 'Luke Skywalker'
    )
)
AND c.name != 'Luke Skywalker';

-- Query 10: Show each character with a count of how many vehicles they polit
SELECT 
    c.name,
    c.species,
    (SELECT COUNT(*)
    FROM character_vehicles cv
    WHERE cv.character_id = c.id) AS vehicle_count
FROM characters c 
ORDER BY vehicle_count DESC;

-- Query 11: Character statistics
SELECT 
    name,
    height,
    (SELECT AVG(height) FROM characters) AS avg_height,
    height - (SELECT AVG(height) FROM characters) AS height_difference
FROM characters
WHERE height IS NOT NULL 
ORDER BY height_difference DESC;

-- Exercies 1: Find all characters from planets with "temperate" climate
SELECT name, species 
FROM characters
WHERE homeworld_id IN (
    SELECT id
    FROM planets 
    WHERE climate = 'temperate'
);

-- Exercise 2: Find vehicles piloted by more characters than average
SELECT v.name, COUNT(cv.character_id) AS pilot_count
FROM vehicles v 
JOIN character_vehicles cv ON v.id = cv.vehicle_id
GROUP BY v.name 
HAVING COUNT(cv.character_id) > (
    SELECT AVG(pilot_cnt)
    FROM (
        SELECT COUNT(character_id) AS pilot_cnt 
        FROM character_vehicles
        GROUP BY vehicle_id
    )
);

-- Exercise 3: Find planets with no characters
SELECT name, climate
FROM planets p 
WHERE NOT EXISTS (
    SELECT 1
    FROM characters c 
    WHERE c.homeworld_id = p.id
);

-- Exercise 4: Find characters shorter than all droids
SELECT name, species, height
FROM characters
WHERE height < (
    SELECT MIN(height)
    FROM characters
    WHERE species = 'Droid' AND height IS NOT NULL
)
AND height IS NOT NULL;


