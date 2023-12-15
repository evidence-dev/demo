select
partner,
sum(sales) as sales_usd1m
from partners
group by 1
order by 2 desc