WITH shippers AS (
    SELECT
        id_transporte,
        nombre_transporte,
        telefono_transporte
    
    FROM {{ ref('int_orders_shippers')}}
)

SELECT 
    id_transporte,
    nombre_transporte,
    telefono_transporte,
    COUNT(id_transporte) AS cantidad_pedidos

FROM shippers
GROUP BY 1, 2, 3
ORDER BY cantidad_pedidos DESC
