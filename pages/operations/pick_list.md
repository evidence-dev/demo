# Pick List

```pick_list
select 
strftime('%Y-%m-%d',order_datetime) as order_date_short,
item,
email,
address,
state
from orders

where order_datetime >='2021-12-25'

order by order_datetime

```

The following orders need to be picked and dispatched to customers.

<DataTable 
data={data.pick_list}
rowNumbers=false
rows=50
/>

