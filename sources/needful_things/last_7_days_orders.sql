select 
order_datetime::date as order_date
from orders
group by order_date
order by order_date desc


limit 7