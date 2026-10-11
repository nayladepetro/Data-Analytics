USE Ventas_Tech_DB;
--Consulta 1 resumen ejecutivo mensual 

SELECT
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unutario) AS Total_Facturado,
COUNT (*) AS Cantidad_Pedidos,
AVG(cantidad * precio_unutario) AS Ticket_promedio 
FROM Ventas
GROUP BY MONTH(fecha_venta);

--Consulta 2 RANKING DE PRODUCTOS

SELECT TOP 5
id_producto,
SUM(cantidad) AS Unidades_vendidas,
SUM	(Cantidad * precio_unutario) AS Total_factuado
FROM Ventas
group by id_producto
ORDER BY Total_factuado DESC;

--	Consulta 3 CLIENTES RECURRENTES

Select 
id_cliente,
COUNT (*) AS Cantidad_Pedidos,
SUM(cantidad * precio_unutario) AS Total_gastado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT(*) >1;

-- CONSULTA 4 MESES POR DEBAJO/EMCOMA DEL PROMEDIO
SELECT 
MONTH(fecha_venta) AS Mes,
SUM(cantidad * precio_unutario) AS Total_facturado,
CASE
WHEN SUM(cantidad * precio_unutario) > 
( 
SELECT AVG(Total_mensual)
FROM(
SELECT SUM(cantidad * precio_unutario) AS total_mensual
FROM ventas
GROUP BY MONTH(fecha_Venta)
) AS totales_mensuales
)
THEN 'Por encima'
ELSE 'Por debajo'
END AS Comparacion_Promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

--HALLAZGOS
-- 1. En marzo se registraron 10 pedidos, con una facturación total de $6.444 y un ticket promedio de $644,4
--2. El producto 1 fue el que generó la mayor facturación, con un total de $3.600 y 3 unidades vendidas.
--3. Todos los clientes realizaron más de un pedido. El cliente 1 fue el de mayor gasto, con un total de $2.640