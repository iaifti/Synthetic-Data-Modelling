with customers as(

    select *  from {{ ref('stg_raw__raw_customers') }}

),

subscriptions as(

    select *  from {{ ref('stg_raw__raw_subscriptions') }}
),

products AS (

    SELECT * FROM {{ ref('stg_raw__raw_products') }}
)

SELECT
    s.subscription_id,
    s.product_id,
    s.status,
    s.created_at,
    s.canceled_at,

    c.customer_id          AS customer_id,
    c.email         AS customer_email,

    p.product_name          AS product_name,
    p.monthly_price         AS product_price,
    p.product_type          AS product_type

FROM subscriptions s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN products  p ON s.product_id  = p.product_id