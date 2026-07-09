# 06 — Building Intermediate Models

Intermediate models hold **reusable business logic and joins**. They're the
bridge between clean staging tables and aggregated marts. They're views, and
they're not meant to be queried directly by dashboards.

> ✍️ **Write these yourself** — this is where the real modeling judgment lives
> (grain, joins, derived flags). Do the thinking before peeking. For each model,
> decide the grain *first*, then write the SQL. Check against the
> [reference `models/intermediate/`](https://github.com/Skylinnnnnn/ding12/tree/main/models/intermediate)
> after your attempt. The `schema.yml` here is lighter than staging — short model
> and column descriptions, plus a `unique`+`not_null` on the order-grain keys.

## The five intermediate models
| Model | Grain | Purpose |
| --- | --- | --- |
| `int_orders_enriched` | one row per order | orders + customer geography + date grains + lifecycle flags |
| `int_order_delivery_performance` | one row per order | delivery timing: delay days, late flag, purchase-to-delivered |
| `int_seller_order_performance` | one row per order item | revenue fact + seller/product/category context |
| `int_review_experience` | one row per review record | reviews + delivery, for CX analysis |
| `int_category_performance` | one row per order item | category economics fact |

## Design ideas worth internalizing
- **State the grain explicitly** (we put it in a comment at the top of every
  model). Grain confusion is the #1 cause of wrong metrics.
- **Compute flags/derivations once** here, reuse everywhere. Example:
  `late_delivery_flag` is defined in `int_order_delivery_performance` and reused
  by both delivery and customer-experience marts.
- **Only compute delivery metrics when a delivery happened.** We guard with
  `case when order_delivered_customer_at is not null then ...`, so undelivered
  orders don't distort reliability numbers.
- **Fallbacks matter.** Category joins use
  `coalesce(english_name, portuguese_name)` so a missing translation never drops
  a row.

## Grain decision to notice: reviews
`int_review_experience` is **one row per review record**, not per order — because
Olist has orders with multiple reviews and repeated review_ids. Downstream, when
we want a per-seller or per-category review score, we **average per order first**,
then average up. That two-step avoids double-counting orders that touched many
items or sellers.

## Run it, then commit
```bash
dbt build --select intermediate   # build + test the intermediate views
git add -A && git commit -m "Add intermediate models" && git push
```
