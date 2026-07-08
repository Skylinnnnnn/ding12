-- Order-item level fact focused on product category economics.
-- Grain: one row per order_id + order_item_id.
with order_items as (

    select * from {{ ref('stg_order_items') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

products as (

    select * from {{ ref('stg_products') }}

),

category as (

    select * from {{ ref('stg_product_category_translation') }}

)

select
    order_items.order_id,
    order_items.order_item_id,
    order_items.product_id,

    products.product_category_name,
    -- ~610 Olist products have no category; bucket them as 'unknown' so they
    -- aggregate visibly instead of collapsing into a null group.
    coalesce(category.product_category_name_english, products.product_category_name, 'unknown')
        as product_category_name_english,

    orders.order_status,
    cast(orders.order_purchased_at as date) as order_date,

    order_items.price,
    order_items.freight_value
from order_items
left join orders   on order_items.order_id   = orders.order_id
left join products on order_items.product_id = products.product_id
left join category on products.product_category_name = category.product_category_name
