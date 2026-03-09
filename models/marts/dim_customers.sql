WITH customers AS (
    SELECT * FROM {{ ref('stg_raw__raw_customers') }}
)

SELECT
    customer_id,
    email,
    created_at,

    DATEDIFF('day', created_at, CURRENT_DATE)   AS customer_age_days,
    DATE_TRUNC('month', created_at)             AS cohort_month
FROM customers