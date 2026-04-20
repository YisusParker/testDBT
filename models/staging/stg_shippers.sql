{{config(materialized='table')}}


SELECT
    id as id_transporte,
    name as nombre_transporte,
    phone as telefono_transporte
FROM  {{ source('bigquery_source','shippers')}}