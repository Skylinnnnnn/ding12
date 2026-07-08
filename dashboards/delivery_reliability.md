# Dashboard — Delivery Reliability

**Primary source:** `mart_delivery_reliability` (grain: order_month).

## Audience
Operations analytics.

## Business questions
- How often are orders delivered late?
- How large are delivery delays?
- Are delivery issues getting better or worse over time?

## Metrics
- delivered orders
- late orders
- late delivery rate
- avg delivery delay days
- avg purchase-to-delivered days

## Suggested charts
- Line: late delivery rate by month.
- Line: avg delivery delay days and avg purchase-to-delivered days by month.
- Bar: delivered vs. late orders by month (stacked).

## Filters
- Month / date range.
- (If extended) customer state or seller state for regional reliability.

## Example insights to look for
- Trend direction of late delivery rate — improving or degrading.
- Months where average delay spikes (capacity or seasonal stress).
- Gap between promised (estimated) and actual delivery time.
