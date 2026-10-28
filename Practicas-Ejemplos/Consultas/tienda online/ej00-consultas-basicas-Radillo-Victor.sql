# Consultas SQL Graduales para tiendaonline-data.sql


## O. Intro

### Mostrar todas las tablas

show tables;

### Mostrar la estructura de la tabla clientes

select * from clientes;

## 1. Consultas Básicas

### 1.1. Mostrar todos los clientes registrados

select id_cliente,nombre,fecha_registro from clientes;

### 1.2. Mostrar todos los productos disponibles

select * from productos;

### 1.3. Mostrar todos los pedidos realizados

select * from pedidos;

## 2. Consultas Básicas seleccionando campos específicos

### 2.1. Mostrar solo el nombre y el email de todos los clientes

select nombre,email from clientes;

### 2.2. Mostrar solo el nombre y el precio de todos los productos

select nombre,precio from productos;

### 2.3. Mostrar solo el nombre y el estado de todos los pedidos

select id_cliente,estado from pedidos;
-- En este caso se pide el nombre delpedido como esa columna no existe he seleccionado la columna que mas se podria parecer alnombre del pedido que es la columna id_pedido 

## 3. Consultas con ORDER BY, SORT y LIMIT

### 3.1. Mostrar los productos ordenados por precio de mayor a menor

select * from productos order by precio desc;

### 3.2. Mostrar los pedidos ordenados por fecha de pedido de más reciente a más antigua

select * from pedidos order by fecha_pedido desc;

### 3.3. Mostrar los 5 primeros clientes registrados

select nombre from clientes order by fecha_registro desc limit 5;

### 3.4. Mostrar los 3 últimos pedidos realizados

select * from pedidos order by fecha_pedido desc limit 3;

## 4. Filtros avanzados (IN, BETWEEN, LIKE...)

### 4.1. Mostrar los productos cuyo precio esté entre 100 y 500 euros

select * from productos where precio between 100 and 500;

### 4.2. Mostrar los clientes que sean de España

select * from clientes where pais like ("_spaña");

### 4.3. Mostrar los pedidos que tengan un estado que no sea 'pendiente'

select * from pedidos where estado not like "pendiente";

### 4.4. Mostrar los productos cuyo nombre contenga la palabra 'Laptop'

select * from productos where nombre like "%Laptop%";

### 4.5. Buscar productos cuyo nombre comiencen por 'Laptop' o 'laptop'

select * from productos where nombre like "Laptop%" or "laptop%";

### 4.6. Mostrar los clientes que tengan un email que contenga '@example.com'

select * from clientes where email like "%@example.com";

### 4.7. Mostrar los productos cuya categoría sea 'Electrónica' o 'Muebles' usando el operador IN

select * from productos where categoria in ("Electrónica" or "Muebles");

### 4.8. Mostrar los pedidos que tengan un total entre 100 y 500 euros

select * from pedidos where coste_total  between 100 and 500 order by coste_total desc;

## 5. Ejemplos con funciones de cadenas, numéricas y de fechas

### Numéricas

#### 5.1. Obtener la longitud del nombre de cada cliente

SELECT CHAR_LENGTH(nombre) AS cantidad_de_caracteres FROM clientes;
-- Utilizamos CHAR_LENGTH porque no cuenta las tildes como doble caracter.

#### 5.2. Obtener el total de pedidos realizados

SELECT COUNT(id_pedido) FROM pedidos;
-- cuenta cuantos id_pedido hay.

#### 5.3. Obtener el precio promedio de los productos

SELECT AVG(precio) FROM productos;
-- Hace la media (AVG) de todos los precios de los pedidos.

#### 5.4. Obtener el precio más bajo de los productos

SELECT MIN(precio) FROM productos;
-- Selecciona el precio de producto más bajo.

#### 5.5. Obtener el precio más alto de los productos

SELECT MAX(precio) FROM productos;
-- Selecciona el precio de producto más alto.

### Funciones de cadena

#### 5.6. Convertir el nombre de los productos a mayúsculas

SELECT UPPER(nombre) FROM productos;
-- Cambia todas las letras por mayusculas (UPPER).

#### 5.7. Convertir el nombre de los clientes a minúsculas

SELECT LOWER(nombre) FROM productos;
-- Cambia todas las letras por minusculas (LOWER).

#### 5.8. Obtener los primeros 3 caracteres del nombre de cada producto

SELECT LEFT(nombre, 3) FROM productos;
-- Selecciona de la columna nombre los 3 primeros caracteres empezando por la izquierda.

#### 5.9. Obtener los últimos 3 caracteres del nombre de cada producto

SELECT RIGHT(nombre, 3) FROM productos;
-- Selecciona de la columna nombre los 3 primeros caracteres empezando por la derecha.

### Funciones de fecha

#### 5.10. Obtener la fecha de hoy

SELECT NOW();
-- Nos da la fecha y hora de hoy.

#### 5.11. Calcular cuántos días han pasado desde el registro de cada cliente hasta hoy

SELECT DATEDIFF(NOW(), fecha_registro) FROM clientes;
-- Nos da la diferencia en dias entre 2 fechas gracias a DATEDIFF.
