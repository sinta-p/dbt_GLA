{{ config(
    materialized='metric_view'
) }}

version: 1.1
source: {{ ref('fct_orders_microbatch') }}
filter: order_timestamp >= DATE'2026-04-02'

fields:
  - name: order_number
    expr: order_number
  - name: country
    expr: country
  - name: customer_id
    expr: customer_id

measures:
  - name: total_revenue
    expr: SUM(transaction_amt)
  - name: customer_count
    expr: COUNT(DISTINCT customer_id)
