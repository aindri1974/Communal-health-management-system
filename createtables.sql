-- Table: Location
CREATE TABLE Location (
  PINCODE INT PRIMARY KEY,
  Town_or_Village VARCHAR(45) NOT NULL,
  City VARCHAR(45) NOT NULL,
  State_name VARCHAR(45) NOT NULL
);

-- Table: Hospitals
CREATE TABLE Hospitals (
  HospitalID INT PRIMARY KEY,
  Hospital_name VARCHAR(50) NOT NULL,
  Street_No VARCHAR(10) NOT NULL,
  PinCode INT NOT NULL,
  Phone_No INT,
  Email_id VARCHAR(100) NOT NULL,
  FOREIGN KEY (PinCode) REFERENCES Location(PINCODE)
);

-- Table: Doctor
CREATE TABLE Doctor (
  Doc_ID INT PRIMARY KEY,
  First_name VARCHAR(45) NOT NULL,
  Last_name VARCHAR(45) NOT NULL,
  Specialization VARCHAR(50) NOT NULL,
  Hospital_ID INT NOT NULL,
  FOREIGN KEY (Hospital_ID) REFERENCES Hospitals(HospitalID)
);

-- Table: Patient
CREATE TABLE Patient (
  AadharNO VARCHAR(12) PRIMARY KEY,
  First_name VARCHAR(45) NOT NULL,
  Last_name VARCHAR(45) NOT NULL,
  Email_id VARCHAR(100),
  Date_Of_Birth DATE,
  Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
  EmergencyNo VARCHAR(15),
  DoctorID INT,
  FOREIGN KEY (DoctorID) REFERENCES Doctor(Doc_ID),
  Hospital_ID INT,
  FOREIGN KEY (Hospital_ID) REFERENCES Hospitals(HospitalID)
);

-- Table: PatientPhone
CREATE TABLE PatientPhone (
  AadharNO VARCHAR(12),
  Phone_No VARCHAR(15),
  PRIMARY KEY (AadharNO, Phone_No),
  FOREIGN KEY (AadharNO) REFERENCES Patient(AadharNO),
  CHECK (LENGTH(Phone_No) = 10 )
);

-- Table: Appointments
CREATE TABLE Appointments (
  Appointment_ID INT PRIMARY KEY,
  Appointment_Date DATE NOT NULL,
  Appointment_Time VARCHAR(5) NOT NULL,
  Patient_ID VARCHAR(12) NOT NULL,
  Doc_ID INT NOT NULL,
  Appointment_status VARCHAR(20) NOT NULL CHECK (Appointment_status IN ('Booked', 'Not Booked')),
  FOREIGN KEY (Patient_ID) REFERENCES Patient(AadharNO),
  FOREIGN KEY (Doc_ID) REFERENCES Doctor(Doc_ID)
);

-- Table: Medication
CREATE TABLE Medication (
  Medication_NO INT PRIMARY KEY,
  Medication_Name VARCHAR(45) NOT NULL,
  Cost DECIMAL(10,2),
  Dosage VARCHAR(10)
);

-- Table: Manufacturer
CREATE TABLE Manufacturer(
  Manufacturer_NO INT PRIMARY KEY,
  Medication_ID INT,
  FOREIGN KEY (Medication_ID) REFERENCES Medication(Medication_NO)
);

-- Table: BloodType
CREATE TABLE BloodType (
  Aadhar_NO VARCHAR(12) PRIMARY KEY,
  Blood_Type VARCHAR(5) NOT NULL,
  FOREIGN KEY (Aadhar_NO) REFERENCES Patient(AadharNO)
);

-- Table: Prescription
CREATE TABLE Prescription (
  Prescription_ID INT PRIMARY KEY,
  Patient_ID VARCHAR(12) NOT NULL,
  DoctorID INT NOT NULL,
  Medication_ID INT NOT NULL,
  Prescription_Date DATE NOT NULL,
  Quantity INT,
  FOREIGN KEY (Patient_ID) REFERENCES Patient(AadharNO),
  FOREIGN KEY (DoctorID) REFERENCES Doctor(Doc_ID),
  FOREIGN KEY (Medication_ID) REFERENCES Medication(Medication_NO)
);

-- Table: Vaccination
CREATE TABLE Vaccination (
  VaccinationID INT PRIMARY KEY,
  Vaccination_name VARCHAR(50) NOT NULL,
  Min_Required_Age INT,
  Max_Required_Age INT,
  Booster_Required VARCHAR(5)
);

-- Table: VaccinationRecords
CREATE TABLE VaccinationRecords (
  Record_ID INT PRIMARY KEY,
  AadharNo VARCHAR(12) NOT NULL,
  VaccinationID INT NOT NULL,
  DateOfAdminstrationOfDose DATE,
  Location VARCHAR(255),
  FOREIGN KEY (AadharNo) REFERENCES Patient(AadharNO),
  FOREIGN KEY (VaccinationID) REFERENCES Vaccination(VaccinationID)
);

-- Table: InfantRecord
CREATE TABLE InfantRecord (
  InfantID INT PRIMARY KEY,
  AadharOfMother VARCHAR(12) NOT NULL,
  DateOfBirth DATE NOT NULL,
  TimeOfBirth VARCHAR(5) NOT NULL,
  BirthWeight DECIMAL(5,2),
  Length DECIMAL(5,2),
  ApgarScore INT,
  HeadCircumference DECIMAL(5,2),
  Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
  FOREIGN KEY (AadharOfMother) REFERENCES Patient(AadharNO)
);

-- Table: Disease
CREATE TABLE Disease (
  DiseaseID INT PRIMARY KEY,
  Disease_Name VARCHAR(50) NOT NULL,
  MortalityRate DECIMAL(5,2),
  MedicationID INT,
  FOREIGN KEY (MedicationID) REFERENCES Medication(Medication_NO)
);

-- Table: DiseaseStatistics
CREATE TABLE DiseaseStatistics (
  DiseaseID INT NOT NULL,
  Pincode INT NOT NULL,
  TotalCases INT,
  TotalDeaths INT,
  DateOfRecording DATE NOT NULL,
  Contaminated VARCHAR(3) CHECK (Contaminated IN ('Yes', 'No')),
  FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID),
  FOREIGN KEY (Pincode) REFERENCES Location(PINCODE)
);

-- Table: WaterQuality
CREATE TABLE WaterQuality (
  RecordID INT PRIMARY KEY,
  RecordDate DATE NOT NULL,
  PH DECIMAL(5,2),
  DissolvedOxygen DECIMAL(5,2),
  Chlorine DECIMAL(5,2),
  Contaminated VARCHAR(3) CHECK (Contaminated IN ('Yes', 'No'))
);

-- Table: AirQuality
CREATE TABLE AirQuality (
  RecordID INT PRIMARY KEY,
  RecordDate DATE NOT NULL,
  AQI INT,
  CO DECIMAL(5,2),
  PPM VARCHAR(10)
);

-- Table: FoodSafety
CREATE TABLE FoodSafety (
  RecordID INT PRIMARY KEY,
  RecordDate DATE NOT NULL,
  ChemicalContaminants VARCHAR(255),
  Contaminated VARCHAR(3) CHECK (Contaminated IN ('Yes', 'No'))
);

-- Table: SanitationStatus
CREATE TABLE SanitationStatus (
  SanitationStatusID INT PRIMARY KEY,
  WasteManagementStatus VARCHAR(50) NOT NULL CHECK (WasteManagementStatus IN ('Good', 'OK', 'Not OK')),
  WasteManagementTreatment VARCHAR(3) NOT NULL CHECK (WasteManagementTreatment IN ('Yes', 'No')),
  SanitationFacilityStatus VARCHAR(50) NOT NULL CHECK (SanitationFacilityStatus IN ('Good', 'OK', 'Not OK')),
  Contaminated VARCHAR(3) CHECK (Contaminated IN ('Yes', 'No')),
  RecordDate DATE NOT NULL
);

-- Table: EnvironmentalData
CREATE TABLE EnvironmentalData (
  DataID INT PRIMARY KEY,
  WaterQualityRecordID INT,
  AirPollutionRecordID INT,
  FoodSafetyRecordID INT,
  SanitationStatusRecordID INT,
  LocationPincode INT,
  FOREIGN KEY (WaterQualityRecordID) REFERENCES WaterQuality(RecordID),
  FOREIGN KEY (AirPollutionRecordID) REFERENCES AirQuality(RecordID),
  FOREIGN KEY (FoodSafetyRecordID) REFERENCES FoodSafety(RecordID),
  FOREIGN KEY (SanitationStatusRecordID) REFERENCES SanitationStatus(SanitationStatusID),
  FOREIGN KEY (LocationPincode) REFERENCES Location(PINCODE)
);
