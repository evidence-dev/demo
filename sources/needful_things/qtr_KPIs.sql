select 
date_part('YEAR', order_datetime) || '-Q' || date_part('QUARTER', order_datetime) as order_quarter,
count(*) as orders,
round(sum(sales),0) as sales,
sum(sales) / count(*) as aov,
(sum(sales))/ (lag(sum(sales) , 1) over (order by order_quarter)) -1 as qtr_sales_chg,
1.0*(count(*))/ (lag(count(*) , 1) over (order by order_quarter)) -1 as qtr_orders_chg,
(sum(sales)/count(*))/ (lag(sum(sales)/count(*) , 1) over (order by order_quarter)) -1 as qtr_aov_chg

from orders


group by order_quarter
order by order_quarter