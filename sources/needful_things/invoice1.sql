select
partner,
item,
sum(quantity) as num_units_num0,
sum(sales) as cost

from partners
where date_trunc('MONTH', order_datetime)='2021-12-01'
group by 1,2 order by 1,4 desc