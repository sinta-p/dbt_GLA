{% macro get_begin_date(days_back=5) %}
    {% set begin_date = (modules.datetime.date.today() - modules.datetime.timedelta(days=days_back)).strftime('%Y-%m-%d 00:00:00') %}
    {{ return(begin_date) }}
{% endmacro %}
