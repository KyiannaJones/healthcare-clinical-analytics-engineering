# Project Walkthrough
This project was designed to simulate a simplified analytics engineering workflow using a hospital admissions dataset. The goal was not just to analyze the data, but to structure it in a way that reflects how data pipelines and warehouse models are built in real environments.

## Initial Goal
The dataset came from Kaggle and contained simulated hospital admissions data. It included patient information, admission and discharge dates, condition types, departments, and insurance information.
One limitation of the dataset was that it did not include a natural admission or encounter identifier. Because of this, I created a deterministic **Admission_ID** using a combination of Patient_ID, Admission_Date, and Department. This ensures a consistent unique key that can be recreated during each pipeline run.

## Pipeline Design
The project follows a layered architecture commonly used in modern data warehouses:

Landing → Raw → Staging → Marts

The raw dataset is first ingested from a CSV file stored in Azure Blob Storage using Azure Data Factory. The data is loaded into the **raw schema** in Azure SQL without any transformations so the source data remains preserved.
The **staging layer** introduces light transformation logic and generates the Admission_ID key. This layer prepares the dataset for dimensional modeling.
The **marts layer** contains the final star schema used for analytics.

## Dimensional Modeling
To support analytics and reporting, I built a star schema with the following structure:

Dimension tables:
- dim_patient
- dim_department
- dim_condition
- dim_insurance

Fact table:
- fact_admissions_star

The fact table stores admission events and references each dimension using surrogate keys. This structure allows analytical tools to efficiently query the data while keeping descriptive attributes normalized.

## Data Validation
Basic validation queries were implemented to ensure the pipeline produced reliable outputs. These checks confirm:

- Raw, staging, and mart row counts are consistent
- Admission_ID values are unique
- Critical fields do not contain unexpected nulls

## Tools Used
- Azure SQL Database
- Azure Data Factory
- Azure Blob Storage
- VS Code
- GitHub

## What This Project Demonstrates
This project reflects the transition from traditional data analysis to analytics engineering. Instead of focusing only on analysis outputs, the emphasis was placed on building a structured data model, maintaining clean data layers, and ensuring reproducibility through version-controlled SQL scripts.# Project Walkthrough
This project was designed to simulate a simplified analytics engineering workflow using a hospital admissions dataset. The goal was not just to analyze the data, but to structure it in a way that reflects how data pipelines and warehouse models are built in real environments.

## Initial Goal
The dataset came from Kaggle and contained simulated hospital admissions data. It included patient information, admission and discharge dates, condition types, departments, and insurance information.
One limitation of the dataset was that it did not include a natural admission or encounter identifier. Because of this, I created a deterministic **Admission_ID** using a combination of Patient_ID, Admission_Date, and Department. This ensures a consistent unique key that can be recreated during each pipeline run.

## Pipeline Design
The project follows a layered architecture commonly used in modern data warehouses:

Landing → Raw → Staging → Marts

The raw dataset is first ingested from a CSV file stored in Azure Blob Storage using Azure Data Factory. The data is loaded into the **raw schema** in Azure SQL without any transformations so the source data remains preserved.
The **staging layer** introduces light transformation logic and generates the Admission_ID key. This layer prepares the dataset for dimensional modeling.
The **marts layer** contains the final star schema used for analytics.

## Dimensional Modeling
To support analytics and reporting, I built a star schema with the following structure:

Dimension tables:
- dim_patient
- dim_department
- dim_condition
- dim_insurance

Fact table:
- fact_admissions_star

The fact table stores admission events and references each dimension using surrogate keys. This structure allows analytical tools to efficiently query the data while keeping descriptive attributes normalized.

## Data Validation
Basic validation queries were implemented to ensure the pipeline produced reliable outputs. These checks confirm:

- Raw, staging, and mart row counts are consistent
- Admission_ID values are unique
- Critical fields do not contain unexpected nulls

## Tools Used
- Azure SQL Database
- Azure Data Factory
- Azure Blob Storage
- VS Code
- GitHub

## What This Project Demonstrates

This project reflects the transition from traditional data analysis to analytics engineering. Instead of focusing only on analysis outputs, the emphasis was placed on building a structured data model, maintaining clean data layers, and ensuring reproducibility through version-controlled SQL scripts.
