SELECT p.*
FROM {{ ref('fct_payments') }} p
LEFT JOIN {{ ref('dim_customers') }} c 
    ON p.customer_id = c.customer_id
WHERE c.customer_id IS NULL