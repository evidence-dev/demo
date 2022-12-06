# {$page.params.partner} Monthly Report

```all
select * from partners
limit 10
```

## Monthly Purchases

```monthly
select
date_trunc('MONTH', order_datetime) as month,
partner,
sum(sales) as cost_usd,
sum(quantity) as num_units

from partners
group by 1,2 order by 2,1
```


<AreaChart data={monthly.filter(d => d.partner === $page.params.partner)} y=cost_usd title="Goods Purchased ($)"/>

## Most Popular Products to Date



```items
select
partner,
item,
sum(sales) as cost_usd,
sum(quantity) as num_units_num0

from partners
group by 1,2 order by 1,4 desc
```



The most popular product you ordered by volume is the <Value data={items.filter(d => d.partner === $page.params.partner)} column=item/>, which sold <Value data={items.filter(d => d.partner === $page.params.partner)} column=num_units_num0 /> units. 

<BarChart data={items.filter(d => d.partner === $page.params.partner)} y=num_units_num0 x=item swapXY=true title="Units Purchased"/>




## Invoice for Last Month

```invoice
select
partner,
item,
sum(quantity) as num_units_num0,
sum(sales) as cost_usd

from partners
where date_trunc('MONTH', order_datetime)='2021-12-01'
group by 1,2 order by 1,4 desc
```

```invoice_total
select
partner,
sum(quantity) as num_units_num0,
sum(sales) as cost_usd

from partners
where date_trunc('MONTH', order_datetime)='2021-12-01'
group by 1 order by 1,3 desc
```




<DataTable data={invoice.filter(d => d.partner === $page.params.partner)} rows=12/>
<div class='invoice-total'>
<div>
    Total Cost: 
</div>
<div>
    <Value data={invoice_total.filter(d => d.partner === $page.params.partner)} column =cost_usd />
</div>
</div>




## Previous Monthly Invoices

```months
select 
DATE_TRUNC('month',order_datetime)::Date as month_monthyear
from partners
group by 1
order by 1 desc
```

{#each months as month_row}

    - [<Value data={month_row}/>  ](/partners/{$page.params.partner}/{month_row.month_monthyear})

{/each}






<style>
    .invoice-total {
        display: flex;
        justify-content: space-between;
    }
    
    ul{
        margin-block-end: 0;
    }


</style>