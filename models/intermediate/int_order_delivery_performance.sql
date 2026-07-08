-- Delivery timing metrics per order.
-- Grain: one row per order_id.
-- Actual-delivery metrics are only computed when a delivered timestamp exists.
with orders as (

    select * from {{ ref('stg_orders') }}

)

select
    order_id,
    order_status,
    order_purchased_at,
    order_delivered_customer_at,
    order_estimated_delivery_at,

    -- Days from purchase to actual delivery (null until delivered)
    case
        when order_delivered_customer_at is not null
        then date_diff('day', order_purchased_at, order_delivered_customer_at)
    end as purchase_to_delivered_days,

    -- Days from purchase to the promised (estimated) delivery date
    date_diff('day', order_purchased_at, order_estimated_delivery_at)
        as estimated_delivery_days,

    -- Positive = delivered later than promised; negative = early
    case
        when order_delivered_customer_at is not null
        then date_diff('day', order_estimated_delivery_at, order_delivered_customer_at)
    end as delivery_delay_days,

    -- Late only when we have an actual delivery date that is past the estimate
    case
        when order_delivered_customer_at is not null
             and order_delivered_customer_at > order_estimated_delivery_at
        then 1
        when order_delivered_customer_at is not null
        then 0
    end as late_delivery_flag
from orders
