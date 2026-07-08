# Metrics Glossary

Definitions for the metrics produced by the Ding12 marts. Keep this in sync with the SQL.

| Metric | Definition |
| --- | --- |
| **Gross orders** | Count of all orders placed in the period, regardless of final status. |
| **Completed orders** | Orders with `order_status = 'delivered'`. |
| **Canceled orders** | Orders with `order_status = 'canceled'`. |
| **Completion rate** | `completed_orders / gross_orders`. Share of orders that reached delivery. |
| **Cancellation rate** | `canceled_orders / gross_orders`. Share of orders that were canceled. |
| **GMV (Gross Merchandise Value)** | Sum of order-item `price + freight_value`. This is a marketplace-transaction view of value, not net revenue. See the GMV assumption in `business_assumptions.md`. |
| **Freight** | Sum of `freight_value` (shipping charged on items). |
| **AOV (Average Order Value)** | `total_gmv / gross_orders`. |
| **Late delivery flag** | 1 when the order was delivered *after* its estimated delivery date, 0 when delivered on/before, null when never delivered. |
| **Delivery delay days** | Actual delivered date minus estimated delivery date, in days. Positive = late, negative = early. Null until delivered. |
| **Purchase-to-delivered days** | Days from purchase timestamp to actual delivery. Null until delivered. |
| **Average review score** | Mean of `review_score` (1–5). |
| **Low review rate** | Share of reviews with `review_score <= 2`. |
| **Late delivery rate** | Late orders / delivered orders (only orders that actually delivered are in the denominator). |
| **Active customers** | Distinct `customer_unique_id` with an order in the period. |

**Divide-by-zero:** all rate metrics use the `safe_divide` macro (`x / nullif(y, 0)`), so an empty denominator yields null rather than an error.
