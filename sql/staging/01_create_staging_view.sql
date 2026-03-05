/*
STAGING LAYER
-------------
Goal: Create a transformation layer that is clean + repeatable.
- Staging is where business logic begins (light transformations)
- Create a fictitious Admission_ID because the dataset has no Encounter/Admission ID.
*/

-- Create schema if needed
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'staging')
    EXEC('CREATE SCHEMA staging');
GO

/*
Admission_ID logic:
- Patient_ID + Admission_Date + Department (cleaned)
- This makes a consistent key that can be re-created every run
- Typically, in clinical systems, this would usually be Encounter_ID / Visit_ID from the EMR
*/
CREATE OR ALTER VIEW staging.vw_admissions AS
SELECT
    Patient_ID,
    Admission_Date,
    Discharge_Date,
    Age,
    Age_Group,
    Gender,
    Condition_Type,
    Department,
    Severity_Score,
    Length_of_Stay,
    Insurance_Type,
    Discharge_Status,
    Readmission_Within_30_Days,
    Clinical_Notes,

    CONCAT(
        CAST(Patient_ID AS varchar(20)), '-',
        CONVERT(char(8), Admission_Date, 112), '-',
        REPLACE(REPLACE(REPLACE(LOWER(Department), ' ', ''), '/', ''), '-', '')
    ) AS Admission_ID

FROM raw.simulated_hospital_admissions;
GO

-- Quick test: view returns rows + Admission_ID exists
SELECT TOP 10
  Patient_ID, Admission_Date, Department, Admission_ID
FROM staging.vw_admissions
ORDER BY Admission_Date;
