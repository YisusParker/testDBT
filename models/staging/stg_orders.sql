{{config(materialized='table')}}


SELECT
    id as id_pedido,
    customer_id as fk_cliente,
    employee_id as fk_empleado,
    date as fecha_pedido,
    shipper_id as fk_transporte
FROM  {{ source('bigquery_source','orders')}}