select
partner,
item,
sum(sales) as cost,
sum(quantity) as num_units_num0

from partners
group by 1,2 order by 1,4 desc