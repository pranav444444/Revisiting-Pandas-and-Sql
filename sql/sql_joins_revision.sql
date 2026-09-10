create database join_revision;
use join_revision;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);


INSERT INTO customers VALUES
(101, 'Rahul', 'Delhi', 'rahul@gmail.com', '9000011111'),
(102, 'Priya', 'Mumbai', 'priya@gmail.com', '9000022222'),
(103, 'Amit', 'Pune', 'amit@gmail.com', '9000033333'),
(104, 'Sneha', 'Chennai', 'sneha@gmail.com', '9000044444'),
(105, 'Karan', 'Delhi', 'karan@gmail.com', '9000055555'),
(106, 'Neha', 'Kolkata', 'neha@gmail.com', '9000066666'),
(107, 'Vikas', 'Hyderabad', 'vikas@gmail.com', '9000077777'),
(108, 'Anjali', 'Bangalore', 'anjali@gmail.com', '9000088888'),
(109, 'Rohit', 'Delhi', 'rohit@gmail.com', '9000099999'),
(110, 'Meera', 'Pune', 'meera@gmail.com', '9000012121');






CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product VARCHAR(50),
    quantity INT,
    sales DECIMAL(10,2)
);


INSERT INTO orders VALUES
(5001, 101, '2025-01-01', 'Laptop', 1, 55000),
(5002, 102, '2025-01-02', 'Mouse', 2, 1000),
(5003, 101, '2025-01-05', 'Keyboard', 1, 1500),
(5004, 103, '2025-01-07', 'Monitor', 1, 12000),
(5005, 103, '2025-01-10', 'Tablet', 1, 20000),
(5006, 104, '2025-01-11', 'Mobile', 1, 18000),
(5007, 105, '2025-01-12', 'Charger', 2, 800),
(5008, 106, '2025-01-15', 'Headphones', 1, 2500),
(5009, 106, '2025-01-18', 'Camera', 1, 45000),
(5010, 107, '2025-01-20', 'Printer', 1, 9000),
(5011, 108, '2025-01-21', 'Desk', 1, 7000),
(5012, 108, '2025-01-22', 'Fan', 1, 2000), 
(5013, 111, '2025-01-25', 'SSD', 1, 5000),
(5014, 112, '2025-01-27', 'RAM', 2, 6000);

-- INNER JOIN
select *
from customers c INNER JOIN orders o
on c.customer_id=o.customer_id;

select c.customer_name,c.city,o.product,o.quantity,o.sales
from customers c INNER JOIN orders o
on c.customer_id=o.customer_id;

select c.customer_name,c.city,o.product,o.quantity,o.sales
from customers c INNER JOIN orders o
on c.customer_id=o.customer_id
where c.city='Delhi';

select c.customer_name,c.city,o.product,o.quantity,o.sales
from customers c INNER JOIN orders o
on c.customer_id=o.customer_id
where c.city='Delhi'
order by sales desc;


select c.customer_name,c.city,o.product,o.quantity,o.sales
from customers c INNER JOIN orders o
on c.customer_id=o.customer_id
where c.city='Delhi'
order by sales desc
limit 1;select c.customer_name,c.city,o.product,o.quantity,o.sales
from customers c INNER JOIN orders o
on c.customer_id=o.customer_id
where c.city='Delhi'
order by sales desc
limit 1;


-- LEFT JOIN / LEFT OUTER JOIN
SELECT *
from customers c LEFT JOIN orders o
on c.customer_id=o.customer_id;


SELECT *
from orders o LEFT JOIN customers c
on c.customer_id=o.customer_id;


-- RIGHT JOIN/RIGHT OUTER JOIN 
-- 45:00


