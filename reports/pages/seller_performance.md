---
title: Seller Performance
---

Which sellers drive value — and which are high-value but risky on customer
experience? Grain: one row per seller.

```sql seller_kpis
select
  count(*)                              as sellers,
  sum(seller_gmv)                       as total_gmv,
  avg(avg_review_score)                 as avg_review_score,
  avg(late_delivery_rate)               as avg_late_rate
from ding12.seller_performance
```

<BigValue data={seller_kpis} value=sellers fmt='#,##0' title="Sellers"/>
<BigValue data={seller_kpis} value=total_gmv fmt='#,##0' title="Total Seller GMV (R$)"/>
<BigValue data={seller_kpis} value=avg_review_score fmt='#,##0.00' title="Avg Review Score"/>
<BigValue data={seller_kpis} value=avg_late_rate fmt='pct1' title="Avg Late Rate"/>

## Top sellers by GMV

```sql top_sellers
select
  seller_id,
  seller_orders,
  seller_gmv,
  avg_item_price,
  distinct_products_sold,
  avg_review_score,
  late_delivery_rate
from ding12.seller_performance
order by seller_gmv desc
limit 20
```

<DataTable data={top_sellers} rows=20>
  <Column id=seller_id title="Seller"/>
  <Column id=seller_orders title="Orders" fmt='#,##0'/>
  <Column id=seller_gmv title="GMV (R$)" fmt='#,##0'/>
  <Column id=avg_item_price title="Avg Price" fmt='#,##0.00'/>
  <Column id=distinct_products_sold title="Products" fmt='#,##0'/>
  <Column id=avg_review_score title="Review" fmt='#,##0.0'/>
  <Column id=late_delivery_rate title="Late Rate" fmt='pct1' contentType=colorscale colorScale='#dc2626'/>
</DataTable>

## Value vs. experience risk

Each dot is a seller (limited to those with 20+ orders for signal). Sellers in
the **lower-right** — high GMV but low review scores — are the ones an operations
team should support first.

```sql seller_scatter
select
  seller_id,
  seller_gmv,
  avg_review_score,
  late_delivery_rate,
  seller_orders
from ding12.seller_performance
where seller_orders >= 20
  and avg_review_score is not null
```

<ScatterPlot data={seller_scatter} x=seller_gmv y=avg_review_score size=seller_orders xFmt='#,##0' yFmt='#,##0.0' title="Seller GMV vs. Avg Review Score (sellers with 20+ orders)"/>
