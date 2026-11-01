-- Apartment Leasing Data Quality Audit
-- Step 3: Insert Sample Data
-- Author: Alexandra Huston
-- Purpose: Populate database tables with fictional apartment
--          leasing data, including intentional quality defects
-- Dataset: Synthetic apartment leasing records


USE apartment_qa;

-- Insert apartment property records

INSERT INTO properties
	(property_id, property_name, city, state, total_units)
VALUES
	(101, 'Mountain View Apartments', 'Denver', 'CO', 120),
    (102, 'Pine Creek Residences', 'Fort Collins', 'CO', 85),
    (103, 'Riverbend Flats', 'Boulder', 'CO', 150),
    (104, 'Sunset Ridge Apartments', 'Colorado Springs', 'CO', 95),
    (105, 'Aspen Grove Living', 'Loveland', 'CO', 75);
    
-- Verify property records were inserted correctly

SELECT *
FROM properties;


-- Insert fictional apartment unit records
-- Some records intentionally contain data quality issues

INSERT INTO units
    (unit_id, property_id, unit_number, bedrooms,
     bathrooms, monthly_rent, occupancy_status)
VALUES
    (1001, 101, 'A101', 1, 1, 1450.00, 'Occupied'),
    (1002, 101, 'A102', 2, 2, 1850.00, 'Vacant'),
    (1003, 101, 'A103', 2, 2, 1900.00, 'Occupied'),
    (1004, 102, 'B201', 1, 1, 1350.00, 'Occupied'),
    (1005, 102, 'B202', 3, 2, 2200.00, 'Vacant'),
    (1006, 103, 'C301', 2, 2, 2100.00, 'Occupied'),
    (1007, 103, 'C302', 1, 1, 1650.00, 'Vacant'),
    (1008, 104, 'D401', 2, 1, 1750.00, 'Occupied'),
    (1009, 104, 'D402', 3, 2, 2400.00, 'Occupied'),
    (1010, 105, 'E501', 1, 1, 1400.00, 'Vacant'),
    (1011, 105, 'E502', 2, 2, -1800.00, 'Occupied'),
    (1012, 101, 'A104', 1, 1, NULL, 'Vacant'),
    (1013, 999, 'X999', 2, 2, 1950.00, 'Occupied'),
    (1014, 102, 'B203', 2, 2, 1750.00, 'Unknown'),
    (1015, 103, 'C303', 1, 1, 1600.00, 'Occupied');

-- Verify apartment unit records

SELECT *
FROM units;

SELECT COUNT(*) AS total_properties
FROM properties;
-- Expected result: 5 
SELECT COUNT(*) AS total_units
FROM units;
-- Expected result: 15

-- Insert fictional apartment lease records
-- Some records intentionally contain data quality issues

INSERT INTO leases
    (lease_id, unit_id, tenant_name, lease_start,
     lease_end, monthly_rent, lease_status)
VALUES
    (5001, 1001, 'Emma Johnson', '2026-01-01', '2026-12-31', 1450.00, 'Active'),
    (5002, 1003, 'Michael Davis', '2026-03-01', '2027-02-28', 1900.00, 'Active'),
    (5003, 1004, 'Sophia Martinez', '2026-06-01', '2027-05-31', 1350.00, 'Active'),
    (5004, 1006, 'James Wilson', '2026-02-01', '2027-01-31', 2100.00, 'Active'),
    (5005, 1008, 'Olivia Brown', '2026-04-01', '2027-03-31', 1750.00, 'Active'),
    (5006, 1009, 'Liam Anderson', '2026-05-01', '2027-04-30', 2400.00, 'Active'),
    (5007, 1015, 'Ava Thompson', '2026-07-01', '2027-06-30', 1600.00, 'Active'),

    -- Intentional QA issues
    (5008, 1002, 'Noah Taylor', '2026-01-01', '2026-12-31', 1850.00, 'Active'),
    (5009, 1003, 'Isabella Moore', '2026-08-01', '2027-07-31', 1900.00, 'Active'),
    (5010, 1010, 'Ethan White', '2026-09-01', '2026-03-01', 1400.00, 'Active'),
    (5011, 1005, 'Mia Harris', '2026-05-01', '2027-04-30', NULL, 'Active'),
    (5012, 9999, 'Lucas Clark', '2026-06-01', '2027-05-31', 1800.00, 'Active');

-- Verify lease records

SELECT *
FROM leases;

SELECT COUNT(*) AS total_leases
FROM leases;
-- Expected result: 12