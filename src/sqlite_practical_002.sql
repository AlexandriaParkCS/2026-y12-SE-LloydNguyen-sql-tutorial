-- database: ../runtime/db/starwars.db

-- Practical 2: Selecting anf Filtering Data
-- Student Name: [Lloyd]
-- Date: [16 12 2025]
--
-- This script demonstrates SELECT queries with WHERE clauses

SELECT * FROM table_name;

-- Query 1: View all characters and all columns
SELECT * FROM characters;

-- Query 2: View only names and species
SELECT name, species FROM characters;

-- Query 3: View columns in a different order
SELECT homeworld, name, species FROM characters;

SELECT columns FROM characters WHERE condition;

-- Query 4: Find all human characters
SELECT * FROM characters WHERE species = 'Human';

-- Query 5: Find all characters from Tatooine
SELECT name, homeworld FROM characters WHERE homeworld = 'Tatooine';

-- Query 6: Fidn all characters who are NOT human
SELECT name, species FROM characters WHERE species != 'Human';
