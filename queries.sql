/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT name FROM animals
  WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals
  WHERE date_of_birth > '2016-01-01' 
  AND date_of_birth < '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals
  WHERE neutered = '1' 
  AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals
  WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals
  WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals
  WHERE neutered = '1';

-- Find all animals not named Gabumon.
SELECT * FROM animals
  WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals
  WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Vet clinic database: query and update animals table

QUERY



-- Update species column to unspecified and roll back transaction

-- start a transaction
BEGIN;

-- update species column
ALTER TABLE animals
RENAME COLUMN species TO unspecified;

SELECT * FROM animals;

ROLLBACK;

\d animals -- Verify Rollback

-- start a transaction
BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.

UPDATE animals 
SET species = 'digimon' 
WHERE name LIKE '%mon';


-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals 
SET species = 'pokimon'
WHERE NULLIF(species, '') IS NULL;

-- commit the transaction
COMMIT;

-- Verify the transaction
SELECT * FROM animals;
 

-- DELETE ALL RECORDS FROM ANIMALS TABLE
-- start a transaction
BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

-- Roll back the transaction
ROLLBACK;

SELECT * FROM animals;


-- start a transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT animals_sp_1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint.
ROLLBACK TO animals_sp_1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit transaction.
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE COALESCE(escape_attempts, 0) = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-31'
GROUP BY species;

-- Query multiple tables


-- What animals belong to Melody Pond?
SELECT animals.name
FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
FROM animals 
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name, animals.name;


-- How many animals are there per species?
SELECT species.name AS species, COUNT(*) AS num_animals
FROM animals 
JOIN species ON animals.species_id = species.id
GROUP BY species.name;


-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS animal
FROM animals 
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';


-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name AS animal
FROM animals
WHERE owner_id = (
  SELECT id
  FROM owners
  WHERE full_name = 'Dean Winchester'
) AND escape_attempts = 0;


-- Who owns the most animals?
SELECT owners.full_name AS owner, COUNT(*) AS num_animals_owned
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY num_animals_owned DESC
LIMIT 1;
