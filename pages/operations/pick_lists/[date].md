# Pick List for {fmt(params.date, "mmmm yyyy")}

```pick_list
select 
    *,
    strftime('%Y-%m-%d', order_day) as yyyy_mm_dd
 from needful_things.pick_list
```
<!--only show list if at least 1 order-->
{#if ((pick_list.filter(d => d.yyyy_mm_dd == params.date)).length > 0) }
    
    The following orders need to be picked and dispatched to customers:

    <DataTable 
        data={pick_list.filter(d => d.yyyy_mm_dd == params.date)}
        rowNumbers=false
        rows=all
    />


{:else}
    
    There are no new orders to pick for {params.date}.
    
    Time to take a break? ☕️

{/if}






