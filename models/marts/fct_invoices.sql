WITH int_invoices AS (
    SELECT * FROM {{ ref('int_customer_invoices') }}
)

SELECT
    invoice_id,
    customer_id,
    invoice_amount_due,
    invoice_status,
    invoice_date,
    DATE_TRUNC('month', invoice_date)   AS invoice_month,
    DATE_TRUNC('year', invoice_date)    AS invoice_year
FROM int_invoices