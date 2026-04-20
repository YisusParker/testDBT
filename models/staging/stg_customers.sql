{{config(materialized='table')}}


SELECT
    id as id_cliente,
    name as nombre,
    contact as contacto,
    address as direccion,
    city as ciudad,
    postal_code as codigo_postal,
    country as pais

FROM  {{ source('bigquery_source','customers')}}
