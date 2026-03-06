/*
VALIDATION
----------
Goal: Prove data integrity across layers.
*/

-- Row count consistency across layers
SELECT 'raw' AS layer, COUNT(*) AS row_count FROM raw.simulated_hospital_admissions
UNION ALL
SELECT 'staging', COUNT(*) FROM staging.vw_admissions
UNION ALL
SELECT 'marts.fact_admissions_star', COUNT(*) FROM marts.fact_admissions_star;

-- Admission_ID should be unique
SELECT Admission_ID, COUNT(*) AS cnt
FROM staging.vw_admissions
GROUP BY Admission_ID
HAVING COUNT(*) > 1;

-- Critical null checks
SELECT
  SUM(CASE WHEN Patient_ID IS NULL THEN 1 ELSE 0 END) AS null_patient_id,
  SUM(CASE WHEN Admission_Date IS NULL THEN 1 ELSE 0 END) AS null_admission_date,
  SUM(CASE WHEN Admission_ID IS NULL THEN 1 ELSE 0 END) AS null_admission_id
FROM staging.vw_admissions;
