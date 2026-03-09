WITH fct_subs AS (
    SELECT * FROM {{ ref('fct_subscriptions') }}
)

SELECT
    DATE_TRUNC('month', created_at)     AS month,
    COUNT(subscription_id)              AS total_subscriptions,
    COUNT(CASE WHEN is_active = 1 
          THEN subscription_id END)     AS active_subscriptions,
    SUM(CASE WHEN is_active = 1 
        THEN product_price ELSE 0 END)  AS mrr,
    SUM(product_price)                  AS total_arr
FROM fct_subs
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month