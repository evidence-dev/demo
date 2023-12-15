select 
nps_score,
item
from reviews
left join orders on orders.id=reviews.order_id

order by item