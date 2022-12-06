# Partner Sales

Needful Things sells goods to a variety of retail partners. 

These partners need individual reports on those sales trends.


## Revenue to Date, by Partner

```partner_list
select
partner,
sum(sales) as sales_usd1m
from partners
group by 1
order by 2 desc
```

<BarChart data={partner_list} title='Sales per partner'/>

## Partner Reports

Click on a partner below to go to their report:

{#each partner_list as partner_data}

- [{partner_data.partner}](/partners/{partner_data.partner}/)

{/each}

<style>
    ul{
        margin-block-end: 0;
    }
</style>