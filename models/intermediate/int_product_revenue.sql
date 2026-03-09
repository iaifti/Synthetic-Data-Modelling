with payments as(

    select * from {{ ref('stg_raw__raw_payments') }}
),
subscriptions as(

    select * from {{ ref('stg_raw__raw_subscriptions') }}
),

products as(

    select * from {{ ref('stg_raw__raw_products') }}
)

SELECT
    s.subscription_id,
    s.customer_id,
    s.status            AS subscription_status,
    s.created_at,
    s.canceled_at,

    p.product_id,
    p.product_name      AS product_name,
    p.monthly_price     AS product_price,
    p.product_type      AS product_type,

    pay.payment_id,
    pay.amount          AS payment_amount,
    pay.status          AS payment_status,
    pay.created_at      AS payment_date

FROM subscriptions s
LEFT JOIN products  p   ON s.product_id   = p.product_id
LEFT JOIN payments  pay ON s.customer_id  = pay.customer_id