select
date_trunc('MONTH', order_datetime) as month,
partner,
sum(sales) as cost,
sum(quantity) as num_units

from partners
group by 1,2 order by 2,1