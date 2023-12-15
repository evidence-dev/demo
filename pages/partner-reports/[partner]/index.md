# {params.partner} Monthly Report

```all
select * from needful_things.all
```

## Monthly Purchases

```monthly
select * from needful_things.monthly
```


<AreaChart 
    data={monthly.filter(d => d.partner === params.partner)} 
    y=cost
    yFmt=usd
    title="Goods Purchased ($)"
/>

## Most Popular Products to Date



```items
select * from needful_things.items
```



The most popular product you ordered by volume is the <Value data={items.filter(d => d.partner === params.partner)} column=item/>, which sold <Value data={items.filter(d => d.partner === params.partner)} column=num_units_num0 /> units. 

<BarChart 
    data={items.filter(d => d.partner === params.partner)} 
    y=num_units_num0 
    x=item 
    swapXY=true 
    title="Units Purchased, 000s"
    labels=true
    labelFmt="#.0,"
    yGridlines=false
    yAxisLabels=false
/>




## Invoice for Last Month

```invoice1
select * from needful_things.invoice1
```

```invoice_total1
select * from needful_things.invoice_total1
```




<DataTable 
    data={invoice1.filter(d => d.partner === params.partner)} 
    rows=12
>
<Column id=item/>
<Column id=num_units_num0 label="Units"/>
<Column id=cost label="Cost" fmt="$###,###.00"/>
</DataTable>

<div class="flex justify-between text-sm font-bold ml-2 mr-4 mb-6">
<div>Total Cost:</div>
<div>
    <Value data={invoice_total1.filter(d => d.partner === params.partner)} column=cost fmt="$###,###.00" />
</div>
</div>




## Previous Monthly Invoices

```months
select *, 
    strftime('%Y-%m', month_monthyear) as yyyy_mm
 from needful_things.months
```

{#each months as month_row}

    - [<Value data={month_row} value=month_monthyear fmt="mmmm yyyy"/>  ](/partner-reports/{params.partner}/{month_row.yyyy_mm}/)

{/each}






<style>
    ul{
        margin-block-end: 0;
    }
</style>