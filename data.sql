/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES ('Agumon', '2020-02-03', null, null, 10.23),
         ('Gabumon', '2018-11-15', 2, '1', 8),
         ('Pikachu', '2021-01-07', 1, '0', 15.04), 
         ('Devimon', '2017-05-12', 5, '1', 11);

SELECT * FROM animals;  -- to verify inserted data

-- Insert more animals
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, '0', -11),
       ('Plantmon', '2021-11-15', 2, '1', -5.7 ),
       ('Squirtle', '1993-04-02', 3, '0', -12.13),
       ('Angemon', '2005-06-12', 1, '1',-45),
       ('Boarmon', '2005-06-07', 7, '1', 20.4),
       ('Blossom', '1998-10-13', 3, '1', 17),
       ('Ditto', '2022-05-14', 4, '1', 22);

-- Query multiple tables


-- Insert the following data into the owners table:
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
      ('Jennifer Orwell', 19),
      ('Bob', 45),
      ('Melody Pond', 77),
      ('Dean Winchester', 14),
      ('Jodie Whittaker', 38);

-- Insert the following data into the species table:
INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');

-- Modify your inserted animals so it includes the species_id value
UPDATE animals
SET species_id =
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END;

-- Modify your inserted animals to include owner information (owner_id):
UPDATE animals
SET owner_id =
    CASE
        WHEN name = 'agumon' THEN (SELECT id FROM owners WHERE name = 'Sam Smith')
        WHEN name = 'gubamon' OR name = 'pikachu' THEN (SELECT id FROM owners WHERE name = 'Jennifer Orwell')
        WHEN name = 'devimon' OR name = 'plantmon' THEN (SELECT id FROM owners WHERE name = 'Bob')
        WHEN name = 'charmander' OR name = 'squirtle' OR name = 'blossom' THEN (SELECT id FROM owners WHERE name = 'Melody Pond')
        WHEN name = 'angemon' OR name = 'boarmon' THEN (SELECT id FROM owners WHERE name = 'Jennifer Orwell')
    END;
