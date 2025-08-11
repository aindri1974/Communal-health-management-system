CREATE OR REPLACE FUNCTION GetPatientDetails 
RETURN SYS_REFCURSOR IS 
    cur SYS_REFCURSOR; 
BEGIN 
    OPEN cur FOR 
    SELECT pp.Phone_No, p.First_name, p.Last_name, l.PINCODE 
    FROM Patient p 
    JOIN PatientPhone pp ON p.AadharNO = pp.AadharNO 
    JOIN BloodType bt ON p.AadharNO = bt.Aadhar_NO 
    JOIN Location l ON p.PinCode = l.PINCODE 
    WHERE bt.Blood_Type = 'AB-'  
    AND p.Age > 18; 
     
    RETURN cur; 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No records found.'); 
        RETURN NULL; 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM); 
        RETURN NULL; 
END; 

CREATE SEQUENCE sanitation_status_seq; 

CREATE OR REPLACE TRIGGER CheckWaterQuality 
AFTER INSERT ON WaterQuality 
FOR EACH ROW 
BEGIN 
    IF :NEW.Contaminated = 'Yes' THEN 
        INSERT INTO SanitationStatus (SanitationStatusID, WasteManagementStatus, WasteManagementTreatment, SanitationFacilityStatus, Contaminated, RecordDate) 
        VALUES (sanitation_status_seq.NEXTVAL, 'Not OK', 'No', 'Not OK', 'Yes', SYSDATE); 
    ELSE 
        INSERT INTO SanitationStatus (SanitationStatusID, WasteManagementStatus, WasteManagementTreatment, SanitationFacilityStatus, Contaminated, RecordDate) 
        VALUES (sanitation_status_seq.NEXTVAL, 'OK', 'Yes', 'Good', 'No', SYSDATE); 
    END IF; 
END; 

CREATE OR REPLACE PROCEDURE GetPatientsByDoctor IS 
    CURSOR patient_cursor IS 
        SELECT p.AadharNO, p.First_name, p.Last_name, p.Email_id, p.Date_Of_Birth, p.Gender 
        FROM Patient p 
        WHERE p.DoctorID = 108; 
 
    patient_record patient_cursor%ROWTYPE; 
BEGIN 
    OPEN patient_cursor; 
    FETCH patient_cursor INTO patient_record; 
    IF patient_cursor%NOTFOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No patients found for Doctor ID 108.'); 
    ELSE 
        LOOP 
            DBMS_OUTPUT.PUT_LINE('AadharNO: ' || patient_record.AadharNO || 
                                 ', First Name: ' || patient_record.First_name || 
                                 ', Last Name: ' || patient_record.Last_name || 
                                 ', Email ID: ' || NVL(patient_record.Email_id, 'N/A') || 
                                 ', DOB: ' || TO_CHAR(patient_record.Date_Of_Birth, 'DD-MON-YYYY') || 
                                 ', Gender: ' || patient_record.Gender); 
            FETCH patient_cursor INTO patient_record; 
            EXIT WHEN patient_cursor%NOTFOUND; 
        END LOOP; 
    END IF; 
    CLOSE patient_cursor; 
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM); 
END GetPatientsByDoctor;

CREATE OR REPLACE PROCEDURE GetPatientInfoByDocID(p_doc_id IN NUMBER) IS 
    CURSOR patients_cursor IS 
        SELECT p.AadharNO, p.First_name, p.Last_name, p.Email_id, p.Date_Of_Birth, p.Gender, h.Hospital_name, l.PINCODE 
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
                             ', First Name: ' || patient_record.First_name || 
                             ', Last Name: ' || patient_record.Last_name || 
                             ', Email ID: ' || NVL(patient_record.Email_id, 'N/A') || 
                             ', DOB: ' || TO_CHAR(patient_record.Date_Of_Birth, 'DD-MON-YYYY') || 
                             ', Gender: ' || patient_record.Gender || 
                             ', Hospital Name: ' || patient_record.Hospital_name || 
                             ', PIN Code: ' || patient_record.PINCODE); 
    END LOOP; 
    CLOSE patients_cursor; 
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM); 
END GetPatientInfoByDocID;
