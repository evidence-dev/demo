# Pick Lists

Pick lists for a specific day can be accessed at /operations/pick-lists/yyyy-mm-dd/

For example, for 20th Jan 2021, the link is: [/operations/pick_lists/2021-01-20/](/operations/pick_lists/2021-01-20/)

## Recent Lists:
The last 7 days pick lists are below:

```last_7_days_orders
select 
    *,
    strftime('%Y-%m-%d', order_date) as yyyy_mm_dd
from needful_things.last_7_days_orders
```

{#each last_7_days_orders as day}

    - [<Value data={day} fmt="dd mmm yyyy"/>](/operations/pick_lists/{day.yyyy_mm_dd}/)

{/each}

<style>
    ul{
        margin-block-end: 0;
    }
</style>



