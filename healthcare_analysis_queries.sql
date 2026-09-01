-- Healthcare Analytics Queries

-- Total Patients
SELECT COUNT(*) AS total_patients FROM patients;

-- Gender Distribution
SELECT gender, COUNT(*) AS total
FROM patients
GROUP BY gender;

-- Top Diagnoses
SELECT diagnosis, COUNT(*) AS cases
FROM medical_records
GROUP BY diagnosis
ORDER BY cases DESC;

-- Doctor Workload
SELECT d.doctor_name, COUNT(a.appointment_id) AS appointments
FROM doctors d
JOIN appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY appointments DESC;

-- Total Revenue
SELECT SUM(amount) AS hospital_revenue
FROM billing;

-- Highest Spending Patients
SELECT patient_id, SUM(amount) AS total_spent
FROM billing
GROUP BY patient_id
ORDER BY total_spent DESC;