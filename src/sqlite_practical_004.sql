-- database: ../runtime/db/starwars.db

-- Practical 4: Aggregating and Grouping
-- Student Name: [Name]
-- Date: [Today]
--
-- This script demonstrates aggregate functions and grouping data

-- Query 1: Count how many characters are in the table
SELECT COUNT(*) FROM characters;

-- Query 2: Count characters who have a height recoreded
SELECT COUNT(height) FROM characters;
-- Note: COUNT(column) ignores NULL but COUNT(*) counts all.ALTER

-- Query 3: Find the tallest character's height
SELECT MAX(height) FROM characters;

-- Query 4: Find the shortest character's height
SELECT MIN(height) FROM characters;

-- Query 5: Calculate the average height of all characters
SELECT AVG(height) FROM characters;

-- Query 6: Add up all character heights
SELECT SUM(height) FROM characters;

-- Query 7: Get multiple statistics at once
SELECT
    COUNT(*) AS total_characters,
    AVG(height) AS average_height,
    MAX(height) AS tallest,
    MIN(height) AS shortest
FROM characters;
-- Explanation: AS creates an alies(friendly name) for the result column.ALTER

-- GROUP by Syntax
SELECT height, AGGREGATE_FUNCTION(height)
FROM characters
GROUP BY height;


-- Query 8: Count how many characters of each species
SELECT species, COUNT(*) AS character_count
FROM characters
GROUP BY species;

-- Query 9: Find the average height for each species
SELECT species, AVG(height) AS average_height
FROM characters
WHERE height IS NOT NULL
GROUP BY species;

-- Query 10: Count characters from each homeworld
SELECT homeworld, COUNT(*) AS character_count
FROM characters
GROUP BY homeworld
ORDER BY character_count DESC;
-- groups bt homeworld, counts each group then sorts by count (heighest first)



-- Add affiliation column
ALTER TABLE characters ADD COLUMN affiliation TEXT;

-- Update characters with affiliations
UPDATE characters SET affiliation = 'Rebel Alliance' WHERE name IN ('Luke Skywalker', 'Leia Organa', 'Han Solo', 'Chewbacca');
UPDATE characters SET affiliation = 'Jedi Order' WHERE name IN ('Obi-Wan Kenobi', 'Yoda');
UPDATE characters SET affiliation = 'Galactic Empire' WHERE name = 'Darth Vader';
UPDATE characters SET affiliation = 'Independent' WHERE name = 'R2-D2';


-- Query 11: Count characters in each affiliation
SELECT affiliation, COUNT(*) AS members
FROM characters
WHERE affiliation IS NOT NULL
GROUP BY affiliation
ORDER BY members DESC;

-- HAVING Syntax
SELECT name, AGGREGATE_FUNCTION(height)
FROM characters
GROUP BY height
HAVING condition;


-- Query 12: Show only species with 2 or more characters
SELECT species, COUNT(*) AS character_count
FROM characters
GROUP BY species
HAVING COUNT(*) >= 2;

-- Query 13: Find affiliations with more than the average number of members
SELECT affiliation, COUNT(*) AS member_count
FROM characters
WHERE affiliation IS NOT NULL
GROUP BY affiliation
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM characters
        WHERE affiliation IS NOT NULL
        GROUP BY affiliation));
-- complex. it calculates average group size them filters.


-- Query 14: Count humans by homeworld, only planets with 2+ humans
SELECT homeworld, COUNT(*) AS human_count
FROM characters
WHERE species = 'Human'
GROUP BY homeworld
HAVING COUNT(*) >= 2;
-- filter humans first, group remain rows by planet, show groupa 2+ characters.ALTER

-- COUNT DISTINCT
-- COUNT(DISTINCT column)

-- Query 15: How many different species are there?
SELECT COUNT(DISTINCT species) AS unique_species
FROM characters;

-- Query 16: How many different homeworlds are represented?
SELECT COUNT(DISTINCT homeworld) AS unique_homeworlds
FROM characters;

-- EXERCISES
-- Exercise 1: Find the total height of all characters combined
SELECT SUM(height) AS total_height
FROM characters;

-- Exercise 2: Count characters from each homeworld, sorted alphabetically
SELECT homeworld, COUNT(*) AS character_count
FROM characters 
GROUP BY homeworld
ORDER BY homeworld;

-- Exercise 3: Find average height by affiliation
SELECT affiliation, AVG(height) AS avg_height
FROM characters
WHERE height IS NOT NULL AND affiliation IS NOT NULL
GROUP BY affiliation;

-- Exercise 4: Show homewords that have exactly 1 character
SELECT homeworld, COUNT(*) AS character_count
FROM characters 
GROUP BY homeworld
HAVING COUNT(*) = 1;

-- ERROR: misuse of aggregate function
-- WRONG: 
SELECT species, COUNT(*)
FROM characters;
-- CORRECT:
SELECT species, COUNT(*)
FROM characters
GROUP BY species;
