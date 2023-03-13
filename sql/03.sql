/*
 * Write a SQL query SELECT query that:
 * List the first and last names of all actors who have appeared in movies in the "Children" category,
 * but that have never appeared in movies in the "Horror" category.
 */

WITH 
    c_actors AS (
        SELECT actor_id
        FROM film_actor
        WHERE film_id IN (
            SELECT film_id
            FROM film
            JOIN film_category USING (film_id)
            JOIN category USING (category_id)
            WHERE name ILIKE 'children')
    ),

    h_actors AS (
        SELECT actor_id
        FROM film_actor
        WHERE film_id IN (
            SELECT film_id
            FROM film
            JOIN film_category USING (film_id)
            JOIN category USING (category_id)
            WHERE name ILIKE 'horror')
    )

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT * FROM c_actors)
AND actor_id NOT IN (SELECT * FROM h_actors)
ORDER BY last_name, first_name;
