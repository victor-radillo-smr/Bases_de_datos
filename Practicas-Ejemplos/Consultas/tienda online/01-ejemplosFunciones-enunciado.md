USE tienda_online;
## 1. Funciones numéricas
### 1.1. Truncar el precio de cada producto a 1 decimal

SELECT * FROM productos;
-- Selecciona de la tabla precios la columna precio y hace que solo aparezca 1 decimal gracias a TRUNCATE
SELECT precio, TRUNCATE(precio,1) FROM productos;

### 1.2. Redondear hacia abajo (FLOOR) y hacia arriba (CEIL) el precio

/* Selecciona de la tabla productos la columna precio y la ordena  hacia abajo y gracias al AS aparecera el nombre de latabla como parte_entera 
 y despues la vuelve a seleccionar y la ordena hacia arriba y gracias al AS aparecera el nombre de latabla como parte_decimal. */

/* Orden de ejecucion IMPORTANTE!!! 1:SELECT ----> 2:FROM ----> 3:WHERE ----> Ultimo ultimisimo: AS
por mucho que este en una linea anterior al resto siempre se ejecutara AS COMO EL ULTIMO  por loque no puede seleccionar nada que "renombrase" gracias al AS.*/
SELECT precio, FLOOR(precio) AS parte_entera, CEIL(precio) FROM productos AS parte_decimal;

-- Bonnus track quita la parte decimal del precio
-- y filtra para obtener los que tienen un .99

SELECT precio, FLOOR(precio) AS parte_entera, CEIL(precio) AS parte_decimal FROM productos WHERE precio - FLOOR(precio) = 0.99;

### 1.3. Calcular el precio con IVA (21%)

-- SELECT nombre, precio AS precio_sin_IVA

### 1.4. Descuento del 15% aplicado sobre el precio

SELECT nombre, precio, ROUND(precio*0.85,2) AS precio_con_descuento FROM productos;

### 1.5. Desviación estándar y varianza del precio del catálogo

SELECT VARIANCE(precio) AS varianza, STDDEV(precio) AS desv_estandar FROM productos;

/* Preguntar para que me explique la varianza y la desviacion y porque la desviacion esta en funciones de agregacion si es hacer na raiz cuadrada a un unico dato que es la varianza 
   aunque esta este compuesta de relacionar varios campos. */

-- Precio máximo y mínimo

SELECT MAX(precio) AS precio_maximo, MIN(precio) AS precio_minimo FROM productos;

/* Las fuciones de agregacion: trabajan con los valores asignados a una lista o una columna.
   Las funciones de numeracion: trabajan con un unico dato asignado a una celda. 
   Leer 14.6 Numeric Functions and Operators y 14.19.1 Aggregate Function Descriptions del manual de MySQL.*/

### 1.6. Diferencia absoluta frente a un stock objetivo (600 uds.)


SELECT nombre, stock, stock - 600 FROM productos WHERE stock - 600 < 0 ORDER BY stock - 600 ASC;

-- Bonus: Nombre del producto con el máximo del precio

-- Con esta funcion consulto cual es el precio maximo de la columna precio en la tabla productos
SELECT MAX(precio) FROM productos;

-- Y con esta funcion selecciono nombre y precio de la tabla productos  de aquellos productos que tengan el valor máximo en la columna precio
SELECT nombre, precio FROM productos WHERE precio = (SELECT MAX(precio) FROM productos);

-- Ejercicios:
-- 1) Calcula el stock maximo y minimo

SELECT MAX(stock) AS Stock_máximo, MIN(stock) AS Stock_mínimo FROM productos;

-- 2) Es la semana del Black Friday y vamos a sacar un listado de productos de electronica con un descuento del 30% saca el listado  de nombre, precio_antiguo, precio_nuevo, categoria
-- (pista: basta con que muestres sololacategoria "Electronica"

SELECT nombre, precio AS precio_antiguo,precio * 0.70 AS precio_nuevo, categoria FROM productos WHERE categoria = "Electrónica";

-- 3) Hemos recibido 200 unidades de cada tipo de "silla" Saca un listado de nombre, stock_antiguo, stock_nuevo y categoria

SELECT nombre, stock AS stock_antiguo, stock + 200 AS stock_nuevo, categoria FROM productos WHERE nombre LIKE "%_illa%";

## 2. Funciones de cadena
### 2.1. Concatenar categoría y nombre con separador usando `CONCAT_WS`

SELECT CONCAT_WS(" | ", categoria,nombre) AS concatenado FROM productos;

### 2.2. Extraer una subcadena del nombre de cada producto (pos. 4, longitud 5)

SELECT SUBSTRING(nombre, 4, 5) AS nombre FROM productos;

### 2.3. Buscar la posición de una palabra dentro del nombre (por ejemplo 'Pro')

SELECT LOCATE("Pro", nombre) FROM productos;
-- SELECT nombre FROM productos WHERE POSITION("Pro" IN nombre) OR POSITION("Pro" IN descripcion);

### 2.4. Invertir el nombre de cada producto

SELECT REVERSE(nombre) AS nombre_invertido  FROM productos;

### 2.5. Rellenar a la izquierda el id_producto con ceros hasta 5 dígitos

SELECT  RIGHT(CONCAT("00000",id_producto),5) FROM productos;

### 2.6. Enmascarar el nombre de cliente con asteriscos según su longitud

SELECT REPEAT("*", LENGTH(nombre)) AS nombre_codificado FROM clientes;

SELECT nombre, LENGTH(nombre), CHAR_LENGTH(nombre) FROM clientes;
-- LENGTH cuenta las tildes como doble caracter y CHAR_LENGTH no

### 2.7. Reemplazar el símbolo '@' en el email para mostrarlo “ofuscado”

SELECT REPLACE(email,"@" , );

## 3. Funciones de fecha
### 3.1. Obtener la fecha y hora actual (NOW)

-- fecha y hora actuales
SELECT NOW();

-- Sacar dia mesy año de cada pedido
SELECT fecha_pedido, YEAR(fecha_pedido), MONTH(fecha_pedido), DAY(fecha_pedido),DAYNAME(fecha_pedido), DAYOFWEEK(fecha_pedido) FROM pedidos;

### 3.2. Formatear la fecha de pedido como “YYYY-MM”

SELECT*FROM pedidos;

### Para más información, consulta la documentación oficial (https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html#function_date-format)
### 3.3. Extraer el trimestre (QUARTER) de la fecha de pedido

SELECT fecha_pedido,QUARTER(fecha_pedido) FROM pedidos;

### 3.4. Último día del mes de cada pedido

SELECT fecha_pedido, LAST_DAY(fecha_pedido) FROM pedidos;

### 3.5. Diferencia en meses desde el registro de cada cliente hasta hoy

SELECT fecha_registro, TIMESTAMPDIFF(MONTH, fecha_registro, NOW()) FROM clientes;

### 3.6. Semana del año de cada pago (YEARWEEK)

SELECT RIGHT(YEARWEEK(fecha_pedido),2) FROM pedidos;
-- Se hace el right para que solo aparezcan 

### 3.7. Restar 2 horas a la fecha/hora de cada pedido (SUBTIME)
### 3.8. Sumar 10 minutos a la fecha/hora de cada pago (ADDTIME)
