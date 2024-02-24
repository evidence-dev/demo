

![Needful Things Logo](/static/needful-logo.png)

```daily_KPIs
select 
date_trunc('DAY', order_datetime) as order_date,
count(*) as orders,
sum(sales) as sales_usd,
sum(sales) / count(*) as aov_usd,
(sum(sales))/ (lag(sum(sales) , 1) over (order by order_date)) -1 as daily_sales_chg_pct1,
1.0*(count(*))/ (lag(count(*) , 1) over (order by order_date)) -1 as daily_orders_chg_pct1,
(sum(sales)/count(*))/ (lag(sum(sales)/count(*) , 1) over (order by order_date)) -1 as daily_aov_chg_pct1,
(sum(sales))/ (lag(sum(sales) , 8) over (order by order_date)) -1 as weekly_sales_chg_pct1
from orders
where order_date >= '2021-12-01'
group by 1
order by 1
```

```yesterday_KPIs
select *
from ${daily_KPIs}

order by order_date desc
limit 1
```


# Daily KPIs for <Value data={yesterday_KPIs} fmt="dd mmm yy"/>

Sales yesterday were **down** <Value data={yesterday_KPIs} column='daily_sales_chg_pct1' /> since the previous day, and **down** <Value data={yesterday_KPIs} column='weekly_sales_chg_pct1' /> on last week.


<BigValue 
  data={yesterday_KPIs} 
  value='sales_usd' 
  comparison=daily_sales_chg_pct1 
  comparisonTitle='vs prev. day'/>

<BigValue 
  data={yesterday_KPIs} 
  value='orders' 
  comparison=daily_orders_chg_pct1 
  comparisonTitle='vs prev. day'/>

<BigValue 
  data={yesterday_KPIs} 
  value='aov_usd' 
  comparison=daily_aov_chg_pct1 
  comparisonTitle='vs prev. day'/>



<BarChart
    title='Daily sales in last month'
    subtitle='USD'
    data={daily_KPIs}
    x=order_date
    y=sales_usd
/>


# Jump to:

- [📊 Whole Business KPIs](/business-performance)
- [💬 Customer Feedback](/customer)
- [📢 Marketing](/marketing)
- [⚙️ Ops](/operations)
- [🤝🏽 Partner Reports](/partner-reports)
- [📦 Retail](/retail)


<style>
  img {
    width: 50%;
  }
</style>
