# Modelo de Datos para Reporting

Modelo relacional pequeño para una empresa ficticia llamada **NovaMarket**. El
proyecto muestra cómo organizar ventas comerciales en PostgreSQL para obtener
reportes consistentes mediante claves, restricciones, datos de ejemplo y una
vista reutilizable.

## Objetivo

Construir una base de datos sencilla, clara y extensible que permita responder
preguntas comunes de negocio:

- ¿Cuánto se vendió?
- ¿Qué clientes generan más ingresos?
- ¿Qué productos venden más unidades y dinero?
- ¿Cómo evolucionan las ventas por mes?

## Estructura del proyecto

```text
modelo-reporting/
├── schema.sql    # Esquema, restricciones, índices y vista reporte_ventas
├── data.sql      # Datos de ejemplo de clientes, productos y ventas
├── queries.sql   # Consultas para reporting
├── README.md     # Documentación del modelo
└── diagram.md    # Diagrama de relaciones
```

## Tablas y relaciones

### `clientes`

Catálogo de clientes de NovaMarket. `cliente_id` es la clave primaria y
`email` es único para evitar duplicados.

### `productos`

Catálogo de artículos disponibles. Incluye categoría, precio actual, stock y
estado de actividad.

### `ventas`

Cabecera de cada operación comercial. Tiene una relación muchos-a-uno con
`clientes`: un cliente puede realizar varias ventas. El estado permite
distinguir operaciones completadas, pendientes y canceladas.

### `detalle_ventas`

Líneas de cada venta. Tiene relaciones muchos-a-uno con `ventas` y `productos`.
La clave primaria compuesta (`venta_id`, `producto_id`) evita repetir el mismo
producto dentro de una venta. `precio_unitario` conserva el precio histórico
usado en la operación, aunque el precio del catálogo cambie posteriormente.

## Vista `reporte_ventas`

`reporte_ventas` combina la cabecera de venta, cliente, producto y detalle en
una fila por producto vendido. Calcula `total_linea` considerando cantidad,
precio unitario y descuento. Esto centraliza la lógica y evita repetir joins
en cada reporte.

## Consultas realizadas

`queries.sql` incluye:

1. Ventas totales completadas.
2. Ventas por cliente, con cantidad de ventas y total comprado.
3. Ventas por producto, con unidades e ingresos.
4. Ranking de productos más vendidos por unidades.
5. Resumen mensual de ingresos.
6. Ticket promedio de las ventas completadas.

Las consultas excluyen ventas pendientes y canceladas cuando calculan ingresos
reales.

## Ejecución

Desde una base de datos PostgreSQL vacía o de práctica:

```bash
createdb novamarket_reporting
psql -d novamarket_reporting -f schema.sql
psql -d novamarket_reporting -f data.sql
psql -d novamarket_reporting -f queries.sql
```

El esquema utilizado es `reporting`. Si se usa una herramienta SQL que no
conserve la sesión entre archivos, ejecutar cada archivo con su propio
`SET search_path TO reporting, public;` (ya incluido en los tres scripts).

## Resultado esperado con los datos de ejemplo

El total de ventas completadas es **5,145.00**. El cliente con mayor compra es
**Ana López**, con **1,815.00**. El producto con más unidades vendidas es
**Mouse ergonómico**, con **5 unidades**.

El modelo está diseñado como ejercicio de portafolio: prioriza nombres claros,
integridad referencial, precios históricos en el detalle y consultas que pueden
ser reutilizadas por un dashboard o una herramienta de BI.