{{config(materialized='table')}}


SELECT
    employee_id as id_empleado,
    last_name as apellido,
    first_name as nombre,
    birthdate as fecha_nacimiento,
    photo as foto,
    notes as notas
FROM  {{ source('bigquery_source','employees')}}