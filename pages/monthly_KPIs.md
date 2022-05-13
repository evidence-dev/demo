# Monthly KPIs


```monthly_KPIs
select 
strftime('%Y-%m-01',order_datetime) as order_month,
count(*) as orders,
sum(sales) as sales_usd,
sum(sales) / count(*) as aov_usd

from orders

where order_month >= '2021-01-01'

group by order_month
order by order_month desc

```

```last_month_KPIs
select *
from ${monthly_KPIs}

order by order_month desc
limit 1
```

| <Value data={data.last_month_KPIs} column='sales_usd' /> | <Value data={data.last_month_KPIs} column='orders' /> | <Value data={data.last_month_KPIs} column='aov_usd' /> |
|::|::|::|
| *December Sales* | *December Orders* | *December AOV* |

<AreaChart
    title='Montly sales, last 12 months'
    subtitle='USD'
    data={data.monthly_KPIs}
    x=order_month
    y=sales_usd
/>


Sales are **{ (data.monthly_KPIs.at(-1).sales_usd - data.monthly_KPIs.at(-2).sales_usd) > 0 ? "up" : "down" }** by {pct_formatter.format(data.monthly_KPIs.at(-1).sales_usd / data.monthly_KPIs.at(-2).sales_usd -1)} from the previous month.


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
  minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
  maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
});

var pct_formatter = new Intl.NumberFormat('en-US', {
  style: 'percent',

  // These options are needed to round to whole numbers if that's what you want.
  minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
  maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
});

</script>