/*
MARTS LAYER (DIMENSIONS)
-----------------------
Goal: Create dimension tables for a star schema.
- To standardize descriptive fields (department, condition, insurance, patient)
- To give surrogate keys (identity integers) for clean joins
- Makes the model BI/Analytics ready
*/

-- Create schema if needed
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'marts')
    EXEC('CREATE SCHEMA marts');
GO

-- DIM: Department
IF OBJECT_ID('marts.dim_department', 'U') IS NOT NULL DROP TABLE marts.dim_department;
GO

CREATE TABLE marts.dim_department (
  Department_Key INT IDENTITY(1,1) PRIMARY KEY,
  Department VARCHAR(100) NOT NULL
);
GO

INSERT INTO marts.dim_department (Department)
SELECT DISTINCT Department
FROM staging.vw_admissions
ORDER BY Department;
GO

-- DIM: Condition
IF OBJECT_ID('marts.dim_condition', 'U') IS NOT NULL DROP TABLE marts.dim_condition;
GO

CREATE TABLE marts.dim_condition (
  Condition_Key INT IDENTITY(1,1) PRIMARY KEY,
  Condition_Type VARCHAR(100) NOT NULL
);
GO

INSERT INTO marts.dim_condition (Condition_Type)
SELECT DISTINCT Condition_Type
FROM staging.vw_admissions
ORDER BY Condition_Type;
GO

-- DIM: Insurance
IF OBJECT_ID('marts.dim_insurance', 'U') IS NOT NULL DROP TABLE marts.dim_insurance;
GO

CREATE TABLE marts.dim_insurance (
  Insurance_Key INT IDENTITY(1,1) PRIMARY KEY,
  Insurance_Type VARCHAR(100) NOT NULL
);
GO

INSERT INTO marts.dim_insurance (Insurance_Type)
SELECT DISTINCT Insurance_Type
FROM staging.vw_admissions
ORDER BY Insurance_Type;
GO

-- DIM: Patient
IF OBJECT_ID('marts.dim_patient', 'U') IS NOT NULL DROP TABLE marts.dim_patient;
GO

CREATE TABLE marts.dim_patient (
  Patient_Key INT IDENTITY(1,1) PRIMARY KEY,
  Patient_ID INT NOT NULL,
  Age INT NULL,
  Age_Group VARCHAR(50) NULL,
  Gender VARCHAR(20) NULL
);
GO

INSERT INTO marts.dim_patient (Patient_ID, Age, Age_Group, Gender)
SELECT DISTINCT Patient_ID, Age, Age_Group, Gender
FROM staging.vw_admissions
ORDER BY Patient_ID;
GO

-- Quick checks: counts
SELECT COUNT(*) AS dept_cnt FROM marts.dim_department;
SELECT COUNT(*) AS cond_cnt FROM marts.dim_condition;
SELECT COUNT(*) AS ins_cnt  FROM marts.dim_insurance;
SELECT COUNT(*) AS patient_cnt FROM marts.dim_patient;
