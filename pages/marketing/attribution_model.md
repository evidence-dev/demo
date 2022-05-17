# Attribution Model

## Orders by Channel

The largest channels are currently <Value data={data.orders_by_channel} row=5/>, <Value data={data.orders_by_channel} row=4/> and <Value data={data.orders_by_channel} row=3/>.

```orders_by_channel
select 
channel,
strftime('%Y-%m-01', order_datetime) as order_month_date,
channel_month,
count(*) as orders

from orders

where order_datetime >= '2021-01-01'

group by channel, order_month_date
order by order_month_date desc, orders
```

<AreaChart
    title='Orders attributed to each channel'
    data={data.orders_by_channel}
    x=order_month_date
    y=orders
    series=channel
/>

## CPA


```channel_cpa
select 
channel_month,
substr(channel_month,length(channel_month)-9) as month,
marketing_channel,
sum(spend) as total_spend_usd,
sum(orders) as total_orders,
round(sum(spend) / sum(orders),2) as cpa_usd

from ${orders_by_channel}
left join marketing_spend using(channel_month)

group by marketing_channel, channel_month
order by cpa_usd
```

```total_cpa
select 
round(sum(total_spend_usd) / sum(total_orders),2) as blended_cpa_usd
from ${channel_cpa}
```

```most_efficient_channels
select 
marketing_channel,
round(total_spend_usd,0) as spend_usd,
total_orders,
cpa_usd

from ${channel_cpa}

where month >= '2021-12-01'
and marketing_channel is not null
```

|  |
|::|
| *2021 CPA* |

| <Value data={data.total_cpa}/> | 
|::|
| {pct_formatter.format(data.total_cpa[0].blended_cpa_usd / 14 - 1)} vs target|


{#if ((data.total_cpa[0].blended_cpa_usd / 14 - 1) < 0) }

CPA is below target, so you may wish to investigate spending more in efficient channels, or testing new channels:

The most efficient channels are currently <Value data={data.most_efficient_channels}/> (CPA <Value data={data.most_efficient_channels} column=cpa_usd/>) and <Value data={data.most_efficient_channels} row=1/> (CPA <Value data={data.most_efficient_channels} row=1 column=cpa_usd/>).


{:else}

CPA is above target - you may wish to reduce marketing spend.

{/if}





<LineChart
    title='Cost per Acquisition by Channel, 2021'
    data={data.channel_cpa}
    x=month
    y=cpa_usd
    series=marketing_channel
/>

### N.B. TikTik Ads are being tested as a new channel and are expected to become more efficient over time



<ScatterPlot
    title='CPA vs Spend, Paid channels, Dec 2021'
    subtitle='The best channels are in the bottom right, with high reach and low cost'
    data={data.most_efficient_channels}
    x=spend_usd
    y=cpa_usd
    xAxisTitle=true
    yAxisTitle=true
    pointSize=20
    series=marketing_channel
    
/>




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