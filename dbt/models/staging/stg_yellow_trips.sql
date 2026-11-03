-- Fully worked example: one staging model per source.
-- Staging = rename, cast, light cleaning. No joins, no business logic.
with source as (

    select * from {{ source('tlc', 'yellow_trips') }}

),

renamed as (

    select
        -- surrogate key: the raw data has no trip id
        {{ dbt_utils.generate_surrogate_key([
            'VendorID', 'tpep_pickup_datetime', 'tpep_dropoff_datetime',
            'PULocationID', 'DOLocationID', 'total_amount'
        ]) }}                                         as trip_id,

        -- ids
        cast(VendorID as integer)                     as vendor_id,
        cast(RatecodeID as integer)                   as rate_code_id,
        cast(PULocationID as integer)                 as pickup_location_id,
        cast(DOLocationID as integer)                 as dropoff_location_id,
        cast(payment_type as integer)                 as payment_type_id,

        -- timestamps
        cast(tpep_pickup_datetime as timestamp)       as pickup_at,
        cast(tpep_dropoff_datetime as timestamp)      as dropoff_at,

        -- trip info
        cast(passenger_count as integer)              as passenger_count,
        cast(trip_distance as double)                 as trip_distance_miles,
        store_and_fwd_flag = 'Y'                      as is_store_and_forward,

        -- money (USD)
        cast(fare_amount as decimal(10, 2))           as fare_amount,
        cast(extra as decimal(10, 2))                 as extra_amount,
        cast(mta_tax as decimal(10, 2))               as mta_tax_amount,
        cast(tip_amount as decimal(10, 2))            as tip_amount,
        cast(tolls_amount as decimal(10, 2))          as tolls_amount,
        cast(improvement_surcharge as decimal(10, 2)) as improvement_surcharge_amount,
        cast(congestion_surcharge as decimal(10, 2))  as congestion_surcharge_amount,
        cast(Airport_fee as decimal(10, 2))           as airport_fee_amount,
        cast(cbd_congestion_fee as decimal(10, 2))    as cbd_congestion_fee_amount,
        cast(total_amount as decimal(10, 2))          as total_amount,

        -- decoded payment type (see README codes)
        case cast(payment_type as integer)
            when 1 then 'credit_card'
            when 2 then 'cash'
            when 3 then 'no_charge'
            when 4 then 'dispute'
            when 0 then 'flex_fare'
            when 5 then 'unknown'
            when 6 then 'voided'
        end                                           as payment_type

    from source
    where tpep_pickup_datetime >= cast('{{ var("start_date") }}' as timestamp)
      and tpep_pickup_datetime <  cast('{{ var("end_date") }}' as timestamp)

)

select * from renamed
