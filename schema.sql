/* Database schema to keep the structure of entire database. */

psql -U postgres -- log into postgreSQL as user postgres

CREATE DATABASE vet_clinic;  -- create a database named vet_clinic

\d -- list all table to verify the creation of vet_clinic

\c vet_clinic -- connect to the vet_clinic database

CREATE TABLE animals(
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
escape_attempts INT,
neutered BIT,
weight_kg FLOAT
);  -- create a table with listed fields, properties and constraint

\d vet_clinic -- to view the created fields

-- Add a new column to the table
ALTER TABLE animals
ADD COLUMN species VARCHAR(80);

--Query multiple table

-- Create a table named owners
CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
full_name VARCHAR(100) NOT NULL,
age INT 
);

-- Create a table named species
CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

-- Modify animals table

-- Make sure that id is set as autoincremented PRIMARY KEY
\d animals

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
-- Add the species_id column to the animals table
ALTER TABLE animals ADD COLUMN species_id INT;

-- Create the foreign key constraint
ALTER TABLE animals ADD CONSTRAINT fk_species_id
    FOREIGN KEY (species_id)
    REFERENCES species (id);

-- Add column owner_id which is a foreign key referencing owners table
-- Add the owner_id column to the animals table
ALTER TABLE animals ADD COLUMN owner_id INT;

-- Create the foreign key constraint
ALTER TABLE animals ADD CONSTRAINT fk_owner_id
    FOREIGN KEY (owner_id)
    REFERENCES owners (id);