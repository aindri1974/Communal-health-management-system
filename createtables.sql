-- Drop existing tables in reverse dependency order before recreating schema
DROP TABLE EnvironmentalData CASCADE CONSTRAINTS;
DROP TABLE SanitationStatus CASCADE CONSTRAINTS;
DROP TABLE FoodSafety CASCADE CONSTRAINTS;
DROP TABLE AirQuality CASCADE CONSTRAINTS;
DROP TABLE WaterQuality CASCADE CONSTRAINTS;
DROP TABLE DiseaseStatistics CASCADE CONSTRAINTS;
DROP TABLE Disease CASCADE CONSTRAINTS;
DROP TABLE InfantRecord CASCADE CONSTRAINTS;
DROP TABLE VaccinationRecords CASCADE CONSTRAINTS;
DROP TABLE Vaccination CASCADE CONSTRAINTS;
DROP TABLE Prescription CASCADE CONSTRAINTS;
DROP TABLE Medication CASCADE CONSTRAINTS;
DROP TABLE Manufacturer CASCADE CONSTRAINTS;
DROP TABLE Appointments CASCADE CONSTRAINTS;
DROP TABLE PatientPhone CASCADE CONSTRAINTS;
DROP TABLE Patient CASCADE CONSTRAINTS;
DROP TABLE Doctor CASCADE CONSTRAINTS;
DROP TABLE Hospitals CASCADE CONSTRAINTS;
DROP TABLE Location CASCADE CONSTRAINTS;

CREATE TABLE Location (
  PINCODE NUMBER PRIMARY KEY,
  Town_or_Village VARCHAR2(45) NOT NULL,
  City VARCHAR2(45) NOT NULL,
  State_name VARCHAR2(45) NOT NULL
);

CREATE TABLE Hospitals (
  HospitalID NUMBER PRIMARY KEY,
  Hospital_name VARCHAR2(50) NOT NULL,
  Street_No VARCHAR2(10) NOT NULL,
  PinCode NUMBER NOT NULL,
  Phone_No VARCHAR2(15),
  Email_id VARCHAR2(100) NOT NULL,
  FOREIGN KEY (PinCode) REFERENCES Location(PINCODE)
);

CREATE TABLE Doctor (
  Doc_ID NUMBER PRIMARY KEY,
  First_name VARCHAR2(45) NOT NULL,
  Last_name VARCHAR2(45) NOT NULL,
  Specialization VARCHAR2(50) NOT NULL,
  Hospital_ID NUMBER NOT NULL,
  FOREIGN KEY (Hospital_ID) REFERENCES Hospitals(HospitalID)
);

CREATE TABLE Patient (
  AadharNO VARCHAR2(12) PRIMARY KEY CHECK (LENGTH(AadharNO) = 12),
  First_name VARCHAR2(45) NOT NULL,
  Last_name VARCHAR2(45) NOT NULL,
  Email_id VARCHAR2(100),
  Date_Of_Birth DATE,
  Gender VARCHAR2(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
  Blood_Type VARCHAR2(3) CHECK (Blood_Type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
  EmergencyNo VARCHAR2(15),
  DoctorID NUMBER,
  FOREIGN KEY (DoctorID) REFERENCES Doctor(Doc_ID),
  Hospital_ID NUMBER,
  FOREIGN KEY (Hospital_ID) REFERENCES Hospitals(HospitalID)
);

-- One patient can have multiple contact numbers
CREATE TABLE PatientPhone (
  AadharNO VARCHAR2(12),
  Phone_No VARCHAR2(15),
  PRIMARY KEY (AadharNO, Phone_No),
  FOREIGN KEY (AadharNO) REFERENCES Patient(AadharNO),
  CHECK (LENGTH(Phone_No) = 10 )
);

CREATE TABLE Appointments (
  Appointment_ID NUMBER PRIMARY KEY,
  Appointment_Date DATE NOT NULL,
  Appointment_Time VARCHAR2(5) NOT NULL,
  Patient_ID VARCHAR2(12) NOT NULL,
  Doc_ID NUMBER NOT NULL,
  Appointment_status VARCHAR2(20) NOT NULL CHECK (Appointment_status IN ('Booked', 'Not Booked')),
  FOREIGN KEY (Patient_ID) REFERENCES Patient(AadharNO),
  FOREIGN KEY (Doc_ID) REFERENCES Doctor(Doc_ID)
);

CREATE TABLE Manufacturer (
  Manufacturer_NO NUMBER PRIMARY KEY,
  Manufacturer_Name VARCHAR2(100) NOT NULL,
  Contact_Email VARCHAR2(100),
  Contact_Phone VARCHAR2(15)
);

-- Medication references its manufacturer
CREATE TABLE Medication (
  Medication_NO NUMBER PRIMARY KEY,
  Medication_Name VARCHAR2(45) NOT NULL,
  Cost NUMBER(10,2),
  Dosage VARCHAR2(10),
  Manufacturer_NO NUMBER,
  FOREIGN KEY (Manufacturer_NO) REFERENCES Manufacturer(Manufacturer_NO)
);

CREATE TABLE Prescription (
  Prescription_ID NUMBER PRIMARY KEY,
  Patient_ID VARCHAR2(12) NOT NULL,
  DoctorID NUMBER NOT NULL,
  Medication_ID NUMBER NOT NULL,
  Prescription_Date DATE NOT NULL,
  Quantity NUMBER,
  FOREIGN KEY (Patient_ID) REFERENCES Patient(AadharNO),
  FOREIGN KEY (DoctorID) REFERENCES Doctor(Doc_ID),
  FOREIGN KEY (Medication_ID) REFERENCES Medication(Medication_NO)
);

CREATE TABLE Vaccination (
  VaccinationID NUMBER PRIMARY KEY,
  Vaccination_name VARCHAR2(50) NOT NULL,
  Min_Required_Age NUMBER,
  Max_Required_Age NUMBER,
  Booster_Required VARCHAR2(5)
);

CREATE TABLE VaccinationRecords (
  Record_ID NUMBER PRIMARY KEY,
  AadharNo VARCHAR2(12) NOT NULL,
  VaccinationID NUMBER NOT NULL,
  DateOfAdminstrationOfDose DATE,
  Location_Pincode NUMBER,
  FOREIGN KEY (AadharNo) REFERENCES Patient(AadharNO),
  FOREIGN KEY (VaccinationID) REFERENCES Vaccination(VaccinationID),
  FOREIGN KEY (Location_Pincode) REFERENCES Location(PINCODE)
);

-- InfantAadhar is nullable; populated once the infant is registered as a patient
CREATE TABLE InfantRecord (
  InfantID NUMBER PRIMARY KEY,
  AadharOfMother VARCHAR2(12) NOT NULL,
  InfantAadhar VARCHAR2(12) UNIQUE,
  DateOfBirth DATE NOT NULL,
  TimeOfBirth VARCHAR2(5) NOT NULL,
  BirthWeight NUMBER(5,2),
  Length NUMBER(5,2),
  ApgarScore NUMBER,
  HeadCircumference NUMBER(5,2),
  Gender VARCHAR2(10) CHECK (Gender IN ('Male', 'Female')),
  FOREIGN KEY (AadharOfMother) REFERENCES Patient(AadharNO),
  FOREIGN KEY (InfantAadhar) REFERENCES Patient(AadharNO)
);

CREATE TABLE Disease (
  DiseaseID NUMBER PRIMARY KEY,
  Disease_Name VARCHAR2(50) NOT NULL,
  MortalityRate NUMBER(5,2),
  MedicationID NUMBER,
  FOREIGN KEY (MedicationID) REFERENCES Medication(Medication_NO)
);

-- Composite PK prevents duplicate stats for the same disease, location, and date
CREATE TABLE DiseaseStatistics (
  DiseaseID NUMBER NOT NULL,
  Pincode NUMBER NOT NULL,
  TotalCases NUMBER,
  TotalDeaths NUMBER,
  DateOfRecording DATE NOT NULL,
  Contaminated VARCHAR2(3) CHECK (Contaminated IN ('Yes', 'No')),
  PRIMARY KEY (DiseaseID, Pincode, DateOfRecording),
  FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID),
  FOREIGN KEY (Pincode) REFERENCES Location(PINCODE)
);

CREATE TABLE WaterQuality (
  RecordID NUMBER PRIMARY KEY,
  RecordDate DATE NOT NULL,
  PH NUMBER(5,2),
  DissolvedOxygen NUMBER(5,2),
  Chlorine NUMBER(5,2),
  Contaminated VARCHAR2(3) CHECK (Contaminated IN ('Yes', 'No'))
);

CREATE TABLE AirQuality (
  RecordID NUMBER PRIMARY KEY,
  RecordDate DATE NOT NULL,
  AQI NUMBER,
  CO NUMBER(5,2),
  PPM NUMBER(8,2)
);

CREATE TABLE FoodSafety (
  RecordID NUMBER PRIMARY KEY,
  RecordDate DATE NOT NULL,
  ChemicalContaminants VARCHAR2(255),
  Contaminated VARCHAR2(3) CHECK (Contaminated IN ('Yes', 'No'))
);

CREATE TABLE SanitationStatus (
  SanitationStatusID NUMBER PRIMARY KEY,
  WasteManagementStatus VARCHAR2(50) NOT NULL CHECK (WasteManagementStatus IN ('Good', 'OK', 'Not OK')),
  WasteManagementTreatment VARCHAR2(3) NOT NULL CHECK (WasteManagementTreatment IN ('Yes', 'No')),
  SanitationFacilityStatus VARCHAR2(50) NOT NULL CHECK (SanitationFacilityStatus IN ('Good', 'OK', 'Not OK')),
  Contaminated VARCHAR2(3) CHECK (Contaminated IN ('Yes', 'No')),
  RecordDate DATE NOT NULL
);

-- Aggregates water, air, food, and sanitation records for a single location
CREATE TABLE EnvironmentalData (
  DataID NUMBER PRIMARY KEY,
  WaterQualityRecordID NUMBER,
  AirPollutionRecordID NUMBER,
  FoodSafetyRecordID NUMBER,
  SanitationStatusRecordID NUMBER,
  LocationPincode NUMBER,
  FOREIGN KEY (WaterQualityRecordID) REFERENCES WaterQuality(RecordID),
  FOREIGN KEY (AirPollutionRecordID) REFERENCES AirQuality(RecordID),
  FOREIGN KEY (FoodSafetyRecordID) REFERENCES FoodSafety(RecordID),
  FOREIGN KEY (SanitationStatusRecordID) REFERENCES SanitationStatus(SanitationStatusID),
  FOREIGN KEY (LocationPincode) REFERENCES Location(PINCODE)
);
