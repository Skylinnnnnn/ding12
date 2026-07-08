# Dashboard — Seller Performance

> **Live page:** https://skylinnnnnn.github.io/ding12/seller_performance/ · built
> in [`reports/pages/seller_performance.md`](../reports/pages/seller_performance.md).
> This file is the spec; the Evidence page is the implementation.

**Primary source:** `mart_seller_performance` (grain: seller_id).

## Audience
Marketplace operations / seller management.

## Business questions
- Which sellers drive the most GMV?
- Which sellers are high value but have poor customer experience?
- Which sellers may need operational support?

## Metrics
- seller orders, seller GMV
- average item price, total freight, average freight
- distinct products sold
- average review score
- late delivery rate

## Suggested charts
- Bar: top sellers by GMV.
- Scatter: seller GMV (x) vs. average review score (y), sized by orders — the
  bottom-right quadrant is "high value, low satisfaction."
- Scatter: seller GMV vs. late delivery rate — flags high-value delivery risk.
- Table: seller leaderboard with GMV, review score, late rate, products sold.

## Filters
- Seller state.
- Minimum order count (to hide low-volume noise).
- GMV threshold.

## Example insights to look for
- High-GMV sellers with review scores or late rates worse than the marketplace
  average — priority for operational intervention.
- Sellers with narrow product ranges but outsized GMV (concentration risk).
