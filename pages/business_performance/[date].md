# KPIs for {$page.params.date}

## Daily KPIs

```daily_KPIs
select 
strftime('%Y-%m-%d',order_datetime) as order_date,
count(*) as orders,
round(sum(sales),0) as sales_usd,
round(sum(sales) / count(*),2) as aov_usd

from orders

group by order_date
```

{#if ((data.daily_KPIs.filter(d => d.order_date === $page.params.date)).length > 0) }
    
    |{usd_formatter.format(data.daily_KPIs.filter(d => d.order_date === $page.params.date)[0].sales_usd)}|{data.daily_KPIs.filter(d => d.order_date === $page.params.date)[0].orders}|{usd_formatter.format(data.daily_KPIs.filter(d => d.order_date === $page.params.date)[0].aov_usd)}|
    |::|::|::|
    | *Sales* | *Orders* | *AOV* |

{:else}
    

    There are no sales for this date - did you enter it correctly?

{/if}


<br>
<br>

|||
|::|::|
|[← Prev Day](/business_performance/{addDays($page.params.date,-1)})|[Next Day →](/business_performance/{addDays($page.params.date,1)})|


<style>
    table {
        width: 100%;
        
    }
    th {
        font-size: 32px;
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