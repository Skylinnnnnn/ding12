---
title: Customer Experience
---

How does customer sentiment trend, and is it linked to late delivery? Grain: one
row per order month. Low review = score of 1 or 2.

```sql cx
select
  order_month,
  review_count,
  avg_review_score,
  low_review_count,
  low_review_rate,
  late_delivery_rate,
  avg_delivery_delay_days
from ding12.customer_experience
order by order_month
```

<LineChart data={cx} x=order_month y=avg_review_score yFmt='#,##0.00' title="Avg Review Score by Month"/>

## Does late delivery hurt reviews?

Plotting the low-review rate against the late-delivery rate on the same axis: when
late delivery rises, negative reviews tend to follow.

<LineChart data={cx} x=order_month y={['low_review_rate','late_delivery_rate']} yFmt='pct1' title="Low-Review Rate vs Late-Delivery Rate"/>

## Monthly detail

<DataTable data={cx} rows=all>
  <Column id=order_month title="Month"/>
  <Column id=review_count title="Reviews" fmt='#,##0'/>
  <Column id=avg_review_score title="Avg Score" fmt='#,##0.00'/>
  <Column id=low_review_count title="Low Reviews" fmt='#,##0'/>
  <Column id=low_review_rate title="Low-Review Rate" fmt='pct1' contentType=colorscale colorScale='#dc2626'/>
  <Column id=late_delivery_rate title="Late Rate" fmt='pct1' contentType=colorscale colorScale='#dc2626'/>
</DataTable>
