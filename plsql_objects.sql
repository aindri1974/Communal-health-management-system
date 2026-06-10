SET SERVEROUTPUT ON;

-- Sequence starts at 6 to avoid conflict with the 5 manually inserted SanitationStatus rows
CREATE SEQUENCE sanitation_status_seq START WITH 6;

-- Trigger fires after each WaterQuality insert; derives sanitation status from contamination flag
-- Uses :NEW.RecordDate to keep the sanitation record date consistent with the water record
CREATE OR REPLACE TRIGGER CheckWaterQuality 
AFTER INSERT ON WaterQuality 
FOR EACH ROW 
BEGIN 
    IF :NEW.Contaminated = 'Yes' THEN 
        INSERT INTO SanitationStatus (SanitationStatusID, WasteManagementStatus, WasteManagementTreatment, SanitationFacilityStatus, Contaminated, RecordDate) 
        VALUES (sanitation_status_seq.NEXTVAL, 'Not OK', 'No', 'Not OK', 'Yes', :NEW.RecordDate); 
    ELSE 
        INSERT INTO SanitationStatus (SanitationStatusID, WasteManagementStatus, WasteManagementTreatment, SanitationFacilityStatus, Contaminated, RecordDate) 
        VALUES (sanitation_status_seq.NEXTVAL, 'OK', 'Yes', 'Good', 'No', :NEW.RecordDate); 
    END IF; 
END; 
/

-- Returns phone number, name, and PIN code of all AB- patients over 18
-- Location resolved via Patient -> Hospital -> Location join chain
CREATE OR REPLACE FUNCTION GetPatientsByBloodType 
RETURN SYS_REFCURSOR IS 
    cur SYS_REFCURSOR; 
BEGIN 
    OPEN cur FOR 
    SELECT pp.Phone_No, p.First_name, p.Last_name, l.PINCODE 
    FROM Patient p 
    JOIN PatientPhone pp ON p.AadharNO = pp.AadharNO 
    JOIN Hospitals h ON p.Hospital_ID = h.HospitalID 
    JOIN Location l ON h.PinCode = l.PINCODE 
    WHERE p.Blood_Type = 'AB-'  
    AND TRUNC(MONTHS_BETWEEN(SYSDATE, p.Date_Of_Birth) / 12) > 18; 
     
    RETURN cur; 
END; 
/

-- Fetches all patients under a given doctor with hospital and location details
CREATE OR REPLACE PROCEDURE GetPatientInfoByDocID(p_doc_id IN NUMBER) IS 
    CURSOR patients_cursor IS 
        SELECT p.AadharNO, p.First_name, p.Last_name, p.Email_id, p.Date_Of_Birth, p.Gender, p.Blood_Type, h.Hospital_name, l.PINCODE 
        FROM Patient p 
        JOIN Hospitals h ON p.Hospital_ID = h.HospitalID 
        JOIN Location l ON h.PinCode = l.PINCODE 
        WHERE p.DoctorID = p_doc_id; 
 
    patient_record patients_cursor%ROWTYPE; 
BEGIN 
    DBMS_OUTPUT.ENABLE; 
    OPEN patients_cursor; 
    LOOP 
        FETCH patients_cursor INTO patient_record; 
        EXIT WHEN patients_cursor%NOTFOUND; 
        DBMS_OUTPUT.PUT_LINE('AadharNO: ' || patient_record.AadharNO || 
                             ', Name: ' || patient_record.First_name || ' ' || patient_record.Last_name || 
                             ', Blood: ' || patient_record.Blood_Type ||
                             ', DOB: ' || TO_CHAR(patient_record.Date_Of_Birth, 'DD-MON-YYYY') || 
                             ', Hospital: ' || patient_record.Hospital_name || 
                             ', PIN: ' || patient_record.PINCODE); 
    END LOOP; 
    CLOSE patients_cursor; 
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM); 
END GetPatientInfoByDocID;
/

-- Fetches all appointments for a given doctor ordered by date and time
CREATE OR REPLACE PROCEDURE GetAppointmentsByDoctor(p_doc_id IN NUMBER) IS
    CURSOR appt_cursor IS
        SELECT Appointment_ID, Appointment_Date, Appointment_Time, Patient_ID, Appointment_status
        FROM Appointments
        WHERE Doc_ID = p_doc_id
        ORDER BY Appointment_Date, Appointment_Time;
        
    appt_record appt_cursor%ROWTYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    OPEN appt_cursor;
    LOOP
        FETCH appt_cursor INTO appt_record;
        EXIT WHEN appt_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Appt ID: ' || appt_record.Appointment_ID || 
                             ' | Date: ' || TO_CHAR(appt_record.Appointment_Date, 'YYYY-MM-DD') || 
                             ' | Time: ' || appt_record.Appointment_Time || 
                             ' | Patient Aadhar: ' || appt_record.Patient_ID || 
                             ' | Status: ' || appt_record.Appointment_status);
    END LOOP;
    CLOSE appt_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END GetAppointmentsByDoctor;
/

-- Fetches disease case statistics for a given PIN code, most recent first
CREATE OR REPLACE PROCEDURE GetDiseaseStatsByLocation(p_pincode IN NUMBER) IS
    CURSOR stats_cursor IS
        SELECT d.Disease_Name, ds.TotalCases, ds.TotalDeaths, ds.DateOfRecording, ds.Contaminated
        FROM DiseaseStatistics ds
        JOIN Disease d ON ds.DiseaseID = d.DiseaseID
        WHERE ds.Pincode = p_pincode
        ORDER BY ds.DateOfRecording DESC;
        
    stat_record stats_cursor%ROWTYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    OPEN stats_cursor;
    LOOP
        FETCH stats_cursor INTO stat_record;
        EXIT WHEN stats_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Disease: ' || stat_record.Disease_Name || 
                             ' | Cases: ' || stat_record.TotalCases || 
                             ' | Deaths: ' || stat_record.TotalDeaths || 
                             ' | Date: ' || TO_CHAR(stat_record.DateOfRecording, 'YYYY-MM-DD') || 
                             ' | Contaminated Flag: ' || stat_record.Contaminated);
    END LOOP;
    CLOSE stats_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END GetDiseaseStatsByLocation;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Appointments for Doctor 101 ---');
    GetAppointmentsByDoctor(101);
    
    DBMS_OUTPUT.PUT_LINE('--- Patients under Doctor 101 ---');
    GetPatientInfoByDocID(101);
    
    DBMS_OUTPUT.PUT_LINE('--- Disease Statistics for Delhi (110001) ---');
    GetDiseaseStatsByLocation(110001);
END;
/
