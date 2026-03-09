WITH customers AS (
    SELECT * FROM {{ ref('stg_raw__raw_customers') }}
),
payments AS (
    SELECT * FROM {{ ref('stg_raw__raw_payments') }}
)

SELECT
    p.payment_id,
    p.customer_id,
    p.amount            AS payment_amount,
    p.status            AS payment_status,
    p.created_at        AS payment_date,

    c.email             AS customer_email,
    c.created_at        AS customer_created_at

FROM payments p
LEFT JOIN customers c ON p.customer_id = c.customer_id