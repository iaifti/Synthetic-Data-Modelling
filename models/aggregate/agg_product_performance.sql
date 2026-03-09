WITH int_product_revenue AS (
    SELECT * FROM {{ ref('int_product_revenue') }}
)

SELECT
    product_id,
    product_name,
    product_type,
    product_price,
    COUNT(DISTINCT customer_id)                 AS total_customers,
    COUNT(DISTINCT subscription_id)             AS total_subscriptions,
    SUM(CASE WHEN subscription_status = 'active' 
        THEN 1 ELSE 0 END)                      AS active_subscriptions,
    SUM(CASE WHEN subscription_status = 'canceled' 
        THEN 1 ELSE 0 END)                      AS cancelled_subscriptions,
    SUM(CASE WHEN payment_status = 'succeeded'
        THEN payment_amount ELSE 0 END)         AS total_revenue,
    ROUND(AVG(CASE WHEN payment_status = 'succeeded'
        THEN payment_amount END) , 2)               AS avg_revenue_per_payment,
    ROUND(
        SUM(CASE WHEN subscription_status = 'cancelled' 
            THEN 1 ELSE 0 END) / 
        NULLIF(COUNT(DISTINCT subscription_id), 0) * 100
    , 2)                                        AS churn_rate_pct
FROM int_product_revenue
GROUP BY 
    product_id, product_name, 
    product_type, product_price
ORDER BY total_revenue DESC