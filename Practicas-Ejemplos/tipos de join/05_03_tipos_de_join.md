### 1. Idiomas y películas 

# Muestra el identificador y nombre de todos los idiomas, junto con el identificador y título de sus películas. Incluye los idiomas que no tengan películas. Ordena por idioma y título.

### 2. Películas y ejemplares 

# Muestra el identificador y título de todas las películas y el identificador de cada ejemplar del inventario. Incluye las películas sin ejemplares. Ordena por título y ejemplar.

### 3. Películas y reparto 

# Muestra el identificador y título de todas las películas, junto con los identificadores de los actores que participan en ellas. Incluye las películas sin actores. Ordena por título y actor.

### 4. Ciudades y direcciones 

# Muestra el identificador y nombre de todas las ciudades, junto con el identificador y texto de las direcciones registradas. Incluye ciudades sin direcciones. Ordena por ciudad y dirección.
select country_id as id_país, country as país, city_id as id_ciudad, city as ciudad, address_id as id_direccion, address, address2
from city left join address using (city_id) join country using (country_id)
where address is null and address2 is null; 

### 5. Ejemplares y alquileres 

# Muestra el identificador de todos los ejemplares, su película y el identificador de cada alquiler registrado. Incluye los ejemplares nunca alquilados. Ordena por identificador de ejemplar y alquiler.
 
### 6. Inventario de la tienda 1 

# Muestra todas las películas y los identificadores de los ejemplares disponibles en la tienda 1. Incluye las películas sin ejemplares en esa tienda, aunque tengan en otra. Ordena por título y ejemplar.

### 7. Alquileres de mayo de 2005 

# Muestra el identificador, nombre y apellidos de todos los clientes y los alquileres que realizaron en mayo de 2005, con su fecha. Incluye clientes sin alquileres ese mes. Ordena por cliente y fecha.

select c.customer_id as id_cliente, concat(first_name, " ",last_name) as cliente, rental_date as alquiler_2005
from rental r right join customer c on r.customer_id = c.customer_id and rental_date like "%2005-05%" or rental_date is null
order by c.customer_id, rental_id;

-- casos de filtrar en el on:
-- caso 1 cuando estoy buscando sacar nulls
-- caso 2 para optimizar consultas

### 8. Películas por idioma 

# Muestra todos los idiomas y las películas asociadas a cada uno, incluyendo los idiomas sin películas. Esta vez la tabla de películas debe aparecer a la izquierda del JOIN. Ordena por idioma y título.

### 9. Películas y copias 

# Muestra todas las películas y sus identificadores de inventario, incluyendo las que no tienen copias. Sitúa la tabla de inventario a la izquierda del JOIN. Ordena por película y ejemplar.

Select f.film_id as id_película, title as película, i.inventory_id as id_inventario
from inventory i 
left join film f on i.film_id = f.film_id or inventory_id is null
order by f.film_id, i.inventory_id;

select count(inventory_id)
from inventory i
left join film f on i.film_id = f.film_id;

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

# Muestra el identificador y título de las películas que tienen menos de tres ejemplares en la tienda 1, incluidos los que tienen cero. Añade el recuento de ejemplares y el máximo identificador de ejemplar. Ordena por recuento y título.

### 20. Películas jamás alquiladas (varios JOIN) 

# Muestra las películas que nunca se han alquilado, considerando todos sus ejemplares en las dos tiendas. Devuelve identificador, título, número de alquileres y máximo identificador de alquiler. Ordena por título.

