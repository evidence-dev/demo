select 
order_datetime::date as order_day,
item,
email,
address,
state

from orders

order by order_datetime