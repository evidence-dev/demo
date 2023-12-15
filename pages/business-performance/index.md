# Daily KPIs


```daily_KPIs1
select * from needful_things.daily_KPIs1
```

```yesterday_KPIs
select *
from ${daily_KPIs1}
order by order_date desc
limit 1
```

## [<Value data={yesterday_KPIs} fmt="ddd dd mmm yyyy"/>](/business-performance/2021-12-31)

Sales are **{ (daily_KPIs1.at(-1).sales - daily_KPIs1.at(-2).sales) > 0 ? "up" : "down" }** by {fmt(daily_KPIs1.at(-1).sales - daily_KPIs1.at(-2).sales,"$###")} from the previous day, and **{ (daily_KPIs1.at(-1).sales - daily_KPIs1.at(-8).sales) > 0 ? "up" : "down" }** by {fmt(daily_KPIs1.at(-1).sales - daily_KPIs1.at(-8).sales,"$###")} from the same day the previous week.

<BigValue 
  data={yesterday_KPIs} 
  value='sales' 
  fmt='usd'
  comparison=daily_sales_chg 
  comparisonTitle='vs prev. day'
  comparisonFmt=pct1
/>

<BigValue 
  data={yesterday_KPIs} 
  value='orders' 
  comparison=daily_orders_chg 
  comparisonTitle='vs prev. day'
  comparisonFmt=pct1
/>

<BigValue 
  data={yesterday_KPIs} 
  value=aov 
  title='AOV'
  fmt='usd2'
  comparison=daily_aov_chg 
  comparisonTitle='vs prev. day'
  comparisonFmt=pct1
/>


<BarChart
    title='Daily sales, Last month'
    subtitle='USD'
    data={daily_KPIs1}
    x=order_date
    y=sales
    yFmt=usd
/>


KPIs for a specific date are at /business-performance/[YYYY-MM-DD]. E.g. [/business-performance/2020-01-01](/business-performance/2020-01-01)


# Monthly KPIs


```monthly_KPIs
select * from needful_things.monthly_KPIs

```

```last_month_KPIs
select *
from ${monthly_KPIs}

order by order_month desc
limit 1
```

## <Value data = {last_month_KPIs} fmt="mmmm yyyy"/>



Sales are **{ (monthly_KPIs.at(-1).sales - monthly_KPIs.at(-2).sales) > 0 ? "up" : "down" }** by {fmt(monthly_KPIs.at(-1).sales / monthly_KPIs.at(-2).sales -1,"pct")} from the previous month.



<BigValue
    data={last_month_KPIs}
    value='sales'
    fmt='usd'
    comparison=monthly_sales_chg
    comparisonTitle='vs prev. month'
    comparisonFmt=pct1
/>
<BigValue
    data={last_month_KPIs}
    value='orders'
    comparison=monthly_orders_chg
    comparisonTitle='vs prev. month'
    comparisonFmt=pct1
/>
<BigValue
    data={last_month_KPIs}
    value=aov
    title='AOV'
    fmt=usd2
    comparison=monthly_aov_chg
    comparisonTitle='vs prev. month'
    comparisonFmt=pct1
/>





<AreaChart
    title='Monthly sales, Last 12 months'
    subtitle='USD'
    data={monthly_KPIs}
    x=order_month
    y=sales
    yFmt=usd
/>



# Quarterly KPIs

```qtr_KPIs
select * from needful_things.qtr_KPIs

```

```last_qtr_KPIs
select *
from ${qtr_KPIs}

order by order_quarter desc
limit 1
```

## {last_qtr_KPIs[0].order_quarter}



Sales are **{ (qtr_KPIs.at(-1).sales - qtr_KPIs.at(-2).sales) > 0 ? "up" : "down" }** by {fmt(qtr_KPIs.at(-1).sales / qtr_KPIs.at(-2).sales -1,"pct")} from the previous quarter.

<BigValue
    data={last_qtr_KPIs}
    value='sales'
    fmt='usd'
    comparison=qtr_sales_chg
    comparisonTitle='vs prev. quarter'
    comparisonFmt=pct1
/>
<BigValue
    data={last_qtr_KPIs}
    value='orders'
    fmt=num0
    comparison=qtr_orders_chg
    comparisonTitle='vs prev. quarter'
    comparisonFmt=pct1
/>
<BigValue
    data={last_qtr_KPIs}
    value=aov
    title='AOV'
    fmt=usd2
    comparison=qtr_aov_chg
    comparisonTitle='vs prev. quarter'
    comparisonFmt=pct1
/>




<LineChart
    title='Quarterly sales, 2019 - 2022'
    subtitle='USD'
    data={qtr_KPIs}
    x=order_quarter
    y=sales
    yFmt=usd1m
    sort=false
    labels=true
    labelFmt=usd0k
/>

