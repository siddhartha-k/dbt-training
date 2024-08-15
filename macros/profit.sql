{% macro profit() %}
case when ordercostprice = 0 then null else (ordersellingprice - ordercostprice) / ordercostprice end 
{% endmacro %}