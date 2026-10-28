
# CLIENTES
## 1) Número total de clientes

SELECT COUNT(*) AS numero_clientes FROM clientes;

## 2) Número de clientes por país

-- SELECT pais

## 3) Número de clientes registrados por año

SELECT YEAR(fecha_registro), COUNT(id_cliente) AS clientes_año FROM clientes GROUP BY YEAR(fecha_registro);

## 4) Número de clientes registrados por mes (todas las fechas)

SELECT MONTH(fecha_registro), COUNT(id_cliente) AS clientes_mes FROM clientes GROUP BY MONTH(fecha_registro);

SELECT MONTH(fecha_registro) AS clientes_mes,  YEAR(fecha_registro) AS clientes_año FROM clientes GROUP BY MONTH(fecha_registro),  YEAR(fecha_registro);

## 5) Fecha de primer y último cliente registrado

SELECT MIN(fecha_registro) AS primer_registro, MAX(fecha_registro) AS  ultimo_registro FROM clientes;

## 6) Número de países distintos con clientes

SELECT COUNT(DISTINCT pais) AS paises_distintos FROM clientes;

## 7) Conteo de clientes con email y sin email

SELECT  REPLACE(RIGHT(email , 3), "com", "si") AS tiene_email ,COUNT(email) AS cantidad  FROM clientes GROUP BY REPLACE(RIGHT(email , 3), "com", "si");

## 8) Distribución de clientes por primera letra del nombre

SELECT LEFT(nombre , 1), COUNT(*) FROM clientes GROUP BY LEFT(nombre , 1) ORDER BY LEFT(nombre , 1);

# PRODUCTOS
## 9) Número total de productos

SELECT COUNT(DISTINCT nombre) AS cantidad_productos FROM productos; 

## 10) Número de productos por categoría

SELECT categoria,  COUNT(DISTINCT nombre) AS cantidad FROM productos group by categoria;

## 11) Precio promedio de productos

SELECT ROUND(AVG(precio)) AS precio_medio_productos FROM productos; 

## 12) Precio mínimo y máximo de productos

SELECT MIN(precio) AS precio_minimo, MAX(precio) AS precio_maximo FROM productos;

## 13) Stock total de productos

SELECT SUM(STOCK) AS cantidad_productos FROM productos;

## 14) Stock total por categoría

SELECT categoria,  sum(stock) AS stock_acumulado FROM productos GROUP BY categoria;

## 15) Valor de inventario total (stock * precio)

SELECT ROUND(SUM(stock * precio)) AS valor_total_producto FROM productos;

## 16) Valor de inventario por categoría

SELECT categoria, ROUND(stock * precio) AS inventario_por_categoria FROM productos GROUP BY categoria;

# PEDIDOS
## 18) Número total de pedidos
SELECT * FROM pedidos;
SELECT COUNT(*) FROM pedidos;

## 19) Número de pedidos por estado

SELECT estado ,COUNT(estado) FROM pedidos GROUP BY estado;

## 20) Total facturado (suma de la columna total)

SELECT SUM(coste_total) AS total_facturado FROM pedidos;

## 21) Promedio del total de pedidos

SELECT AVG(coste_total) AS promedio FROM pedidos;

## 22) Pedido de mayor y menor importe

SELECT MAX(coste_total) AS pedido_maximo, MIN(coste_total) AS pedido_minimo FROM pedidos;

## 23) Número de pedidos por año

SELECT YEAR(fecha_pedido) AS año, COUNT(id_pedido) AS pedidos FROM pedidos GROUP BY YEAR(fecha_pedido);

## 24) Total facturado por año

SELECT YEAR(fecha_pedido) AS año, SUM(coste_total) AS facturado_año FROM pedidos GROUP BY YEAR(fecha_pedido);

## 25) Número de pedidos por mes de todos los años

SELECT MONTH(fecha_pedido) AS mes,
 COUNT(MONTH(fecha_pedido)) AS pedidos_al_mes,
 YEAR(fecha_pedido) AS año FROM pedidos
 GROUP BY MONTH(fecha_pedido)
 ORDER BY MONTH(fecha_pedido);

## 26) Total facturado por estado

SELECT SUM(coste_total), 
estado
FROM pedidos
GROUP BY estado;

## 27) Promedio del total por estado

SELECT AVG(coste_total) AS media,
estado
FROM pedidos
GROUP BY estado;

# DETALLE_PEDIDO
## 29) Número de líneas de detalle registradas

SELECT COUNT(id_detalle) AS lineas_detalle
FROM detalle_pedido;

## 30) Total de unidades vendidas (suma de cantidad)

SELECT SUM(cantidad) AS cantidad_producto_vendido
FROM detalle_pedido;


## 31) Precio promedio de las líneas de detalle

SELECT TRUNCATE(AVG(precio_unitario), 2) AS media_precio_unitario
FROM detalle_pedido;

## 32) Cantidad promedio por línea

SELECT id_producto, 
TRUNCATE(AVG(cantidad), 2) AS cantidad_promedio
FROM detalle_pedido
GROUP BY id_producto;


## 33) Número de líneas por producto

-- no entiendo

## 34) Unidades totales por producto
## 35) Ingreso total por producto (cantidad * precio_unitario)

# Otros ejemplos

## 1) ¿Cuántos clientes se han registrado por año y mes?
## 2) ¿Cuántos clientes españoles se han registrado por año y mes?
## 3) Ordenas las consultas anteriores
## 4) Precio promedio agrupando por categoría e inicial del nombre con más de 3 unidades de stock
## 5) ¿Cuántos clientes cuyo nombre empieza por 'A' se han registrado cada año?
## 6) ¿Cuántos productos se han pedido en cada pedido?
## 7) Obtén el listado de los pedidos que han solicitado más de 10 productos

