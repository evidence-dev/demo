select
date_trunc(month, order_datetime)::date as date,
partner,
sum(quantity) as num_units_num0,
sum(sales) as cost

from partners
group by 1,2 order by 2,4 desc