# Diagrama de relaciones

```mermaid
erDiagram
    CLIENTES ||--o{ VENTAS : realiza
    VENTAS ||--|{ DETALLE_VENTAS : contiene
    PRODUCTOS ||--o{ DETALLE_VENTAS : aparece_en

    CLIENTES {
        bigint cliente_id PK
        varchar nombre
        varchar email UK
        varchar ciudad
        date fecha_registro
        boolean activo
    }

    PRODUCTOS {
        bigint producto_id PK
        varchar nombre
        varchar categoria
        numeric precio
        integer stock
        boolean activo
    }

    VENTAS {
        bigint venta_id PK
        bigint cliente_id FK
        date fecha_venta
        varchar estado
    }

    DETALLE_VENTAS {
        bigint venta_id PK, FK
        bigint producto_id PK, FK
        integer cantidad
        numeric precio_unitario
        numeric descuento
    }
```

## Lectura rápida

```text
CLIENTES (1) ────────< VENTAS (1) ────────< DETALLE_VENTAS >──────── (1) PRODUCTOS
                         cliente_id              venta_id
                                                  producto_id
```

`DETALLE_VENTAS` funciona como tabla de relación entre `VENTAS` y
`PRODUCTOS`. Su clave primaria compuesta identifica de forma única cada
producto dentro de una venta.