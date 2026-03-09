with 

source as (

    select * from {{ source('raw', 'raw_payments') }}

),

renamed as (

    select
        payment_id,
        subscription_id,
        customer_id,
        amount,
        currency,
        status,
        payment_method,
        created_at,
        failure_code,
        fee

    from source

)

select * from renamed