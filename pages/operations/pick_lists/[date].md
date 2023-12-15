# Pick List for {fmt(params.date,"ddd dd mmm, yyyy") }

```pick_list
select * from needful_things.pick_list
```
<!--only show list if at least 1 order-->
{#if ((pick_list.filter(d => d.order_day == params.date)).length > 0) }
    
    The following orders need to be picked and dispatched to customers:

    <DataTable 
        data={pick_list.filter(d => d.order_day == params.date)}
        rowNumbers=false
        rows=all
    />


{:else}
    
    There are no new orders to pick for {params.date}.
    
    Time to take a break? ☕️

{/if}






