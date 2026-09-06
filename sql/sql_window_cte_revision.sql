CREATE DATABASE WINDOW_FUNCTION_REVISION;

USE WINDOW_FUNCTION_REVISION;

CREATE TABLE employees (
    emp_id INTEGER,
    emp_name CHARACTER VARYING(50),
    dept_name CHARACTER VARYING(50),
    salary INTEGER
);

INSERT INTO employees (emp_id, emp_name, dept_name, salary) VALUES
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh', 'Finance', 5000),
(107, 'Preet', 'HR', 7000);

INSERT INTO employees (emp_id, emp_name, dept_name, salary) VALUES
(108, 'Sneha', 'Admin', 4500),
(109, 'Vikram', 'IT', 4800),
(110, 'Priya', 'Finance', 6200),
(111, 'Arjun', 'HR', 3200),
(112, 'Kiran', 'IT', 4600),
(113, 'Neha', 'Admin', 4100),
(114, 'Suresh', 'Finance', 5800),
(115, 'Anita', 'HR', 3400),
(116, 'Ravi', 'IT', 5000),
(117, 'Meera', 'Admin', 4300),
(118, 'Hari', 'Finance', 5900),
(119, 'Sunil', 'HR', 3600),
(120, 'Lakshmi', 'IT', 4700),
(121, 'Deepak', 'Admin', 4200),
(122, 'Shalini', 'Finance', 6300),
(123, 'Vijay', 'HR', 3800),
(124, 'Pooja', 'IT', 4900);

UPDATE employees
SET salary = 4100
WHERE emp_id = 113;

UPDATE employees
SET salary = 4200
WHERE emp_id = 117;

UPDATE employees
SET salary = 6300
WHERE emp_id = 118;

UPDATE employees
SET salary = 5000
WHERE emp_id = 124;

SELECT 
    *
FROM
    employees;

SELECT 
    MAX(SALARY) AS MAX_SALARY
FROM
    employees;

SELECT 
    dept_name, MAX(SALARY) AS MAX_SALARY
FROM
    employees
GROUP BY dept_name;

-- WINDOW FUNCTIONS: A window function performs a calculation across a set of related rows 
-- while keeping every individual row in the result.

-- OVER() means It converts an aggregate calculation into a window calculation.

-- 1)Using aggregate functions as WINDOW FUNCTIONS(max,min,average,sum etc)
select e.* ,max(salary) over(partition by dept_name) as max_salary from employees e;

SELECT *,MIN(salary) OVER(PARTITION BY dept_name) AS MIN_SALARY FROM employees;


SELECT *,
       AVG(salary) OVER(PARTITION BY dept_name) AS avg_salary
FROM employees;


SELECT *,
       SUM(salary) OVER(PARTITION BY dept_name) AS total_salary
FROM employees;


SELECT *,
       COUNT(*) OVER(PARTITION BY dept_name) AS emp_count
FROM employees;



SELECT *,
       MAX(salary) OVER(PARTITION BY dept_name) AS max_salary,
       MIN(salary) OVER(PARTITION BY dept_name) AS min_salary,
       AVG(salary) OVER(PARTITION BY dept_name) AS avg_salary,
       SUM(salary) OVER(PARTITION BY dept_name) AS total_salary,
       COUNT(*) OVER(PARTITION BY dept_name) AS emp_count
FROM employees;



-- continue from 6:00

-- ROW_NUMBER(): It is a window function that assigns a unique sequential number 
-- to each row based on the order specified inside the OVER() clause.
-- Even if two rows have the same value, ROW_NUMBER() still gives them different numbers.




SELECT *,ROW_NUMBER() OVER()as rn FROM employees;

SELECT *,ROW_NUMBER() OVER(PARTITION BY dept_name) AS rn FROM employees;

-- Fetch the first 2 employees who joined the company in each department (look for lower emp_id)
SELECT * FROM (
SELECT *,ROW_NUMBER() OVER(partition by dept_name ORDER BY emp_id) AS rn FROM employees) AS X
WHERE X.rn<=2;



-- RANK() : A window function that assigns ranks to rows based on a specified order.
--  Rows with equal values receive the same rank, and the subsequent rank is skipped. 
-- With PARTITION BY, ranking restarts for each group.



-- fetch the top 3 employees in each department earning the max salary
SELECT * FROM 
(SELECT *,RANK() OVER(partition by dept_name order by salary DESC) AS rnk FROM employees) AS X
WHERE x.rnk IN (1,2,3);


-- DENSE_RANK():A SQL window function that assigns ranks to rows based on the order specified inside the OVER() clause.
-- If two or more rows have the same value, they receive the same rank. 
-- Unlike RANK(), DENSE_RANK() does not skip the next rank after a tie.


-- fetch the top 3 employees in each department earning the max salary
SELECT * FROM (SELECT *,DENSE_RANK() OVER(partition by dept_name order by salary desc) AS drnk 
FROM employees) AS x
WHERE x.drnk IN (1,2,3);


-- DIFFEERENCE between ROW_NUMBER,RANK(),DENSE_RANK()

SELECT *,
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY SALARY DESC) AS rn,
RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk,
DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS drnk
FROM employees;

-- LAG(): It is a SQL window function that is used to access the value of a previous row from the current row, 
-- without using a self join.
-- It works based on the order defined inside the OVER() clause.




-- fetch a query to display if the salary of an employee is higher,lower or equal to the pervious employee
SELECT *,
LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary
FROM employees;

-- fetch a query to display if the salary of an employee is higher,lower or equal to the pervious 2nd employee
SELECT *,
LAG(salary,2,0) OVER(PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary_2
FROM employees ; -- here (salary,2,0) will look for record 2 steps back and it not found will return 0


-- LEAD():


-- fetch a query to display if the salary of an employee is higher,lower or equal to the next employee
SELECT *,
LEAD(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS next_emp_salary
FROM employees;

-- Fetch a query to display if the salary of an employee is higher,lower or equal to the next 2nd employee
SELECT *,
LEAD(salary,2,0) OVER (PARTITION BY dept_name ORDER BY emp_id) AS next_emp_salary_2
FROM employees;


-- FINAL ANSWER TO BOTH LEAD() AND LAG() QUESTIONS RELATED TO HIGH,LOW OR EQUAL SALARY
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
    FROM employees
) AS x;