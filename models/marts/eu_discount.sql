WITH customers AS (
    SELECT
        id_cliente,
        nombre,
        contacto,
        direccion,
        ciudad,
        codigo_postal,
        pais,
        estado
        
    FROM {{ ref('int_customers_in_eu') }}
)

SELECT
    c.id_cliente,
    c.nombre,
    c.contacto,
    c.direccion,
    c.ciudad,
    c.codigo_postal,
    c.pais,
    {{ add_discount('c.estado') }} AS descuento
    

FROM customers c


