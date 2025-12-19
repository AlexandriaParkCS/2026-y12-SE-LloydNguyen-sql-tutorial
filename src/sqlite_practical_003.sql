-- database: ../runtime/db/starwars.db
-- Practical 3: Sorting and Limiting Results
-- Student Name: [Name]
-- Date: [Today]
--
-- This script demonstrates ORDER BY and LIMIT clauses

SELECT columns FROM characters ORDER BY column_name;

-- Add height column to characters table
ALTER TABLE characters ADD COLUMN height INTEGER;

-- Update character with height data (in centimetres)
UPDATE characters SET height = 172 WHERE name = 'Luke Skywalker';
UPDATE characters SET height = 150 WHERE name = 'Leia Organa';
UPDATE characters SET height = 180 WHERE name = 'Han Solo';
UPDATE characters SET height = 228 WHERE name = 'Chewbacca';
UPDATE characters SET height = 182 WHERE name = 'Obi-Wan Kenobi';
UPDATE characters SET height = 202 WHERE name = 'Darth Vader';
UPDATE characters SET height = 66 WHERE name = 'Yoda';
UPDATE characters SET height = 96 WHERE name = 'R2-D2';

-- Query 1: View all characters sorted by name (A-Z)
SELECT name, species, homeworld FROM characters ORDER BY name;

-- Query 2: View characters sorted by species
SELECT name, species FROM characters ORDER BY species;

-- Query 3: View characters sorted by height (shortest to tallest)
SELECT name, height FROM characters ORDER BY height;

-- Query 4: Explicitly sort ascending (same as Query 3)
SELECT name, height FROM characters ORDER BY height ASC;

-- Query 5: Sort by height (tallest to shortest)
SELECT name, height FROM characters ORDER BY height DESC;

-- Query 6: Sort names Z-A
SELECT name FROM characters ORDER BY name DESC;

-- Syntax
SELECT columns FROM characters ORDER BY name, height;

-- Query 7: SOrt by species first, then by name within each species

SELECT name, species, homeworld
FROM characters
ORDER BY species, name;

-- Query 8: Sort by species (A-Z), then height (tallest to shortest)
SELECT name, species, height
FROM characters
ORDER BY species ASC, height DESC;

-- Query 9: Group by homeworld, them by species
SELECT homeworld, species, name 
FROM characters
ORDER BY homeworld, species;

-- Limit Syntex
SELECT columns FROM characters LIMIT 5;

-- Query 10: View only the first 5 characters
SELECT name FROM characters LIMIT 5;

-- Query 11: Find the tallest character 
SELECT name, height
FROM characters
ORDER BY height DESC
LIMIT 1;

-- Query 12: Find the three shortest characters
SELECT name, height
FROM characters
ORDER BY height ASC
LIMIT 3;

-- Query 13: Get the first 5 names alphabetically
SELECT name FROM characters ORDER BY name LIMIT 5;

-- Offset Syntax
SELECT columns FROM characters LIMIT number OFFSET number;

-- Query 14: Get characters 4-8 (skip first 3)
SELECT name FROM characters ORDER BY name LIMIT 5 OFFSET 3;



-- Page 1: First 3 characters
SELECT name FROM characters ORDER BY name LIMIT 3 OFFSET 0;

-- Page 2: Next 3 characters
SELECT name FROM characters ORDER BY name LIMIT 3 OFFSET 3;

-- Page 3: Next 3 characters
SELECT name FROM characters ORDER BY name LIMIT 3 OFFSET 6;


-- Order of Clauses. Order matters! ALWAYS: SELECT -> FROM -> WHERE -> ORDER BY -> LIMIT
SELECT columns 
FROM table_name
WHERE condition
ORDER BY column 
LIMIT number;

-- Query 15: Find the tallest human
SELECT name, species, height
FROM characters
WHERE species = 'Human'
ORDER BY height DESC
LIMIT 1;

-- Query 16: Find 3 characters NOT from Tatooine, sorted by name
SELECT name, homeworld
FROM characters
WHERE homeworld != 'Tatooine'
ORDER BY name
LIMIT 3;


-- Exercise 1: Find the 5 tallest characters
SELECT name, height
FROM characters
ORDER BY height DESC
LIMIT 5;

-- Exercise 2: List all unique species in alphabetical order
SELECT DISTINCT species
FROM characters
ORDER BY species;

-- Exercise 3: Find all humans sorted by height (shorstest first)
SELECT name, species, height
FROM characters
WHERE species = 'Human'
ORDER BY height ASC;

-- Exercise 4: Find the second and third tallest characters
SELECT name, height
FROM characters 
ORDER BY height DESC
LIMIT 2 OFFSET 1;