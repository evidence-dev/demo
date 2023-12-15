

![Needful Things Logo](needful-logo.png)

```daily_KPIs2
select * from needful_things.daily_KPIs2
```

```yesterday_KPIs
select *
from ${daily_KPIs2}

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
    data={daily_KPIs2}
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
