# Dashboard — Customer Experience

**Primary source:** `mart_customer_experience` (grain: order_month), cross-read
with `mart_delivery_reliability` for the delivery link.

## Audience
Customer insights / CX team.

## Business questions
- How do reviews trend over time?
- Are late deliveries associated with lower review scores?
- Which segments have worse customer experience?

## Metrics
- review count
- avg review score
- low review count
- low review rate
- late delivery rate
- avg delivery delay days

## Suggested charts
- Line: avg review score by month.
- Line (dual axis): low review rate vs. late delivery rate by month — visualizes
  the CX↔ops relationship.
- Bar: review score distribution (1–5) for the selected period.

## Filters
- Month / date range.
- Customer state (segment slicing).

## Example insights to look for
- Months where low review rate rises alongside late delivery rate (evidence that
  delivery reliability drives satisfaction).
- Whether overall satisfaction is trending up or down.
- Segments (states) with persistently lower scores.
