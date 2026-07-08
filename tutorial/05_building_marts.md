# 05 — Building Marts

Marts are the **business-facing outputs**. Each mart answers a specific set of
questions at a specific grain, and each is materialized as a **table** so
dashboards read it fast.

> ✍️ **Write these yourself**, one mart at a time, checking each against the
> [reference `models/marts/`](https://github.com/Skylinnnnnn/ding12/tree/main/models/marts).
> 📋 **`macros/safe_divide.sql` is tiny — copy it**, then use it for every rate so
> you never divide by zero. Keep your
> [`docs/metrics_glossary.md`](../docs/metrics_glossary.md) open and make sure each
> metric you write matches its definition — that discipline is the whole point of a
> mart layer.

## The six marts
| Mart | Grain | Feeds |
| --- | --- | --- |
| `mart_daily_marketplace_metrics` | order_date | Executive Overview |
| `mart_seller_performance` | seller_id | Seller Performance |
| `mart_delivery_reliability` | order_month | Delivery Reliability |
| `mart_customer_experience` | order_month | Customer Experience |
| `mart_category_performance` | product_category_name_english | category views |
| `mart_payment_behavior` | payment_type | payment views |

## Patterns to notice
- **One grain per mart, declared at the top.** The `GROUP BY` is the grain.
- **Rates use the `safe_divide` macro**, which expands to
  `numerator / nullif(denominator, 0)` — so an empty denominator returns null
  instead of throwing a divide-by-zero error.
  ```sql
  {{ safe_divide('completed_orders', 'gross_orders') }} as completion_rate
  ```
- **GMV is built from order items** (`price + freight_value`), not payments — a
  documented business choice (see `docs/business_assumptions.md`).
- **Avoid double counting** by aggregating per order before rolling up to seller
  or category (same idea as the review grain from tutorial 04).

## Tests on marts (`models/marts/schema.yml`)
- `not_null` (and `unique`) on each grain column — e.g. `order_date`,
  `seller_id`, `order_month`, `payment_type`.
- `not_null` on headline metrics like `total_gmv`, `total_payment_value`.

## Run it
```bash
dbt build            # seed + run + test in dependency order
# or step by step:
dbt run --select marts
dbt test --select marts

git add -A && git commit -m "Add marts, macro, and singular tests" && git push
```

At this point you have a complete, tested warehouse — the hard part is done.
Chapters 06/08 show how to explore it, and 09 puts a dashboard on top.
