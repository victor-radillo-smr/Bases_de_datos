use sakila;

-- Saca el listado de películas que nunca han sido alquiladas

Select title as película 
from film
join inventory i using (film_id)
right join rental r on i.inventory_id = r.inventory_id
where rental_date = NULL 
group by film_id;

Select title as película 
from film
join inventory i using (film_id)
left join rental r on i.inventory_id = r.inventory_id
where rental_id is null
group by film_id;


-- saca el listado de películas que no tienen copias fisicas.

select f.film_id as id_película, title as películas_sin_copias_físicas, inventory_id
from film f left join inventory i on f.film_id = i.film_id
where inventory_id is null
group by title;

-- preguntas
-- a)¿la peli 14 tiene algún rental? 

select*
from rental right join inventory using (inventory_id)
where film_id = 14;

select*
from rental left join inventory using (inventory_id)
where film_id = 14;

-- Saca el listado de los nombres de películas que nunca han sido alquiladas.

select film.film_id as id_película, title as película
from film left join inventory using(film_id)
left join rental using (inventory_id)
-- where rental_id is null
group by film.film_id
having count(rental_id) = 0;

-- ejemlos de patrones de join.
-- patron 1: dos tablas cosas de a que no tienen b.
