<script>
    const todaysKPIs = daily_KPIs.filter(d => d.order_date === params.date)[0];

    var addDays = function(str, days) {
    var myDate = new Date(str);
    myDate.setDate(myDate.getDate() + parseInt(days));
    return myDate.toISOString().split('T')[0];
    }
</script>



# KPIs for {params.date}

## Daily KPIs

```daily_KPIs
select * from needful_things.daily_KPIs
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
    <BigLink href="/business-performance/{addDays(params.date,-1)}">← Prev Day</BigLink>
    <BigLink href="/business-performance/{addDays(params.date,1)}">Next Day →</BigLink>
</span>

{:else if params.date.substring(0,4) == '2019' || params.date.substring(0,4) == '2020' || params.date.substring(0,4) == '2021'}
    
    There were no sales this day.
<br>
<br>
<div style="line-height:240%;">
    <br>
</div>


<span class="flex justify-between">
    <BigLink href="/business-performance/{addDays(params.date,-1)}">← Prev Day</BigLink>
    <BigLink href="/business-performance/{addDays(params.date,1)}">Next Day →</BigLink>
</span>


{:else}
    
    This is not a date in the Needful Things sales range. 
    
    Please select a date between 2019-01-01 and 2021-12-31.

{/if}



