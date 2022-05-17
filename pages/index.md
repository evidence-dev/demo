
<img src="https://static1.squarespace.com/static/55d5e6bbe4b07fd45aec98a4/t/5a67ff45ec212de974357e39/1622153363313/Needful+logo.png" alt="Needful Things Logo" class ="center"> 


```daily_KPIs
select 
strftime('%Y-%m-%d',order_datetime) as order_date,
count(*) as orders,
round(sum(sales),0) as sales_usd,
sum(sales) / count(*) as aov_usd

from orders

where order_date >= '2021-12-01'

group by order_date
order by order_date

```

```yesterday_KPIs
select *
from ${daily_KPIs}

order by order_date desc
limit 1
```


# Daily KPIs for <Value data={data.yesterday_KPIs}/>

Sales are **{ (data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-2).sales_usd) > 0 ? "up" : "down" }** by {usd_formatter.format(data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-2).sales_usd)} from the previous day, and **{ (data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-8).sales_usd) > 0 ? "up" : "down" }** by {usd_formatter.format(data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-8).sales_usd)} from the same day the previous week.



| {usd_formatter.format(data.yesterday_KPIs[0].sales_usd)} | <Value data={data.yesterday_KPIs} column='orders' /> | <Value data={data.yesterday_KPIs} column='aov_usd' /> |
|::|::|::|
| *Sales* | *Orders* | *AOV* |

<BarChart
    title='Daily sales in last month'
    subtitle='USD'
    data={data.daily_KPIs}
    x=order_date
    y=sales_usd
/>


# Jump to:
- [📊 Whole Business KPIs](/business_performance/summary)
- [💬 Customer Feedback](/customer)
- [📢 Marketing](/marketing)
- [⚙️ Ops](/operations)
- [📦 Retail](/retail)


<style>
    table {
        width: 100%;
        
    }
    th {
        font-size: 32px;
    }

    .center {
      display: block;
      margin-left: auto;
      margin-right: auto;
      width: 50%;
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

