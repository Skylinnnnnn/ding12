# Interview Story

Talking points for presenting Ding12 in interviews.

## 60-second pitch
> Ding12 is a marketplace analytics project. I took the public Olist Brazilian
> e-commerce dataset — around 100k orders across thousands of sellers — and built
> a tested, documented dbt project that turns raw CSVs into dashboard-ready marts
> for marketplace growth, seller performance, delivery reliability, customer
> experience, category performance, and payment behavior. It runs end-to-end
> locally on dbt Core and DuckDB, with data-quality tests and lineage docs, and
> I've scoped a dbt Cloud + BigQuery version as the production-like next step.

## 3-minute deep dive
- **Problem framing:** a marketplace leader needs to know if the business is
  growing, which sellers create value vs. risk, whether deliveries are reliable,
  and how customers feel — so I organized the marts around those questions.
- **Architecture:** raw seeds → **staging** (clean/standardize/cast) →
  **intermediate** (reusable business logic and joins) → **marts** (aggregated,
  dashboard-ready). Staging and intermediate are views; marts are tables.
- **Data quality:** unique/not_null on real keys, relationship tests across the
  order graph, accepted-values tests on status/payment/review fields, plus two
  singular tests (no negative amounts, no delivered-before-purchased rows).
- **Business insight:** I can join seller GMV to review score and late-delivery
  rate to surface *high-value-but-risky* sellers — the kind of insight an ops or
  marketplace team acts on.

## Why dbt
Version-controlled SQL, dependency-managed `ref()` lineage, tests as first-class
citizens, and auto-generated docs. It's how modern analytics teams keep
transformations reviewable and trustworthy instead of buried in BI tools.

## Why DuckDB
Zero-infrastructure, fast, columnar, runs entirely in a local file. Perfect for a
reproducible portfolio: anyone can clone the repo, drop in the CSVs, and get an
identical warehouse in seconds — no cloud account needed.

## How data quality was handled
I let the real data teach me: Olist has legitimately non-unique `order_id`s in
payments, reviews, and order_items, so I only put uniqueness tests on true keys
and documented the grain of every model. Where a naive test would fail on real
messiness, I fixed the assumption rather than forcing the data.

## Example business insights to highlight
- Late deliveries track with lower review scores (CX ↔ ops link).
- A handful of categories and sellers concentrate most GMV.
- Payment mix leans on credit card with multi-installment financing.

## What I'd improve next
Add snapshots/incremental models, a cohort/retention view via
`customer_unique_id`, model geolocation for delivery-distance analysis, and
promote the project to dbt Cloud + BigQuery with scheduled jobs.
