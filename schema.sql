/* Database schema to keep the structure of entire database. */

psql -U postgres -- log into postgreSQL as user postgres

CREATE DATABASE vet_clinic;  -- create a database named vet_clinic

\d -- list all table to verify the creation of vet_clinic

\c vet_clinic -- connect to the vet_clinic database

CREATE TABLE animals(
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
escape_attempt INT,
neutered BIT,
weight_kg FLOAT
);  -- create a table with listed fields, properties and constraint

\d vet_clinic -- to view the created fields
