
{{ config(
    materialized='incremental',
    incremental_strategy='microbatch',
    event_time='process_timestamp',
    begin=get_begin_date(),
    batch_size='day',
    lookback=var('dynamic_lookback',2),
    full_refresh=false
) }}


select
    order_id,
    order_number,
    customer_id,
    order_timestamp,
    process_timestamp
from {{ source('raw_data', 's_orders') }}

-- 2 scenarios for pass 
-- first: making sure that it works on first load (PASS)
-- second: making sure that it works if backfill is happening midway  (PASS)
