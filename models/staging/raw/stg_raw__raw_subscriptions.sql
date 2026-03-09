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
        date(created_at) as created_at,
        date(current_period_start) as current_period_start,
        date(current_period_end) as current_period_end,
        date(canceled_at) as canceled_at,
        date(trial_start) as trial_start,
        date(trial_end) as trial_end

    from source

)

select * from renamed