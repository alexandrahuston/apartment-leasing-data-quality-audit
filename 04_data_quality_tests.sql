-- Apartment Leasing Data Quality Audit
-- Step 4: Data Quality Testing
-- Author: Alexandra Huston
-- Purpose: Validate apartment leasing data against six
--          business rules and identify potential defects
-- Dataset: Synthetic apartment leasing records


USE apartment_qa;

-- QA-001: Identify invalid apartment rental prices
-- Business rule: Monthly rent must be greater than $0
-- Expected result: Units 1011 and 1012

SELECT
    unit_id,
    property_id,
    unit_number,
    monthly_rent
FROM units
WHERE monthly_rent <= 0
   OR monthly_rent IS NULL;
-- QA-001: PASS — the query correctly detected both intentionally invalid records.


-- QA-002: Identify units assigned to nonexistent properties
-- Business rule: Every unit must belong to an existing property
-- Expected result: Unit 1013 (property_id 999)

SELECT
    u.unit_id,
    u.property_id,
    u.unit_number,
    p.property_name
FROM units AS u
LEFT JOIN properties AS p
    ON u.property_id = p.property_id
WHERE p.property_id IS NULL;
-- QA-002 PASS - test passed because it detected the expected 1 defect


-- QA-003: Identify invalid lease dates
-- Business rule: Lease end date must be after lease start date
-- Expected result: Lease 5010

SELECT
    lease_id,
    unit_id,
    tenant_name,
    lease_start,
    lease_end
FROM leases
WHERE lease_end <= lease_start;
-- QA-003: PASS - Detected 1 lease with an invalid date range.


-- QA-004: Identify leases with missing rental amounts
-- Business rule: Every active lease must have a monthly rent
-- Expected result: Lease 5011

SELECT 
	lease_id,
    unit_id,
    tenant_name,
    monthly_rent,
    lease_status
FROM leases
WHERE monthly_rent IS NULL
	AND lease_status = 'Active';
-- QA-004: PASS - Detected 1 active lease with missing rent.


-- QA-005: Identify vacant units with active leases
-- Business rule: A vacant unit should not have an active lease
-- Expected result: 3 potential occupancy conflicts
-- Units: 1002, 1005, and 1010


SELECT 
	u.unit_id,
    u.unit_number,
    u.occupancy_status,
    l.lease_id,
	l.tenant_name,
	l.lease_status
FROM units AS u
INNER JOIN leases AS l
	ON u.unit_id = l.unit_id
WHERE u.occupancy_status = 'Vacant'
	AND l.lease_status = 'Active';
-- QA-005: PASS - Query identified 3 potential occupancy conflicts.
	-- Actual results: Units 1002, 1005, and 1010.
	-- Further investigation required to confirm business impact.


-- QA-006: Identify leases assigned to nonexistent units
-- Business rule: Every lease must reference an existing unit
-- Expected result: Lease 5012 (unit_id 9999)

SELECT
    l.lease_id,
    l.unit_id,
    l.tenant_name,
    u.unit_number
FROM leases AS l
LEFT JOIN units AS u
    ON l.unit_id = u.unit_id
WHERE u.unit_id IS NULL;
-- QA-006: PASS - Detected 1 lease referencing a nonexistent unit.