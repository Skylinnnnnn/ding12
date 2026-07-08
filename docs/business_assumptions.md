# Business Assumptions

Ding12 is a **marketplace analytics portfolio project** built on the public Olist
Brazilian e-commerce dataset. The goal is to demonstrate a modern, tested,
documented analytics-engineering workflow with clear business framing.

## Framing
- Olist is an e-commerce platform, but its structure (many **sellers**, many
  buyers, a platform in the middle) maps cleanly to **marketplace analytics**.
- **Sellers** are treated as merchants whose value and reliability we evaluate.
- **Delivery reliability** is measured as **actual vs. estimated delivery date**.
  An order is *late* when it delivers after its estimate.
- **Customer experience** is proxied by **review scores** (1–5).

## Key assumptions (documented on purpose)
1. **GMV = order-item `price + freight_value`.** We deliberately build GMV from
   the order-items table rather than the payments table. Payments include
   vouchers/installment artifacts and can be split across methods, which makes
   payment value a noisier measure of merchandise value. Payment value is
   analyzed separately in `mart_payment_behavior`.
2. **Low review = `review_score <= 2`.** Scores of 1–2 are treated as clearly
   negative experiences.
3. **Late metrics only count delivered orders.** `late_delivery_flag`,
   `delivery_delay_days`, and `purchase_to_delivered_days` are null until an
   order has an actual delivery timestamp, so undelivered/canceled orders never
   inflate or deflate reliability rates.
4. **Reporting date = purchase date.** Daily/monthly/weekly grains are derived
   from `order_purchase_timestamp`.
5. **Review grain.** `int_review_experience` is one row **per review record**.
   Some orders have more than one review and some `review_id`s repeat, so we do
   not assume one review per order. Order- and seller-level review metrics
   average per-order scores first to avoid double counting.

## Scope
- **Geolocation is excluded** from the MVP to keep scope controlled. The seed is
  kept in `seeds/` if present but is not modeled.
- No Airflow/Spark/Docker/cloud in the MVP. A dbt Cloud + BigQuery polish phase
  is documented in `cloud_migration_plan.md` but intentionally not implemented.
