select 
date_trunc('DAY', order_datetime) as order_date,
count(*) as orders,
sum(sales) as sales_usd,
sum(sales) / count(*) as aov_usd,
(sum(sales))/ (lag(sum(sales) , 1) over (order by order_date)) -1 as daily_sales_chg_pct1,
1.0*(count(*))/ (lag(count(*) , 1) over (order by order_date)) -1 as daily_orders_chg_pct1,
(sum(sales)/count(*))/ (lag(sum(sales)/count(*) , 1) over (order by order_date)) -1 as daily_aov_chg_pct1,
(sum(sales))/ (lag(sum(sales) , 8) over (order by order_date)) -1 as weekly_sales_chg_pct1
from orders
where order_date >= '2021-12-01'
group by 1
order by 1