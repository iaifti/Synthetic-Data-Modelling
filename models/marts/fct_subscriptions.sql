WITH int_subs AS (
    SELECT * FROM {{ ref('int_customer_subscriptions') }}
)

SELECT
    subscription_id,
    customer_id,
    customer_email,
    product_id,
    product_name,
    product_price,
    product_type,
    status,
    created_at,
    canceled_at,

    CASE WHEN status = 'active' THEN 1 ELSE 0 END       AS is_active,
    CASE WHEN status = 'canceled' THEN 1 ELSE 0 END    AS is_churned,
    DATEDIFF('day', created_at, 
        COALESCE(canceled_at, CURRENT_DATE))            AS subscription_age_days
FROM int_subs