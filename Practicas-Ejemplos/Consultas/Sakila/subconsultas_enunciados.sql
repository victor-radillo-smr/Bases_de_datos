-- Enunciados de la guía de subconsultas.
-- Este archivo contiene solo comentarios para practicar la escritura de SQL.
-- Esquema de referencia: Sakila. 

-- Tipos de subconsultas:
-- tipo 1: devuelven una tabla ( siempre necesitan un nombre de tabla)
-- tipo 2: devuelven un unico valor.
-- tipo 3: devuelven una columna.

-- Consulta 01. Actores con al menos 30 películas.

select*
from 
	(select actor_id,count(distinct film_id) as columna_subtabla
	from film_actor
	group by actor_id) as nombre_tabla
Where columna_subtabla > 30;

with nombre_tabla as 
	(select actor_id,count(distinct film_id) as columna_subtabla
	from film_actor
	group by actor_id)
Select * from nombre_tabla
where columna_subtabla > 30;

-- son las dos formas (por el momento) de hacer subconsultas de tipo 1: devuelven una tabla ( siempre necesitan un nombre de tabla)
-- Consulta 02. Películas en inglés.

select * from film
where language_id = (select language_id from language where name like '_nglish'); 

-- forma de hacer una subconsulta tipo 2: devuelve un unico valor.
-- Consulta 03. Películas en inglés — segunda versión con WITH.
-- no aporta mucho.

-- Consulta 04. Películas que superan la duración media.

select film_id, title from film
where (select avg(length) from film) > length
group by film_id;

-- Consulta 05. Películas que superan la duración media — segunda versión con WITH.



-- Consulta 06. Reparto de ALONE TRIP.



-- Sacar cuantas películas han trabajado los actores que salen en ALONE TRIP. 



-- Consulta 07. Reparto de ALONE TRIP — segunda versión con WITH.



-- Consulta 08. Películas de la categoría "Children" — Paso 1.

Select f.film_id, f.title from film f
join film_category fc on f.film_id = fc.film_id
where category_id = (select category_id from category where name like 'Children'); 

-- Consulta 09. Películas de la categoría "Children" — Paso 2.


-- Consulta 10. Películas de la categoría "Children" — Paso 3.

select * from 
(
	Select f.film_id, f.title from film f
	join film_category fc on f.film_id = fc.film_id
	where category_id = (select category_id from category where name like 'Children')
) as peliculas_de_children;

-- Consulta 11. Películas de la categoría "Children" — segunda versión con WITH — Paso 3.


-- Consulta 12. Clientes con al menos un alquiler.


-- Consulta 13. Clientes con al menos un alquiler — segunda versión con WITH.


-- Consulta 14. Películas sin alquileres con NOT EXISTS.


-- Consulta 15. Películas sin alquileres con NOT EXISTS — segunda versión con WITH.


-- Consulta 16. Películas nunca alquiladas, paso a paso — Paso 1.


-- Consulta 17. Películas nunca alquiladas, paso a paso — Paso 2.


-- Consulta 18. Películas nunca alquiladas, paso a paso — Paso 3.


-- Consulta 19. Películas nunca alquiladas, paso a paso — Paso 4.


-- Consulta 20. Películas nunca alquiladas, paso a paso — segunda versión con WITH — Paso 4.


-- Consulta 21. Actores con alguna película de más de 120 minutos — Paso 1.


-- Consulta 22. Actores con alguna película de más de 120 minutos — Paso 2.


-- Consulta 23. Actores con alguna película de más de 120 minutos — Paso 3.


-- Consulta 24. Actores con alguna película de más de 120 minutos — Paso 4.


-- Consulta 25. Actores con alguna película de más de 120 minutos — segunda versión con WITH — Paso 4.


-- Consulta 26. Número de alquileres por película.


-- Consulta 27. Número de alquileres por película — segunda versión con WITH.


-- Consulta 28. Importe pagado por cada cliente.


-- Consulta 29. Importe pagado por cada cliente — segunda versión con WITH.


-- Consulta 30. Recuento de películas por categoría.


-- Consulta 31. Recuento de películas por categoría — segunda versión con WITH.


-- Consulta 32. Categorías con un recuento por encima de la media.


-- Consulta 33. Categorías con un recuento por encima de la media.


-- Consulta 34. Duración media como tabla derivada.


-- Consulta 35. Duración media como tabla derivada — segunda versión con WITH.


-- Consulta 36. Categorías con un recuento por encima de la media.


-- Consulta 37. Películas de duración mínima por clasificación.


-- Consulta 38. Ejercicio 1: Películas por encima de la duración promedio.


-- Consulta 39. Ejercicio 2: Actores en "Action" y en "Comedy".


-- Consulta 40. Ejercicio 3: Clientes con más alquileres.


-- Consulta 41. Ejercicio 4: Películas de "Sports" no alquiladas en 2005.


-- Consulta 42. Derivada — Películas por idioma.


-- Consulta 43. Derivada — Idiomas con longitud media superior a 110 minutos.


-- Consulta 44. Derivada — Máximo y mínimo replacement_cost por idioma.


-- Consulta 45. Correlacionada (EXISTS) — Idiomas con al menos una película rating='R'.


-- Consulta 46. Escalar — Número total de idiomas distintos presentes en film.


-- Consulta 47. Escalar — Número de películas con calificación 'R'.


-- Consulta 48. Derivada — Idioma con más películas (TOP-1).


-- Consulta 49. Derivada — Idioma con mayor AVG(length) (TOP-1).


-- Consulta 50. Escalar — Media global de length.


-- Consulta 51. Correlacionada (NOT EXISTS) — Idiomas de language sin películas.


-- Consulta 52. Escalar — Películas clasificadas en una categoría distinta de R.


-- Consulta 53. Escalar — Proporción de R sobre el total (4 decimales).


-- Consulta 54. Correlacionada (EXISTS) — ¿Algún idioma distinto de English con películas?.


-- Consulta 55. Escalar — ¿Cuántos idiomas hay en language?.


-- Consulta 56. Correlacionada (EXISTS) — Idiomas con al menos una película.


-- Consulta 57. Derivada — Idiomas con MAX(replacement_cost) = 29.99.


-- Consulta 58. Derivada — Idiomas con MIN(replacement_cost) = 9.99.


-- Consulta 59. Correlacionada (EXISTS) — Idiomas con películas no 'R'.


-- Consulta 60. Derivada — ¿Cuántas películas totales hay? (derivada trivial).


-- Consulta 61. Escalar — Media global de length (redondeada a 4 decimales).


-- Consulta 62. Subconsultas con ANY, ALL y comparaciones avanzadas.


-- Consulta 63. Subconsultas con ANY, ALL y comparaciones avanzadas.


-- Consulta 64. Condiciones para todos con doble NOT EXISTS.


-- Variante con pista 01:
-- Muestra los actores que han participado en al menos 40 películas y el recuento de cada uno.
-- Pista. Mantén la CTE film_count. Cambia el umbral en el WHERE de la consulta principal.

-- Variante con pista 02:
-- Muestra el título y la duración de las películas que duran exactamente lo mismo que la película más corta del catálogo.
-- Pista. Cambia la función de agregado y el operador de comparación. La duración mínima puede estar compartida por varias películas.

-- Variante con pista 03:
-- Muestra los títulos de las películas que pertenecen a 'Children' o a 'Family'.
-- Pista. Amplía la condición sobre el nombre de la categoría en la consulta interna. Mantén la lista de identificadores de películas como resultado intermedio.

-- Variante con pista 04:
-- Muestra los clientes que no tienen ningún alquiler registrado el 1 de julio de 2005.
-- Pista. Conserva la condición que conecta ambas tablas, limita las fechas dentro de la subconsulta y cambia la comprobación de existencia.

-- Variante con pista 05:
-- Muestra cada película junto con el número de copias que tiene en inventario.
-- Pista. Mantén la referencia a la película exterior. Dentro solo necesitas la tabla que contiene las copias.

-- Variante con pista 06:
-- Muestra el nombre de los actores que han participado en al menos 30 películas, junto con su recuento.
-- Pista. Empieza agrupando film_actor por actor. Añade el nombre a partir del identificador que devuelve la tabla derivada.

-- Variante con pista 07:
-- Muestra las categorías que tienen al menos 65 películas y el recuento de cada una. Conserva la CTE del ejemplo.
-- Pista. Usa el recuento que ya entrega category_counts y cambia el filtro de la consulta principal.

-- Variante con pista 08:
-- Muestra las películas que tienen el coste de reemplazo más alto de su clasificación. Incluye todos los empates.
-- Pista. Mantén la clasificación como primer componente y usa el coste de reemplazo como segundo componente en ambos lados de la comparación.

-- Reto autónomo 01:
-- Muestra el nombre, el apellido y el número de alquileres de los clientes que han realizado al menos 30 alquileres. Usa una CTE que devuelva una fila por cliente con alquileres.
-- Comprueba. Un cliente con exactamente 30 alquileres debe aparecer una sola vez.

-- Reto autónomo 02:
-- Muestra el título y el coste de reemplazo de las películas cuyo coste supera la media de las películas con clasificación 'PG'. La comparación se aplica a todo el catálogo, sea cual sea la clasificación de cada película.
-- Comprueba. Si cambia el grupo que sirve para calcular la media, ¿qué parte de tu consulta tendrías que modificar?

-- Reto autónomo 03:
-- Muestra el nombre y el apellido de los actores que han participado en alguna película de más de 120 minutos de la categoría 'Family'. Usa IN para comprobar la pertenencia a la lista de actores.
-- Comprueba. Si un actor ha participado en dos películas que cumplen ambas condiciones, ¿cuántas veces debe aparecer su fila?

-- Reto autónomo 04:
-- Muestra el identificador y el nombre de las categorías que no contienen ninguna película de más de 180 minutos.
-- Comprueba. Una categoría con diez películas cortas y una de 181 minutos debe quedar fuera. ¿Qué ocurre con una categoría sin películas?

-- Reto autónomo 05:
-- Muestra el identificador, el nombre y el apellido de cada actor, junto con la duración de la película más larga en la que haya participado. Si un actor no tiene películas, debe aparecer con NULL en la columna calculada.
-- Comprueba. Si dos películas de un mismo actor comparten la duración máxima, la consulta exterior debe seguir devolviendo una sola fila para ese actor.

-- Reto autónomo 06:
-- Muestra el título y el recuento de las películas que tienen más de tres copias en la tienda 1. El resultado intermedio debe tener una fila por película con copias en esa tienda.
-- Comprueba. Una película con tres copias en la tienda 1 y cuatro en la tienda 2 debe quedar fuera.

-- Reto autónomo 07:
-- Muestra el nombre, el apellido y el número de películas de los actores cuyo recuento supera la media de películas por actor. Para calcular la media, considera a los actores con al menos una película. Usa la misma CTE para obtener los recuentos que muestras y para calcular su media.
-- Comprueba. ¿Qué representa cada fila de la CTE? Si un actor iguala la media, el filtro debe dejarlo fuera.

-- Reto autónomo 08:
-- Obtén la película o películas de mayor duración de cada categoría de Sakila. Muestra la categoría, el título y la duración. Una película que aparezca en varias categorías se compara dentro de cada una.
-- Comprueba. Si dos películas son las más largas de una categoría, deben aparecer ambas. Una película con esa misma duración en otra categoría solo aparece si también alcanza el máximo de su propio grupo.

-- Práctica de integración: seis consultas.

-- 1) Película(s) más larga(s) por categoría
-- Objetivo: Para cada categoría, devolver la(s) película(s) de mayor duración dentro de esa categoría.
-- Columnas y alias obligatorios:
-- `category` (nombre de la categoría)
-- `title` (título de la película)
-- `length` (duración en minutos)
-- Reglas: Si en una categoría hay empate en la duración máxima, deben aparecer todas las películas empatadas. Sin duplicados adicionales.
-- Orden: `category` ASC. Dentro de cada categoría, el orden es indiferente.

-- 2) Número de películas sin stock disponible en ninguna tienda
-- Objetivo: Devolver una única fila con el recuento de películas que no tienen ninguna copia disponible en stock en ninguna tienda.
-- Columna y alias obligatorio:
-- `num_unavailable_films` (número total de películas sin stock disponible)
-- Reglas: Cuenta las películas sin copias y aquellas cuyas copias tienen todas algún alquiler sin fecha de devolución. Una sola copia disponible en cualquier tienda excluye la película.

-- 3) Recaudación mensual por categoría en 2005
-- Objetivo: Para cada categoría y cada mes del año natural 2005, devolver la recaudación total (suma de importes cobrados) correspondiente a esa categoría en ese mes.
-- Columnas y alias obligatorios:
-- `category` (nombre de la categoría)
-- `month` (número de mes 1–12)
-- `total` (importe total cobrado ese mes en esa categoría)
-- Reglas: Considerar exclusivamente los pagos con fecha en 2005. Incluye solo pagos vinculados a un alquiler y a su categoría. Omite las combinaciones categoría–mes sin pagos. Si la película pertenece a varias categorías, atribuye el pago completo a cada una.
-- Orden: `category` ASC, `month` ASC.

-- 4) Clientes con alquileres pero sin pagos registrados
-- Objetivo: Listar los clientes que han realizado al menos un alquiler y no tienen ningún pago registrado.
-- Columnas y alias obligatorios:
-- `customer_id`
-- `customer` (nombre y apellidos en una sola columna)
-- Reglas: El cliente debe cumplir ambas condiciones (≥1 alquiler y 0 pagos). Sin duplicados.
-- Orden: Indiferente.

-- 5) Cliente(s) que más ha(n) gastado en cada país
-- Objetivo: Para cada país con clientes, devolver el/los cliente(s) con mayor gasto total y el importe gastado. Usa el país del domicilio del cliente y asigna un gasto de cero si no tiene pagos.
-- Columnas y alias obligatorios:
-- `country` (nombre del país)
-- `top_customer` (nombre y apellidos del cliente)
-- `max_spent` (importe total gastado por ese cliente en ese país)
-- Reglas: Si hay empate en el gasto máximo de un país, incluir todos los clientes empatados. Sin duplicados.
-- Orden: `country` ASC.

-- 6) Categorías con ingresos superiores a la media global
-- Objetivo: Devolver las categorías cuyo ingreso total (suma de importes cobrados asociados a sus alquileres) es estrictamente superior a la media global de ingresos por categoría.
-- Columnas y alias obligatorios:
-- `category` (nombre de la categoría)
-- `total_revenue` (ingreso total de la categoría)
-- Reglas: Comparar cada categoría con la media aritmética de los ingresos totales por categoría. Incluye con valor cero las categorías sin ingresos. Si la película pertenece a varias categorías, atribuye el pago completo a cada una. Excluir las categorías que no superen dicha media. Sin duplicados.
-- Orden: `total_revenue` DESC.
