# Data Architecture Overview

This project demonstrates a simple analytics engineering workflow using a simulated hospital admissions dataset.

The goal was to design a clean and reproducible data pipeline that separates ingestion, transformation, and analytics modeling.

## Architecture Flow

Landing (CSV in Azure Blob Storage)  
→ Azure Data Factory ingestion pipeline  
→ Azure SQL Database

Within the SQL database the data is organized into layered schemas:

### Raw Layer

`raw.simulated_hospital_admissions`

This table stores the dataset exactly as it arrives from the source file.  
No transformations or business logic are applied here.  
The raw layer serves as the source of truth for downstream processing.

### Staging Layer

`staging.vw_admissions`

The staging layer introduces light transformation logic and creates a deterministic **Admission_ID** because the dataset does not contain a natural encounter identifier.

Admission_ID is generated using:

Patient_ID + Admission_Date + Department

This approach ensures a consistent key that can be recreated across pipeline runs.

### Marts Layer

The marts schema contains a **star schema** used for analytics and reporting.

Dimension tables:

- dim_patient
- dim_department
- dim_condition
- dim_insurance

Fact table:

- fact_admissions_star

The fact table stores each admission event and references dimension tables using surrogate keys.

This structure allows BI tools such as Power BI to query the data efficiently while keeping descriptive attributes normalized in dimension tables.

## Data Validation

Basic validation checks are included to confirm:

- Raw vs staging vs mart row counts match
- Admission_ID values are unique
- Critical fields do not contain unexpected nulls

## Tools Used

- Azure SQL Database
- Azure Data Factory
- Azure Blob Storage
- VS Code
- GitHub
