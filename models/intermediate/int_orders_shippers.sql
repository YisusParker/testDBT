WITH orders AS (
    SELECT
        id_pedido,
        fk_cliente,
        fecha_pedido,
        fk_transporte,
    FROM {{ ref('stg_orders') }}
),
shippers AS (
    SELECT
        id_transporte,
        nombre_transporte,
        telefono_transporte
    FROM {{ ref('stg_shippers') }}
)

SELECT
    s.id_transporte,
    o.id_pedido,
    o.fk_cliente,
    o.fecha_pedido,
    s.nombre_transporte,
    s.telefono_transporte

FROM orders o
    JOIN shippers s
    ON o.fk_transporte = s.id_transporte