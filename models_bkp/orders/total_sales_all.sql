{{ dynamic_total_sales (
    source_relation = ref('orders_model'),
    amount_column = 'order_amount'
)}}