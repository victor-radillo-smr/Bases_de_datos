use sakila;

select*from film;
select*from category;
select*from film_category;
select*from actor;
select*from film_actor;

-- 0) saca el nombre de los actores que salieron en "AGENT TRUMAN"

SELECT 
    CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM
    film
        JOIN
    film_actor USING (film_id)
        JOIN
    actor USING (actor_id)
WHERE
    title LIKE 'AGENT TRUMAN';
    
-- 1)Cinco actores con mas peliculas.

SELECT 
    CONCAT(first_name, ' ', last_name) AS nombre_completo,
    COUNT(film_id) AS numero_de_peliculas
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 5;

-- Para corregir el viernes 16/10:
-- Cuantas peliculas hay por categoria.

SELECT *from category;
SELECT *from film_category;

SELECT 
    category.name, COUNT(film_id)
FROM
    film_category
        JOIN
    category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- ¿cuantas peliculas tienen mas de una categoria?

SELECT 
    film_id, COUNT(category_id)
FROM
    film_category
GROUP BY film_id
HAVING COUNT(category_id) > 1;

-- Obten el top 3 categorias con mas peliculas

SELECT 
    name, category.category_id, COUNT(film_id)
FROM
    film_category
        JOIN
    category ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY COUNT(category.category_id) DESC
LIMIT 3;

-- 

SELECT 
    name,category_id, COUNT(film_id)
FROM
    film_category
        JOIN
    category USING (category_id)
GROUP BY category_id
ORDER BY COUNT(category_id) DESC
LIMIT 3;

--

-- Obten el listado de categorias que tienen mas de 5 peliculas

SELECT 
    name, COUNT(film_id)
FROM
    film_category
        JOIN
    category USING (category_id)
GROUP BY category_id
HAVING COUNT(film_id) > 5
ORDER BY COUNT(category_id) DESC;

-- Obten un listado de categorias que tengan mas de 5 peliculas que empiezan por la letra 'A'

SELECT 
    category_id, name, COUNT(film_id)
FROM
    film
        JOIN
    category USING (category_id)
        JOIN
    film_category USING (film_id)
WHERE
    title LIKE 'A%'
GROUP BY category_id
HAVING COUNT(film_id) > 5;

-- Obten un listado de nombre del actor, pelicula enla que ha trabajado y categoria de esa pelicula.alter

SELECT 
    CONCAT(fist_name, ' ', last_name) AS actor,
    title AS pelicula,
    name AS categoria
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
        JOIN
    category USING (category_id);
    
-- ¿Cuantos actores distintos han trabajado en cada categoria?

SELECT
name AS categoria, COUNT(DISTINCT actor_id) AS numeroActores 
FROM
actor 
JOIN
film_actor  USING (actor_id)
JOIN
film  USING (film_id)
JOIN
film_category  USING (film_id)
JOIN
category  USING (category_id)
GROUP BY name;

-- Nombre de actores que han trabajado en mas de 7 categorias.

SELECT
actor_id, concat(first_name, ' ', last_name) AS Nombre, COUNT(DISTINCT category_id) AS categoriasDistintas
FROM
actor
JOIN
film_actor  USING (actor_id)
JOIN
film  USING (film_id)
JOIN
film_category  USING (film_id)
GROUP BY concat(first_name, ' ', last_name)
HAVING COUNT(DISTINCT category_id) > 7
ORDER BY COUNT(DISTINCT category_id) DESC;

-- Peliculas que tienen mas copias fisicas (inventory_id).

SELECT 
film.title, inventory.film_id, COUNT(DISTINCT inventory.inventory_id) AS cantidadInventario
FROM
film JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title, inventory.film_id 
ORDER BY  COUNT(DISTINCT inventory.inventory_id) DESC LIMIT 10;

-- Víctor me ha dicho que le pregunte sobre esto por qué me da lo mismo.
 SELECT 
 fil.title, fil.film_id,inv.film_id, COUNT(DISTINCT inv.inventory_id) AS cantidadInventario
 FROM
 inventory inv, film fil
 GROUP BY fil.title, inv.film_id 
 ORDER BY  COUNT(DISTINCT inv.inventory_id) DESC LIMIT 10;

-- Actores que empiezan por 'J' y han trabajado en categorias que empiezan por 'A.

--  el DISTINCT  en el select es contar filas distintas 
SELECT DISTINCT
CONCAT(first_name, ' ', last_name) AS nombre, category.name
FROM
actor
JOIN
film_actor  USING (actor_id)
JOIN
film  USING (film_id)
JOIN
film_category  USING (film_id)
JOIN
category  USING (category_id)
WHERE name LIKE 'A%' AND first_name LIKE 'J%'
ORDER BY nombre;

-- mañana
-- 2) País con más clientes

SELECT 
    country, COUNT(DISTINCT customer_id)
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
        JOIN
    country USING (country_id)
GROUP BY country_id
ORDER BY COUNT(DISTINCT customer_id) DESC
LIMIT 1;

-- PARANOIA

SELECT 
    country, COUNT(DISTINCT customer_id)
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    store USING (address_id)
        JOIN
    customer USING (store_id)
GROUP BY country_id
ORDER BY COUNT(DISTINCT customer_id) DESC
LIMIT 1;

-- incorrecta porque...

-- 3) Tres películas con mayores ingresos por alquiler

SELECT 
    title AS titulo, SUM(amount) AS Ingresos_totales
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY title
ORDER BY Ingresos_totales DESC
LIMIT 3;

SELECT 
    title AS titulo, TRUNCATE(AVG(amount), 2) AS Ingresos_medios
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY title
ORDER BY Ingresos_medios DESC
LIMIT 3;


-- 4) Cliente que más ha gastado

-- PARA COMPROBAR ESTE TIPO DE CONSULTAS MUESTRO PRIMERO TODO ORDENADO PAR VER SI HAY 
-- EMPATE Y SI HAY EMPATE MUESTRO LAS QUE EMPATAN Y SINO MUESTRO SOLO LAQUE MAS
SELECT 
    customer.customer_id,
    CONCAT(first_name, ' ', last_name) AS Nombre,
    SUM(amount) AS Gasto
FROM
    customer
        JOIN
    rental USING (customer_id)
        JOIN
    payment USING (customer_id)
GROUP BY customer.customer_id
ORDER BY gasto DESC
LIMIT 1;


-- viernes
-- 5) Ingreso promedio por alquiler en cada tienda

SELECT 
	store_id AS numero_tienda,
    ROUND(AVG(amount), 2) AS media_alquiler
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    rental USING (staff_id)
        JOIN
    payment USING (rental_id)
GROUP BY numero_tienda;

Select rental.rental_id, payment.customer_id, customer.store_id, inventory.store_id
from customer
join payment using (customer_id)
join rental using (rental_id) 
join inventory using (inventory_id)
where customer.store_id != inventory.store_id
order by payment.customer_id;



-- 6) Ventas totales por categoría ordenadas

-- por ingresos totales
SELECT 
    name AS categoria, SUM(amount) AS ventas_totales
FROM
    payment
        JOIN
    rental USING (rental_id)
        JOIN
    inventory USING (inventory_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
        JOIN
    category USING (category_id)
GROUP BY categoria
ORDER BY ventas_totales DESC;

-- por cantidad de alquileres
SELECT 
    name AS categoria, count(distinct rental_id) AS ventas_totales
FROM
    payment
        JOIN
    rental USING (rental_id)
        JOIN
    inventory USING (inventory_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
        JOIN
    category USING (category_id)
GROUP BY categoria
ORDER BY ventas_totales DESC;


-- 7) Actores con al menos diez películas de categorías distintas

-- no se como hacerlo
SELECT 
    CONCAT(first_name, ' ', last_name) AS Actor,
    COUNT(DISTINCT category_id) AS Cantidad_de_categorias,
    COUNT(DISTINCT film_id) AS Cantidad_de_peliculas
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
GROUP BY actor_id
HAVING cantidad_de_peliculas > 10
    AND Cantidad_de_categorias > 10
ORDER BY cantidad_de_peliculas DESC;




-- 8) Tiendas con más stock disponible
-- 9) Películas que nunca han sido alquiladas
-- 10) Diez películas con mayor diferencia entre coste de reposición y tarifa de alquiler
-- 11) Películas con más de tres actores y duración menor a 90 minutos

SELECT 
    title AS titulo,
    COUNT(actor_id) AS número_de_actores, length as duracion
FROM
    film_actor
        JOIN
    film USING (film_id)
WHERE
    length < 90
GROUP BY film_id
HAVING número_de_actores > 3
ORDER BY número_de_actores DESC;