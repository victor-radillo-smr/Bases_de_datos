-- Relacionar cada pedido con el producto

SELECT productos.nombre, productos.id_producto,
detalle_pedido.id_pedido, detalle_pedido.id_producto, detalle_pedido.cantidad 
FROM productos, detalle_pedido
WHERE  detalle_pedido.id_producto = productos.id_producto;

-- ids de producto pedidos por  Ana torres

SELECT c.id_cliente, c.nombre,
dp.id_producto
FROM clientes AS c, detalle_pedido AS dp, pedidos AS p
WHERE c.id_cliente = p.id_cliente AND dp.id_pedido = p.id_pedido;

-- Sacar cuantos productos ha sacado cada cliente.

SELECT c.id_cliente, c.nombre,
dp.id_producto, dp.cantidad
FROM clientes AS c, detalle_pedido AS dp, pedidos AS p
WHERE c.id_cliente = p.id_cliente AND dp.id_pedido = p.id_pedido;

-- Fechas en las que se ha pedido cada producto identificado por e lnombre de producto.

SELECT pr.nombre, p.fecha_pedido
FROM productos AS pr, detalle_pedido AS dp, pedidos AS p
WHERE p.id_pedido = dp.id_pedido AND pr.id_producto = dp.id_producto;

-- version optima.

SELECT pr.nombre, pr.id_producto, pe.fecha_pedido
FROM pedidos
JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
JOIN productos pr ON dp.id_producto = pr.id_producto;

-- version optima 2

SELECT  pr.nombre, pr.id_producto ,pe.fecha_pedido
FROM pedidos pe 
JOIN detalle_pedido dp USING(id_pedido) -- solo si la columna se llama igual en las 2 tablas.
JOIN productos pr USING(id_producto);

    
-- Saca el listado de productos (nombre e id) y el nombre de los clientes que los han compardo.

-- saca el nombre de los productos que se encuentren en un estado de pedido cancelado.

-- ¿cuantos clientes han hecho algun pedido de cada categoria?.

-- 