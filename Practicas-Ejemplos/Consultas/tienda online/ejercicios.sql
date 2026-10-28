-- # Ejemplos resueltos en la BBDD tiendaonline_completa.


USE tienda_online; -- Siempre lo primero que tenemos que seleccionar la base de datos con la que vamos a trabajar con el comando USE
select * from clientes;
select * from pedidos;
select* from detalle_pedido;
select * from pagos;
select * from productos; 
-- ## 1) Selección básica de datos y renombrado de columnas

-- Listado simple de nombres y correos de todos los clientes.

select nombre,email from clientes; -- Con este commando seleccionamos (select)  el nombre y el email de (from) la tabla clientes(clientes)

-- Catálogo: nombre y precio de todos los productos.

explain productos; -- te da una explicacion detallada sobre las partes de la tabla te dice el tipo( si es caracter, entero, don decimales) si es clave (primaria o secunaria) etc
select nombre,precio from productos; -- Con este commando seleccionamos (select) nombre y precio de (from) la tabla clientes(productos)

-- Pedidos con su fecha y estado.

select id_pedido,fecha_pedido,estado from pedidos;

-- Pagos: método y monto registrados.

select metodo_pago,total_pagado from pagos;

-- Detalle de líneas: producto y cantidad por cada detalle_pedido.

select id_producto,cantidad from detalle_pedido;  

-- Clientes con fecha de registro (orden natural de inserción).

select nombre, fecha_registro from clientes; 
-- aqui solo ejecutamos por elmomento pero en un futuro tendremos que pensar a quien le vamos a dar la informacion para darle unos datos o otrospor ejemplo si nos
-- lo pide elde marketing porque quiere contactar con ellos pues le daremos el email  y lafecha perosi nos lo pide un informatico podriamos darle alomejor el id de cliente

-- Productos con su categoría asociada (solo columnas principales).

select nombre, categoria from productos;

-- IDs de pedidos y su total.

select id_pedido, coste_total from pedidos;

-- IDs de pagos con su fecha de pago.

select id_pago, fecha_pago from pagos;

-- Relación básica: id_pedido e id_producto de detalle_pedido.

select id_pedido, id_producto from detalle_pedido;

-- ## 2) Filtros con WHERE (comparadores, lógicos, BETWEEN, IN, LIKE, NULL)

-- Clientes registrados en 2024.

select * from clientes where year(fecha_registro) = 2024;


-- Productos con precio > 200.

select * from productos where precio > 200;

-- Pedidos con estado = 'pendiente' y total > 500.

select * from pedidos where estado = "pendiente" and coste_total > 500;

-- Pagos cuyo método IN ('tarjeta','paypal').

-- select * from pagos where metodo_pago = "tarjeta" or metodo_pago = "Paypal"; solucion rudimentaria
select * from pagos where metodo_pago in ("tarjeta","paypal"); -- mejor solucion
-- Productos con stock entre 300 y 400.

select * from productos where stock between 300 and 400;

-- Clientes de país IN ('España','México','Argentina').

select * from clientes where pais in ("españa", "argentina", "mexico");

-- Productos cuyo nombre contenga Silla.

select * from productos where nombre like "%silla%" or descripcion like "%silla%";

-- Pedidos con fecha_pedido en abril de 2023.

-- select * from pedidos where month(fecha_pedido) = 04 and year(fecha_pedido) = 2023;

select * from pedidos where fecha_pedido like "2023-04%"; -- aprender esta mejor

-- Pagos con fecha_pago IS NULL (simularía no pagados si existieran).

select * from pagos where fecha_pago is null;

-- Detalles donde cantidad sea 3 o más pero el precio_unitario menor que 50.

select * from detalle_pedido where cantidad>=3 and precio_unitario <=50;

-- 


-- ## 3) Ordenación, límite y duplicados (ORDER BY, LIMIT, DISTINCT)

-- Top 10 productos más caros.
-- Últimos 20 pedidos por fecha_pedido DESC.
-- Clientes más recientes por fecha_registro.
-- Primeros 5 productos con menor stock.
-- DISTINCT de categorías de productos disponibles.
-- Países distintos de los clientes registrados.
-- Pagos ordenados por monto DESC (mayor a menor).
-- Pedidos ordenados por total ASC.
-- Primeros 10 clientes por orden alfabético del nombre.
-- Top 5 productos más baratos en la categoría “Accesorios”.


