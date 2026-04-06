{% macro dynamic_total_sales(source_relation, amount_column, where_clause=None) %}
	select sum({{ amount_column }}) as total_sales
	from {{ source_relation }}
	{% if where_clause is not none %}
	where {{ where_clause }}
	{% endif %}
{% endmacro %}