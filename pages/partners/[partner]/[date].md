## Invoice for {$page.params.date}

```invoice
select
date_trunc(month, order_datetime)::date as date,
partner,
item,
sum(quantity) as num_units_num0,
sum(sales) as cost_usd

from partners
group by 1,2,3 order by 2,5 desc
```

```invoice_total
select
date_trunc(month, order_datetime)::date as date,
partner,
sum(quantity) as num_units_num0,
sum(sales) as cost_usd

from partners
group by 1,2 order by 2,4 desc
```




<DataTable data={invoice.filter(d => d.partner === $page.params.partner).filter(d => d.date === $page.params.date)} rows=12/>
<div class='invoice-total'>
<div>
    Total Cost: 
</div>
<div>
    <Value data={invoice_total.filter(d => d.partner === $page.params.partner).filter(d => d.date === $page.params.date)} column =cost_usd />
</div>
</div>


<style>
    .invoice-total {
        display: flex;
        justify-content: space-between;
    }
</style>