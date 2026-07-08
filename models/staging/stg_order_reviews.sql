-- Standardized customer reviews.
-- Grain: one row per review record. Neither review_id nor order_id is unique
-- (some orders have multiple reviews; some review_ids repeat).
with source as (

    select * from {{ ref('olist_order_reviews_dataset') }}

)

select
    review_id,
    order_id,
    cast(review_score as integer) as review_score,
    review_comment_title,
    review_comment_message,
    cast(review_creation_date   as timestamp) as review_created_at,
    cast(review_answer_timestamp as timestamp) as review_answered_at
from source
