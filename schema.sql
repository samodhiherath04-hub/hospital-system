-- Hospital Management System: database structure and demo data.
-- In phpMyAdmin: open the Import tab, choose this file, click Import.

CREATE DATABASE IF NOT EXISTS hospital_db CHARACTER SET utf8mb4;
USE hospital_db;

CREATE TABLE IF NOT EXISTS hms_patients (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_doctors (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_departments (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_appointments (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_admissions (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_records (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_labs (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_meds (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_bills (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_payments (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_employees (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_attendance (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_leaves (id VARCHAR(40) PRIMARY KEY, data JSON NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_users (id VARCHAR(40) PRIMARY KEY, username VARCHAR(60) NOT NULL UNIQUE, name VARCHAR(120) NOT NULL, role VARCHAR(20) NOT NULL, pw_hash VARCHAR(255) NOT NULL) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_audit (id INT AUTO_INCREMENT PRIMARY KEY, ts DATETIME NOT NULL, username VARCHAR(60), action VARCHAR(80), detail VARCHAR(200)) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS hms_meta (k VARCHAR(20) PRIMARY KEY, v BIGINT NOT NULL) ENGINE=InnoDB;

-- Demo data
INSERT IGNORE INTO hms_departments(id,data) VALUES('DP1','{"id": "DP1", "name": "General Medicine", "head": "Dr. Silva"}');
INSERT IGNORE INTO hms_departments(id,data) VALUES('DP2','{"id": "DP2", "name": "Cardiology", "head": "Dr. Perera"}');
INSERT IGNORE INTO hms_departments(id,data) VALUES('DP3','{"id": "DP3", "name": "Paediatrics", "head": "Dr. Fernando"}');
INSERT IGNORE INTO hms_doctors(id,data) VALUES('D1','{"id": "D1", "name": "Dr. Silva", "dept": "DP1", "spec": "Physician", "fee": 1500, "days": "Mon,Tue,Wed,Thu,Fri,Sat,Sun", "hours": "09:00-15:00"}');
INSERT IGNORE INTO hms_doctors(id,data) VALUES('D2','{"id": "D2", "name": "Dr. Perera", "dept": "DP2", "spec": "Cardiologist", "fee": 3000, "days": "Mon,Tue,Wed,Thu,Fri,Sat,Sun", "hours": "10:00-16:00"}');
INSERT IGNORE INTO hms_patients(id,data) VALUES('P1','{"id": "P1", "name": "Nimal Jayasuriya", "dob": "1978-03-14", "gender": "Male", "phone": "0771234567", "address": "12 Lake Road", "blood": "O+", "allergies": "Penicillin"}');
INSERT IGNORE INTO hms_patients(id,data) VALUES('P2','{"id": "P2", "name": "Kamala Wijesinghe", "dob": "1991-09-02", "gender": "Female", "phone": "0719876543", "address": "48 Temple Lane", "blood": "A+", "allergies": ""}');
INSERT IGNORE INTO hms_appointments(id,data) VALUES('A1','{"id": "A1", "patient": "P1", "doctor": "D1", "date": "2026-10-18", "time": "10:00", "status": "Booked", "notes": "Fever"}');
INSERT IGNORE INTO hms_appointments(id,data) VALUES('A2','{"id": "A2", "patient": "P2", "doctor": "D2", "date": "2026-10-18", "time": "11:30", "status": "Booked", "notes": "Checkup"}');
INSERT IGNORE INTO hms_records(id,data) VALUES('R1','{"id": "R1", "patient": "P1", "doctor": "D1", "date": "2026-10-18", "diagnosis": "Viral fever", "treatment": "Rest and fluids", "med": "M1", "qty": 10, "report": "", "done": 0}');
INSERT IGNORE INTO hms_labs(id,data) VALUES('L1','{"id": "L1", "patient": "P1", "doctor": "D1", "test": "Full blood count", "price": 1200, "date": "2026-10-18", "status": "Requested", "result": ""}');
INSERT IGNORE INTO hms_meds(id,data) VALUES('M1','{"id": "M1", "name": "Paracetamol 500mg", "stock": 200, "reorder": 50, "price": 5, "expiry": "2027-11-22"}');
INSERT IGNORE INTO hms_meds(id,data) VALUES('M2','{"id": "M2", "name": "Amoxicillin 250mg", "stock": 12, "reorder": 30, "price": 18, "expiry": "2026-11-17"}');
INSERT IGNORE INTO hms_bills(id,data) VALUES('B1','{"id": "B1", "inv": "INV-1001", "patient": "P2", "date": "2026-10-18", "consult": 3000, "lab": 0, "pharmacy": 0, "admission": 0}');
INSERT IGNORE INTO hms_employees(id,data) VALUES('E1','{"id": "E1", "name": "Sunil Fernando", "role": "Nurse", "dept": "DP1", "phone": "0702223344", "joined": "2022-05-01"}');
REPLACE INTO hms_meta VALUES('inv',1001);
-- Demo users: username = role, password = username + 123
INSERT IGNORE INTO hms_users(id,username,name,role,pw_hash) VALUES('U-admin','admin','Administrator','admin','$2b$10$Z6ws0eM6JFhg.iepS1qsaeKZJNmBrGYAi5o0.SDc9EKeCmxXQZZVy');
INSERT IGNORE INTO hms_users(id,username,name,role,pw_hash) VALUES('U-doctor','doctor','Doctor','doctor','$2b$10$z32eNXtko8usTut.8FOim.r3rOmcj.31cpacXjFfxo7SIO80EP0qq');
INSERT IGNORE INTO hms_users(id,username,name,role,pw_hash) VALUES('U-nurse','nurse','Nurse','nurse','$2b$10$fjvQLybrwQW8Nf6H.K.umu1uSSpyMS67t/1m4UKFKGZrR3Mvltipa');
INSERT IGNORE INTO hms_users(id,username,name,role,pw_hash) VALUES('U-reception','reception','Receptionist','reception','$2b$10$D5d6JilLJGUUQ4F5mDBF6u23gCgjKL0xOLK.P0e1YZmUIa5tliRHS');
INSERT IGNORE INTO hms_users(id,username,name,role,pw_hash) VALUES('U-lab','lab','Laboratory staff','lab','$2b$10$JydpW9.fxonNPPPqxqD6GOBPiY0qedTq8IxdBW9BcI/1lkjIVAzQu');
INSERT IGNORE INTO hms_users(id,username,name,role,pw_hash) VALUES('U-pharmacist','pharmacist','Pharmacist','pharmacist','$2b$10$XQMYqOysV9uO8XfzyKiJTesGmkVzy9lplMH4YIWJiSlDtePbk7fp6');
INSERT IGNORE INTO hms_users(id,username,name,role,pw_hash) VALUES('U-accountant','accountant','Accountant','accountant','$2b$10$Ngde6AeL3WC7mQHyyEBUo.KA7azk3kGQZXQRdY1yQuafiZxH9Vh7.');
