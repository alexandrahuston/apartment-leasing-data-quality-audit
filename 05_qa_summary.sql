-- Apartment Leasing Data Quality Audit
-- Step 5: QA Summary Report
-- Author: Alexandra Huston
-- Purpose: Summarize findings from six SQL data quality
--          checks and generate a consolidated defect report
-- Dataset: Synthetic apartment leasing records


USE apartment_qa;

-- QA Summary: Count units with invalid rental prices
-- Business rule: Monthly rent must be greater than $0
-- Expected result: 2 invalid units

SELECT
    COUNT(*) AS invalid_rent_count
FROM units
WHERE monthly_rent <= 0
    OR monthly_rent IS NULL;


-- QA Summary: Count units assigned to nonexistent properties
-- Business rule: Every unit must belong to an existing property
-- Expected result: 1 invalid property reference

SELECT
    COUNT(*) AS missing_property_count
FROM units AS u
LEFT JOIN properties AS p
    ON u.property_id = p.property_id
WHERE p.property_id IS NULL;


-- QA Summary: Count leases with invalid date ranges
-- Business rule: Lease end date must be after lease start date
-- Expected result: 1 invalid lease

SELECT
    COUNT(*) AS invalid_lease_dates_count
FROM leases
WHERE lease_end <= lease_start;


-- QA Summary: Count active leases with missing rent
-- Business rule: Every active lease must have a monthly rent
-- Expected result: 1 active lease with missing rent

SELECT
    COUNT(*) AS missing_lease_rent_count
FROM leases
WHERE monthly_rent IS NULL
    AND lease_status = 'Active';


-- QA Summary: Count vacant units with active leases
-- Business rule: Vacant units should not have active leases
-- Expected result: 3 potential occupancy conflicts

SELECT
    COUNT(*) AS occupancy_conflict_count
FROM units AS u
INNER JOIN leases AS l
    ON u.unit_id = l.unit_id
WHERE u.occupancy_status = 'Vacant'
    AND l.lease_status = 'Active';
    

-- QA Summary: Count leases referencing nonexistent units
-- Business rule: Every lease must reference an existing unit
-- Expected result: 1 invalid unit reference

SELECT
    COUNT(*) AS missing_unit_count
FROM leases AS l
LEFT JOIN units AS u
    ON l.unit_id = u.unit_id
WHERE u.unit_id IS NULL;


-- Combined Data Quality Summary Report
-- Displays all six QA checks in one result table

SELECT 'QA-001' AS test_id,
       'Invalid monthly rent' AS issue,
       COUNT(*) AS defects_found
FROM units
WHERE monthly_rent <= 0 OR monthly_rent IS NULL

UNION ALL

SELECT 'QA-002',
       'Nonexistent property reference',
       COUNT(*)
FROM units AS u
LEFT JOIN properties AS p
    ON u.property_id = p.property_id
WHERE p.property_id IS NULL

UNION ALL

SELECT 'QA-003',
       'Invalid lease dates',
       COUNT(*)
FROM leases
WHERE lease_end <= lease_start

UNION ALL

SELECT 'QA-004',
       'Active lease missing rent',
       COUNT(*)
FROM leases
WHERE monthly_rent IS NULL
  AND lease_status = 'Active'

UNION ALL

SELECT 'QA-005',
       'Vacant unit with active lease',
       COUNT(*)
FROM units AS u
INNER JOIN leases AS l
    ON u.unit_id = l.unit_id
WHERE u.occupancy_status = 'Vacant'
  AND l.lease_status = 'Active'

UNION ALL

SELECT 'QA-006',
       'Nonexistent unit reference',
       COUNT(*)
FROM leases AS l
LEFT JOIN units AS u
    ON l.unit_id = u.unit_id
WHERE u.unit_id IS NULL;
