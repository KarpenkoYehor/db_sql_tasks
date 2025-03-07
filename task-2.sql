SELECT customer.first_name, customer.last_name, film.title, lower(rental.rental_date) AS rental_start_date
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.first_name = 'PATRICIA' AND customer.last_name = 'JOHNSON';


SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;


INSERT INTO city (city, country_id, last_update)
VALUES ('San Francisco', (SELECT country_id FROM country WHERE country = 'United States'), NOW());

INSERT INTO address (address, address2, district, city_id, postal_code, phone, last_update)
VALUES ('123 Main St', '', 'District 1', (SELECT city_id FROM city WHERE city = 'San Francisco'), '1234', '345-232', NOW());

INSERT INTO customer (store_id, first_name, last_name, email, address_id, activebool, create_date, last_update)
VALUES (1, 'ALICE', 'COOPER', 'email@mail', (SELECT address_id FROM address WHERE address = '123 Main St' LIMIT 1), TRUE, NOW(), NOW());


UPDATE address
SET address = '456 Elm St', last_update = NOW()
WHERE address_id = (
    SELECT address_id
    FROM address
    WHERE address = '123 Main St'
      AND city_id = (SELECT city_id FROM city WHERE city = 'San Francisco')
      AND address_id IN (
          SELECT address_id
          FROM customer
          WHERE first_name = 'ALICE' AND last_name = 'COOPER'
      )
);


DELETE FROM public.customer
WHERE first_name = 'ALICE' AND last_name = 'COOPER';


