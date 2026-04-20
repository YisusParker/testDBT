WITH orders AS (
    SELECT
        id_pedido,
        fk_cliente,
        fk_empleado,
        fecha_pedido,
        fk_transporte
    FROM {{ ref('stg_orders') }}
),
employees AS (
    SELECT
        id_empleado,
        {{ full_name('apellido','nombre') }} AS nombre_completo,
        fecha_nacimiento,
        foto,
        notas

    FROM {{ ref('stg_employees') }}
)

SELECT
    e.id_empleado,
    o.id_pedido,
    o.fk_cliente,
    o.fecha_pedido,
    e.nombre_completo,
    e.fecha_nacimiento,
    e.foto,
    e.notas

FROM orders o
    JOIN employees e
    ON o.fk_empleado = e.id_empleado