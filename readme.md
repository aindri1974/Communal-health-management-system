# Database Project README

## Project Overview
**This project contains a collection of SQL and PL/SQL commands designed to manage and retrieve data from a healthcare system database.** The database includes information about patients, doctors, hospitals, medical records, and environmental data.

## Database Schema
The database schema includes the following tables:

- `Location`
- `Hospitals`
- `Doctor`
- `Patient`
- `PatientPhone`
- `BloodType`
- `Prescription`
- `Vaccination`
- `VaccinationRecords`
- `InfantRecord`
- `Disease`
- `DiseaseStatistics`
- `WaterQuality`
- `AirQuality`
- `FoodSafety`
- `SanitationStatus`
- `EnvironmentalData`

## Prerequisites
- Oracle Database Server
- SQL*Plus or Oracle SQL Developer
- Necessary privileges to create, modify, and execute database objects

## Setup Instructions
1. Connect to your Oracle database using SQL*Plus or Oracle SQL Developer.
2. Execute the provided `CREATE TABLE` statements to create the necessary database schema.
3. Run the `CREATE SEQUENCE` and `CREATE OR REPLACE TRIGGER` statements to set up database triggers and sequences.
4. Use the `CREATE OR REPLACE FUNCTION` and `CREATE OR REPLACE PROCEDURE` statements to create the required stored procedures and functions.

## Usage
The stored procedures and functions can be called to perform operations such as retrieving patient details, checking water quality, and fetching information about patients associated with a specific doctor.

**Example of calling a stored procedure to get patient information by doctor ID:**

```sql
BEGIN 
    GetPatientInfoByDoctor(108); -- Replace 108 with the actual doctor ID
END;
