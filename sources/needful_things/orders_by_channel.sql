select 
channel,
date_trunc("MONTH", order_datetime) as order_month_date,
channel_month,
count(*) as orders

from orders

where order_datetime >= '2021-01-01'

group by channel, order_month_date, 3
order by order_month_date desc, orders desc