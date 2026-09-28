create database joins_assignment;

use joins_assignment;

DROP TABLE IF EXISTS visits;

DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(30),
    blood_group VARCHAR(5)
);

CREATE TABLE visits (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    visit_date DATE,
    department VARCHAR(40),
    doctor_name VARCHAR(50),
    treatment_cost DECIMAL(8,2),
    payment_mode VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

INSERT INTO patients VALUES
(1, 'Amit Sharma', 'Male', 34, 'Delhi', 'B+'),
(2, 'Neha Verma', 'Female', 28, 'Mumbai', 'O+'),
(3, 'Rahul Singh', 'Male', 45, 'Delhi', 'A+'),
(4, 'Priya Mehta', 'Female', 32, 'Bangalore', 'AB+'),
(5, 'Karan Malhotra', 'Male', 50, 'Mumbai', 'O-'),
(6, 'Simran Kaur', 'Female', 26, 'Chandigarh', 'B+'),
(7, 'Arjun Rao', 'Male', 39, 'Hyderabad', 'A-'),
(8, 'Megha Jain', 'Female', 41, 'Pune', 'O+'),
(9, 'Vikas Yadav', 'Male', 36, 'Lucknow', 'B-'),
(10, 'Sneha Iyer', 'Female', 30, 'Chennai', 'AB-'),
(11, 'Ritika Das', 'Female', 29, 'Kolkata', 'A+'),
(12, 'Manoj Kumar', 'Male', 52, 'Jaipur', 'B+'),
(13, 'Anjali Nair', 'Female', 24, 'Kochi', 'O-'),
(14, 'Deepak Joshi', 'Male', 48, 'Bhopal', 'AB+'),
(15, 'Pallavi Roy', 'Female', 37, 'Mumbai', 'A-'),
(16, 'Rohan Gupta', 'Male', 33, 'Ahmedabad', 'O+');

INSERT INTO visits VALUES
(101, 1, '2025-01-01', 'Cardiology', 'Dr. Shah', 5000, 'Card'),
(102, 2, '2025-01-02', 'Dermatology', 'Dr. Rao', 1500, 'Cash'),
(103, 1, '2025-01-05', 'Orthopedic', 'Dr. Mehta', 3000, 'UPI'),
(104, 3, '2025-01-06', 'Neurology', 'Dr. Khan', 7000, 'Card'),
(105, 4, '2025-01-06', 'Gynecology', 'Dr. Sharma', 2500, 'UPI'),
(106, 5, '2025-01-07', 'General', 'Dr. Patel', 1200, 'Cash'),
(107, 6, '2025-01-08', 'ENT', 'Dr. Singh', 1800, 'UPI'),
(108, 7, '2025-01-09', 'Orthopedic', 'Dr. Mehta', 3500, 'Card'),
(109, 8, '2025-01-09', 'Cardiology', 'Dr. Shah', 6200, 'Card'),
(110, 2, '2025-01-10', 'General', 'Dr. Patel', 1000, 'Cash'),
(111, 9, '2025-01-10', 'Dermatology', 'Dr. Rao', 1600, 'UPI'),
(112, 10, '2025-01-11', 'ENT', 'Dr. Singh', 2000, 'Card'),
(113, 3, '2025-01-11', 'Cardiology', 'Dr. Shah', 5500, 'UPI'),
(114, 5, '2025-01-12', 'Neurology', 'Dr. Khan', 7200, 'Card'),
(115, 8, '2025-01-12', 'General', 'Dr. Patel', 1300, 'Cash'),
(116, 4, '2025-01-13', 'General', 'Dr. Patel', 1100, 'Cash'),
(117, 6, '2025-01-13', 'Cardiology', 'Dr. Shah', 4800, 'Card'),
(118, 7, '2025-01-14', 'Dermatology', 'Dr. Rao', 1700, 'UPI'),
(119, 9, '2025-01-14', 'Orthopedic', 'Dr. Mehta', 3100, 'Card'),
(120, 13, '2025-01-14', 'Gynecology', 'Dr. Mehta', 3500, 'Card'),
(121, 16, '2025-01-15', 'General', 'Dr. Patel', 900, 'Cash');


SELECT * FROM patients;

SELECT * FROM visits;

-- 5) Show patient name and department where department = 'Cardiology'.
select p.patient_name,v.department
from patients p inner join visits v
on p.patient_id=v.patient_id
where v.department='Cardiology';

-- 7)List visits of patients from Delhi only.
select v.visit_id,v.patient_id,v.department,v.doctor_name
from patients p join visits v
on p.patient_id=v.patient_id
where p.city='Delhi';

-- 10)Show patients aged above 40 who had visits.
select DISTINCT p.patient_id,p.patient_name,p.gender,p.age
from patients p join visits v
on p.patient_id=v.patient_id
where p.age>40;

-- 12)Display patient name and visit date sorted by latest visit first.
select p.patient_name,v.visit_date
from patients p join visits v
on p.patient_id=v.patient_id
order by v.visit_date desc;

-- 15)Show patients who have no visits.
select p.patient_name,v.visit_id
from patients p left join visits v
on p.patient_id=v.patient_id
where v.visit_id IS NULL;

-- 16)Display patients whose department is NULL.
select p.patient_id,p.patient_name,v.department
from patients p left join visits v
on p.patient_id=v.patient_id
where v.department is null;

-- 17)Show all patients with visits only from Cardiology (include patients without visits).
select p.patient_id,p.patient_name,v.department
from patients p left join visits v
on p.patient_id=v.patient_id
AND v.department='Cardiology';


-- 18)Find patients from Mumbai who never visited.
select distinct p.patient_id, p.patient_name,v.visit_id
from patients p left join visits v
on p.patient_id=v.patient_id
where p.city='Mumbai' and  v.visit_id is  NULL;

-- 19)Count number of visits per patient
select p.patient_id,p.patient_name,count(v.visit_id)
from patients p join visits v
on p.patient_id=v.patient_id
group by p.patient_id,p.patient_name;


-- 21)Calculate total revenue per department
select department,sum(treatment_cost) as total_revenue
from visits
group by department;

-- 22)Find number of patients per city who visited.
select p.city,count(distinct v.patient_id) as total_patients
from patients p left join visits v
on p.patient_id=v.patient_id
where v.visit_id is not null
group by p.city;

-- 24)Show doctors who handled more than 2 visits
select doctor_name,count(visit_id) as visits
from visits
group by doctor_name
having visits>2;

-- 25)Find cities where hospital revenue is greater than 12,000
select p.city,sum(v.treatment_cost) as total_revenue
from patients p join visits v
on p.patient_id=v.patient_id
group by p.city
having total_revenue>12000;

-- 26)Show top 5 most expensive visits
select visit_id,sum(treatment_cost) as total_expense
from visits
group by visit_id
order by total_expense desc
limit 5;

-- 27)Show patient name and total spending sorted by highest spending
select p.patient_name,sum(v.treatment_cost) as total_spending
from patients p join visits v
on p.patient_id=v.patient_id
group by p.patient_name
order by total_spending desc;

-- EXTRAS
-- Find all patients who have visited more than one distinct department.
-- Find the most expensive visit for each patient.
-- Find patients whose total treatment cost is greater than the average total treatment cost of all patients.
-- Find the department that generated the highest total revenue.
-- Find all patients who never visited Cardiology.
-- Find the doctor who has treated the highest number of distinct patients.


-- extra 1:Find all patients who have visited more than one distinct department.
select p.patient_name,count(p.patient_name)
from patients p join visits v
on p.patient_id=v.patient_id
group by p.patient_name
having count(p.patient_name)>1 and count(distinct v.department)>1;

-- extra 2: Find the most expensive visit for each patient.
select patient_name,visit_id,max_expense
from
(
select patient_name,visit_id,max_expense,
row_number() over(partition by patient_name order by max_expense desc) as rn
from
	(
	select p.patient_name,v.visit_id,max(v.treatment_cost) as max_expense
	from patients p join visits v
	on p.patient_id=v.patient_id
	group by p.patient_name,v.visit_id
	) as x
 ) as y where rn=1;

-- extra 3:Find patients whose total treatment cost is greater than the average total treatment cost of all patients.


SELECT patient_name
FROM (
    SELECT patient_name,
           total_cost,
           AVG(total_cost) OVER() AS avg_cost
    FROM (
        SELECT p.patient_name,
               SUM(v.treatment_cost) AS total_cost
        FROM patients p
        JOIN visits v
            ON p.patient_id = v.patient_id
        GROUP BY p.patient_name
    ) AS x
) AS y
WHERE total_cost > avg_cost;

-- extra 4)Find the department that generated the highest total revenue.
select department,sum(treatment_cost) as total_revenue
from visits
group by department
order by total_revenue desc limit 1;

-- extra 5: Find all patients who never visited Cardiology.
select p.patient_id , v.visit_id
from patients p left join visits v
on p.patient_id=v.patient_id
and v.department='Cardiology'
where v.department is null;

-- extra 6:Find the doctor who has treated the highest number of distinct patients.
select v.doctor_name,count(distinct p.patient_id ) as patients_treated
from patients p  join visits v
on p.patient_id=v.patient_id
group by v.doctor_name
order by patients_treated desc
limit 1;