select 
order_month,
order_datetime,
nps_score as rating,
case 
when nps_score > 8 then 100
when nps_score < 7 then -100
else 0
end as nps,
case 
when nps_score > 8 then 'promotor'
when nps_score < 7 then 'detractor'
else 'neutral'
end as label,
item
from reviews

left join orders on reviews.order_id=orders.id