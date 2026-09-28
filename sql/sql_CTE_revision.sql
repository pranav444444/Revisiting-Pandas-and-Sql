CREATE DATABASE cte_practice;

USE cte_practice;

CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INTEGER
);


INSERT INTO employees (emp_id, emp_name, salary)
VALUES
(101, 'Mohan', 40000),
(102, 'James', 50000),
(103, 'Robin', 60000),
(104, 'Carol', 70000),
(105, 'Alice', 80000),
(106, 'Jimmy', 90000);

select * from employees;


-- QUERY-1 
-- fetch employees who earn more than the average salary of all employees
-- select emp_name from employees where salary>(select avg(salary) from employees);

-- WITH clause creates a temporary table and it remains valid until the query execution ';' ends
-- WITH 'alias_TEMPORARY_table_name' ('alias_column_name_OPTIONAL')AS ('query')
WITH avg_salary (avg_sal) AS
(
	SELECT AVG(salary) FROM employees
)
SELECT emp_name FROM employees,avg_salary WHERE salary>avg_sal;


WITH avg_salary AS
(
	SELECT ROUND(AVG(salary),0) as avg_sal FROM employees
)
SELECT * FROM employees,avg_salary WHERE salary>avg_sal;



-- QUERY-2


CREATE TABLE stores (
    store_id INTEGER,
    store_name VARCHAR(50),
    product VARCHAR(50),
    quantity INTEGER,
    cost INTEGER
);


INSERT INTO stores (store_id, store_name, product, quantity, cost)
VALUES
(1, 'Apple Originals 1', 'iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1', 'MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1', 'AirPods Pro', 2, 280),
(2, 'Apple Originals 2', 'iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3', 'iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3', 'MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3', 'MacBook Air', 4, 1100),
(3, 'Apple Originals 3', 'iPhone 12', 2, 1000),
(3, 'Apple Originals 3', 'AirPods Pro', 3, 280),
(4, 'Apple Originals 4', 'iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4', 'MacBook pro 13', 1, 2500);

SELECT *
FROM stores;

-- Find stores who's sales were better than the average sales across all stores

select store_id,sum(cost) as total_sales_per_store
from stores
group by store_id;

select avg(total_sales_per_store) as avg_sales
from
(
	select store_id,sum(cost) as total_sales_per_store
	from stores
	group by store_id
) as x;


-- finally
WITH 
Total_sales(store_id,total_sales_per_store)
AS
(
	select store_id,sum(cost) as total_sales_per_store
	from stores
	group by store_id
),
Avg_sales(avg_sales_of_all_stores) AS
(
	select avg(total_sales_per_store) from Total_sales
)

SELECT * FROM Total_sales,Avg_sales
WHERE total_sales_per_store>avg_sales_of_all_stores;


-- ADVANATGES OF USING WITH clause

-- 1)makes code easier and readable
-- 2)breakes down multiple queries into pieces
-- 3)helps in performance optimization and improvement

-- WITH clause creates a temporary table or a temporary names result set (CTE) which remains valid until the query execution ends

-- generally used when we need to write multiple sub queries (queries within queries) and recurssive queries