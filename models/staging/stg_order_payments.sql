-- Standardized payment records.
-- Grain: one row per order_id + payment_sequential. order_id is NOT unique here.
with source as (

    select * from {{ ref('olist_order_payments_dataset') }}

)

select
    order_id,
    cast(payment_sequential   as integer) as payment_sequential,
    lower(trim(payment_type))             as payment_type,
    cast(payment_installments as integer) as payment_installments,
    cast(payment_value        as double)  as payment_value
from source
