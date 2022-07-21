-- Multi JOIN
-- connect info FROM film, film_actor, and actor tables
SELECT first_name, last_name, title
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film.film_id = film_actor.film_id
WHERE first_name = 'Nick'
ORDER BY title;

-- Sub Query
-- You can make sub queries in the SELECT, FROM and WHERE statements

SELECT headers_you _want_to _see
FROM table_you_want-to_pull_from
WHERE condition_goes_here

-- WHERE CLAUSE IS MOST COMMON
-- TWO basic queries into 1
-- query 1: find customer_id that has more than $175 SAVEPOINT
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount)>175
ORDER BY SUM(amount) DESC
LIMIT 10;
-- query 2: get customer_info (name, address..)
SELECT * from customer;

-- FINALLY, lets put these 2 together
SELECT * 
FROM customer
WHERE customer_id IN (
    SELECT customer_id, SUM(amount)
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount)>175
    ORDER BY SUM(amount) DESC
    LIMIT 10
);

-- ANOTHER WHERE CLAUSE SUB QUERY (adding joins)
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT film_actor.actor_id
    FROM actor
    INNER JOIN film_actor
    ON actor.actor_id = film_actor.actor_id
    INNER JOIN film
    ON film.film_id = film_actor.film_id
    WHERE title = 'Mulan Moon'
);

--2nd most common is FROM
SELECT first_name, last_name
FROM (
    SELECT first_name, last_name, title
    FROM actor
    INNER JOIN film_actor
    ON film.actor.actor_id = actor.actor_id
    INNER JOIN film
    ON film_actor.film_id = film.film_id
) AS actors_and_movie_titles
WHERE title = 'Mulan Moon';

-- SELECT STATEMENT -- VERY UNCOMMON
SELECT  first_name, last_name, (
    SELECT count(rental_id)
    FROM rental
)
FROM customer;

-- Stored Procedures
-- simulate a late fee charge
SELECT * FROM payment;
--
CREATE PROCEDURE latefee__dara (
    customer integer,
    lateFeeAmount NUMERIC (5,2)
)
LANGUAGE plpgsql
AS
$$
BEGIN
    -- add late fee to customer
    UPDATE payment
    SET amount = amount + lateFeeAmount
    WHERE customer_id = customer;
       -- commit the above statement inside of a TRANSACTION
    COMMIT;

END
$$

-- CALL STORED PROCEDURE
CALL latefee_dara(341, -.01)

SELECT * FROM payment WHERE customer_id=341;


-- Stored FUNCTIONS
CREATE OR REPLACE FUNCTION add_an_actor(
    actor INTEGER,
    f_name VARCHAR(45),
    l_name VARCHAR(45),
    updated TIMESTAMP WITHOUT TIME ZONE
)

RETURNS VOID
LANGUAGE plpgsql
AS
$MAIN$
BEGIN
-- insert into the actor TABLE
    INSERT INTO  actor(actor_id, first_name, last_name, last_update)
    VALUES (actor, f_name, l_name, updated);

END
$MAIN$

SELECT * FROM actor ORDER BY actor_id DESC LIMIT 10;

-- unfortunately, calling a function is different from calling a PROCEDURE
-- do not sue the keyword CALL
-- instead use SELECT
SELECT add_an_actor(699, 'Chris', 'Bail', NOW()::TIMESTAMP)