## {$page.params.partner} invoice for {fmt($page.params.date, "MMMM YYYY")}

```invoice
select
date_trunc(month, order_datetime)::date as date,
partner,
item,
sum(quantity) as num_units_num0,
sum(sales) as cost

from partners
group by 1,2,3 order by 2,5 desc
```

```invoice_total
select
date_trunc(month, order_datetime)::date as date,
partner,
sum(quantity) as num_units_num0,
sum(sales) as cost

from partners
group by 1,2 order by 2,4 desc
```




<DataTable 
    data={invoice.filter(d => d.partner === $page.params.partner).filter(d => d.date === $page.params.date)} 
    rows=12
>
    <Column id=date/>
    <Column id=item/>
    <Column id=num_units_num0 fmt="###,###"/>
    <Column id=cost fmt="$###,###.00"/>
</DataTable>



<div class="flex justify-between text-sm font-bold ml-2 mr-4 mb-6">
<div>Total Cost:</div>
<div>
    <Value data={invoice_total.filter(d => d.partner === $page.params.partner)} column=cost fmt="$###,###.00" />
</div>
</div>
