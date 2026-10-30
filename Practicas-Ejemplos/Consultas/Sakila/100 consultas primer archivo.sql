-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
-- Necesito la tabla  actor, film-actor
SELECT 
    CONCAT(first_name, ' ', last_name) AS actor,
    COUNT(DISTINCT film_id) AS número_de_películas
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY CONCAT(first_name, ' ', last_name);

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.
-- necesito las tablas actor y film_actor

SELECT 
    CONCAT(first_name, ' ', last_name) AS actor,
    COUNT(DISTINCT film_id) AS numero_peliculas_más_de_20
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY actor
HAVING numero_peliculas_más_de_20 > 20;

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.
-- necesito las tablas language, film

SELECT 
    name AS idioma, COUNT(film_id) AS películas
FROM
    language
        JOIN
    film USING (language_id);

SELECT 
    *
FROM
    film
WHERE
    language_id != 1;

-- solo hay películas en inglés
-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.
-- necesito las tablas film, language

SELECT 
    name AS idioma, ROUND(AVG(length), 2) AS duración_media
FROM
    film
        JOIN
    language USING (language_id)
GROUP BY idioma
HAVING duración_media > 110;

-- como hemos visto antes solo tienen un idioma.

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.
-- necesito las tablas  film, inventory

SELECT 
    title AS titulo, COUNT(film_id) AS número_copias
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY titulo;

SELECT 
    film_id
FROM
    inventory
WHERE
    film_id = 1;

-- con esta consulta comprobamos que la pelicula ACADEMY DINOSAUR con id 1 tiene 8 copias.
-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.
-- necesito las tablas  film, inventory

SELECT 
    title AS titulo, COUNT(film_id) AS número_copias
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY titulo
HAVING número_copias > 5; 

-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.
-- Necesito las tablas inventory, rental

SELECT 
    inventory_id AS id_copia_fisica,
    COUNT(rental_id) AS número_de_alquileres
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY inventory_id;

-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.
-- Necesito las tablas customer, rental

SELECT 
    CONCAT(first_name, ' ', last_name) AS cliente,
    COUNT(rental_id) AS alquileres
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY cliente;

-- 9:  Lista los clientes con 30 o más alquileres acumulados.
-- Necesito las tablas customer, rental

SELECT 
    CONCAT(first_name, ' ', last_name) AS cliente,
    COUNT(rental_id) AS alquileres
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY cliente
HAVING alquileres > 30;

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.
-- Necesito las tablas payments, customer

SELECT 
    CONCAT(first_name, ' ', last_name) AS cliente,
    SUM(amount) AS importe_total_alquileres
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY cliente;

-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.
-- Necesito las tablas customer y payment

SELECT 
    CONCAT(first_name, ' ', last_name) AS clientes,
    SUM(amount) AS pagos_totales
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY clientes
HAVING pagos_totales > 200;

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.
-- necesito las tablas staff y payments

SELECT 
    staff_id AS id_empleado,
    CONCAT(first_name, ' ', last_name) AS empleado,
    COUNT(payment_id)
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY empleado;

select * from staff;

select count(payment_id) from payment;
-- con esta ultimas consultas comprobamos que solo hay 2 empleados del staff y que hay un total de 16044 pagos
 
-- 13:  Para cada empleado, muestra el importe total procesado.
-- necesito las tablas staff y payment
SELECT 
    staff_id AS id_empleado,
    CONCAT(first_name, ' ', last_name) AS empleado,
    SUM(amount) AS total_pago_procesado
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY empleado;


-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.
-- Necesito las tablas store y inventory

SELECT 
    store_id AS id_tienda,
    COUNT(inventory_id) AS cantidad_articulos
FROM
    store
        JOIN
    inventory USING (store_id)
GROUP BY store_id;

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.
-- Necesito las tablas customer y store

SELECT 
    store_id AS número_de_tienda,
    COUNT(customer_id) AS clientes_asignados
FROM
    store
        JOIN
    customer USING (store_id)
GROUP BY número_de_tienda;

-- como dijo Víctor esto no significa que un cliente no pueda comprar en varias tiendas pero solo tiene asignada una por como esta hecha Sakila
-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.
-- Necesito las tablas staff y store 

SELECT 
    store_id AS número_de_tienda,
    COUNT(staff_id) AS empleados_por_tienda
FROM
    store
        JOIN
    staff USING (store_id)
GROUP BY store_id;

-- Como vimos antes solo hay 2 empleados  uno por cada tienda
-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).
-- Necesito las tablas address y store

SELECT 
    address_id AS id_dirección,
    address AS dirección,
    COUNT(store_id) AS tiendas
FROM
    address
        JOIN
    store USING (address_id)
GROUP BY address.address_id;

select* from address;

-- vimos en consultas anteriores que solo habia 2 tiendas
-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.
-- Necesito las tablas address y staff

SELECT 
    address.address_id AS id_dirección,
    address AS dirección,
    COUNT(staff_id) AS empleados_residentes
FROM
    address
        JOIN
    staff ON address.address_id = staff.address_id
GROUP BY address.address_id;

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.
-- Necesito las tablas address y customer

SELECT 
    address_id AS id_dirección,
    address AS dirección,
    COUNT(customer_id) AS número_clientes_residentes
FROM
    address
        JOIN
    customer USING (address_id)
GROUP BY address_id; 

-- preguntar a victor si se pueden sacar el resto de direcciones con un 0 en el 17, 18, 19 
-- Respuesta: se podria sacar con tipos de JOIN pero no lo hemos visto.
-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.
-- Necesito las tablas city y address

SELECT 
    city AS ciudad, COUNT(address_id) AS direcciones_registradas
FROM
    city
        JOIN
    address USING (city_id)
GROUP BY city_id;

-- 21:  Para cada país, cuenta cuántas ciudades existen.
-- Necesito las tablas country y city.

SELECT 
    country AS país, COUNT(city_id) AS número_de_ciudades
FROM
    country
        JOIN
    city USING (country_id)
GROUP BY país;

select * from city where country_id = 15;
-- Si ejecutamos la consulta de encima veremos que el pais 15 (que es Brasil) nos devuelve 28 rows que son justo el número de ciudades que nos devielve la primera consulta.
-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
-- Necesito las tablas language y film.

Select name as Idioma, round(avg(length), 2) as duracion_media
from language
join film using (language_id)
group by idioma
having  duracion_media >89 and duracion_media <121;

-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
-- Necesito las tablas inventory y rental.

SELECT 
    film_id AS id_pelicula,
    COUNT(rental_id) AS veces_alquilada
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY id_pelicula;

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).
-- Necesito las tablas customer y payment

SELECT 
    CONCAT(first_name, ' ', last_name) AS cliente,
    COUNT(payment_id) AS pagos_2005
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    payment_date LIKE '%2005%'
GROUP BY cliente;

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
-- Necesito las tablas film y inventory.

SELECT 
    title AS película,
    ROUND(AVG(rental_rate), 2) AS coste_por_alquiler,
    COUNT(inventory_id) AS número_copias
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY película;

-- no lo he entendido.
-- lo debatimos en clase 2 compañeros y yo y me dijeron que habia un dato que no habia visto pensandoque ese dato estaba en rental en vez de en film (rental_rate)
-- 26:  Para cada actor, muestra la duración media (length) de sus películas.
-- necesito las tablas film_actor y film (aunque yo añadiria tambien actor para poner el nombre) 

SELECT 
    actor_id AS id_actor,
    ROUND(AVG(length), 2) AS duracíon_media_películas
FROM
    film
        JOIN
    film_actor USING (film_id)
GROUP BY actor_id
ORDER BY actor_id;

-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
-- Necesito las tablas city, customer y address.

SELECT 
    city AS ciudad, COUNT(customer_id) AS clientes_en_la_ciudad
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY ciudad;

-- ------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    city AS ciudad, COUNT(address) AS prueba
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY ciudad;

-- Cualquiera de las 2 da el mismo resultado.
-- 28:  Para cada película, cuenta cuántos actores tiene asociados.
-- necesito las tablas film_actor y film

SELECT 
    title AS película,
    COUNT(actor_id) AS número_de_actores_asociados
FROM
    film
        JOIN
    film_actor USING (film_id)
GROUP BY película;

-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
-- Necesito las tablas category_film y film.

SELECT 
    category_id AS id_categoria,
    COUNT(film_id) AS cantidad_de_películas
FROM
    film
        JOIN
    film_category USING (film_id)
GROUP BY category_id;

-- Como ya vimos en clase cada película solo puede tener una categoria.
-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
-- Necesito las tablas rental y inventory.

SELECT 
    store_id AS id_tienda,
    COUNT(rental_id) AS alquileres_totales_por_inventario
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY id_tienda;


-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
-- Necesito las tablas actor, film actor.
SELECT 
    CONCAT(first_name, ' ', last_name) AS actor,
    COUNT(film_id) AS participacion_en_películas
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY actor
HAVING participacion_en_películas > 15;

-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
-- Necesito las tablas category, film_category.

SELECT 
    name AS categoria, film_id AS cantidad_de_películas
FROM
    category
        JOIN
    film_category USING (category_id)
GROUP BY categoria;

-- Lo hable con Víctor y estas dos ultimas consultas las pude hacer con solo dos tablas
-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.
-- Necesito las tablas film, rental y inventory.

SELECT 
    title AS película,
    COUNT(rental_id) AS número_de_veces_alquilada
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY película;

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.
-- Necesito las tablas  customer,  payment.

SELECT 
    CONCAT(first_name, ' ', last_name) AS cliente,
    SUM(amount) AS pagos_2005
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    payment_date LIKE '%2005%'
GROUP BY cliente
HAVING pagos_2005 >= 150;

-- solo he necesitado 2 tablas porque en payment ya hay un payment_date
-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.
-- Necesito las tablas store, staff y payment.

SELECT 
    CONCAT(first_name, ' ', last_name) AS empleado,
    store_id AS número_de_tienda,
    SUM(amount) AS cantidad_gestionada_de_pagos
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
GROUP BY empleado;

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).
-- Necesito las tablas city, address y staff.

SELECT 
    city AS ciudad,
    COUNT(staff_id) AS número_empleados_residentes
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    staff USING (address_id)
GROUP BY city;

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).
-- Necesito las tablas city, address y store.

SELECT 
    city AS ciudad, COUNT(store_id) AS número_de_tiendas
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    store USING (address_id)
GROUP BY ciudad;

-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.
-- Necesito las tablas actor, film_actor, film.

SELECT 
    CONCAT(first_name, ' ', last_name) AS actor,
    ROUND(AVG(length), 2) AS duracion_media_2006
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
WHERE
    release_year LIKE '%2006'
GROUP BY actor;


-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.
-- Necesito las tablas category, film_category.

SELECT 
    name AS categoria, ROUND(AVG(length), 2) AS duracion_media
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY categoria
HAVING duracion_media > 120;

-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.
-- Necesito las tablas language , film y inventory.

SELECT 
    language_id AS id_idioma,
    name AS idioma,
    SUM(rental_rate) AS Coste_alquiler_idioma
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    inventory USING (film_id)
GROUP BY id_idioma;

-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).




-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
-- 70:  Para cada país, suma los importes pagados por sus clientes.
-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.
