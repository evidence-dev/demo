# Pick Lists

Pick lists for a specific day can be accessed at /operations/pick-lists/yyyy-mm-dd/

For example, for 20th Jan 2021, the link is: [/operations/pick_lists/2021-01-20/](/operations/pick_lists/2021-01-20/)

## Recent Lists:
The last 7 days pick lists are below:

```last_7_days_orders
select 
order_datetime::date as order_date
from orders
group by order_date
order by order_date desc


limit 7
```

{#each data.last_7_days_orders as day}

    - [<Value data={day}/>](/operations/pick_lists/{day.order_date}/)

{/each}





