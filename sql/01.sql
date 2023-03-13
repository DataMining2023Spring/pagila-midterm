/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

WITH
    no_title AS (
    SELECT film_id
    FROM film
    WHERE title ILIKE '%f%'
    ),

    no_actor AS (
        SELECT film_id
        FROM actor
        JOIN film_actor USING (actor_id)
        WHERE first_name || ' ' || last_name ILIKE '%f%'
    ),

    no_customer AS (
        SELECT
            film_id
        FROM customer
        JOIN rental USING (customer_id)
        JOIN inventory USING (inventory_id)
        WHERE first_name || ' ' || last_name ILIKE '%f%'
    ),
    
    no_address AS (
        SELECT
            film_id
        FROM country
        JOIN city USING (country_id)
        JOIN address USING (city_id)
        JOIN customer USING (address_id)
        JOIN rental USING (customer_id)
        JOIN inventory USING (inventory_id)
        WHERE country ILIKE '%f%'
            OR city ILIKE '%f%'
            OR address ILIKE '%f%'
            OR address2 ILIKE '%f%'
        )


SELECT title
FROM film
WHERE film_id NOT IN (SELECT * FROM no_title)
    AND film_id NOT IN (SELECT * FROM no_actor)
    AND film_id NOT IN (SELECT * FROM no_customer)
    AND film_id NOT IN (SELECT * FROM no_address);
