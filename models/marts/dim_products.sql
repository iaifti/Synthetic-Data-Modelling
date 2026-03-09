WITH products AS (
    SELECT * FROM {{ ref('stg_raw__raw_products') }}
)

SELECT
    product_id,
    product_name            AS product_name,
    monthly_price           AS product_price,
    product_type            AS product_type
FROM products