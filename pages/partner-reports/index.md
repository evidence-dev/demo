# Partner Sales

Needful Things sells goods to a variety of retail partners. 

These partners need individual reports on those sales trends.


## Revenue to Date, by Partner

```partner_list
select * from needful_things.partner_list
```

<BarChart 
    data={partner_list} 
    title='Sales per partner' 
    swapXY
    labels=true
    yGridlines=false
    yAxisLabels=false
/>

## Partner Reports

Click on a partner below to go to their report:

{#each partner_list as partner_data}

- [{partner_data.partner}](/partner-reports/{partner_data.partner})

{/each}
