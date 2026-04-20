{{ config(severity='error') }}
-- Test fails if eu_discount has unexpected discount values.
SELECT *
FROM {{ ref('eu_discount') }}
WHERE descuento NOT IN ({{ var('discount') }}, 1)
