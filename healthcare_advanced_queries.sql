USE medicare_hospital;

-- 1. Monthly Hospital Revenue
SELECT
YEAR(bill_date) AS year,
MONTH(bill_date) AS month,
SUM(amount) AS revenue
FROM billing
GROUP BY YEAR(bill_date), MONTH(bill_date)
ORDER BY year, month;


-- 2. Top 5 Diagnoses
SELECT
diagnosis,
COUNT(*) AS cases
FROM medical_records
GROUP BY diagnosis
ORDER BY cases DESC
LIMIT 5;


-- 3. Patient Medical History View
CREATE VIEW patient_history AS
SELECT
p.patient_id,
CONCAT(p.first_name,' ',p.last_name) AS patient_name,
m.diagnosis,
m.severity,
m.admission_date
FROM patients p
JOIN medical_records m
ON p.patient_id=m.patient_id;


-- 4. Doctor Appointment Ranking
SELECT
d.doctor_name,
COUNT(a.appointment_id) AS total_visits,
RANK() OVER(
ORDER BY COUNT(a.appointment_id) DESC
) AS workload_rank
FROM doctors d
JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY d.doctor_name;


-- 5. High Risk Patients
SELECT
patient_id,
COUNT(*) AS critical_cases
FROM medical_records
WHERE severity='Critical'
GROUP BY patient_id;