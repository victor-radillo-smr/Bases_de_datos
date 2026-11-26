use sakila;

### 1. Idiomas y películas (hacer)

# Muestra el identificador y nombre de todos los idiomas, junto con el identificador y título de sus películas. Incluye los idiomas que no tengan películas. Ordena por idioma y título.

### 2. Películas y ejemplares 

# Muestra el identificador y título de todas las películas y el identificador de cada ejemplar del inventario. Incluye las películas sin ejemplares. Ordena por título y ejemplar.

### 3. Películas y reparto (hacer)

# Muestra el identificador y título de todas las películas, junto con los identificadores de los actores que participan en ellas. Incluye las películas sin actores. Ordena por título y actor.

### 4. Ciudades y direcciones 

# Muestra el identificador y nombre de todas las ciudades, junto con el identificador y texto de las direcciones registradas. Incluye ciudades sin direcciones. Ordena por ciudad y dirección.
SELECT 
    country_id AS id_país,
    country AS país,
    city_id AS id_ciudad,
    city AS ciudad,
    address_id AS id_direccion,
    address,
    address2
FROM
    city
        LEFT JOIN
    address USING (city_id)
        JOIN
    country USING (country_id)
WHERE
    address IS NULL AND address2 IS NULL; 

### 5. Ejemplares y alquileres 

# Muestra el identificador de todos los ejemplares, su película y el identificador de cada alquiler registrado. Incluye los ejemplares nunca alquilados. Ordena por identificador de ejemplar y alquiler.
 
### 6. Inventario de la tienda 1 

# Muestra todas las películas y los identificadores de los ejemplares disponibles en la tienda 1. Incluye las películas sin ejemplares en esa tienda, aunque tengan en otra. Ordena por título y ejemplar.

### 7. Alquileres de mayo de 2005 

# Muestra el identificador, nombre y apellidos de todos los clientes y los alquileres que realizaron en mayo de 2005, con su fecha. Incluye clientes sin alquileres ese mes. Ordena por cliente y fecha.

SELECT 
    c.customer_id AS id_cliente,
    CONCAT(first_name, ' ', last_name) AS cliente,
    rental_date AS alquiler_2005
FROM
    rental r
        RIGHT JOIN
    customer c ON r.customer_id = c.customer_id
        AND rental_date LIKE '%2005-05%'
        OR rental_date IS NULL
ORDER BY c.customer_id , rental_id;

-- casos de filtrar en el on:
-- caso 1 cuando estoy buscando sacar nulls
-- caso 2 para optimizar consultas

### 8. Películas por idioma 

# Muestra todos los idiomas y las películas asociadas a cada uno, incluyendo los idiomas sin películas. Esta vez la tabla de películas debe aparecer a la izquierda del JOIN. Ordena por idioma y título.

### 9. Películas y copias 

# Muestra todas las películas y sus identificadores de inventario, incluyendo las que no tienen copias. Sitúa la tabla de inventario a la izquierda del JOIN. Ordena por película y ejemplar.

SELECT 
    f.film_id AS id_película,
    title AS película,
    i.inventory_id AS id_inventario
FROM
    inventory i
        LEFT JOIN
    film f ON i.film_id = f.film_id
        OR inventory_id IS NULL
ORDER BY f.film_id , i.inventory_id;

SELECT 
    COUNT(inventory_id)
FROM
    inventory i
        LEFT JOIN
    film f ON i.film_id = f.film_id;

### 10. Películas y asociaciones con actores 

# Muestra todas las películas y sus identificadores de actores asociados, incluidas las que no tienen ninguno. Sitúa la tabla intermedia de actores a la izquierda. Ordena por título.

### 11. Ciudades y direcciones 

# Muestra todas las ciudades y sus direcciones, incluidas las ciudades sin direcciones. Sitúa la tabla de direcciones a la izquierda del JOIN. Ordena por ciudad y dirección.

### 12. Alquileres por ejemplar 

# Muestra cada ejemplar del inventario y los identificadores de sus alquileres, incluyendo los nunca alquilados. Sitúa rental a la izquierda del JOIN. Ordena por ejemplar y alquiler.

### 13. Ejemplares de la tienda 2 

# Muestra todas las películas y sus ejemplares de la tienda 2, incluyendo las películas que no tengan ejemplares en esa tienda. Sitúa inventory a la izquierda del JOIN. Ordena por título y ejemplar.
 
### 14. Idiomas sin películas 

# Muestra exclusivamente el identificador y nombre de los idiomas que no tienen películas asociadas. Incluye el identificador de la película en la salida para apreciar el valor nulo. Ordena por idioma.

### 15. Películas sin inventario 

# Muestra exclusivamente el identificador y título de las películas que carecen de ejemplares. Incluye también inventory_id en la salida. Utiliza 

### 16. Películas sin actores 

# Muestra exclusivamente las películas sin actores asociados. Devuelve identificador, título y el identificador del actor, y ordena por título.

### 17. Ejemplares nunca alquilados 

# Muestra exclusivamente los ejemplares que nunca se han alquilado. Devuelve el identificador del ejemplar, su película y el identificador del alquiler (nulo). Utiliza 

### 18. Ciudades sin direcciones (agrupación) 

# Muestra las ciudades que no tienen ninguna dirección registrada, junto con el número de direcciones y el máximo identificador de dirección. Ordena por ciudad.

### 19. Películas con menos de 3 copias en tienda 1 

# Muestra el identificador y título de las películas que tienen menos de tres ejemplares en la tienda 1, incluidos los que tienen cero. 
# Añade el recuento de ejemplares y el máximo identificador de ejemplar. Ordena por recuento y título.

SELECT 
    f.film_id AS id_película,
    f.title AS película,
    COUNT(i.inventory_id) AS número_de_películas
FROM
    film f
        LEFT JOIN
    inventory i ON f.film_id = i.film_id AND store_id = 1
GROUP BY f.film_id , f.title
HAVING COUNT(i.inventory_id) < 3;

-- no sale la 14 
-- la peli 14 no tiene copias fisicas en ninguna tienda.
-- por lo tanto no tiene copiasen la tienda 1.
-- ergo, deberia salir en esta consulta 

SELECT 
    f.film_id AS id_película,
    f.title AS película,
    COUNT(i.inventory_id) AS número_de_películas
FROM
    film f
        LEFT JOIN
    inventory i ON f.film_id = i.film_id
WHERE
    store_id = 1 OR store_id IS NULL
GROUP BY f.film_id , f.title
HAVING COUNT(i.inventory_id) < 3;
-- esta mal

/*
Al haber filtrado con where en store_id = 1 te cargas los valores null porque un inventario que no existe no puede tener asignado ninguna tienda por lo que no muestra todas las peliculas que no tienen copias fisicas.
Si se hace un filtro con store_id = 1 en el on salen consiguen salir todos los datos ¿porque?.
CONCLUSION:
Si filtramos con el WHERE por el orden de ejecucion de una consulta filtrara despues de la union de las tablas machacando por completo el LEFT JOIN dejandolo practicamente como un INNER JOIN sin encambio al hacer 
el filtro en el ON hara el filtro igual pero los que no compartan ese filtro recibiran un valor NULL lo cual es lo que se necesita en esta consulta porque si las peliculas tienen copias fisicas pero no en la tienda 1 
tambien se deben de contar.
EXPLICACION:

*/
### 20. Películas jamás alquiladas (varios JOIN) 

# Muestra las películas que nunca se han alquilado, considerando todos sus ejemplares en las dos tiendas. Devuelve identificador, título, número de alquileres y máximo identificador de alquiler. Ordena por título.

SELECT 
    f.film_id,
    f.title AS pelicula,
    COUNT(r.rental_id),
    COUNT(i.inventory_id),
    COUNT(DISTINCT i.inventory_id)
FROM
    film f
        LEFT JOIN
    inventory i ON f.film_id = i.film_id
        LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
HAVING COUNT(rental_id) = 0;

-- Esta consulta deberia de repasarla bastante es un buen ejemplo para estudiar.