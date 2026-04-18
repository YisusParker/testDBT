WITH customers AS (
    SELECT
        id_cliente,
        nombre,
        contacto,
        direccion,
        ciudad,
        codigo_postal,
        pais

    FROM {{ ref('stg_customers') }}
),

eu_list AS (
    SELECT
        Country_name AS nombre
    FROM {{ ref('countriesEU')}}
)

SELECT
    c.id_cliente,
    c.nombre,
    c.contacto,
    c.direccion,
    c.ciudad,
    c.codigo_postal,
    c.pais,
    CASE WHEN e.nombre IS NOT NULL THEN '{{ var('eu_member') }}' ELSE 'otro' END AS estado

FROM customers c
LEFT JOIN eu_list e
    ON c.pais = e.nombre