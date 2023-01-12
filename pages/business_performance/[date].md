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

{#if ((data.daily_KPIs.filter(d => d.order_date === $page.params.date)).length > 0) }
    
    <BigValue
        data={daily_KPIs.filter(d => d.order_date === $page.params.date)}
        value="sales_usd"/>
    <BigValue
        data={daily_KPIs.filter(d => d.order_date === $page.params.date)}
        value="orders"/>
    <BigValue
        data={daily_KPIs.filter(d => d.order_date === $page.params.date)}
        value="aov_usd2"/>

<br>
<br>



<span class="same-line">
    <BigLink href="/business_performance/{addDays($page.params.date,-1)}">← Prev Day</BigLink>
    <BigLink href="/business_performance/{addDays($page.params.date,1)}">Next Day →</BigLink>
</span>

{:else if $page.params.date.substring(0,4) == '2019' || $page.params.date.substring(0,4) == '2020' || $page.params.date.substring(0,4) == '2021'}
    
    There were no sales this day.
<br>
<br>
<div style="line-height:240%;">
    <br>
</div>


<span class="same-line">
    <BigLink href="/business_performance/{addDays($page.params.date,-1)}">← Prev Day</BigLink>
    <BigLink href="/business_performance/{addDays($page.params.date,1)}">Next Day →</BigLink>
</span>


{:else}
    
    This is not a date in the Needful Things sales range. 
    
    Please select a date between 2019-01-01 and 2021-12-31.

{/if}


<style>
    table {
        width: 100%;
        
    }
    th {
        font-size: 32px;
    }

    .same-line {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }
</style>


<script>

var usd_formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',

  // These options are needed to round to whole numbers if that's what you want.
  // minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
  maximumFractionDigits: 2, // (causes 2500.99 to be printed as $2,501)
});

var pct_formatter = new Intl.NumberFormat('en-US', {
  style: 'percent',
  // These options are needed to round to whole numbers if that's what you want.
  minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
  maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
});


var addDays = function(str, days) {
  var myDate = new Date(str);
  myDate.setDate(myDate.getDate() + parseInt(days));
  return myDate.toISOString().split('T')[0];
}

</script>