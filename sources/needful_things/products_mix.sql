select 
item,
category,
sum(sales) as sales_usd,
sum(sales)/sum(sum(sales)) over () as sales_pct
from orders

where order_month >= '2021-01-01' 

group by 1,2
order by sales_usd desc