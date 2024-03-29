# Retail

## Sales Mix

```products_mix_pct
select 
DATE_TRUNC('MONTH',order_datetime) as month,
category,
sum(sales) / sum(sum(sales)) over (partition by DATE_TRUNC('MONTH',order_datetime)) as sales_pct

from orders
where order_datetime >= '2021-01-01' 

group by 1,2
order by 1
```

```category_summary
select 
category,
sum(sales_pct)/count(sales_pct) as yearly_sales_pct
from ${products_mix_pct}

group by category
order by yearly_sales_pct desc
```


In the past year, {pct_formatter.format(category_summary[0].yearly_sales_pct+category_summary[1].yearly_sales_pct)} of sales have come from <Value data={category_summary} row=0/> and <Value data={category_summary} row=1/>.




<BarChart 
    data = {products_mix_pct}
    title = 'Category Mix, 2021'
    subtitle = '% of sales'
    y=sales_pct
    series=category
    yMax=1
    labels=true
    stackTotalLabel=false
    yGridlines=false
    yAxisLabels=False
/>


```products_mix
select 
item,
category,
sum(sales) as sales_usd,
sum(sales)/sum(sum(sales)) over () as sales_pct
from orders

where order_month >= '2021-01-01' 

group by 1,2
order by sales_usd desc
```



The most popular items were the <Value data={products_mix} row=0/> ({usd_formatter.format(products_mix[0].sales_usd)}), <Value data={products_mix} row=1/> ({usd_formatter.format(products_mix[1].sales_usd)}), and <Value data={products_mix} row=2/> ({usd_formatter.format(products_mix[2].sales_usd)}).


<BarChart
    title='Sales by Product'
    subtitle='$, 2021' 
    data={products_mix}
    x=item
    y=sales_usd
    series=category
    swapXY=true
    sort=false
    labels=true
    labelPosition=outside
    stackTotalLabel=false
    yGridlines=false
    labelFmt="$#,k"
    yAxisLabels=False
/>




## Product Popularity



```nps_by_category
select 
category, 
round(avg(case 
when nps_score > 8 then 100
when nps_score <7 then -100
else 0 end),0) as nps_avg,
round(sum(sales),3) as sales_usd

from reviews
left join orders on orders.id=reviews.order_id

group by category
order by nps_avg
```

Customers have differing opinions about the products, however: <Value data={nps_by_category}/> is an unpopular category in customer NPS reviews.


<ScatterPlot
    title='NPS by Category, 2019 - 2021'
    data={nps_by_category}
    x=nps_avg
    y=sales_usd
    yAxisTitle=true
    xAxisTitle='NPS Score'
    pointSize=20
    series=category
/>


```nps_by_product
select 
item, 
category, 
round(avg(case 
when nps_score > 8 then 100
when nps_score <7 then -100
else 0 end),0) as nps_avg,
round(sum(sales),3) as sales_usd

from reviews
left join orders on orders.id=reviews.order_id

group by 1,2
order by nps_avg
```

The <Value data={nps_by_product}/> (NPS: <Value data={nps_by_product} column=nps_avg/>) in particular is dragging down the average.


<ScatterPlot
    title='NPS by Product, 2019 - 2021'
    data={nps_by_product}
    x=nps_avg
    y=sales_usd
    yAxisTitle=true
    xAxisTitle='NPS Score'
    pointSize=20
    series=item
/>

```all_reviews
select 
nps_score,
item
from reviews
left join orders on orders.id=reviews.order_id

order by item
```



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