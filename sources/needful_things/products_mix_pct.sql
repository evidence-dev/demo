select 
DATE_TRUNC('MONTH',order_datetime) as month,
category,
sum(sales) / sum(sum(sales)) over (partition by DATE_TRUNC('MONTH',order_datetime)) as sales_pct

from orders
where order_datetime >= '2021-01-01' 

group by 1,2
order by 1