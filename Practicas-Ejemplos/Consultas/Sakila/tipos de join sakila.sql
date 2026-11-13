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

-- --------------------------------------------------------------------------------------------------------------
-- ejemlos de patrones de join.
-- patron 1: dos tablas cosas de a que no tienen b.

select*
from a 
left join b
where b.id is null;

-- patron 2: mas de 2 tablas cosas de la primera tabla que no tiene la ultima 

select*
from a 
left join b
left join c
group by a.id
having count(c.id)=0;

-- --------------------------------------------------------------------------------------------------------------


-- 1) Obten el listado de idiomas que no tienen ninguna película.

Select name as idioma
from language
left join film using (language_id)
where film_id is null;

-- 2)¿Hay algún actor que no salga en ninguna película?

Select actor_id as id_actor, concat(first_name, " ",last_name) as actor
from actor
left join film_actor using (actor_id)
where film_actor.film_id is null;

-- comprobacion que esta bien hecha.
select count(*),count(distinct actor_id) from actor join film_actor using (actor_id);
