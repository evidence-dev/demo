# Unsatisfied Customers


```unsatisfied_customers
select 
order_datetime::date as order_date_clean, first_name, last_name, email, nps_score
from reviews
left join orders on orders.id=reviews.order_id

where nps_score <7
and order_datetime > '2021-10-01'

order by order_datetime desc
``` 

Below are customers who had a poor experience that we need to follow up with:


<DataTable data={unsatisfied_customers} rows=50 />
