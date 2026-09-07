CREATE DATABASE WINDOW_FUNCTION_INTERVIEW_REVISION;

USE WINDOW_FUNCTION_INTERVIEW_REVISION;

DROP TABLE IF EXISTS employees_wf;

CREATE TABLE employees_wf (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT,
    joining_date DATE
);


INSERT INTO employees_wf
(emp_id, emp_name, dept_name, salary, joining_date)
VALUES

(101, 'Mohan',    'Admin',   4000, '2024-01-10'),
(102, 'Sneha',    'Admin',   4500, '2024-02-15'),
(103, 'Neha',     'Admin',   4200, '2024-03-20'),
(104, 'Meera',    'Admin',   4200, '2024-04-10'),
(105, 'Deepak',   'Admin',   3800, '2024-05-05'),

(106, 'Rajkumar', 'HR',      3000, '2024-01-12'),
(107, 'Rohit',    'HR',      3000, '2024-02-18'),
(108, 'Preet',    'HR',      7000, '2024-03-01'),
(109, 'Arjun',    'HR',      5000, '2024-04-21'),
(110, 'Vijay',    'HR',      5000, '2024-05-30'),

(111, 'Akbar',    'IT',      4000, '2024-01-05'),
(112, 'Vikram',   'IT',      6000, '2024-02-14'),
(113, 'Kiran',    'IT',      6000, '2024-03-11'),
(114, 'Ravi',     'IT',      5000, '2024-04-16'),
(115, 'Pooja',    'IT',      4500, '2024-05-12'),

(116, 'Dorvin',   'Finance', 6500, '2024-01-07'),
(117, 'Rajesh',   'Finance', 5000, '2024-02-11'),
(118, 'Priya',    'Finance', 6200, '2024-03-17'),
(119, 'Hari',     'Finance', 6200, '2024-04-19'),
(120, 'Shalini',  'Finance', 5800, '2024-05-25');



SELECT *
FROM employees_wf
ORDER BY dept_name, salary DESC;


DROP TABLE IF EXISTS sales_wf;

CREATE TABLE sales_wf (
    order_id INT,
    customer_id INT,
    customer_name VARCHAR(50),
    region VARCHAR(30),
    category VARCHAR(30),
    product VARCHAR(50),
    order_date DATE,
    sales_amount DECIMAL(10,2)
);


INSERT INTO sales_wf
(order_id, customer_id, customer_name, region,
 category, product, order_date, sales_amount)
VALUES

(1001, 201, 'Amit',   'West',  'Electronics', 'Laptop',     '2026-01-03', 55000),
(1002, 202, 'Neha',   'North', 'Electronics', 'Mobile',     '2026-01-05', 25000),
(1003, 201, 'Amit',   'West',  'Furniture',   'Chair',      '2026-01-10',  6000),
(1004, 203, 'Rahul',  'South', 'Electronics', 'Laptop',     '2026-01-12', 60000),
(1005, 204, 'Priya',  'West',  'Furniture',   'Table',      '2026-01-15', 12000),

(1006, 202, 'Neha',   'North', 'Furniture',   'Chair',      '2026-01-20',  7000),
(1007, 205, 'Karan',  'South', 'Electronics', 'Mobile',     '2026-01-25', 30000),
(1008, 206, 'Sneha',  'East',  'Electronics', 'Tablet',     '2026-01-28', 22000),

(1009, 201, 'Amit',   'West',  'Electronics', 'Mobile',     '2026-02-03', 28000),
(1010, 203, 'Rahul',  'South', 'Furniture',   'Table',      '2026-02-05', 15000),
(1011, 204, 'Priya',  'West',  'Electronics', 'Laptop',     '2026-02-10', 58000),
(1012, 205, 'Karan',  'South', 'Furniture',   'Chair',      '2026-02-12',  6500),

(1013, 202, 'Neha',   'North', 'Electronics', 'Laptop',     '2026-02-18', 62000),
(1014, 206, 'Sneha',  'East',  'Furniture',   'Table',      '2026-02-20', 14000),
(1015, 206, 'Sneha',  'East',  'Furniture',   'Table',      '2026-02-20', 14000),

(1016, 201, 'Amit',   'West',  'Electronics', 'Tablet',     '2026-03-02', 24000),
(1017, 203, 'Rahul',  'South', 'Electronics', 'Mobile',     '2026-03-05', 27000),
(1018, 204, 'Priya',  'West',  'Furniture',   'Chair',      '2026-03-08',  7500),
(1019, 205, 'Karan',  'South', 'Electronics', 'Laptop',     '2026-03-11', 61000),
(1020, 202, 'Neha',   'North', 'Electronics', 'Mobile',     '2026-03-15', 26000),

(1021, 206, 'Sneha',  'East',  'Electronics', 'Laptop',     '2026-03-18', 59000),
(1022, 201, 'Amit',   'West',  'Furniture',   'Table',      '2026-03-20', 13000),
(1023, 203, 'Rahul',  'South', 'Furniture',   'Chair',      '2026-03-22',  8000),
(1024, 204, 'Priya',  'West',  'Electronics', 'Mobile',     '2026-03-25', 29000);


SELECT *
FROM sales_wf
ORDER BY order_date;


-- 1)Assign a row number to every employee based on salary from highest to lowest.
SELECT *,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS rn FROM employees_wf;

-- 2)Assign a row number to employees within each department, with the highest salary getting row number 1 in each department.
SELECT *,
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rn 
FROM employees_wf;

-- 3) Rank all employees based on salary.
SELECT *,
RANK() OVER(ORDER BY salary DESC) AS rnk
FROM employees_wf;

-- 4) Rank employees department-wise based on salary.
SELECT *,
RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk
FROM employees_wf;

-- 5)Use DENSE_RANK() to rank salaries within each department.
SELECT *,
DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS drnk
FROM employees_wf;

-- 6)Display the previous employee’s salary within each department using LAG().
SELECT *,
LAG(salary) OVER (partition by dept_name order by emp_id) as prev_emp_salary
FROM employees_wf;

-- 7)Display the next employee's salary within each department using LEAD().
SELECT *,
LEAD(salary) OVER (partition by dept_name order by emp_id) as next_emp_salary
FROM employees_wf;

-- 8)Show whether an employee's salary is higher, lower, or equal to the previous employee's salary.
SELECT *,
       CASE
           WHEN salary > prev_emp_salary THEN 'Higher than previous employee'
           WHEN salary < prev_emp_salary THEN 'Lower than previous employee'
           WHEN salary = prev_emp_salary THEN 'Same as previous employee'
           ELSE 'No previous employee'
       END AS sal_range
FROM (
    SELECT *,
           LAG(salary) OVER (
               PARTITION BY dept_name
               ORDER BY emp_id
           ) AS prev_emp_salary
    FROM employees_wf
) AS x;


-- 9)Find the highest-paid employee in each department.
SELECT emp_name,dept_name,salary
FROM (
SELECT emp_name,dept_name,salary,
rank() over (partition by dept_name order by salary desc) as high_salary
from employees_wf)AS x where high_salary=1;

-- 10)Find the second-highest salary in each department.
SELECT emp_name,dept_name,salary
FROM (
SELECT emp_name,dept_name,salary,
DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS second_high_salary
FROM employees_wf) AS x
WHERE second_high_salary=2;

-- 11)Find the top 3 salaries in each department.
SELECT emp_id,emp_name,dept_name,salary
FROM
(SELECT emp_id,emp_name,dept_name,salary,
dense_rank() over(partition by dept_name order by salary desc) as top_3_sal
from employees_wf) as x
WHERE top_3_sal<=3;

-- 12)Find exactly the top 3 employees in each department based on salary.
SELECT emp_id,emp_name,dept_name,salary
FROM 
(
SELECT emp_id,emp_name,dept_name,salary,
row_number() over (partition by dept_name order by salary desc) as top_3_exact_sal
from employees_wf
)as x
WHERE top_3_exact_sal<=3;

-- 13)Find employees whose salary is greater than the average salary of their own department.

select emp_name,dept_name from
(
select emp_name,dept_name,salary,
avg(salary) over (partition by dept_name) as avg_sal
from employees_wf
) as x
where salary>avg_sal
;

-- 14)Display every employee along with the average salary of their department.
select emp_name,dept_name,
AVG(salary) OVER(partition by dept_name) as avg_sal
FROM employees_wf;

-- 15)Calculate the difference between each employee’s salary and the average salary of their department.
select emp_name,dept_name,salary,avg_sal, (salary-avg_sal) as salary_difference
from 
(
select emp_name,dept_name,salary,
AVG(salary) over(partition by dept_name) AS avg_sal
FROM employees_wf
) as x;

-- 16)Find the lowest-paid employee in each department.
select emp_name,dept_name,salary
from
(
select emp_name,dept_name,salary,
rank() over(partition by dept_name order by salary asc)as low_sal
from employees_wf
)
as x
where low_sal=1;

-- 17)Find the first two employees from each department based on emp_id.
select emp_id,emp_name,dept_name
from 
(
select emp_id,emp_name,dept_name,
row_number() over(partition by dept_name order by emp_id asc) as rn
from employees_wf
)
as x
where rn<=2;

-- 18)Calculate a running total of salaries ordered by emp_id.
select *,
sum(salary) over (order by emp_id) as running_total
from employees_wf;

-- 19)Calculate a department-wise running total of salaries.
select dept_name,salary,
sum(salary) over(partition by dept_name order by emp_id) as dept_running_total
from employees_wf;

-- 20)Compare every employee’s salary with the previous employee’s salary within the same department.
select emp_name,dept_name,salary,prev_salary,
CASE 
when salary>prev_salary then "high salary"
when salary<prev_salary then "low salary"
when salary=prev_salary then "equal salary"
else "no employee found"
END AS salary_comparison
FROM
(
select emp_name,dept_name,salary,
lag(salary) over(partition by dept_name order by emp_id) as prev_salary
from employees_wf
) as x;


-- 21)Calculate the salary difference between the current employee and the previous employee within the same department.
select emp_name,dept_name,salary,prev_salary,
(salary-prev_salary) as salary_difference
from 
(
select emp_name,dept_name,salary,
lag(salary) over(partition by dept_name order by emp_id) as prev_salary
from employees_wf
) as x;
