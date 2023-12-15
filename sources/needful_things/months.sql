select 
DATE_TRUNC('month',order_datetime)::Date as month_monthyear
from partners
group by 1
order by 1 desc