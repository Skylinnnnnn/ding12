# 03 — Building Staging Models

Staging is the **clean, standardized version of raw data** — not the business
logic layer. One staging model per source table.

> ✍️ **Write these yourself.** The SQL is easy for you; the point is to internalize
> the *pattern* (`ref()`, one model per source, explicit casts). Work in the
> *worked example → you try* rhythm: write `stg_orders.sql` fully (below), run it,
> then write the other seven from the same template. Check against the
> [reference `models/staging/`](https://github.com/Skylinnnnnn/ding12/tree/main/models/staging)
> only after you've attempted each.
>
> ✍️ **`schema.yml` is the highest-value thing to hand-write.** Declarative tests
> are *new* dbt knowledge — don't copy them. Keep the
> [dbt tests docs](https://docs.getdbt.com/docs/build/data-tests) and
> [test properties](https://docs.getdbt.com/reference/resource-properties/data-tests)
> open, write the tests for one model, then repeat.

## Rules we follow
- Reference the seed with `ref()` using the seed name **without `.csv`**:
  `ref('olist_orders_dataset')`.
- **Cast** timestamps/dates and numeric fields explicitly so downstream models
  can trust types.
- **Rename** only where it adds clarity (e.g. `order_purchase_timestamp` →
  `order_purchased_at`).
- **Standardize strings** with `lower(trim(...))` where useful (cities, statuses)
  and `upper(trim(...))` for state codes.
- **No metrics, no business logic** here. Keep it boring.

## Example (`stg_orders.sql`)
```sql
with source as (
    select * from {{ ref('olist_orders_dataset') }}
)
select
    order_id,
    customer_id,
    lower(trim(order_status)) as order_status,
    cast(order_purchase_timestamp as timestamp) as order_purchased_at,
    ...
from source
```

The `with source as (select * ...)` pattern at the top is a convention: it gives
every model a single, obvious entry point and makes edits easy.

## Tests for staging (`models/staging/schema.yml`)
- `unique` + `not_null` on **true keys only**: `customer_id`, `order_id`,
  `seller_id`, `product_id`.
- `accepted_values` on `order_status`, `payment_type`, `review_score`.
- `relationships` tests across the order graph (items → orders, payments →
  orders, reviews → orders, etc.).

## A real-data lesson
Olist has **duplicate `order_id`s** in payments, reviews, and order_items (an
order can have several items/payments/reviews). So we do **not** put `unique`
tests on those `order_id`s — we put uniqueness only where it's actually true.
When real data contradicts an assumption, fix the assumption, not the data.

## Run it, then commit
```bash
dbt run  --select staging   # build the eight staging views
dbt test --select staging   # run their tests
git add -A && git commit -m "Add staging models and tests" && git push
```
