{{ config(
    materialized = "view"
)}}

select 
    order_id,
    customer_id,
    product_name,
    category,
    quantity,
    price,
    quantity * price as total_amount
from {{ source('demo_dag_sources', 'orders')}}