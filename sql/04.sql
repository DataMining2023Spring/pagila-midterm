/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query SELECT query that:
 * Lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 * (You may choose to either include or exclude the movie 'AMERICAN CIRCUS' in the results.)
 */

SELECT DISTINCT
    f1.title,
    fa2.film_id,
    count(*)
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
    JOIN film f1 ON fa2.film_id = f1.film_id
    WHERE
        fa1.film_id = 21
        AND f1.film_id != 21
    GROUP BY f1.title, fa2.film_id
    HAVING count(*) > 1
    ORDER BY count(*) DESC;
