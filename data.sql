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
        WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN name = 'Gubamon' OR name = 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN name = 'Devimon' OR name = 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN name = 'Angemon' OR name = 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    END;

-- JOIN Table
-- Insert data into vets:
INSERT INTO vets (name, age, date_of_graduation)
VALUES('Vet William Tatcher', 45, '2000-04-23'),
      ('Vet Maisy Smith', 26, '2019-01-17'),
      ('Vet Stephanie Mendez', 64, '1981-05-04'),
      ('Vet Jack Harkness', 38, '2008-06-08');

-- Insert the data for specializations:
INSERT INTO specializations (vet_id, species_id)
VALUES (
       (SELECT id FROM vets WHERE name = 'Vet William Tatcher'),
       (SELECT id FROM species WHERE name = 'Pokemon')
       ),
       (
       (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
       (SELECT id FROM species WHERE name = 'Digimon')
       ),
       (
       (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
       (SELECT id FROM species WHERE name = 'Pokemon')
       ),
       (
       (SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
       (SELECT id FROM species WHERE name = 'Digimon')
       );

-- Insert data for visits:
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES
  (
    (SELECT id FROM vets WHERE name = 'Vet William Tatcher'),
    (SELECT id FROM animals WHERE name = 'Agumon'),
    '2020-05-24'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
    (SELECT id FROM animals WHERE name = 'Agumon'),
    '2020-07-22'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
    (SELECT id FROM animals WHERE name = 'Gubamon'),
    '2021-02-02'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    '2020-01-05'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    '2020-03-08'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    '2020-05-14'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
    (SELECT id FROM animals WHERE name = 'Devimon'),
    '2021-05-04'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
    (SELECT id FROM animals WHERE name = 'Charmander'),
    '2021-02-24'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    '2019-12-21'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet William Tatcher'),
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    '2020-08-10'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    '2021-04-07'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
    (SELECT id FROM animals WHERE name = 'Squirtle'),
    '2019-09-29'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
    (SELECT id FROM animals WHERE name = 'Angemon'),
    '2020-10-03'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
    (SELECT id FROM animals WHERE name = 'Angemon'),
    '2020-11-04'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    '2019-01-24'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    '2019-05-15'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    '2020-02-27'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    '2020-08-03'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
    (SELECT id FROM animals WHERE name = 'Blossom'),
    '2020-05-24'
  ),
  (
    (SELECT id FROM vets WHERE name = 'Vet William Tatcher'),
    (SELECT id FROM animals WHERE name = 'Blossom'),
    '2021-01-11'
  );