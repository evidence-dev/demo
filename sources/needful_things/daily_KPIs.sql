select 
order_datetime::date as order_date,
count(*) as orders,
round(sum(sales),0) as sales_usd,
round(sum(sales) / count(*),2) as aov_usd2

from orders

group by order_date