with 

source as (

    select * from {{ source('raw', 'raw_customers') }}

),

renamed as (

    select
        customer_id,
        email,
        created_at,
        country,
        customer_type,
        marketing_channel

    from source

)

select * from renamed