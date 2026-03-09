WITH int_payments AS (
    SELECT * FROM {{ ref('int_customer_payment') }}
)

SELECT
    payment_id,
    customer_id,
    payment_amount,
    payment_status,
    payment_date,
    DATE_TRUNC('month', payment_date)   AS payment_month,
    DATE_TRUNC('year', payment_date)    AS payment_year
FROM int_payments