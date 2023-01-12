# Pick List for {$page.params.date}

```pick_list
select 
order_datetime::date as order_day,
item,
email,
address,
state

from orders

order by order_datetime
```
<!--only show list if at least 1 order-->
{#if ((data.pick_list.filter(d => d.order_day === $page.params.date)).length > 0) }
    
    The following orders need to be picked and dispatched to customers:

    <DataTable 
        data={data.pick_list.filter(d => d.order_day === $page.params.date)}
        rowNumbers=false
        rows=50
    />


{:else}
    

    There are no new orders to pick for {$page.params.date}.
    
    Time to take a break? ☕️

{/if}






