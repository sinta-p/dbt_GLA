{% macro get_dynamic_lookback() %}
  {% if execute %}
    {% set query %}
      select datediff(day, max(process_timestamp), current_date) + 1 as lookback_day
      from {{this}}
    {% endset %}
    {% set results = run_query(query) %}
    {{ return(results.columns[0].values()[0]) }}
  {% else %}
    {{ return(1) }}
  {% endif %}
{% endmacro %}
