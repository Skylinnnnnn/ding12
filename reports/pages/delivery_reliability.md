---
title: Delivery Reliability
---

How reliable is delivery, and is it improving? Grain: one row per order month
(delivered orders only).

```sql delivery
select
  order_month,
  delivered_orders,
  late_orders,
  late_delivery_rate,
  avg_delivery_delay_days,
  avg_purchase_to_delivered_days
from ding12.delivery_reliability
order by order_month
```

<LineChart data={delivery} x=order_month y=late_delivery_rate yFmt='pct1' title="Late Delivery Rate by Month"/>

A negative delay means orders arrive **before** the promised date — Olist's
estimates are conservative, so most months run early on average.

<LineChart data={delivery} x=order_month y=avg_delivery_delay_days yFmt='#,##0.0' title="Avg Delivery Delay (days, negative = early)"/>

<BarChart data={delivery} x=order_month y={['late_orders','delivered_orders']} title="Delivered vs Late Orders"/>

## Monthly detail

<DataTable data={delivery} rows=all>
  <Column id=order_month title="Month"/>
  <Column id=delivered_orders title="Delivered" fmt='#,##0'/>
  <Column id=late_orders title="Late" fmt='#,##0'/>
  <Column id=late_delivery_rate title="Late Rate" fmt='pct1' contentType=colorscale colorScale='#dc2626'/>
  <Column id=avg_delivery_delay_days title="Avg Delay (d)" fmt='#,##0.0'/>
  <Column id=avg_purchase_to_delivered_days title="Purchase→Delivered (d)" fmt='#,##0.0'/>
</DataTable>
