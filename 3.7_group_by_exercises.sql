USE employees;
DESCRIBE titles;

SELECT DISTINCT title FROM titles;

SELECT DISTINCT last_name, first_name FROM employees
	WHERE last_name LIKE 'e%' AND
          last_name LIKE '%e'
	GROUP BY last_name, first_name;
    
-- Which (across all employees) name is the most common, the least common? Find this for both first name, last name, and the combination of the two.

SELECT DISTINCT last_name, COUNT(last_name) FROM employees 
	GROUP BY last_name 
    ORDER BY COUNT(last_name);
-- Least common last name - Sadowsky
-- Most common last name - Baba
SELECT DISTINCT first_name, COUNT(first_name) FROM employees 
	GROUP BY first_name 
	ORDER BY COUNT(first_name);
-- Least common first name - Lech and Renny
-- Most common first name - Shahab

SELECT CONCAT(first_name, ' ', last_name), COUNT(CONCAT(first_name, ' ', last_name)) FROM employees 
	GROUP BY CONCAT(first_name, ' ', last_name) 
    ORDER BY COUNT(CONCAT(first_name, ' ', last_name));
-- Most unique name tie between Laurentiu Cesareni and Rosalyn Baalen

SELECT DISTINCT last_name, COUNT(first_name) FROM employees
	WHERE last_name LIKE '%q%' AND
		  last_name NOT LIKE '%qu%'
	GROUP BY last_name;
          
SELECT COUNT(*), gender FROM employees 
	WHERE (first_name = 'Irena' OR 
		   first_name = 'Vidya' OR 
           first_name = 'Maya')
    GROUP BY gender;       
    
  SELECT DISTINCT LOWER(CONCAT(LEFT(first_name, 1), 
					LEFT(last_name, 4),
					'_',
					SUBSTRING(birth_date, 6,2),
					SUBSTRING(birth_date, 3, 2))) AS Username 
	FROM employees;
    
    -- 14,152 duplicate usernames = 300024 (undistinct usernames) - 285872 (distinct usernames)
       
    