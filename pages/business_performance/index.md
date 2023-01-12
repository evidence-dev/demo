# Daily KPIs


```daily_KPIs
select 
date_trunc('DAY', order_datetime) as order_date,
count(*) as orders,
sum(sales) as sales_usd,
sum(sales) / count(*) as aov_usd2,
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

## [<Value data={data.yesterday_KPIs}/>](/business_performance/2021-12-31)

Sales are **{ (data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-2).sales_usd) > 0 ? "up" : "down" }** by {usd_formatter.format(data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-2).sales_usd)} from the previous day, and **{ (data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-8).sales_usd) > 0 ? "up" : "down" }** by {usd_formatter.format(data.daily_KPIs.at(-1).sales_usd - data.daily_KPIs.at(-8).sales_usd)} from the same day the previous week.

<BigValue 
  data={yesterday_KPIs} 
  value='sales_usd' 
  comparison=daily_sales_chg_pct1 
  comparisonTitle='vs previous day'/>

<BigValue 
  data={yesterday_KPIs} 
  value='orders' 
  comparison=daily_orders_chg_pct1 
  comparisonTitle='vs previous day'/>

<BigValue 
  data={yesterday_KPIs} 
  value='aov_usd2' 
  comparison=daily_aov_chg_pct1 
  comparisonTitle='vs previous day'/>


<BarChart
    title='Daily sales, Last month'
    subtitle='USD'
    data={data.daily_KPIs}
    x=order_date
    y=sales_usd
/>


KPIs for a specific date are at /business_performance/[YYYY-MM-DD]. E.g. [/business_performance/2020-01-01](/business_performance/2020-01-01)


# Monthly KPIs


```monthly_KPIs
select 
order_month,
count(*) as orders,
round(sum(sales),0) as sales_usd,
sum(sales) / count(*) as aov_usd2,
(sum(sales))/ (lag(sum(sales) , 1) over (order by order_month)) -1 as monthly_sales_chg_pct1,
1.0*(count(*))/ (lag(count(*) , 1) over (order by order_month)) -1 as monthly_orders_chg_pct1,
(sum(sales)/count(*))/ (lag(sum(sales)/count(*) , 1) over (order by order_month)) -1 as monthly_aov_chg_pct1

from orders

where order_month >= '2021-01-01'

group by 1
order by 1

```

```last_month_KPIs
select *
from ${monthly_KPIs}

order by order_month desc
limit 1
```

## <Value data = {last_month_KPIs}/>



Sales are **{ (data.monthly_KPIs.at(-1).sales_usd - data.monthly_KPIs.at(-2).sales_usd) > 0 ? "up" : "down" }** by {pct_formatter.format(data.monthly_KPIs.at(-1).sales_usd / data.monthly_KPIs.at(-2).sales_usd -1)} from the previous month.



<BigValue
    data={last_month_KPIs}
    value='sales_usd'
    comparison=monthly_sales_chg_pct1
    comparisonTitle='vs previous month'/>
<BigValue
    data={last_month_KPIs}
    value='orders'
    comparison=monthly_orders_chg_pct1
    comparisonTitle='vs previous month'/>
<BigValue
    data={last_month_KPIs}
    value='aov_usd2'
    comparison=monthly_aov_chg_pct1
    comparisonTitle='vs previous month'/>





<AreaChart
    title='Monthly sales, Last 12 months'
    subtitle='USD'
    data={data.monthly_KPIs}
    x=order_month
    y=sales_usd
/>



# Quarterly KPIs

```qtr_KPIs
select 
date_part('YEAR', order_datetime) || '-Q' || date_part('QUARTER', order_datetime) as order_quarter,
count(*) as orders_num0,
round(sum(sales),0) as sales_usd,
sum(sales) / count(*) as aov_usd2,
(sum(sales))/ (lag(sum(sales) , 1) over (order by order_quarter)) -1 as qtr_sales_chg_pct1,
1.0*(count(*))/ (lag(count(*) , 1) over (order by order_quarter)) -1 as qtr_orders_chg_pct1,
(sum(sales)/count(*))/ (lag(sum(sales)/count(*) , 1) over (order by order_quarter)) -1 as qtr_aov_chg_pct1

from orders


group by order_quarter
order by order_quarter

```

```last_qtr_KPIs
select *
from ${qtr_KPIs}

order by order_quarter desc
limit 1
```

## {data.last_qtr_KPIs[0].order_quarter}



Sales are **{ (data.qtr_KPIs.at(-1).sales_usd - data.qtr_KPIs.at(-2).sales_usd) > 0 ? "up" : "down" }** by {pct_formatter.format(data.qtr_KPIs.at(-1).sales_usd / data.qtr_KPIs.at(-2).sales_usd -1)} from the previous quarter.

<BigValue
    data={last_qtr_KPIs}
    value='sales_usd'
    comparison=qtr_sales_chg_pct1
    comparisonTitle='vs previous quarter'/>
<BigValue
    data={last_qtr_KPIs}
    value='orders_num0'
    comparison=qtr_orders_chg_pct1
    comparisonTitle='vs previous quarter'/>
<BigValue
    data={last_qtr_KPIs}
    value='aov_usd2'
    comparison=qtr_aov_chg_pct1
    comparisonTitle='vs previous quarter'/>




<LineChart
    title='Quarterly sales, 2019 - 2022'
    subtitle='USD'
    data={data.qtr_KPIs}
    x=order_quarter
    y=sales_usd
    sort=false
/>


<style>
    table {
        width: 100%;
        padding-bottom: 20px;
        
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