# Attribution Model

## Orders by Channel

The largest channels are currently <Value data={data.orders_by_channel} row=5/>, <Value data={data.orders_by_channel} row=4/> and <Value data={data.orders_by_channel} row=3/>.

```orders_by_channel
select 
channel,
date_trunc("MONTH", order_datetime) as order_month_date,
channel_month,
count(*) as orders

from orders

where order_datetime >= '2021-01-01'

group by channel, order_month_date, 3
order by order_month_date desc, orders
```

<AreaChart
    title='Orders attributed to each channel'
    data={data.orders_by_channel}
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
sum(spend) as total_spend_usd,
sum(orders) as total_orders,
round(sum(spend) / sum(orders),2) as cpa_usd0

from ${orders_by_channel}
left join marketing_spend using(channel_month)

group by 1,2,3
order by 6
```

```total_cpa
select 
round(sum(total_spend_usd) / sum(total_orders),2) as blended_cpa_usd,
14 as target_cpa_usd,
(sum(total_spend_usd) / sum(total_orders))/target_cpa_usd - 1 as diff_vs_target_pct
from ${channel_cpa}
```

```most_efficient_channels
select 
marketing_channel,
round(total_spend_usd,0) as spend_usd0k,
total_orders,
cpa_usd0

from ${channel_cpa}

where month >= '2021-12-01'
and marketing_channel is not null
```

<BigValue 
    data={total_cpa} 
    value=blended_cpa_usd
    comparison=diff_vs_target_pct
    comparisonTitle='vs target'
    downIsGood
    />



{#if ((data.total_cpa[0].blended_cpa_usd / 14 - 1) < 0) }

CPA is below target, so you may wish to investigate spending more in efficient channels, or testing new channels:

The most efficient channels are currently <Value data={data.most_efficient_channels}/> (CPA <Value data={data.most_efficient_channels} column=cpa_usd0/>) and <Value data={data.most_efficient_channels} row=1/> (CPA <Value data={data.most_efficient_channels} row=1 column=cpa_usd0/>).


{:else}

CPA is above target - you may wish to reduce marketing spend.

{/if}





<LineChart
    title='Cost per Acquisition by Channel, 2021'
    data={data.channel_cpa}
    x=month
    y=cpa_usd0
    series=marketing_channel
/>

### N.B. TikTik Ads are being tested as a new channel and are expected to become more efficient over time



<ScatterPlot
    title='CPA vs Spend, Paid channels, Dec 2021'
    subtitle='The best channels are in the bottom right, with high reach and low cost'
    data={data.most_efficient_channels}
    x=spend_usd0k
    y=cpa_usd0
    xAxisTitle=true
    yAxisTitle=true
    pointSize=20
    series=marketing_channel
    
/>




<style>
    table {
        width: 100%;
        padding-bottom: 20px;
    }
    th{
        font-size: 16px;
    }
    tr:nth-child(1) {
        font-size: 32px;

    }


</style>

