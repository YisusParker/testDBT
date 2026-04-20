{% macro full_name(last_name, first_name) %}
    CONCAT({{ last_name }}, ' ', {{ first_name }})
{% endmacro %}
