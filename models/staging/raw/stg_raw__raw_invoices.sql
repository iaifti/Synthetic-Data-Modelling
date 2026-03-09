with 

source as (

    select * from {{ source('raw', 'raw_invoices') }}

),

renamed as (

    select
        invoice_id,
        subscription_id,
        customer_id,
        payment_id,
        amount_due,
        amount_paid,
        status,
        created_at,
        due_date,
        paid_at

    from source

)

select * from renamed