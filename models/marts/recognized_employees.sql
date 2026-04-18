WITH employees AS (
    SELECT
        id_empleado,
        nombre_completo,
        fecha_nacimiento,
        foto,
        notas
    FROM {{ ref('int_orders_employees')}}
)

SELECT
    id_empleado,
    nombre_completo,
    foto,
    COUNT(id_empleado) AS cantidad_ventas,
    {{ assign_status('COUNT(id_empleado)') }} AS estado
    


FROM employees
GROUP BY 1, 2, 3
ORDER BY cantidad_ventas DESC

