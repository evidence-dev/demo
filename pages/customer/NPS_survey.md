# NPS Survey

Each customer is sent a survey after recieving their products. We use NPS, where customers rate their experience on a 0 - 10 scale. [NPS scores](https://delighted.com/nps-calculator) range on a scale between -100 and 100.


```reviews
select * from needful_things.reviews

```

```histogram
select 
count(*)*1.0 /sum(count(*)) over () as reviews,
rating,
nps,
label
from ${reviews}

group by 2,3,4
order by rating
```



```nps_over_time
select 
order_month,
round(avg(nps),0) as nps_avg,
count(*) as review_count
from ${reviews}

group by order_month
```

```nps_to_date
select 
round(avg(nps),1) as nps_avg,
count(*) as review_count
from ${reviews}
```

<BigValue data={nps_to_date} value=nps_avg title="NPS Average to date"/>

NPS scores of >70 are considered market leading in ecommerce. Our NPS score is well below that, indicating unsatisfied customers.

## Distribution of Scores

While 
{fmt(histogram[9].reviews+histogram[10].reviews,"pct")} of customers are promoters, 
{fmt(histogram[0].reviews+histogram[1].reviews+histogram[2].reviews+histogram[3].reviews+histogram[4].reviews+histogram[5].reviews+histogram[6].reviews,"pct")} are detractors.


<BarChart 
    data={histogram} 
    title='NPS review score distribution'
    x=rating
    y=reviews
    yFmt=pct
    series=label
    labels=true
    labelPosition=outside
    stackTotalLabel=false
    yGridlines=false
    yAxisLabels=false
/>

## Score over Time

The volume of NPS reviews is currently too low for month on month trends to be significant.

<Chart 
    data={nps_over_time}
    title='Average NPS Score and # of Reviews (2019 - 2022)'
    subtitle='#,#' >
    <Line y=nps_avg/>
    <Bar y=review_count/>
</Chart>




<style>
    table {
        width: 100%;
        padding-bottom: 20px;
        
    }
    th {
        font-size: 32px;
    }
</style>

