
{{dynamic_total_sales(
    source_relation = ref('stg_orders'),
    amount_column = 'order_amount'
)}}
