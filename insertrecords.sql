INSERT INTO Location VALUES (110001, 'Connaught Place', 'Delhi', 'Delhi');
INSERT INTO Location VALUES (400001, 'Colaba', 'Mumbai', 'Maharashtra');
INSERT INTO Location VALUES (700001, 'BBD Bagh', 'Kolkata', 'West Bengal');
INSERT INTO Location VALUES (600001, 'George Town', 'Chennai', 'Tamil Nadu');
INSERT INTO Location VALUES (560001, 'MG Road', 'Bangalore', 'Karnataka');
INSERT INTO Location VALUES (500001, 'Abids', 'Hyderabad', 'Telangana');
INSERT INTO Location VALUES (380001, 'Lal Darwaja', 'Ahmedabad', 'Gujarat');
INSERT INTO Location VALUES (411001, 'Camp', 'Pune', 'Maharashtra');
INSERT INTO Location VALUES (302001, 'Bapu Nagar', 'Jaipur', 'Rajasthan');
INSERT INTO Location VALUES (751001, 'Ashok Nagar', 'Bhubaneswar', 'Odisha');

INSERT INTO Hospitals VALUES (101, 'Apollo Hospital', '10', 110001, '1122334455', 'apollo@hospital.com');
INSERT INTO Hospitals VALUES (102, 'Fortis Hospital', '20', 400001, '2233445566', 'fortis@hospital.com');
INSERT INTO Hospitals VALUES (103, 'Medanta Medicity', '30', 700001, '3344556677', 'medanta@medicity.com');
INSERT INTO Hospitals VALUES (104, 'Max Healthcare', '40', 600001, '4455667788', 'max@healthcare.com');
INSERT INTO Hospitals VALUES (105, 'Manipal Hospital', '50', 560001, '5566778899', 'manipal@hospital.com');
INSERT INTO Hospitals VALUES (106, 'KIMS', '60', 500001, '6677889900', 'kims@hospital.com');
INSERT INTO Hospitals VALUES (107, 'Narayana Health', '70', 380001, '7788990011', 'narayana@health.com');
INSERT INTO Hospitals VALUES (108, 'Ruby Hall Clinic', '80', 411001, '8899001122', 'rubyhall@clinic.com');
INSERT INTO Hospitals VALUES (109, 'Sawai Mansingh Hospital', '90', 302001, '9900112233', 'smh@hospital.com');
INSERT INTO Hospitals VALUES (110, 'Kalinga Hospital', '100', 751001, '1011122334', 'kalinga@hospital.com');

INSERT INTO Doctor VALUES (101, 'Amit', 'Sharma', 'Cardiology', 101);
INSERT INTO Doctor VALUES (102, 'Priya', 'Malik', 'Dermatology', 102);
INSERT INTO Doctor VALUES (103, 'Rajesh', 'Kumar', 'Neurology', 103);
INSERT INTO Doctor VALUES (104, 'Sunita', 'Gupta', 'Pediatrics', 104);
INSERT INTO Doctor VALUES (105, 'Anil', 'Patel', 'Orthopedics', 105);
INSERT INTO Doctor VALUES (106, 'Geeta', 'Roy', 'Oncology', 106);
INSERT INTO Doctor VALUES (107, 'Manish', 'Singh', 'Gynecology', 107);
INSERT INTO Doctor VALUES (108, 'Rani', 'Das', 'Psychiatry', 108);
INSERT INTO Doctor VALUES (109, 'Kunal', 'Joshi', 'Gastroenterology', 109);
INSERT INTO Doctor VALUES (110, 'Neha', 'Agarwal', 'Ophthalmology', 110);

INSERT INTO Patient VALUES ('123456789012', 'Vijay', 'Kumar', 'vijay.kumar@email.com', DATE '1990-08-15', 'Male', 'A+', '9999888800', 101, 101);
INSERT INTO Patient VALUES ('234567890123', 'Deepa', 'Nair', 'deepa.nair@email.com', DATE '1982-12-22', 'Female', 'B+', '9999888801', 102, 102);
INSERT INTO Patient VALUES ('345678901234', 'Sohail', 'Khan', 'sohail.khan@email.com', DATE '1983-03-30', 'Male', 'O+', '9999888802', 103, 103);
INSERT INTO Patient VALUES ('456789012345', 'Anjali', 'Mehta', 'anjali.mehta@email.com', DATE '1975-05-25', 'Female', 'AB+', '9999888803', 104, 104);
INSERT INTO Patient VALUES ('567890123456', 'Rahul', 'Reddy', 'rahul.reddy@email.com', DATE '1987-07-17', 'Male', 'A-', '9999888804', 105, 105);
INSERT INTO Patient VALUES ('678901234567', 'Lata', 'Mishra', 'lata.mishra@email.com', DATE '1992-09-10', 'Female', 'B-', '9999888805', 106, 106);
INSERT INTO Patient VALUES ('789012345678', 'Karan', 'Shah', 'karan.shah@email.com', DATE '1980-01-14', 'Male', 'O-', '9999888806', 107, 107);
INSERT INTO Patient VALUES ('890123456789', 'Suman', 'Singh', 'suman.singh@email.com', DATE '1985-11-05', 'Female', 'AB-', '9999888807', 108, 108);
INSERT INTO Patient VALUES ('901234567890', 'Raj', 'Patel', 'raj.patel@email.com', DATE '1993-04-20', 'Male', 'A+', '9999888808', 109, 109);
INSERT INTO Patient VALUES ('012345678901', 'Nisha', 'Goyal', 'nisha.goyal@email.com', DATE '1989-02-28', 'Female', 'B+', '9999888809', 110, 110);

INSERT INTO PatientPhone VALUES ('123456789012', '9876543210');
INSERT INTO PatientPhone VALUES ('234567890123', '8765432109');
INSERT INTO PatientPhone VALUES ('345678901234', '7654321098');
INSERT INTO PatientPhone VALUES ('456789012345', '6543210987');
INSERT INTO PatientPhone VALUES ('567890123456', '5432109876');
INSERT INTO PatientPhone VALUES ('678901234567', '4321098765');
INSERT INTO PatientPhone VALUES ('789012345678', '3210987654');
INSERT INTO PatientPhone VALUES ('890123456789', '2109876543');
INSERT INTO PatientPhone VALUES ('901234567890', '1098765432');
INSERT INTO PatientPhone VALUES ('012345678901', '0987654321');

INSERT INTO Appointments VALUES (1, DATE '2023-12-28', '10:00', '123456789012', 101, 'Booked');
INSERT INTO Appointments VALUES (2, DATE '2023-12-29', '10:30', '234567890123', 102, 'Booked');
INSERT INTO Appointments VALUES (3, DATE '2023-12-30', '11:00', '345678901234', 103, 'Booked');
INSERT INTO Appointments VALUES (4, DATE '2023-12-31', '11:30', '456789012345', 104, 'Booked');
INSERT INTO Appointments VALUES (5, DATE '2024-01-01', '12:00', '567890123456', 105, 'Booked');
INSERT INTO Appointments VALUES (6, DATE '2024-01-02', '12:30', '678901234567', 106, 'Booked');
INSERT INTO Appointments VALUES (7, DATE '2024-01-03', '13:00', '789012345678', 107, 'Booked');
INSERT INTO Appointments VALUES (8, DATE '2024-01-04', '13:30', '890123456789', 108, 'Booked');
INSERT INTO Appointments VALUES (9, DATE '2024-01-05', '14:00', '901234567890', 109, 'Booked');
INSERT INTO Appointments VALUES (10, DATE '2024-01-06', '14:30', '012345678901', 110, 'Booked');

INSERT INTO Manufacturer VALUES (201, 'Sun Pharma', 'sunpharma@contact.com', '1800110001');
INSERT INTO Manufacturer VALUES (202, 'Cipla Ltd', 'cipla@contact.com', '1800110002');
INSERT INTO Manufacturer VALUES (203, 'Dr. Reddys Lab', 'drreddys@contact.com', '1800110003');
INSERT INTO Manufacturer VALUES (204, 'Lupin Ltd', 'lupin@contact.com', '1800110004');
INSERT INTO Manufacturer VALUES (205, 'Aurobindo Pharma', 'aurobindo@contact.com', '1800110005');
INSERT INTO Manufacturer VALUES (206, 'Torrent Pharma', 'torrent@contact.com', '1800110006');
INSERT INTO Manufacturer VALUES (207, 'Alkem Laboratories', 'alkem@contact.com', '1800110007');
INSERT INTO Manufacturer VALUES (208, 'Abbott India', 'abbott@contact.com', '1800110008');
INSERT INTO Manufacturer VALUES (209, 'Pfizer India', 'pfizer@contact.com', '1800110009');
INSERT INTO Manufacturer VALUES (210, 'Zydus Cadila', 'zydus@contact.com', '1800110010');

INSERT INTO Medication VALUES (101, 'Paracetamol', 50.00, '500mg', 201);
INSERT INTO Medication VALUES (102, 'Amoxicillin', 75.00, '250mg', 202);
INSERT INTO Medication VALUES (103, 'Ciprofloxacin', 100.00, '500mg', 203);
INSERT INTO Medication VALUES (104, 'Metformin', 85.00, '1000mg', 204);
INSERT INTO Medication VALUES (105, 'Atorvastatin', 90.00, '40mg', 205);
INSERT INTO Medication VALUES (106, 'Sertraline', 110.00, '100mg', 206);
INSERT INTO Medication VALUES (107, 'Cetirizine', 30.00, '10mg', 207);
INSERT INTO Medication VALUES (108, 'Ibuprofen', 45.00, '400mg', 208);
INSERT INTO Medication VALUES (109, 'Lisinopril', 120.00, '20mg', 209);
INSERT INTO Medication VALUES (110, 'Amlodipine', 135.00, '5mg', 210);

INSERT INTO Prescription VALUES (1, '123456789012', 101, 101, DATE '2024-01-01', 30);
INSERT INTO Prescription VALUES (2, '234567890123', 102, 102, DATE '2024-01-02', 20);
INSERT INTO Prescription VALUES (3, '345678901234', 103, 103, DATE '2024-01-03', 10);
INSERT INTO Prescription VALUES (4, '456789012345', 104, 104, DATE '2024-01-04', 15);
INSERT INTO Prescription VALUES (5, '567890123456', 105, 105, DATE '2024-01-05', 25);
INSERT INTO Prescription VALUES (6, '678901234567', 106, 106, DATE '2024-01-06', 10);
INSERT INTO Prescription VALUES (7, '789012345678', 107, 107, DATE '2024-01-07', 5);
INSERT INTO Prescription VALUES (8, '890123456789', 108, 108, DATE '2024-01-08', 20);
INSERT INTO Prescription VALUES (9, '901234567890', 109, 109, DATE '2024-01-09', 15);
INSERT INTO Prescription VALUES (10, '012345678901', 110, 110, DATE '2024-01-10', 10);

INSERT INTO Vaccination VALUES (101, 'Influenza', 6, 65, 'Yes');
INSERT INTO Vaccination VALUES (102, 'Varicella', 0, 10, 'No');
INSERT INTO Vaccination VALUES (103, 'Hepatitis A', 1, 50, 'Yes');
INSERT INTO Vaccination VALUES (104, 'Hepatitis B', 0, 50, 'Yes');
INSERT INTO Vaccination VALUES (105, 'HPV', 9, 26, 'No');
INSERT INTO Vaccination VALUES (106, 'MMR', 0, 6, 'No');
INSERT INTO Vaccination VALUES (107, 'Pneumococcal', 65, 99, 'No');
INSERT INTO Vaccination VALUES (108, 'Tdap', 11, 50, 'Yes');
INSERT INTO Vaccination VALUES (109, 'Zoster', 60, 99, 'No');
INSERT INTO Vaccination VALUES (110, 'COVID-19', 18, 99, 'Yes');

INSERT INTO VaccinationRecords VALUES (1, '123456789012', 101, DATE '2023-01-15', 110001);
INSERT INTO VaccinationRecords VALUES (2, '234567890123', 102, DATE '2023-02-16', 400001);
INSERT INTO VaccinationRecords VALUES (3, '345678901234', 103, DATE '2023-03-17', 700001);
INSERT INTO VaccinationRecords VALUES (4, '456789012345', 104, DATE '2023-04-18', 600001);
INSERT INTO VaccinationRecords VALUES (5, '567890123456', 105, DATE '2023-05-19', 560001);
INSERT INTO VaccinationRecords VALUES (6, '678901234567', 106, DATE '2023-06-20', 500001);
INSERT INTO VaccinationRecords VALUES (7, '789012345678', 107, DATE '2023-07-21', 380001);
INSERT INTO VaccinationRecords VALUES (8, '890123456789', 108, DATE '2023-08-22', 411001);
INSERT INTO VaccinationRecords VALUES (9, '901234567890', 109, DATE '2023-09-23', 302001);
INSERT INTO VaccinationRecords VALUES (10, '012345678901', 110, DATE '2023-10-24', 751001);

-- InfantAadhar is NULL as these infants are not yet registered as patients
INSERT INTO InfantRecord VALUES (1, '234567890123', NULL, DATE '2024-01-01', '05:30', 3.5, 50, 8, 35, 'Male');
INSERT INTO InfantRecord VALUES (2, '456789012345', NULL, DATE '2024-01-02', '06:45', 2.8, 48, 7, 33, 'Female');
INSERT INTO InfantRecord VALUES (3, '678901234567', NULL, DATE '2024-01-03', '07:55', 3.2, 49, 9, 34, 'Male');
INSERT INTO InfantRecord VALUES (4, '890123456789', NULL, DATE '2024-01-04', '08:15', 3.4, 51, 8, 36, 'Female');
INSERT INTO InfantRecord VALUES (5, '012345678901', NULL, DATE '2024-01-05', '09:25', 3.1, 47, 7, 33, 'Male');

INSERT INTO Disease VALUES (1, 'Influenza', 0.5, 101);
INSERT INTO Disease VALUES (2, 'Chickenpox', 0.1, 102);
INSERT INTO Disease VALUES (3, 'Hepatitis A', 0.2, 103);
INSERT INTO Disease VALUES (4, 'Hepatitis B', 0.25, 104);
INSERT INTO Disease VALUES (5, 'Human Papillomavirus', 0.05, 105);

INSERT INTO DiseaseStatistics VALUES (1, 110001, 500, 3, DATE '2024-01-01', 'No');
INSERT INTO DiseaseStatistics VALUES (2, 400001, 150, 1, DATE '2024-01-02', 'No');
INSERT INTO DiseaseStatistics VALUES (3, 700001, 200, 2, DATE '2024-01-03', 'Yes');
INSERT INTO DiseaseStatistics VALUES (4, 600001, 250, 2, DATE '2024-01-04', 'No');
INSERT INTO DiseaseStatistics VALUES (5, 560001, 300, 1, DATE '2024-01-05', 'Yes');

INSERT INTO WaterQuality VALUES (1, DATE '2024-01-01', 7.2, 6.1, 0.2, 'No');
INSERT INTO WaterQuality VALUES (2, DATE '2024-01-02', 6.8, 5.7, 0.3, 'No');
INSERT INTO WaterQuality VALUES (3, DATE '2024-01-03', 7.5, 6.5, 0.1, 'Yes');
INSERT INTO WaterQuality VALUES (4, DATE '2024-01-04', 7.0, 6.0, 0.4, 'No');
INSERT INTO WaterQuality VALUES (5, DATE '2024-01-05', 7.3, 6.2, 0.2, 'Yes');

INSERT INTO AirQuality VALUES (1, DATE '2024-01-01', 50, 0.02, 410.50);
INSERT INTO AirQuality VALUES (2, DATE '2024-01-02', 70, 0.03, 412.30);
INSERT INTO AirQuality VALUES (3, DATE '2024-01-03', 90, 0.04, 415.00);
INSERT INTO AirQuality VALUES (4, DATE '2024-01-04', 85, 0.05, 414.20);
INSERT INTO AirQuality VALUES (5, DATE '2024-01-05', 60, 0.02, 411.10);

INSERT INTO FoodSafety VALUES (1, DATE '2024-01-01', 'Pesticides', 'No');
INSERT INTO FoodSafety VALUES (2, DATE '2024-01-02', 'Heavy Metals', 'Yes');
INSERT INTO FoodSafety VALUES (3, DATE '2024-01-03', 'Microbial Contaminants', 'No');
INSERT INTO FoodSafety VALUES (4, DATE '2024-01-04', 'Additives', 'No');
INSERT INTO FoodSafety VALUES (5, DATE '2024-01-05', 'Toxins', 'Yes');

INSERT INTO SanitationStatus VALUES (1, 'Good', 'Yes', 'Good', 'No', DATE '2024-01-01');
INSERT INTO SanitationStatus VALUES (2, 'OK', 'No', 'OK', 'Yes', DATE '2024-01-02');
INSERT INTO SanitationStatus VALUES (3, 'Not OK', 'Yes', 'Good', 'No', DATE '2024-01-03');
INSERT INTO SanitationStatus VALUES (4, 'Good', 'No', 'OK', 'Yes', DATE '2024-01-04');
INSERT INTO SanitationStatus VALUES (5, 'OK', 'Yes', 'Good', 'No', DATE '2024-01-05');

INSERT INTO EnvironmentalData VALUES (1, 1, 1, 1, 1, 110001);
INSERT INTO EnvironmentalData VALUES (2, 2, 2, 2, 2, 400001);
INSERT INTO EnvironmentalData VALUES (3, 3, 3, 3, 3, 700001);
INSERT INTO EnvironmentalData VALUES (4, 4, 4, 4, 4, 600001);
INSERT INTO EnvironmentalData VALUES (5, 5, 5, 5, 5, 560001);
