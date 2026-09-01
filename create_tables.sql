USE medicare_hospital;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(20),
    date_of_birth DATE,
    blood_type VARCHAR(5),
    city VARCHAR(50),
    insurance_provider VARCHAR(50),
    registration_date DATE
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100),
    department VARCHAR(50),
    years_experience INT
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    visit_type VARCHAR(50),
    status VARCHAR(30),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE medical_records (
    record_id INT PRIMARY KEY,
    patient_id INT,
    diagnosis VARCHAR(100),
    symptoms TEXT,
    severity VARCHAR(20),
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE medications (
    medication_id INT PRIMARY KEY,
    patient_id INT,
    drug_name VARCHAR(100),
    dosage VARCHAR(50),
    duration_days INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    service VARCHAR(100),
    amount DECIMAL(10,2),
    payment_status VARCHAR(30),
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);