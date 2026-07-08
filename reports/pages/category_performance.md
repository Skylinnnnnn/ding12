---
title: Category Performance
---

Which product categories drive volume, revenue, and satisfaction? Grain: one row
per English product category.

```sql top_categories
select
  product_category_name_english as category,
  orders,
  items_sold,
  category_gmv,
  avg_item_price,
  avg_review_score
from ding12.category_performance
order by category_gmv desc
limit 15
```

<BarChart data={top_categories} x=category y=category_gmv yFmt='#,##0' swapXY=true title="Top 15 Categories by GMV (R$)"/>

## Revenue vs. satisfaction

Bigger, higher-GMV categories aren't always the best-reviewed — worth watching.

```sql category_scatter
select
  product_category_name_english as category,
  category_gmv,
  avg_review_score,
  orders
from ding12.category_performance
where avg_review_score is not null
```

<ScatterPlot data={category_scatter} x=category_gmv y=avg_review_score size=orders xFmt='#,##0' yFmt='#,##0.0' title="Category GMV vs Avg Review Score"/>

## All categories

<DataTable data={top_categories} rows=15 rowShading=true>
  <Column id=category title="Category"/>
  <Column id=orders title="Orders" fmt='#,##0'/>
  <Column id=items_sold title="Items" fmt='#,##0'/>
  <Column id=category_gmv title="GMV (R$)" fmt='#,##0'/>
  <Column id=avg_item_price title="Avg Price" fmt='#,##0.00'/>
  <Column id=avg_review_score title="Review" fmt='#,##0.0'/>
</DataTable>
