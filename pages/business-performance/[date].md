<script>
    const todaysKPIs = daily_KPIs.filter(d => d.order_date === $page.params.date)[0];

    var addDays = function(str, days) {
    var myDate = new Date(str);
    myDate.setDate(myDate.getDate() + parseInt(days));
    return myDate.toISOString().split('T')[0];
    }
</script>



# KPIs for {$page.params.date}

## Daily KPIs

```daily_KPIs
select 
order_datetime::date as order_date,
count(*) as orders,
round(sum(sales),0) as sales_usd,
round(sum(sales) / count(*),2) as aov_usd2

from orders

group by order_date
```

{#if todaysKPIs }
    
    <BigValue
        data={todaysKPIs}
        value="sales_usd"/>
    <BigValue
        data={todaysKPIs}
        value="orders"/>
    <BigValue
        data={todaysKPIs}
        value="aov_usd2"/>



<span class="flex justify-between mt-6">
    <BigLink href="/business-performance/{addDays($page.params.date,-1)}">← Prev Day</BigLink>
    <BigLink href="/business-performance/{addDays($page.params.date,1)}">Next Day →</BigLink>
</span>

{:else if $page.params.date.substring(0,4) == '2019' || $page.params.date.substring(0,4) == '2020' || $page.params.date.substring(0,4) == '2021'}
    
    There were no sales this day.
<br>
<br>
<div style="line-height:240%;">
    <br>
</div>


<span class="flex justify-between">
    <BigLink href="/business-performance/{addDays($page.params.date,-1)}">← Prev Day</BigLink>
    <BigLink href="/business-performance/{addDays($page.params.date,1)}">Next Day →</BigLink>
</span>


{:else}
    
    This is not a date in the Needful Things sales range. 
    
    Please select a date between 2019-01-01 and 2021-12-31.

{/if}



