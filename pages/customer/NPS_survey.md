# NPS Survey

Each customer is sent a survey after recieving their products. We use NPS, where customers rate their experience on a 0 - 10 scale. The [NPS score](https://delighted.com/nps-calculator) is on a scale between -100 and 100.

```reviews

select 
strftime('%Y-%m-%d') as order_day,
order_month,
order_datetime,
nps_score as rating,
case 
when nps_score > 8 then 100
when nps_score < 7 then -100
else 0
end as nps,

item
 from reviews

left join orders on reviews.order_id=orders.id

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

|<Value data={data.nps_to_date}/>|
|::|
|NPS score to date|

NPS scores of >70 are considered market leading in ecommerce. Our NPS score is well below that, indicating unsatisfied customers.


<Chart 
    data={data.nps_over_time}
    title='Average NPS Score and # of Reviews (2019 - 2022)'
    subtitle='#,#' >
    
    <Line y=nps_avg/>
    <Bar y=review_count/>
</Chart>

The volume of NPS reviews is currently too low for month on month trends to be significant.



<style>
    table {
        width: 100%;
        
    }
    th {
        font-size: 32px;
    }
</style>



