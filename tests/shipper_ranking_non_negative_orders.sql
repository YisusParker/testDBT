{{ config(severity='warn') }}
-- Test fails if aggregated order count becomes negative (warn: no bloquea el pipeline).
SELECT *
FROM {{ ref('shipper_ranking') }}
WHERE cantidad_pedidos < 0
