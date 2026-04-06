{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge',
    schema= 'mart'
) }}

WITH source_data AS (
    SELECT
        order_id,
        customer_id,
        product_name,
        product_category,
        quantity,
        price,
        quantity * price AS total_amount,
        to_timestamp(updated_at, 'DD-MM-YYYY HH24:MI') AS updated_at
    FROM {{ source('demo_dag_sources', 'orders_seed') }}
),

filtered_source AS (
    {% if is_incremental() %}
    -- Include rows that are new or updated
    SELECT s.*
    FROM source_data s
    LEFT JOIN {{ this }} f
      ON s.order_id = f.order_id
    WHERE f.order_id IS NULL           -- new row
       OR s.customer_id       <> f.customer_id
       OR s.product_name      <> f.product_name
       OR s.product_category  <> f.product_category
       OR s.quantity          <> f.quantity
       OR s.price             <> f.price
       OR s.total_amount      <> f.total_amount
       OR s.updated_at        <> f.updated_at
    {% else %}
    SELECT * FROM source_data
    {% endif %}
)

SELECT *
FROM filtered_source