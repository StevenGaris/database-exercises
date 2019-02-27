USE ada_668;

-- #1
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

SELECT * FROM employees_with_departments;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;


-- #2
-- Create temp table
CREATE TEMPORARY TABLE payment_cents AS
SELECT amount
FROM sakila.payment;

-- Add cents column
ALTER TABLE payment_cents ADD amount_in_cents INT UNSIGNED;

-- convert to cents
UPDATE payment_cents
SET amount_in_cents = amount * 100;

-- drop dollar
ALTER TABLE payment_cents DROP COLUMN  amount;

-- Show end
SELECT * FROM payment_cents;

-- #3
USE employees;

SELECT AVG(salary), STDDEV(salary)
FROM salaries;

CREATE TEMPORARY TABLE z_tab AS
SELECT AVG(salary) AS med, STDDEV(salary) AS sd
FROM employees.salaries
WHERE to_date > NOW();

SELECT departments.dept_name, 










