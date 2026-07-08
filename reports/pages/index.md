---
title: Ding12 — Marketplace Analytics
---

Commerce marketplace analytics on the Olist Brazilian e-commerce dataset. Every
number below is read live from the dbt-built DuckDB marts. Use the sidebar to
explore sellers, delivery, and customer experience.

```sql kpis
select
  sum(gross_orders)                                   as gross_orders,
  sum(total_gmv)                                      as total_gmv,
  sum(total_gmv) / nullif(sum(gross_orders), 0)       as aov,
  sum(completed_orders) / nullif(sum(gross_orders),0) as completion_rate
from ding12.daily_marketplace_metrics
```

<BigValue data={kpis} value=total_gmv fmt='#,##0' title="Total GMV (R$)"/>
<BigValue data={kpis} value=gross_orders fmt='#,##0' title="Gross Orders"/>
<BigValue data={kpis} value=aov fmt='#,##0.00' title="Avg Order Value (R$)"/>
<BigValue data={kpis} value=completion_rate fmt='pct1' title="Completion Rate"/>

## Growth over time

```sql monthly
select
  date_trunc('month', order_date)                        as month,
  sum(gross_orders)                                       as gross_orders,
  sum(completed_orders)                                   as completed_orders,
  sum(canceled_orders)                                    as canceled_orders,
  sum(total_gmv)                                          as total_gmv,
  sum(completed_orders) / nullif(sum(gross_orders), 0)    as completion_rate,
  sum(canceled_orders)  / nullif(sum(gross_orders), 0)    as cancellation_rate
from ding12.daily_marketplace_metrics
group by 1
order by 1
```

<LineChart data={monthly} x=month y=total_gmv yFmt='#,##0' title="Monthly GMV (R$)"/>

<LineChart data={monthly} x=month y=gross_orders title="Monthly Gross Orders"/>

## Order quality

Completion is the share of orders that reached delivery; cancellation is the
share that were canceled.

<LineChart data={monthly} x=month y={['completion_rate','cancellation_rate']} yFmt='pct1' title="Completion vs Cancellation Rate"/>

> Note: GMV is defined as order-item price + freight (see `docs/metrics_glossary.md`).
> Values are in Brazilian Reais (R$). The first and last months of the dataset are
> partial, so treat the very ends of each trend with care.
