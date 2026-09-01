
USE medicare_hospital;

-- 1. Total registered patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- 2. Patient gender distribution
SELECT gender, COUNT(*) AS patient_count
FROM patients
GROUP BY gender;

-- 3. Age calculation
SELECT
patient_id,
TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS age
FROM patients;

-- 4. Patients by city
SELECT city, COUNT(*) AS patients
FROM patients
GROUP BY city
ORDER BY patients DESC;

-- 5. Insurance provider distribution
SELECT insurance_provider, COUNT(*) AS patients
FROM patients
GROUP BY insurance_provider;

-- 6. Most common diagnoses
SELECT diagnosis, COUNT(*) AS cases
FROM medical_records
GROUP BY diagnosis
ORDER BY cases DESC;

-- 7. Critical condition patients
SELECT *
FROM medical_records
WHERE severity='Critical';

-- 8. Average hospital stay
SELECT AVG(DATEDIFF(discharge_date, admission_date))
AS average_stay_days
FROM medical_records;

-- 9. Doctor workload
SELECT
d.doctor_name,
COUNT(a.appointment_id) AS appointments
FROM doctors d
JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY d.doctor_name
ORDER BY appointments DESC;

-- 10. Appointment completion rate
SELECT
status,
COUNT(*) AS total
FROM appointments
GROUP BY status;

-- 11. Emergency visit volume
SELECT COUNT(*) AS emergency_visits
FROM appointments
WHERE visit_type='Emergency';

-- 12. Most prescribed medications
SELECT
drug_name,
COUNT(*) AS prescriptions
FROM medications
GROUP BY drug_name
ORDER BY prescriptions DESC;

-- 13. Total hospital revenue
SELECT SUM(amount) AS revenue
FROM billing;

-- 14. Revenue by service
SELECT
service,
SUM(amount) AS revenue
FROM billing
GROUP BY service
ORDER BY revenue DESC;

-- 15. Payment status analysis
SELECT
payment_status,
COUNT(*) AS transactions
FROM billing
GROUP BY payment_status;

-- 16. Top spending patients
SELECT
patient_id,
SUM(amount) AS total_spent
FROM billing
GROUP BY patient_id
ORDER BY total_spent DESC
LIMIT 10;

-- 17. Monthly revenue trend
SELECT
MONTH(bill_date) AS month,
SUM(amount) AS revenue
FROM billing
GROUP BY MONTH(bill_date);

-- 18. Diagnosis severity analysis
SELECT
diagnosis,
severity,
COUNT(*) AS cases
FROM medical_records
GROUP BY diagnosis,severity;

-- 19. Doctor specialty workload
SELECT
d.specialization,
COUNT(a.appointment_id) AS visits
FROM doctors d
JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY d.specialization;

-- 20. Patient clinical summary view
CREATE VIEW patient_summary AS
SELECT
p.patient_id,
CONCAT(p.first_name,' ',p.last_name) AS patient_name,
COUNT(m.record_id) AS medical_visits
FROM patients p
LEFT JOIN medical_records m
ON p.patient_id=m.patient_id
GROUP BY p.patient_id;
