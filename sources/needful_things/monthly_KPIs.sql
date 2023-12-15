select 
order_month,
count(*) as orders,
round(sum(sales),0) as sales,
sum(sales) / count(*) as aov,
(sum(sales))/ (lag(sum(sales) , 1) over (order by order_month)) -1 as monthly_sales_chg,
1.0*(count(*))/ (lag(count(*) , 1) over (order by order_month)) -1 as monthly_orders_chg,
(sum(sales)/count(*))/ (lag(sum(sales)/count(*) , 1) over (order by order_month)) -1 as monthly_aov_chg

from orders

where order_month >= '2021-01-01'

group by 1
order by 1