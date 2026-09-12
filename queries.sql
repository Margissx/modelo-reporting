-- Consultas de reporting para NovaMarket.

SET search_path TO reporting, public;

-- 1. Ventas totales completadas.
SELECT
    ROUND(SUM(total_linea), 2) AS ventas_totales
FROM reporte_ventas
WHERE estado = 'completada';

-- 2. Ventas por cliente, incluyendo clientes sin compras completadas.
SELECT
    c.cliente_id,
    c.nombre AS cliente,
    c.ciudad,
    COUNT(DISTINCT rv.venta_id) AS cantidad_ventas,
    COALESCE(ROUND(SUM(rv.total_linea), 2), 0.00) AS total_comprado
FROM clientes AS c
LEFT JOIN reporte_ventas AS rv
    ON rv.cliente_id = c.cliente_id
   AND rv.estado = 'completada'
GROUP BY c.cliente_id, c.nombre, c.ciudad
ORDER BY total_comprado DESC, c.nombre;

-- 3. Ventas por producto.
SELECT
    producto_id,
    producto,
    categoria,
    SUM(cantidad) AS unidades_vendidas,
    ROUND(SUM(total_linea), 2) AS ingresos
FROM reporte_ventas
WHERE estado = 'completada'
GROUP BY producto_id, producto, categoria
ORDER BY ingresos DESC, unidades_vendidas DESC;

-- 4. Productos más vendidos por unidades.
SELECT
    producto_id,
    producto,
    SUM(cantidad) AS unidades_vendidas,
    DENSE_RANK() OVER (ORDER BY SUM(cantidad) DESC) AS posicion
FROM reporte_ventas
WHERE estado = 'completada'
GROUP BY producto_id, producto
ORDER BY posicion, producto;

-- 5. Resumen mensual de ventas completadas.
SELECT
    DATE_TRUNC('month', fecha_venta)::DATE AS mes,
    COUNT(DISTINCT venta_id) AS cantidad_ventas,
    ROUND(SUM(total_linea), 2) AS ingresos
FROM reporte_ventas
WHERE estado = 'completada'
GROUP BY DATE_TRUNC('month', fecha_venta)::DATE
ORDER BY mes;

-- 6. Ticket promedio por venta completada.
WITH totales_por_venta AS (
    SELECT
        venta_id,
        SUM(total_linea) AS total_venta
    FROM reporte_ventas
    WHERE estado = 'completada'
    GROUP BY venta_id
)
SELECT
    COUNT(*) AS ventas_completadas,
    ROUND(AVG(total_venta), 2) AS ticket_promedio
FROM totales_por_venta;