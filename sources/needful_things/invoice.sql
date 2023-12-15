select
date_trunc(month, order_datetime)::date as date,
partner,
item,
sum(quantity) as num_units_num0,
sum(sales) as cost

from partners
group by 1,2,3 order by 2,5 desc