USE employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query.
SELECT emp_no 
FROM employees
WHERE hire_date =
	(SELECT hire_date
     FROM employees
     WHERE emp_no = '101010');
    
-- Find all the titles held by all employees with the first name Aamod.
SELECT title
FROM titles
JOIN employees ON titles.emp_no = employees.emp_no
WHERE first_name IN
	(SELECT first_name
     FROM employees
     WHERE first_name = 'Aamod');

-- How many people in the employees table are no longer working for the company?

SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN
	(SELECT emp_no
	FROM salaries
	WHERE to_date > NOW());


-- Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.emp_no IN
	(SELECT emp_no
     FROM employees
     WHERE gender = 'f' AND dept_manager.to_date > NOW());

-- Find all the employees that currently have a higher than average salary.
SELECT first_name, last_name, salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.to_date > NOW() AND s.salary > 
	(SELECT AVG(salary)
     FROM salaries);

-- How many current salaries are within 1 standard deviation of the highest salary?
SELECT salary 
FROM salaries 
WHERE to_date > NOW() AND salary > 
	(SELECT (dif.top - dif.sd) 
	 FROM (SELECT MAX(salary) AS top, 
			      STDDEV(salary) AS sd
			      FROM salaries) AS dif);


-- BONUS

-- Find all the department names that currently have female managers.
SELECT departments.dept_name
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date > NOW() AND dept_manager.emp_no IN 
	(SELECT employees.emp_no
	 FROM employees
	 WHERE employees.gender = 'f')
ORDER BY departments.dept_name;

-- Find the first and last name of the employee with the highest salary.
SELECT employees.first_name, employees.last_name
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE salaries.salary =
	(SELECT MAX(salaries.salary)
	 FROM salaries);

-- Find the department name that the employee with the highest salary works in.
SELECT departments.dept_name
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.emp_no =
	(SELECT employees.emp_no
	FROM employees
	JOIN salaries ON employees.emp_no = salaries.emp_no
	WHERE salaries.salary =
		(SELECT MAX(salaries.salary)
		FROM salaries));
