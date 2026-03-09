WITH fct_payments AS (
    SELECT * FROM {{ ref('fct_payments') }}
)

SELECT
    payment_month,
    COUNT(DISTINCT customer_id)         AS total_customers,
    COUNT(payment_id)                   AS total_transactions,
    SUM(payment_amount)                 AS total_revenue,
    AVG(payment_amount)                 AS avg_transaction_value,
    SUM(SUM(payment_amount)) OVER (
        ORDER BY payment_month
    )                                   AS cumulative_revenue
FROM fct_payments
WHERE payment_status = 'succeeded'
GROUP BY payment_month
ORDER BY payment_month