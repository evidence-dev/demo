select 
category, 
round(avg(case 
when nps_score > 8 then 100
when nps_score <7 then -100
else 0 end),0) as nps_avg,
round(sum(sales),3) as sales_usd

from reviews
left join orders on orders.id=reviews.order_id

group by category
order by nps_avg