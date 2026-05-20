-- -- failed initial config 
{#
{{ config(
    materialized='incremental',
    incremental_strategy='microbatch',
    event_time='process_timestamp',
    begin='2026-04-01 00:00:00',
    batch_size='day',
    lookback=get_dynamic_lookback(),
    full_refresh=false
) }}
#}

-- alternative orchestrator config 
-- use dbt run --vars '{"lookback": x}'

{{ config(
    materialized='incremental',
    incremental_strategy='microbatch',
    event_time='process_timestamp',
    begin='2026-04-01 00:00:00',
    batch_size='day',
    lookback=var('dynamic_lookback',3),
    full_refresh=false
) }}


select
    order_id,
    order_number,
    customer_id,
    order_timestamp,
    process_timestamp
from {{ source('raw_data', 's_orders') }}

-- note this doesnt work as dbt Jinja-renders your model twice: once when the model is being parsed (extract dependencies, resolve configs), and again when the model is being executed.
-- since lookback belongs to config, it will get defaulted instead of running the actual sql execution
-- seems like right now the only is to set the logic in the orchestrator side of things. 
