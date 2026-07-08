# Dashboard — Executive Overview

**Primary source:** `mart_daily_marketplace_metrics` (grain: order_date), with
`mart_category_performance` for the category breakdown.

## Audience
Business leadership / marketplace analytics manager.

## Business questions
- Are orders and GMV growing?
- What is the completion / cancellation trend?
- Which time periods show unusual performance?

## Metrics
- gross orders, completed orders, canceled orders
- GMV, AOV, active customers
- completion rate, cancellation rate

## Suggested charts
- Line: daily/weekly GMV and gross orders over time.
- Line: completion rate and cancellation rate over time.
- KPI tiles: GMV, AOV, active customers, completion rate (period totals).
- Bar: top categories by GMV (from `mart_category_performance`).

## Filters
- Date range, month, week.
- Customer state (for regional slicing).

## Example insights to look for
- Seasonal spikes/dips in orders and GMV.
- Periods where cancellation rate deviates from its baseline.
- Whether AOV is rising (larger baskets) or volume-driven growth.
