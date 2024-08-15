{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
    )
}}

select
--from raw_orders
{{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as hash_key,
o.orderid,
o.orderdate,
o.shipdate,
o.shipmode,
o.customerid,
o.productid,
o.ordersellingprice,
o.ordercostprice,
--from raw_customer
c.customername,
c.segment,
c.country,
--from raw_product
p.category,
p.productname,
p.subcategory,
o.ordersellingprice - o.ordercostprice as orderprofit,
{{ profit() }} as profit
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customers') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} as p
on o.productid = p.productid