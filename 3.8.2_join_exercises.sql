USE employees;
SHOW TABLES;
DESCRIBE dept_emp;
SELECT * FROM employees;


SELECT 
    departments.dept_name AS 'Department Name',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Department Manager'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE to_date > CURDATE() AND gender = 'f'
ORDER BY departments.dept_name;


SELECT titles.title AS 'Title', COUNT(titles.title) AS 'Count'
FROM departments  
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN titles ON dept_emp.emp_no = titles.emp_no
WHERE titles.to_date > CURDATE() AND dept_emp.to_date > CURDATE()
AND departments.dept_name = 'customer service'
GROUP BY titles.title;

SELECT 
    departments.dept_name AS 'Department Name',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Department Manager',
            salaries.salary AS 'Salary'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
ORDER BY departments.dept_name;

SELECT departments.dept_no, departments.dept_name, COUNT(employees.emp_no)
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_no, departments.dept_name;

SELECT departments.dept_name, AVG(salaries.salary)
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date > CURDATE()  AND salaries.to_date > CURDATE()
GROUP BY departments.dept_name DESC
LIMIT 1;

SELECT employees.first_name, employees.last_name
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE dept_emp.to_date > CURDATE()  AND 
	  salaries.to_date > CURDATE() AND 
      departments.dept_name = 'marketing'
ORDER BY salaries.salary DESC
LIMIT 1;

SELECT employees.first_name, employees.last_name, salaries.salary, departments.dept_name
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE salaries.to_date > CURDATE() AND
	  dept_manager.to_date > CURDATE()
ORDER BY salaries.salary DESC
LIMIT 1;

SELECT CONCAT(employees.first_name, ' ', employees.last_name),
	   departments.dept_name, 
	   CONCAT(employees.first_name, ' ', employees.last_name)
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments d1 ON dept_emp.dept_no = d1.dept_no
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments d2 ON dept_manager.dept_no = d2.dept_no
WHERE dept_emp.to_date > CURDATE() AND dept_manager.to_date > CURDATE();
      
      
SELECT 
	CONCAT(e1.first_name, ' ', e1.last_name) AS 'Employee Name',
    d.dept_name AS 'Department Name',
    CONCAT(e2.first_name, ' ', e2.last_name) AS 'Manager Name'
FROM employees e1
JOIN dept_emp de ON e1.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN dept_manager dm On d.dept_no = dm.dept_no
JOIN employees e2 ON dm.emp_no = e2.emp_no
WHERE de.to_date > NOW() AND dm.to_date > NOW()
LIMIT 100;





