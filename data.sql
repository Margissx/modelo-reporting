-- Datos de ejemplo para NovaMarket.

SET search_path TO reporting, public;

INSERT INTO clientes (cliente_id, nombre, email, ciudad, fecha_registro)
VALUES
    (1, 'Ana López', 'ana.lopez@example.com', 'Tegucigalpa', '2025-01-15'),
    (2, 'Carlos Méndez', 'carlos.mendez@example.com', 'San Pedro Sula', '2025-02-03'),
    (3, 'Beatriz Castillo', 'beatriz.castillo@example.com', 'La Ceiba', '2025-02-18'),
    (4, 'Diego Herrera', 'diego.herrera@example.com', 'Comayagua', '2025-03-10'),
    (5, 'Elena Rivas', 'elena.rivas@example.com', 'Tegucigalpa', '2025-03-22');

INSERT INTO productos (producto_id, nombre, categoria, precio, stock)
VALUES
    (1, 'Laptop Pro 14', 'Tecnología', 1250.00, 18),
    (2, 'Monitor 27 pulgadas', 'Tecnología', 340.00, 30),
    (3, 'Teclado mecánico', 'Accesorios', 95.00, 60),
    (4, 'Mouse ergonómico', 'Accesorios', 45.00, 75),
    (5, 'Silla ejecutiva', 'Mobiliario', 280.00, 12),
    (6, 'Escritorio compacto', 'Mobiliario', 410.00, 9);

INSERT INTO ventas (venta_id, cliente_id, fecha_venta, estado)
VALUES
    (1, 1, '2025-04-02', 'completada'),
    (2, 2, '2025-04-04', 'completada'),
    (3, 3, '2025-04-07', 'completada'),
    (4, 1, '2025-04-12', 'completada'),
    (5, 4, '2025-04-15', 'pendiente'),
    (6, 5, '2025-04-18', 'completada'),
    (7, 2, '2025-04-21', 'cancelada'),
    (8, 3, '2025-04-25', 'completada');

INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, precio_unitario, descuento)
VALUES
    (1, 1, 1, 1250.00, 0.00),
    (1, 3, 1, 95.00, 0.00),
    (1, 4, 2, 45.00, 5.00),
    (2, 2, 2, 340.00, 20.00),
    (2, 3, 1, 95.00, 0.00),
    (3, 5, 1, 280.00, 0.00),
    (3, 6, 1, 410.00, 25.00),
    (4, 2, 1, 340.00, 0.00),
    (4, 4, 1, 45.00, 0.00),
    (5, 6, 2, 410.00, 0.00),
    (6, 1, 1, 1250.00, 50.00),
    (6, 5, 1, 280.00, 0.00),
    (7, 3, 3, 95.00, 0.00),
    (8, 2, 1, 340.00, 0.00),
    (8, 4, 2, 45.00, 0.00);

-- Ajusta las secuencias para que los siguientes INSERT automáticos
-- continúen después de los IDs de ejemplo.
SELECT setval(
    pg_get_serial_sequence('reporting.clientes', 'cliente_id'),
    (SELECT MAX(cliente_id) FROM clientes),
    TRUE
);

SELECT setval(
    pg_get_serial_sequence('reporting.productos', 'producto_id'),
    (SELECT MAX(producto_id) FROM productos),
    TRUE
);

SELECT setval(
    pg_get_serial_sequence('reporting.ventas', 'venta_id'),
    (SELECT MAX(venta_id) FROM ventas),
    TRUE
);