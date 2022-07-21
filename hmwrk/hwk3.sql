--1. List all customers who live in Texas (use
--JOINs)
SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE: 'Texas';

--2. Get all payments above $6.99 with the Customer's Full
--Name
SELECT first_name, last_name
FROM customer
INNER JOIN PAYMENT
WHERE amount > 6.99
ORDER BY amount ASC;

--3. Show all customers names who have made payments over $175(use
--subqueries)
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount)>175
ORDER BY SUM(amount) DESC;

--4. List all customers that live in Nepal (use the city
--table)
SELECT first_name, last_name, city
FROM city, customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE 'Nepal';

--5. Which staff member had the most
--transactions?
SELECT first_name, last_name, staff_id
FROM payment
WHERE 
GROUP BY staff_id

--6. How many movies of each rating are
--there?


--7.Show all customers who have made a single payment
--above $6.99 (Use Subqueries)
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id

HAVING SUM(amount)>6.99
ORDER BY SUM(amount) DESC;

--8. How many free rentals did our stores give away?
SELECT rental_id, SUM(amount)
FROM payment
GROUP BY rental_id
HAVING SUM(amount) = 0
ORDER BY SUM(amount);