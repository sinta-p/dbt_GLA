{% macro test_get_lookback() %}
    {% set result = get_dynamic_lookback() %}
    {{ log("Lookback value: " ~ result, info=true) }}
{% endmacro %}
