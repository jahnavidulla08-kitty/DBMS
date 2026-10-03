/* ============================================================
   PART 1: DATABASE CREATION
   ============================================================ */

CREATE DATABASE Hospital_Management_System;

USE Hospital_Management_System;


/* ============================================================
   PART 2: DDL - CREATE TABLES
   ============================================================ */
/* ------------------------------------------------------------
   1. PATIENT TABLE
   ------------------------------------------------------------ */

CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    DOB DATE,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    Blood_Group VARCHAR(5)
);


/* ------------------------------------------------------------
   2. DEPARTMENT TABLE
   ------------------------------------------------------------ */

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);


/* ------------------------------------------------------------
   3. DOCTOR TABLE
   ------------------------------------------------------------ */

CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Experience INT,
    Department_ID INT,

    CONSTRAINT FK_Doctor_Department
        FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


/* ------------------------------------------------------------
   4. APPOINTMENT TABLE
   ------------------------------------------------------------ */

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Status VARCHAR(30),

    CONSTRAINT FK_Appointment_Patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_Appointment_Doctor
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


/* ------------------------------------------------------------
   5. TREATMENT TABLE
   ------------------------------------------------------------ */

CREATE TABLE Treatment (
    Treatment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT NOT NULL,
    Diagnosis VARCHAR(255),
    Cost DECIMAL(10,2),

    CONSTRAINT FK_Treatment_Patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


/* ------------------------------------------------------------
   6. STAFF TABLE
   ------------------------------------------------------------ */

CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    Department_ID INT,

    CONSTRAINT FK_Staff_Department
        FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


/* ------------------------------------------------------------
   7. PRESCRIPTION TABLE
   ------------------------------------------------------------ */

CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY AUTO_INCREMENT,
    Doctor_ID INT NOT NULL,
    Treatment_ID INT NOT NULL,

    CONSTRAINT FK_Prescription_Doctor
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_Prescription_Treatment
        FOREIGN KEY (Treatment_ID)
        REFERENCES Treatment(Treatment_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


/* ------------------------------------------------------------
   8. MEDICINE TABLE
   ------------------------------------------------------------ */

CREATE TABLE Medicine (
    Medicine_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Dosage VARCHAR(100),
    Stock INT DEFAULT 0,
    Price DECIMAL(10,2)
);


/* ------------------------------------------------------------
   9. PRESCRIPTION_MEDICINE
      JUNCTION TABLE
   ------------------------------------------------------------ */

CREATE TABLE Prescription_Medicine (
    Prescription_ID INT,
    Medicine_ID INT,

    PRIMARY KEY (Prescription_ID, Medicine_ID),

    CONSTRAINT FK_PM_Prescription
        FOREIGN KEY (Prescription_ID)
        REFERENCES Prescription(Prescription_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_PM_Medicine
        FOREIGN KEY (Medicine_ID)
        REFERENCES Medicine(Medicine_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


/* ------------------------------------------------------------
   10. BILLING TABLE
   ------------------------------------------------------------ */

CREATE TABLE Billing (
    Bill_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT NOT NULL,
    Treatment_ID INT,
    Amount DECIMAL(10,2),
    Payment_Status VARCHAR(30),

    CONSTRAINT FK_Billing_Patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_Billing_Treatment
        FOREIGN KEY (Treatment_ID)
        REFERENCES Treatment(Treatment_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


/* ------------------------------------------------------------
   11. ROOM TABLE
   ------------------------------------------------------------ */

CREATE TABLE Room (
    Room_ID INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(50),
    Status VARCHAR(30),
    Patient_ID INT,

    CONSTRAINT FK_Room_Patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


/* ============================================================
   PART 3: ALTER TABLE COMMANDS
   ============================================================ */
ALTER TABLE Patient
ADD COLUMN Emergency_Contact VARCHAR(15);

ALTER TABLE Patient
DROP COLUMN Emergency_Contact;


/* ============================================================
   PART 4: INSERT DATA
   ============================================================ */
/* ------------------------------------------------------------
   DEPARTMENT DATA
   ------------------------------------------------------------ */

INSERT INTO Department
(Name, Location)
VALUES
('Cardiology', 'Block A'),
('Neurology', 'Block B'),
('Orthopedics', 'Block C'),
('Pediatrics', 'Block D'),
('General Medicine', 'Block E');


/* ------------------------------------------------------------
   PATIENT DATA
   ------------------------------------------------------------ */

INSERT INTO Patient
(Name, Gender, DOB, Phone, Address, Blood_Group)
VALUES
('Rahul Sharma', 'Male', '1995-05-12',
 '9876543210', 'Hyderabad', 'O+'),

('Priya Reddy', 'Female', '1998-08-21',
 '9876543211', 'Vijayawada', 'A+'),

('Arjun Kumar', 'Male', '1990-02-15',
 '9876543212', 'Guntur', 'B+'),

('Sneha Rao', 'Female', '2001-11-10',
 '9876543213', 'Warangal', 'AB+'),

('Kiran Kumar', 'Male', '1985-07-25',
 '9876543214', 'Hyderabad', 'O-'),

('Anjali Singh', 'Female', '1997-04-18',
 '9876543215', 'Visakhapatnam', 'A-');


/* ------------------------------------------------------------
   DOCTOR DATA
   ------------------------------------------------------------ */

INSERT INTO Doctor
(Name, Specialization, Experience, Department_ID)
VALUES
('Dr. Ramesh Kumar', 'Cardiologist', 12, 1),

('Dr. Suresh Rao', 'Neurologist', 10, 2),

('Dr. Anil Sharma', 'Orthopedic Surgeon', 15, 3),

('Dr. Lakshmi Devi', 'Pediatrician', 8, 4),

('Dr. Meena Reddy', 'General Physician', 7, 5);


/* ------------------------------------------------------------
   STAFF DATA
   ------------------------------------------------------------ */

INSERT INTO Staff
(Name, Role, Department_ID)
VALUES
('Neha Sharma', 'Nurse', 1),

('Ravi Kumar', 'Receptionist', 5),

('Pooja Reddy', 'Pharmacist', 5),

('Amit Singh', 'Accountant', 5),

('Swathi Rao', 'Nurse', 4);


/* ------------------------------------------------------------
   APPOINTMENT DATA
   ------------------------------------------------------------ */

INSERT INTO Appointment
(Patient_ID, Doctor_ID, Date, Time, Status)
VALUES
(1, 1, '2026-09-10', '09:30:00', 'Scheduled'),

(2, 4, '2026-09-10', '10:00:00', 'Scheduled'),

(3, 3, '2026-09-11', '11:00:00', 'Completed'),

(4, 5, '2026-09-11', '12:30:00', 'Scheduled'),

(5, 2, '2026-09-12', '10:30:00', 'Scheduled'),

(6, 1, '2026-09-13', '09:00:00', 'Completed');


/* ------------------------------------------------------------
   TREATMENT DATA
   ------------------------------------------------------------ */

INSERT INTO Treatment
(Patient_ID, Diagnosis, Cost)
VALUES
(1, 'Hypertension', 2500.00),

(2, 'Viral Fever', 1500.00),

(3, 'Knee Injury', 5000.00),

(4, 'Fever', 1200.00),

(5, 'Migraine', 3000.00),

(6, 'Heart Checkup', 4000.00);


/* ------------------------------------------------------------
   MEDICINE DATA
   ------------------------------------------------------------ */

INSERT INTO Medicine
(Name, Dosage, Stock, Price)
VALUES
('Paracetamol', '500 mg', 100, 5.00),

('Amoxicillin', '500 mg', 80, 12.00),

('Amlodipine', '5 mg', 50, 8.00),

('Ibuprofen', '400 mg', 70, 10.00),

('Cetirizine', '10 mg', 100, 6.00),

('Sumatriptan', '50 mg', 40, 25.00);


/* ------------------------------------------------------------
   PRESCRIPTION DATA
   ------------------------------------------------------------ */

INSERT INTO Prescription
(Doctor_ID, Treatment_ID)
VALUES
(1, 1),
(4, 2),
(3, 3),
(5, 4),
(2, 5),
(1, 6);


/* ------------------------------------------------------------
   PRESCRIPTION_MEDICINE DATA
   ------------------------------------------------------------ */

INSERT INTO Prescription_Medicine
(Prescription_ID, Medicine_ID)
VALUES
(1, 3),
(1, 1),

(2, 1),
(2, 5),

(3, 4),

(4, 1),

(5, 6),

(6, 3);


/* ------------------------------------------------------------
   BILLING DATA
   ------------------------------------------------------------ */

INSERT INTO Billing
(Patient_ID, Treatment_ID, Amount, Payment_Status)
VALUES
(1, 1, 2500.00, 'Paid'),

(2, 2, 1500.00, 'Paid'),

(3, 3, 5000.00, 'Pending'),

(4, 4, 1200.00, 'Paid'),

(5, 5, 3000.00, 'Pending'),

(6, 6, 4000.00, 'Paid');


/* ------------------------------------------------------------
   ROOM DATA
   ------------------------------------------------------------ */

INSERT INTO Room
(Type, Status, Patient_ID)
VALUES
('General', 'Occupied', 1),

('General', 'Available', NULL),

('Semi-Private', 'Occupied', 2),

('Private', 'Available', NULL),

('ICU', 'Occupied', 3),

('ICU', 'Available', NULL);



SELECT * FROM Patient;

SELECT * FROM Department;

SELECT * FROM Doctor;

SELECT * FROM Appointment;

SELECT * FROM Treatment;

SELECT * FROM Staff;

SELECT * FROM Prescription;

SELECT * FROM Prescription_Medicine;

SELECT * FROM Medicine;

SELECT * FROM Billing;

SELECT * FROM Room;



/* ============================================================
   PART 7: WHERE CONDITIONS
   ============================================================ */
/* Patients from Hyderabad */

SELECT *
FROM Patient
WHERE Address = 'Hyderabad';


/* Female patients */

SELECT *
FROM Patient
WHERE Gender = 'Female';


/* Doctors having more than 10 years experience */

SELECT *
FROM Doctor
WHERE Experience > 10;


/* Bills that are pending */

SELECT *
FROM Billing
WHERE Payment_Status = 'Pending';


/* Available rooms */

SELECT *
FROM Room
WHERE Status = 'Available';


/* Medicines with stock less than 60 */

SELECT *
FROM Medicine
WHERE Stock < 60;


/* ============================================================
   PART 8: BETWEEN, IN, LIKE
   ============================================================ */
/* Experience between 8 and 15 */

SELECT *
FROM Doctor
WHERE Experience BETWEEN 8 AND 15;


/* Blood groups O+ and A+ */

SELECT *
FROM Patient
WHERE Blood_Group IN ('O+', 'A+');


/* Patient names beginning with A */

SELECT *
FROM Patient
WHERE Name LIKE 'A%';


/* Doctors whose specialization contains "Cardio" */

SELECT *
FROM Doctor
WHERE Specialization LIKE '%Cardio%';


/* ============================================================
   PART 9: ORDER BY
   ============================================================ */

SELECT *
FROM Patient
ORDER BY Name ASC;


SELECT *
FROM Doctor
ORDER BY Experience DESC;


SELECT *
FROM Treatment
ORDER BY Cost DESC;


SELECT *
FROM Medicine
ORDER BY Price ASC;


/* ============================================================
   PART 10: UPDATE COMMANDS
   ============================================================ */
/* Update appointment status */

UPDATE Appointment
SET Status = 'Completed'
WHERE Appointment_ID = 1;


/* Update patient phone */

UPDATE Patient
SET Phone = '9999999999'
WHERE Patient_ID = 1;


/* Update medicine stock */

UPDATE Medicine
SET Stock = Stock - 5
WHERE Medicine_ID = 1;


/* Update billing status */

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE Bill_ID = 3;


/* ============================================================
   PART 11: DELETE COMMAND
   ============================================================ */

/*
   Demonstration only.

   Uncomment if you actually want to delete:
   
   DELETE FROM Appointment
   WHERE Appointment_ID = 6;
*/


/* ============================================================
   PART 12: INNER JOIN
   ============================================================ */
/* Patient + Appointment + Doctor */

SELECT
    P.Patient_ID,
    P.Name AS Patient_Name,
    D.Name AS Doctor_Name,
    D.Specialization,
    A.Date,
    A.Time,
    A.Status
FROM Patient P
INNER JOIN Appointment A
    ON P.Patient_ID = A.Patient_ID
INNER JOIN Doctor D
    ON A.Doctor_ID = D.Doctor_ID;


/* ============================================================
   PART 13: DOCTOR + DEPARTMENT
   ============================================================ */

SELECT
    D.Doctor_ID,
    D.Name AS Doctor_Name,
    D.Specialization,
    D.Experience,
    DP.Name AS Department_Name,
    DP.Location
FROM Doctor D
INNER JOIN Department DP
    ON D.Department_ID = DP.Department_ID;


/* ============================================================
   PART 14: PATIENT + TREATMENT
   ============================================================ */

SELECT
    P.Patient_ID,
    P.Name AS Patient_Name,
    T.Treatment_ID,
    T.Diagnosis,
    T.Cost
FROM Patient P
INNER JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID;


/* ============================================================
   PART 15: PATIENT + BILLING
   ============================================================ */

SELECT
    B.Bill_ID,
    P.Patient_ID,
    P.Name AS Patient_Name,
    T.Diagnosis,
    B.Amount,
    B.Payment_Status
FROM Billing B
INNER JOIN Patient P
    ON B.Patient_ID = P.Patient_ID
LEFT JOIN Treatment T
    ON B.Treatment_ID = T.Treatment_ID;


/* ============================================================
   PART 16: PRESCRIPTION + MEDICINE
   ============================================================ */

SELECT
    PR.Prescription_ID,
    D.Name AS Doctor_Name,
    T.Diagnosis,
    M.Medicine_ID,
    M.Name AS Medicine_Name,
    M.Dosage,
    M.Stock,
    M.Price
FROM Prescription PR
INNER JOIN Doctor D
    ON PR.Doctor_ID = D.Doctor_ID
INNER JOIN Treatment T
    ON PR.Treatment_ID = T.Treatment_ID
INNER JOIN Prescription_Medicine PM
    ON PR.Prescription_ID = PM.Prescription_ID
INNER JOIN Medicine M
    ON PM.Medicine_ID = M.Medicine_ID;


/* ============================================================
   PART 17: LEFT JOIN
   ============================================================ */


/* Show all departments including departments
   without doctors */

SELECT
    DP.Department_ID,
    DP.Name AS Department_Name,
    D.Name AS Doctor_Name
FROM Department DP
LEFT JOIN Doctor D
    ON DP.Department_ID = D.Department_ID;


/* ============================================================
   PART 18: RIGHT JOIN
   ============================================================ */

SELECT
    DP.Name AS Department_Name,
    D.Name AS Doctor_Name
FROM Doctor D
RIGHT JOIN Department DP
    ON D.Department_ID = DP.Department_ID;


/* ============================================================
   PART 19: SELF JOIN
   ============================================================ */

/* Compare doctors working in the same department */

SELECT
    D1.Name AS Doctor_1,
    D2.Name AS Doctor_2,
    D1.Department_ID
FROM Doctor D1
JOIN Doctor D2
    ON D1.Department_ID = D2.Department_ID
    AND D1.Doctor_ID < D2.Doctor_ID;


/* ============================================================
   PART 20: AGGREGATE FUNCTIONS
   ============================================================ */


/* Number of patients */

SELECT COUNT(*) AS Total_Patients
FROM Patient;


/* Number of doctors */

SELECT COUNT(*) AS Total_Doctors
FROM Doctor;


/* Number of departments */

SELECT COUNT(*) AS Total_Departments
FROM Department;


/* Number of staff */

SELECT COUNT(*) AS Total_Staff
FROM Staff;


/* Total treatment cost */

SELECT SUM(Cost) AS Total_Treatment_Cost
FROM Treatment;


/* Average treatment cost */

SELECT AVG(Cost) AS Average_Treatment_Cost
FROM Treatment;


/* Maximum treatment cost */

SELECT MAX(Cost) AS Maximum_Treatment_Cost
FROM Treatment;


/* Minimum treatment cost */

SELECT MIN(Cost) AS Minimum_Treatment_Cost
FROM Treatment;


/* Total billing */

SELECT SUM(Amount) AS Total_Billing
FROM Billing;


/* ============================================================
   PART 21: GROUP BY
   ============================================================ */


/* Doctors in each department */

SELECT
    DP.Name AS Department_Name,
    COUNT(D.Doctor_ID) AS Number_Of_Doctors
FROM Department DP
LEFT JOIN Doctor D
    ON DP.Department_ID = D.Department_ID
GROUP BY DP.Department_ID, DP.Name;


/* Treatment cost by patient */

SELECT
    P.Name AS Patient_Name,
    SUM(T.Cost) AS Total_Treatment_Cost
FROM Patient P
JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID
GROUP BY P.Patient_ID, P.Name;


/* Bills by payment status */

SELECT
    Payment_Status,
    COUNT(Bill_ID) AS Number_Of_Bills,
    SUM(Amount) AS Total_Amount
FROM Billing
GROUP BY Payment_Status;


/* ============================================================
   PART 22: HAVING
   ============================================================ */


/* Departments having more than one doctor */

SELECT
    DP.Name AS Department_Name,
    COUNT(D.Doctor_ID) AS Doctor_Count
FROM Department DP
JOIN Doctor D
    ON DP.Department_ID = D.Department_ID
GROUP BY DP.Department_ID, DP.Name
HAVING COUNT(D.Doctor_ID) > 1;


/* Patients whose total treatment cost is above 2000 */

SELECT
    P.Name AS Patient_Name,
    SUM(T.Cost) AS Total_Cost
FROM Patient P
JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID
GROUP BY P.Patient_ID, P.Name
HAVING SUM(T.Cost) > 2000;


/* ============================================================
   PART 23: SUBQUERIES
   ============================================================ */


/* Patients having a bill greater than average bill */

SELECT
    P.Patient_ID,
    P.Name,
    B.Amount
FROM Patient P
JOIN Billing B
    ON P.Patient_ID = B.Patient_ID
WHERE B.Amount >
(
    SELECT AVG(Amount)
    FROM Billing
);


/* Doctor with maximum experience */

SELECT
    Doctor_ID,
    Name,
    Specialization,
    Experience
FROM Doctor
WHERE Experience =
(
    SELECT MAX(Experience)
    FROM Doctor
);


/* Patients who have treatment cost above average */

SELECT
    P.Name,
    T.Diagnosis,
    T.Cost
FROM Patient P
JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID
WHERE T.Cost >
(
    SELECT AVG(Cost)
    FROM Treatment
);

/* ============================================================
   PART 27: STRING FUNCTIONS
   ============================================================ */

SELECT
    Name,
    UPPER(Name) AS Upper_Name,
    LOWER(Name) AS Lower_Name
FROM Patient;


/* ============================================================
   PART 28: DATE FUNCTIONS
   ============================================================ */

SELECT
    Name,
    DOB,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM Patient;


/* ============================================================
   PART 29: ROOM REPORT
   ============================================================ */

SELECT
    R.Room_ID,
    R.Type AS Room_Type,
    R.Status,
    P.Patient_ID,
    P.Name AS Patient_Name
FROM Room R
LEFT JOIN Patient P
    ON R.Patient_ID = P.Patient_ID;


/* ============================================================
   PART 30: PHARMACY REPORT
   ============================================================ */

SELECT
    Medicine_ID,
    Name,
    Dosage,
    Stock,
    Price,
    Stock * Price AS Total_Stock_Value
FROM Medicine;


/* ============================================================
   PART 31: LOW STOCK MEDICINES
   ============================================================ */

SELECT
    Medicine_ID,
    Name,
    Stock,
    Price
FROM Medicine
WHERE Stock < 60;


/* ============================================================
   PART 32: BILLING REPORT
   ============================================================ */

SELECT
    B.Bill_ID,
    P.Name AS Patient_Name,
    T.Diagnosis,
    B.Amount,
    B.Payment_Status
FROM Billing B
JOIN Patient P
    ON B.Patient_ID = P.Patient_ID
LEFT JOIN Treatment T
    ON B.Treatment_ID = T.Treatment_ID
ORDER BY B.Amount DESC;


/* ============================================================
   PART 33: PENDING BILL REPORT
   ============================================================ */

SELECT
    B.Bill_ID,
    P.Name AS Patient_Name,
    B.Amount,
    B.Payment_Status
FROM Billing B
JOIN Patient P
    ON B.Patient_ID = P.Patient_ID
WHERE B.Payment_Status = 'Pending';


/* ============================================================
   PART 34: COMPLETE APPOINTMENT REPORT
   ============================================================ */

SELECT
    A.Appointment_ID,
    P.Name AS Patient_Name,
    D.Name AS Doctor_Name,
    DP.Name AS Department_Name,
    A.Date,
    A.Time,
    A.Status
FROM Appointment A
JOIN Patient P
    ON A.Patient_ID = P.Patient_ID
JOIN Doctor D
    ON A.Doctor_ID = D.Doctor_ID
JOIN Department DP
    ON D.Department_ID = DP.Department_ID
ORDER BY A.Date, A.Time;


/* ============================================================
   PART 35: INDEXES
   ============================================================ */

CREATE INDEX IDX_Patient_Name
ON Patient(Name);

CREATE INDEX IDX_Doctor_Name
ON Doctor(Name);

CREATE INDEX IDX_Appointment_Date
ON Appointment(Date);

CREATE INDEX IDX_Medicine_Name
ON Medicine(Name);

CREATE INDEX IDX_Billing_Status
ON Billing(Payment_Status);


/* ============================================================
   PART 36: SHOW INDEXES
   ============================================================ */

SHOW INDEX FROM Patient;

SHOW INDEX FROM Doctor;

SHOW INDEX FROM Appointment;

SHOW INDEX FROM Medicine;

SHOW INDEX FROM Billing;


/* ============================================================
   PART 37: VIEWS
   ============================================================ */


/* ------------------------------------------------------------
   PATIENT VIEW
   ------------------------------------------------------------ */

CREATE VIEW Patient_Report AS
SELECT
    Patient_ID,
    Name,
    Gender,
    DOB,
    Phone,
    Address,
    Blood_Group
FROM Patient;


/* View result */

SELECT *
FROM Patient_Report;


/* ------------------------------------------------------------
   DOCTOR VIEW
   ------------------------------------------------------------ */

CREATE VIEW Doctor_Report AS
SELECT
    D.Doctor_ID,
    D.Name AS Doctor_Name,
    D.Specialization,
    D.Experience,
    DP.Name AS Department_Name,
    DP.Location
FROM Doctor D
LEFT JOIN Department DP
    ON D.Department_ID = DP.Department_ID;


/* View result */

SELECT *
FROM Doctor_Report;


/* ------------------------------------------------------------
   APPOINTMENT VIEW
   ------------------------------------------------------------ */

CREATE VIEW Appointment_Report AS
SELECT
    A.Appointment_ID,
    P.Name AS Patient_Name,
    D.Name AS Doctor_Name,
    DP.Name AS Department_Name,
    A.Date,
    A.Time,
    A.Status
FROM Appointment A
JOIN Patient P
    ON A.Patient_ID = P.Patient_ID
JOIN Doctor D
    ON A.Doctor_ID = D.Doctor_ID
JOIN Department DP
    ON D.Department_ID = DP.Department_ID;


/* View result */

SELECT *
FROM Appointment_Report;


/* ------------------------------------------------------------
   BILLING VIEW
   ------------------------------------------------------------ */

CREATE VIEW Billing_Report AS
SELECT
    B.Bill_ID,
    P.Name AS Patient_Name,
    T.Diagnosis,
    B.Amount,
    B.Payment_Status
FROM Billing B
JOIN Patient P
    ON B.Patient_ID = P.Patient_ID
LEFT JOIN Treatment T
    ON B.Treatment_ID = T.Treatment_ID;


/* View result */

SELECT *
FROM Billing_Report;


/* ============================================================
   PART 38: STORED PROCEDURE
   ============================================================ */


/* Procedure to find patient using ID */

DELIMITER //

CREATE PROCEDURE GetPatientByID(IN P_ID INT)
BEGIN
    SELECT
        Patient_ID,
        Name,
        Gender,
        DOB,
        Phone,
        Address,
        Blood_Group
    FROM Patient
    WHERE Patient_ID = P_ID;
END //

DELIMITER ;


/* Execute procedure */

CALL GetPatientByID(1);


/* ============================================================
   PART 39: STORED PROCEDURE FOR APPOINTMENTS
   ============================================================ */

DELIMITER //

CREATE PROCEDURE GetPatientAppointments(IN P_ID INT)
BEGIN

    SELECT
        A.Appointment_ID,
        P.Name AS Patient_Name,
        D.Name AS Doctor_Name,
        A.Date,
        A.Time,
        A.Status
    FROM Appointment A

    JOIN Patient P
        ON A.Patient_ID = P.Patient_ID

    JOIN Doctor D
        ON A.Doctor_ID = D.Doctor_ID

    WHERE A.Patient_ID = P_ID

    ORDER BY A.Date, A.Time;

END //

DELIMITER ;


/* Execute */

CALL GetPatientAppointments(1);


/* ============================================================
   PART 40: STORED PROCEDURE FOR BILLING
   ============================================================ */

DELIMITER //

CREATE PROCEDURE GetPatientBills(IN P_ID INT)
BEGIN

    SELECT
        B.Bill_ID,
        P.Name AS Patient_Name,
        B.Amount,
        B.Payment_Status
    FROM Billing B

    JOIN Patient P
        ON B.Patient_ID = P.Patient_ID

    WHERE B.Patient_ID = P_ID;

END //

DELIMITER ;


/* Execute */

CALL GetPatientBills(1);


/* ============================================================
   PART 41: TRIGGER
   PREVENT NEGATIVE MEDICINE STOCK
   ============================================================ */

DELIMITER //

CREATE TRIGGER Prevent_Negative_Medicine_Stock
BEFORE UPDATE ON Medicine
FOR EACH ROW
BEGIN

    IF NEW.Stock < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Medicine stock cannot be negative';

    END IF;

END //

DELIMITER ;


/* ============================================================
   PART 42: TRIGGER
   VALIDATE TREATMENT COST
   ============================================================ */

DELIMITER //

CREATE TRIGGER Validate_Treatment_Cost
BEFORE INSERT ON Treatment
FOR EACH ROW
BEGIN

    IF NEW.Cost < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Treatment cost cannot be negative';

    END IF;

END //

DELIMITER ;


/* ============================================================
   PART 43: TRANSACTION COMMANDS
   ============================================================ */


/* Demonstration of transaction */

START TRANSACTION;

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE Bill_ID = 5;

COMMIT;


/* Another transaction example */

START TRANSACTION;

UPDATE Medicine
SET Stock = Stock - 2
WHERE Medicine_ID = 2;

COMMIT;


/* ============================================================
   PART 44: ROLLBACK EXAMPLE
   ============================================================ */


/*
   This demonstrates ROLLBACK.
   The update will NOT be permanently saved.

   START TRANSACTION;

   UPDATE Patient
   SET Phone = '1111111111'
   WHERE Patient_ID = 2;

   ROLLBACK;
*/


/* ============================================================
   PART 45: SAVEPOINT
   ============================================================ */

START TRANSACTION;

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE Bill_ID = 2;

SAVEPOINT Billing_Savepoint;

UPDATE Billing
SET Payment_Status = 'Pending'
WHERE Bill_ID = 4;

ROLLBACK TO Billing_Savepoint;

COMMIT;


/* ============================================================
   PART 46: DATABASE STRUCTURE COMMANDS
   ============================================================ */

SHOW TABLES;


/* Table structures */

DESCRIBE Patient;

DESCRIBE Department;

DESCRIBE Doctor;

DESCRIBE Appointment;

DESCRIBE Treatment;

DESCRIBE Staff;

DESCRIBE Prescription;

DESCRIBE Prescription_Medicine;

DESCRIBE Medicine;

DESCRIBE Billing;

DESCRIBE Room;


/* ============================================================
   PART 47: SHOW CREATE TABLE
   ============================================================ */

SHOW CREATE TABLE Patient;

SHOW CREATE TABLE Department;

SHOW CREATE TABLE Doctor;

SHOW CREATE TABLE Appointment;

SHOW CREATE TABLE Treatment;

SHOW CREATE TABLE Staff;

SHOW CREATE TABLE Prescription;

SHOW CREATE TABLE Prescription_Medicine;

SHOW CREATE TABLE Medicine;

SHOW CREATE TABLE Billing;

SHOW CREATE TABLE Room;


/* ============================================================
   PART 48: HOSPITAL DASHBOARD
   ============================================================ */

SELECT

    (SELECT COUNT(*)
     FROM Patient) AS Total_Patients,

    (SELECT COUNT(*)
     FROM Doctor) AS Total_Doctors,

    (SELECT COUNT(*)
     FROM Department) AS Total_Departments,

    (SELECT COUNT(*)
     FROM Staff) AS Total_Staff,

    (SELECT COUNT(*)
     FROM Appointment) AS Total_Appointments,

    (SELECT COUNT(*)
     FROM Treatment) AS Total_Treatments,

    (SELECT COUNT(*)
     FROM Medicine) AS Total_Medicines,

    (SELECT COUNT(*)
     FROM Room
     WHERE Status = 'Available') AS Available_Rooms,

    (SELECT COUNT(*)
     FROM Room
     WHERE Status = 'Occupied') AS Occupied_Rooms,

    (SELECT COALESCE(SUM(Amount),0)
     FROM Billing) AS Total_Billing,

    (SELECT COALESCE(SUM(Amount),0)
     FROM Billing
     WHERE Payment_Status = 'Paid') AS Total_Paid,

    (SELECT COALESCE(SUM(Amount),0)
     FROM Billing
     WHERE Payment_Status = 'Pending') AS Total_Pending;


/* ============================================================
   PART 49: FINAL RECORD COUNT
   ============================================================ */

SELECT 'Patient' AS Table_Name,
       COUNT(*) AS Record_Count
FROM Patient

UNION ALL

SELECT 'Department',
       COUNT(*)
FROM Department

UNION ALL

SELECT 'Doctor',
       COUNT(*)
FROM Doctor

UNION ALL

SELECT 'Appointment',
       COUNT(*)
FROM Appointment

UNION ALL

SELECT 'Treatment',
       COUNT(*)
FROM Treatment

UNION ALL

SELECT 'Staff',
       COUNT(*)
FROM Staff

UNION ALL

SELECT 'Prescription',
       COUNT(*)
FROM Prescription

UNION ALL

SELECT 'Prescription_Medicine',
       COUNT(*)
FROM Prescription_Medicine

UNION ALL

SELECT 'Medicine',
       COUNT(*)
FROM Medicine

UNION ALL

SELECT 'Billing',
       COUNT(*)
FROM Billing

UNION ALL

SELECT 'Room',
       COUNT(*)
FROM Room;


/* ============================================================
   PART 50: FINAL ER RELATIONSHIP CHECK
   ============================================================ */
/* Patient -> Appointment -> Doctor -> Department */

SELECT
    P.Patient_ID,
    P.Name AS Patient_Name,
    A.Appointment_ID,
    A.Date,
    A.Time,
    D.Doctor_ID,
    D.Name AS Doctor_Name,
    DP.Department_ID,
    DP.Name AS Department_Name
FROM Patient P
JOIN Appointment A
    ON P.Patient_ID = A.Patient_ID
JOIN Doctor D
    ON A.Doctor_ID = D.Doctor_ID
JOIN Department DP
    ON D.Department_ID = DP.Department_ID;


/* Patient -> Treatment -> Prescription -> Medicine */

SELECT
    P.Name AS Patient_Name,
    T.Treatment_ID,
    T.Diagnosis,
    PR.Prescription_ID,
    M.Name AS Medicine_Name,
    M.Dosage
FROM Patient P
JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID
JOIN Prescription PR
    ON T.Treatment_ID = PR.Treatment_ID
JOIN Prescription_Medicine PM
    ON PR.Prescription_ID = PM.Prescription_ID
JOIN Medicine M
    ON PM.Medicine_ID = M.Medicine_ID;


/* Patient -> Treatment -> Billing */

SELECT
    P.Name AS Patient_Name,
    T.Diagnosis,
    T.Cost AS Treatment_Cost,
    B.Bill_ID,
    B.Amount AS Bill_Amount,
    B.Payment_Status
FROM Patient P
JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID
JOIN Billing B
    ON T.Treatment_ID = B.Treatment_ID;


/* Patient -> Room */

SELECT
    P.Patient_ID,
    P.Name AS Patient_Name,
    R.Room_ID,
    R.Type AS Room_Type,
    R.Status
FROM Patient P
LEFT JOIN Room R
    ON P.Patient_ID = R.Patient_ID;
    


/* ============================================================
   PART 51: DCL - DATA CONTROL LANGUAGE
   ============================================================ */

CREATE USER 'hospital_admin'@'localhost'
IDENTIFIED BY 'Admin@123';

CREATE USER 'doctor_user'@'localhost'
IDENTIFIED BY 'Doctor@123';

CREATE USER 'reception_user'@'localhost'
IDENTIFIED BY 'Reception@123';

GRANT ALL PRIVILEGES
ON Hospital_Management_System.*
TO 'hospital_admin'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Hospital_Management_System.Patient
TO 'doctor_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Hospital_Management_System.Appointment
TO 'doctor_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Hospital_Management_System.Treatment
TO 'doctor_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Hospital_Management_System.Prescription
TO 'doctor_user'@'localhost';

GRANT SELECT
ON Hospital_Management_System.Medicine
TO 'doctor_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Hospital_Management_System.Patient
TO 'reception_user'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON Hospital_Management_System.Appointment
TO 'reception_user'@'localhost';

GRANT SELECT
ON Hospital_Management_System.Doctor
TO 'reception_user'@'localhost';

GRANT SELECT
ON Hospital_Management_System.Department
TO 'reception_user'@'localhost';

SHOW GRANTS FOR 'hospital_admin'@'localhost';
SHOW GRANTS FOR 'doctor_user'@'localhost';
SHOW GRANTS FOR 'reception_user'@'localhost';

REVOKE UPDATE
ON Hospital_Management_System.Patient
FROM 'reception_user'@'localhost';

GRANT UPDATE
ON Hospital_Management_System.Patient
TO 'reception_user'@'localhost';

FLUSH PRIVILEGES;


/* ============================================================
   PART 52: DATABASE NORMALIZATION
   ============================================================ */

/*
   1NF:
   - Atomic values
   - No repeating groups
   - Each record has a primary key

   2NF:
   - Must satisfy 1NF
   - No partial dependency
   - Prescription_Medicine separates the many-to-many
     relationship between Prescription and Medicine

   3NF:
   - Must satisfy 2NF
   - No transitive dependency
   - Department details are stored separately
     from Doctor details
*/

SELECT *
FROM Patient;

SELECT *
FROM Appointment;

SELECT
    Prescription_ID,
    Medicine_ID
FROM Prescription_Medicine;

SELECT
    D.Doctor_ID,
    D.Name AS Doctor_Name,
    D.Specialization,
    D.Experience,
    DP.Department_ID,
    DP.Name AS Department_Name,
    DP.Location
FROM Doctor D
JOIN Department DP
    ON D.Department_ID = DP.Department_ID;

SELECT
    P.Patient_ID,
    P.Name AS Patient_Name,
    A.Appointment_ID,
    A.Date,
    A.Time,
    A.Status
FROM Patient P
JOIN Appointment A
    ON P.Patient_ID = A.Patient_ID;

SELECT
    P.Patient_ID,
    P.Name AS Patient_Name,
    T.Treatment_ID,
    T.Diagnosis,
    T.Cost
FROM Patient P
JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID;

SELECT
    PR.Prescription_ID,
    M.Medicine_ID,
    M.Name AS Medicine_Name,
    M.Dosage,
    M.Price
FROM Prescription PR
JOIN Prescription_Medicine PM
    ON PR.Prescription_ID = PM.Prescription_ID
JOIN Medicine M
    ON PM.Medicine_ID = M.Medicine_ID;


/* ============================================================
   PART 53: ACID PROPERTIES
   ============================================================ */

/*
   A - Atomicity
   C - Consistency
   I - Isolation
   D - Durability
*/


/* -------------------- ATOMICITY -------------------- */

START TRANSACTION;

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE Bill_ID = 5;

UPDATE Medicine
SET Stock = Stock - 2
WHERE Medicine_ID = 1;

COMMIT;


/* Atomicity using ROLLBACK */

START TRANSACTION;

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE Bill_ID = 3;

UPDATE Medicine
SET Stock = Stock - 5
WHERE Medicine_ID = 2;

ROLLBACK;


/* -------------------- CONSISTENCY -------------------- */

/*
   The existing trigger Prevent_Negative_Medicine_Stock
   prevents medicine stock from becoming negative.
*/

START TRANSACTION;

UPDATE Medicine
SET Stock = Stock - 10
WHERE Medicine_ID = 1;

COMMIT;


/* -------------------- ISOLATION -------------------- */

START TRANSACTION;

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE Bill_ID = 2;

SELECT *
FROM Billing
WHERE Bill_ID = 2;

COMMIT;


/* -------------------- DURABILITY -------------------- */

START TRANSACTION;

UPDATE Patient
SET Phone = '9999999999'
WHERE Patient_ID = 1;

COMMIT;

SELECT
    Patient_ID,
    Name,
    Phone
FROM Patient
WHERE Patient_ID = 1;


/* -------------------- SAVEPOINT -------------------- */

START TRANSACTION;

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE Bill_ID = 1;

SAVEPOINT Billing_Savepoint;

UPDATE Billing
SET Payment_Status = 'Pending'
WHERE Bill_ID = 4;

ROLLBACK TO Billing_Savepoint;

COMMIT;


/* ============================================================
   ACID SUMMARY
   ============================================================ */

/*
   ATOMICITY   : Complete transaction or complete rollback.
   CONSISTENCY : Database remains valid after a transaction.
   ISOLATION   : Transactions work independently.
   DURABILITY  : Committed changes remain permanently stored.
*/


/* ============================================================
   END OF HOSPITAL MANAGEMENT SYSTEM DATABASE
   ============================================================ */