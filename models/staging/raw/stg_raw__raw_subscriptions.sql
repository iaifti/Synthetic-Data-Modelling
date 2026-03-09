with 

source as (

    select * from {{ source('raw', 'raw_subscriptions') }}

),

renamed as (

    select
        subscription_id,
        customer_id,
        product_id,
        status,
        created_at,
        current_period_start,
        current_period_end,
        canceled_at,
        trial_start,
        trial_end

    from source

)

select * from renamed