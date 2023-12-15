## {params.partner} invoice for {fmt(params.date, "MMMM YYYY")}

```invoice
select 
    *,
    strftime('%Y-%m', date) as yyyy_mm,
     from needful_things.invoice
```

```invoice_total
select * from needful_things.invoice_total
```


<DataTable 
    data={invoice.filter(d => d.partner === params.partner).filter(d => d.yyyy_mm == params.date)} 
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
    <Value data={invoice_total.filter(d => d.partner === params.partner)} column=cost fmt="$###,###.00" />
</div>
</div>
