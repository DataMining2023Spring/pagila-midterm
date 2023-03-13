/*
 * Write a SQL query SELECT query that:
 * computes the country with the most customers in it. 
 */

SELECT country
FROM country
JOIN city  USING (country_id)
JOIN address USING (city_id)
JOIN customer USING (address_id)
GROUP BY country
ORDER BY COUNT(DISTINCT customer_id) DESC
LIMIT 1;
