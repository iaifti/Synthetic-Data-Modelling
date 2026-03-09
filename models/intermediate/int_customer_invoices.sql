with customers as(

    select *  from {{ ref('stg_raw__raw_customers') }}

),

invoices as(

    select *  from {{ ref('stg_raw__raw_invoices') }}
)

SELECT
    i.invoice_id,
    i.amount_due        AS invoice_amount_due,
    i.status            AS invoice_status,
    i.created_at        AS invoice_date,

    c.customer_id       AS customer_id,
    c.email             AS customer_email,
    c.created_at        AS customer_created_at

FROM invoices i
LEFT JOIN customers c ON i.customer_id = c.customer_id