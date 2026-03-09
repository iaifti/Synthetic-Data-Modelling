WITH fct_subs AS (
    SELECT * FROM {{ ref('fct_subscriptions') }}
),

monthly AS (
    SELECT
        DATE_TRUNC('month', created_at)         AS month,
        COUNT(subscription_id)                  AS total_subscriptions,
        SUM(is_active)                          AS active_subscriptions,
        SUM(is_churned)                         AS churned_subscriptions
    FROM fct_subs
    GROUP BY DATE_TRUNC('month', created_at)
)

SELECT
    month,
    total_subscriptions,
    active_subscriptions,
    churned_subscriptions,
    ROUND(
        churned_subscriptions / NULLIF(total_subscriptions, 0) * 100
    , 2)                                        AS churn_rate_pct,
    ROUND(
        active_subscriptions / NULLIF(total_subscriptions, 0) * 100
    , 2)                                        AS retention_rate_pct
FROM monthly
ORDER BY month