-- Consulta 1 (1 punto). Muestra las diez líneas de pedido con mayor importe (cantidad por precio_
-- unitario). Incluye identificador de línea, cantidad, precio unitario e importe; desempata por
-- identificador.

SELECT 
    id_pedido,
    cantidad,
    precio_unitario,
    (cantidad * precio_unitario) AS importe
FROM
    detalle_pedido
ORDER BY (cantidad * precio_unitario) DESC
LIMIT 10; 

-- Consulta 2 (1 punto). Muestra el identificador, fecha y año de pago de los quince primeros
-- pagos por identificador. Conserva los pagos sin fecha.

SELECT 
    id_pedido,
    LEFT(fecha_pedido, 11) AS fecha,
    YEAR(fecha_pedido) AS año,
    coste_total AS pagos
FROM
    pedidos
ORDER BY id_pedido
LIMIT 15;

-- Consulta 3 (1 punto). Construye una etiqueta para cada cliente con el formato «nombre
-- <email>». Muestra el identificador y la etiqueta, ordenados por la quinta letra del nombre.

select*from clientes;
SELECT 
    id_cliente, nombre, email
FROM
    clientes
ORDER BY CHAR(nombre, 5);

-- Consulta 4 (1 punto). Suma el coste de los pedidos por número de mes, reuniendo todos los
-- años. Muestra mes e importe, ordenados por mes.

SELECT 
    YEAR(fecha_pedido) AS año,
    MONTH(fecha_pedido) AS mes,
    SUM(coste_total) AS importe
FROM
    pedidos
GROUP BY MONTH(fecha_pedido)
ORDER BY MONTH(fecha_pedido);

-- Consulta 5 (1 punto). Calcula el stock medio por categoría. Redondea la media a dos decimales
-- y ordena por ella de menor a mayor y por categoría.

SELECT 
    ROUND(AVG(stock), 2), categoria
FROM
    productos
GROUP BY categoria
ORDER BY ROUND(AVG(stock), 2) ASC;

-- Consulta 6 (1 punto). Cuenta los pedidos distintos por día del mes y estado, sin distinguir mes
-- ni año. Muestra día, estado y número de pedidos; ordena por día y por número de pedidos
-- descendente.

SELECT 
    DAY(fecha_pedido) AS dia,
    estado,
    COUNT(id_pedido) AS numero_de_pedidos
FROM
    pedidos
GROUP BY DAY(fecha_pedido)
ORDER BY DAY(fecha_pedido) DESC;

-- Consulta 7 (2 puntos). Pista: puedes usar DATEDIFF(). Relaciona cada pedido con su cliente
-- y calcula, por país, el promedio de días entre el registro del cliente y el pedido. Muestra también
-- el número de pedidos y ordena por número de pedidos descendente y país. Redondea el
-- promedio a un decimal.

SELECT*FROM clientes;
SELECT 
    id_cliente,
    nombre,
    ROUND(AVG(DATEDIFF(fecha_registro, fecha_pedido)),
            1),
    COUNT(id_pedidos) AS numero_de_pedidos,
    pais
FROM
    clientes
GROUP BY pais
ORDER BY COUNT(id_pedidos) DESC;

-- Consulta 8 (2 puntos). Pista: puedes usar LEAST(). Por año de pedido, muestra el número de
-- pedidos, la suma de todos sus costes y la suma de los costes limitados a 1000 euros por pedido.
-- Ordena por año.



-- Extra (0.5 puntos) ¿Ha habido algún pago en 29 de febrero? ¿Y algún pedido?

SELECT fecha_pedido 