USE world;

-- What languages are spoken in Santa Monica?
SELECT  cl.Language, cl.Percentage
FROM city ct
JOIN countrylanguage cl ON ct.CountryCode = cl.CountryCode
JOIN country cu ON cl.CountryCode = cu.code
WHERE ct.Name = 'Santa Monica'
ORDER BY cl.Percentage;

-- How many different countries are in each region?
SELECT country.Region, COUNT(country.Region) AS 'num_countries'
FROM country
GROUP BY country.Region
ORDER BY COUNT(country.Region);

-- What is the population for each region?
SELECT Region, SUM(Population) AS population
FROM country 
GROUP BY Region 
ORDER BY SUM(Population) DESC;

-- What is the population for each continent?
SELECT Continent, SUM(Population) AS population 
FROM country 
GROUP BY Continent 
ORDER BY SUM(Population) DESC; 

-- What is the average life expectancy globally?
SELECT AVG(LifeExpectancy)
FROM country;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
-- By Continent
SELECT Continent, AVG(LifeExpectancy) AS 'life_expectancy'
FROM country
GROUP BY Continent
ORDER BY AVG(LifeExpectancy);

-- By Region
SELECT Region, AVG(LifeExpectancy) AS 'life_expectancy'
FROM country
GROUP BY Region
ORDER BY AVG(LifeExpectancy);

-- Bonus
-- Find all the countries whose local name is different from the official name
SELECT Name, LocalName
FROM country
WHERE Name != LocalName;  

-- How many countries have a life expectancy less than x?
SELECT COUNT(Name)
FROM country
WHERE LifeExpectancy <
	(SELECT LifeExpectancy 
	FROM country
	WHERE Code = 'USA');
    
-- What state is city x located in?
Select District 
FROM city
WHERE Name = 'san antonio';

-- What region of the world is city x located in?
SELECT Region
FROM country
JOIN city ON country.Code = city.CountryCode
WHERE city.Name = 'San Antonio';

-- What country (use the human readable name) city x located in?
SELECT country.Name
FROM country
JOIN city ON country.Code = city.CountryCode
WHERE city.Name = 'San Antonio';

-- What is the life expectancy in city x?
SELECT country.LifeExpectancy
FROM country 
JOIN city ON country.Code = city.CountryCode
WHERE city.Name = 'San Antonio';

-- Sakila
USE sakila;

-- Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), LOWER(last_name) 
FROM actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'Joe';

-- Find all actors whose last name contain the letters "gen":
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%gen%';

-- Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

-- Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country 
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON staff.address_id = address.address_id;

-- Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT SUM(payment.amount), staff.first_name
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
WHERE payment_date BETWEEN '2005-08-01' AND '2005-09-01'
GROUP BY staff.first_name;

-- List each film and the number of actors who are listed for that film.
SELECT film.title, COUNT(film_actor.actor_id)
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(inventory.film_id)
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible';

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT film.title
FROM film
JOIN language ON film.language_id = language.language_id
WHERE film.title LIKE 'k%' OR film.title LIKE 'q%' =
	(SELECT language.language_id 
 	FROM language 
 	WHERE language.name = 'english');

-- Use subqueries to display all actors who appear in the film Alone Trip.

SELECT actor. first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title =
	(SELECT film.title
	FROM film
	WHERE film.title = 'Alone Trip');

-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'canada';

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.

SELECT film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'family';

-- Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, SUM(payment.amount)
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
JOIN  store ON staff.store_id = store.store_id
GROUP BY store.store_id;

-- Write a query to display for each store its store ID, city, and country.

SELECT store.store_id, city.city, country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT category.name, SUM(payment.amount)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;





-- SELECT statements

-- Select all columns from the actor table.
SELECT * FROM actor;

-- Select only the last_name column from the actor table.
SELECT last_name FROM actor;

-- Select only the following columns from the film table.

-- DISTINCT operator

-- Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name FROM actor;

-- Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code FROM address;

-- Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating FROM film;

-- WHERE clause

-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT title, description, rating, length
FROM film
WHERE length > 180;

-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27';

-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date LIKE '05/27/2005';


-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.


-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".


-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.


-- Select all columns minus the password column from the staff table for rows that contain a password.


-- Select all columns minus the password column from the staff table for rows that do not contain a password.



