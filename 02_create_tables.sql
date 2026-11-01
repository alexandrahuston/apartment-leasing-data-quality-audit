-- Apartment Leasing Data Quality Audit
-- Step 2: Create Database Tables
-- Author: Alexandra Huston
-- Purpose: Create tables for properties, units, and leases
-- Dataset: Synthetic apartment leasing records


USE apartment_qa;

-- Create a table to store apartment property information

CREATE TABLE properties (
	property_id INT PRIMARY KEY,
    property_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2),
    total_units int
);

-- Create a table for individual apartment units

CREATE TABLE units (
	unit_id INT PRIMARY KEY,
    property_id INT,
    unit_number VARCHAR(10),
    bedrooms INT,
    bathrooms INT,
    monthly_rent DECIMAL(10,2),
    occupancy_status VARCHAR(20)
);

-- Create a table for apartment leases

CREATE TABLE leases (
	lease_id INT PRIMARY KEY,
    unit_id INT,
    tenant_name VARCHAR(100),
    lease_start DATE,
    lease_end DATE,
    monthly_rent DECIMAL(10,2),
    lease_status VARCHAR(20)
);
