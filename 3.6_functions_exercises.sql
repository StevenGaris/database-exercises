USE employees;
SHOW TABLES;
DESCRIBE employees;

SELECT * FROM employees 
	WHERE (first_name = 'Irena' OR 
		   first_name = 'Vidya' OR 
           first_name = 'Maya') AND
		   gender = 'm'
	ORDER BY last_name, first_name;
           
SELECT UPPER(CONCAT(first_name , ' ', last_name)) AS 'Full_Name' FROM employees
	WHERE last_name LIKE 'e%' AND
          last_name LIKE '%e'
          ORDER BY emp_no DESC;
          
SELECT first_name, last_name, hire_date,
	   DATEDIFF(CURDATE(), hire_date) AS days_from_hire FROM employees
	WHERE hire_date LIKE '199%' AND
          birth_date LIKE '%-12-25'
          ORDER BY birth_date, hire_date DESC;
          
SELECT * FROM employees
	WHERE last_name LIKE '%q%' AND
		  last_name NOT LIKE '%qu%';
          
SELECT MIN(salary), MAX(salary) FROM salaries;     

SELECT LOWER(CONCAT(LEFT(first_name, 1), 
					LEFT(last_name, 4),
					'_',
					SUBSTRING(birth_date, 6,2),
					SUBSTRING(birth_date, 3, 2))) AS Username,
	   first_name, last_name, birth_date FROM employees
       limit 10; 