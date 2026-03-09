with 

source as (

    select * from {{ source('raw', 'raw_products') }}

),

renamed as (

    select
        product_id,
        product_name,
        product_type,
        billing_period,
        price,
        monthly_price

    from source

)

select * from renamed