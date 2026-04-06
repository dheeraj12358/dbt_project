{{ config(
    materialized = "view"
)}}

SELECT 
    customer_id,
    customer_name,
    country as country
FROM {{ source('demo_dag_sources', 'customers') }}