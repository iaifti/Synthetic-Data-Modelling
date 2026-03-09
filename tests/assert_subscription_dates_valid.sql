SELECT *
FROM {{ ref('fct_subscriptions') }}
WHERE canceled_at < created_at