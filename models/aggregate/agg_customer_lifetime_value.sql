WITH fct_payments AS (
    SELECT * FROM {{ ref('fct_payments') }}
),
dim_customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
)

SELECT
    p.customer_id,
    c.email                             AS customer_email,
    c.cohort_month,
    c.customer_age_days,
    COUNT(p.payment_id)                 AS total_payments,
    SUM(p.payment_amount)               AS total_revenue,
    ROUND(AVG(p.payment_amount), 2)     AS avg_payment_value,
    MIN(p.payment_date)                 AS first_payment_date,
    MAX(p.payment_date)                 AS last_payment_date,
    DATEDIFF('day', 
        MIN(p.payment_date), 
        MAX(p.payment_date))            AS customer_lifespan_days,

    ROUND(AVG(p.payment_amount) * 
        COUNT(p.payment_id), 2)         AS clv
FROM fct_payments p
LEFT JOIN dim_customers c ON p.customer_id = c.customer_id
WHERE p.payment_status = 'succeeded'
GROUP BY 
    p.customer_id, c.email, 
    c.cohort_month, c.customer_age_days
ORDER BY clv DESC
