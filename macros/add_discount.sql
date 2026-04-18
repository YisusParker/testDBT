{% macro add_discount(estado) %}
    CASE WHEN estado = '{{ var('eu_member') }}' THEN {{ var('discount') }} ELSE 1 END
{% endmacro %}
