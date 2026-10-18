/*
=====================================================
PROJECT: DATA QUALITY & VALIDATION ENGINE
DATABASE: dq_project
DATABASE SYSTEM: MySQL
=====================================================
*/

-- STEP 1: Create database
CREATE DATABASE IF NOT EXISTS dq_project;

-- STEP 2: Select database
USE dq_project;

-- STEP 3: Create raw customers table
CREATE TABLE IF NOT EXISTS customers_raw (
    row_id INT,
    customer_id TEXT,
    customer_name TEXT,
    email TEXT,
    mobile TEXT,
    state TEXT,
    date_of_birth TEXT,
    created_at TEXT
);

-- STEP 4: Create raw policies table
CREATE TABLE IF NOT EXISTS policies_raw (
    row_id INT,
    policy_id TEXT,
    customer_id TEXT,
    product_type TEXT,
    start_date TEXT,
    end_date TEXT,
    premium_amount TEXT,
    policy_status TEXT,
    agent_id TEXT
);

-- STEP 5: Create raw payments table
CREATE TABLE IF NOT EXISTS payments_raw (
    row_id INT,
    payment_id TEXT,
    policy_id TEXT,
    payment_date TEXT,
    payment_amount TEXT,
    payment_status TEXT,
    payment_method TEXT
);

-- STEP 6: Verify tables
SHOW TABLES;

LOAD DATA LOCAL INFILE
'C:/Users/PRAVANJAN KUANR/OneDrive/Desktop/Desktop/Data Analytics/Data Quality & Validation Engine/customers.csv'
INTO TABLE customers_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

/*
Step 1: Enable LOCAL INFILE on MySQL Server

1. Open MySQL Workbench.
2. Connect to your MySQL database.
3. Run the first command to check whether LOCAL INFILE is enabled.
4. If the result is OFF, run the second command to enable it.
5. Run the first command again to verify the value is ON.

Note:
This setting helps resolve Error Code 3948:
Loading local data is disabled; this must be enabled
on both the client and server sides.

SET GLOBAL requires appropriate administrative privileges.
The setting may reset after restarting the MySQL server.
Enable it only when importing trusted files.
*/

-- Check current LOCAL INFILE status
SHOW GLOBAL VARIABLES LIKE 'local_infile';

-- Enable LOCAL INFILE on the server
SET GLOBAL local_infile = 1;

-- Verify LOCAL INFILE is enabled
SHOW GLOBAL VARIABLES LIKE 'local_infile';

/*
Step 2: Fix MySQL Workbench Settings

1. Open MySQL Workbench.
2. Go to Database -> Manage Connections.
3. Select your connection, such as "Local instance MySQL80".
4. Click the Advanced tab.
5. In the Others field, add:

   OPT_LOCAL_INFILE=1

6. Click OK to save the connection.
7. Close MySQL Workbench completely.
8. Reopen MySQL Workbench.
9. Reconnect to your database.

Note:
This setting helps resolve Error Code 2068:
LOAD DATA LOCAL INFILE file request rejected
due to restrictions on access.
*/


LOAD DATA LOCAL INFILE
'C:/Users/PRAVANJAN KUANR/OneDrive/Desktop/Desktop/Data Analytics/Data Quality & Validation Engine/customers.csv'
INTO TABLE customers_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'C:/Users/PRAVANJAN KUANR/OneDrive/Desktop/Desktop/Data Analytics/Data Quality & Validation Engine/payments.csv'
INTO TABLE payments_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'C:/Users/PRAVANJAN KUANR/OneDrive/Desktop/Desktop/Data Analytics/Data Quality & Validation Engine/policies.csv'
INTO TABLE policies_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- STEP 7: View raw data
SELECT * FROM customers_raw;
SELECT * FROM policies_raw;
SELECT * FROM payments_raw;

-- STEP 8: Check record counts
SELECT COUNT(*) AS total_customers FROM customers_raw;
SELECT COUNT(*) AS total_policies FROM policies_raw;
SELECT COUNT(*) AS total_payments FROM payments_raw;

SELECT 'customers_raw' AS table_name, COUNT(*) AS total_rows
FROM customers_raw

UNION ALL

SELECT 'policies_raw', COUNT(*)
FROM policies_raw

UNION ALL

SELECT 'payments_raw', COUNT(*)
FROM payments_raw;
