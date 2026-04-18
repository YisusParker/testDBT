{% macro assign_status(sales) %}
    CASE WHEN CAST({{ sales }} AS NUMERIC) > {{ var('recog_threshold')}} THEN 'recognized' ELSE 'normal' END
{% endmacro %}
