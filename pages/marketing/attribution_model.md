# Attribution Model

## Orders by Channel

The largest channels are currently <Value data={orders_by_channel} row=0/>, <Value data={orders_by_channel} row=1/> and <Value data={orders_by_channel} row=2/>.

```orders_by_channel
select 
channel,
date_trunc("MONTH", order_datetime) as order_month_date,
channel_month,
count(*) as orders

from orders

where order_datetime >= '2021-01-01'

group by channel, order_month_date, 3
order by order_month_date desc, orders desc
```

<AreaChart
    title='Orders attributed to each channel'
    data={orders_by_channel}
    x=order_month_date
    y=orders
    series=channel
/>

## CPA - 2021


```channel_cpa
select 
channel_month,
order_month_date as month,
marketing_channel,
sum(spend) as total_spend,
sum(orders) as total_orders,
round(sum(spend) / sum(orders),2) as cpa

from ${orders_by_channel}
left join marketing_spend using(channel_month)

group by 1,2,3
order by 6
```

```total_cpa
select 
round(sum(total_spend) / sum(total_orders),2) as blended_cpa,
14 as target_cpa,
(sum(total_spend) / sum(total_orders))/target_cpa - 1 as diff_vs_target_pct
from ${channel_cpa}
```

```most_efficient_channels
select 
marketing_channel,
round(total_spend,0) as spend,
total_orders,
cpa

from ${channel_cpa}

where month >= '2021-12-01'
and marketing_channel is not null
```

<BigValue 
    data={total_cpa} 
    title='Blended CPA'
    value=blended_cpa
    fmt='$0.00'
    comparison=diff_vs_target_pct
    comparisonTitle='vs target'
    downIsGood
/>



{#if ((total_cpa[0].blended_cpa / 14 - 1) < 0) }

CPA is below target, so you may wish to investigate spending more in efficient channels, or testing new channels:

The most efficient channels are currently <Value data={most_efficient_channels}/> (CPA <Value data={most_efficient_channels} column=cpa fmt="$###.00"/>) and <Value data={most_efficient_channels} row=1/> (CPA <Value data={most_efficient_channels} row=1 column=cpa fmt="$###.00"/>).


{:else}

CPA is above target - you may wish to reduce marketing spend.

{/if}


<LineChart
    title='Cost per Acquisition by Channel, 2021'
    data={channel_cpa}
    x=month
    y=cpa
    yFmt='$##0'
    series=marketing_channel
/>

_N.B. TikTok Ads are being tested as a new channel and are expected to become more efficient over time_



<ScatterPlot
    title='CPA vs Spend, Paid channels, Dec 2021'
    subtitle='The best channels are in the bottom right, with high reach and low cost'
    data={most_efficient_channels}
    x=spend
    xMin=0
    yMin=0
    xFmt='$###,##0'
    y=cpa
    yFmt='$##0'
    xAxisTitle=true
    yAxisTitle="CPA"
    pointSize=20
    series=marketing_channel
    
/>