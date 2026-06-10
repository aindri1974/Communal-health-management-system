# Communal Health Management System

A relational database project built on **Oracle SQL and PL/SQL** that models a community-level health infrastructure. The system covers patient records, hospital and doctor management, appointment scheduling, prescription tracking, vaccination history, infant birth records, disease surveillance, and environmental health monitoring.

---

## Tech Stack

- Oracle Database 19c
- SQL (DDL + DML)
- PL/SQL (Triggers, Cursors, Procedures, Functions, Sequences)

---

## Schema Overview

| Table | Description |
| --- | --- |
| `Location` | PIN code indexed geographic reference data |
| `Hospitals` | Hospital details linked to a location |
| `Doctor` | Doctor profiles with specialization, linked to a hospital |
| `Patient` | Central patient record — demographics, blood type, assigned doctor and hospital |
| `PatientPhone` | Stores multiple contact numbers per patient |
| `Appointments` | Appointment records between patients and doctors |
| `Manufacturer` | Pharma manufacturer details |
| `Medication` | Medication catalog with cost, dosage, and manufacturer reference |
| `Prescription` | Prescriptions linking a patient, doctor, and medication |
| `Vaccination` | Master vaccine list with age eligibility and booster requirements |
| `VaccinationRecords` | Per-patient vaccination history with date and location |
| `InfantRecord` | Birth records linked to mother's Aadhar; `InfantAadhar` populated once registered |
| `Disease` | Disease catalog with mortality rate and associated medication |
| `DiseaseStatistics` | Case and death counts per disease per location per date |
| `WaterQuality` | Water quality readings — pH, dissolved oxygen, chlorine |
| `AirQuality` | Air quality index, CO levels, and PPM readings |
| `FoodSafety` | Food safety inspection results with contaminant type |
| `SanitationStatus` | Waste management and sanitation facility status |
| `EnvironmentalData` | Aggregates all environmental sub-records for a given location |

---

## PL/SQL Objects

**Sequence**
- `sanitation_status_seq` — generates IDs for sanitation records created by the trigger

**Trigger**
- `CheckWaterQuality` — fires after every `WaterQuality` insert; automatically creates a corresponding `SanitationStatus` record based on the contamination flag

**Function**
- `GetPatientsByBloodType` — returns a `SYS_REFCURSOR` of all AB- patients over 18, with their phone number and location

**Procedures**
- `GetPatientInfoByDocID(p_doc_id)` — lists all patients under a given doctor with blood type, hospital, and location
- `GetAppointmentsByDoctor(p_doc_id)` — lists all appointments for a given doctor ordered by date and time
- `GetDiseaseStatsByLocation(p_pincode)` — lists disease case statistics for a given PIN code, most recent first

---

## Prerequisites

- Oracle Database 11g or later
- SQL\*Plus or Oracle SQL Developer
- Privileges: `CREATE TABLE`, `CREATE SEQUENCE`, `CREATE TRIGGER`, `CREATE PROCEDURE`, `CREATE FUNCTION`

---

## Setup

Run the files in this order:

```sql
@createtables.sql
@insertrecords.sql
@plsql_objects.sql
```

> Note: `createtables.sql` includes `DROP TABLE` statements at the top. These will throw errors if the tables do not yet exist — this is expected and does not affect execution.

---

## Usage Examples

```sql
-- Get all patients under Doctor ID 101
BEGIN
    GetPatientInfoByDocID(101);
END;
/

-- Get all appointments for Doctor ID 101
BEGIN
    GetAppointmentsByDoctor(101);
END;
/

-- Get disease statistics for Delhi (PIN 110001)
BEGIN
    GetDiseaseStatsByLocation(110001);
END;
/

-- Get all AB- patients over 18
DECLARE
    cur SYS_REFCURSOR;
BEGIN
    cur := GetPatientsByBloodType;
END;
/
```

---

## Design Notes

- **Aadhar as PK** — 12-digit national ID used as primary key for patients with a length check constraint
- **Blood type on Patient** — stored directly on the `Patient` table with a CHECK constraint limiting values to the 8 standard blood groups
- **Manufacturer → Medication** — `Medication` holds the FK to `Manufacturer`, reflecting that a manufacturer exists independently of any single drug
- **Composite PK on DiseaseStatistics** — `(DiseaseID, Pincode, DateOfRecording)` enforces one record per disease per location per day
- **InfantAadhar nullable** — birth records are created before the infant has an Aadhar; the field is populated later when the infant is registered as a patient
- **Trigger date consistency** — `CheckWaterQuality` uses `:NEW.RecordDate` instead of `SYSDATE` so the generated sanitation record matches the water quality record date
