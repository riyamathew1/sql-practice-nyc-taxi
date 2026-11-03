-- TODO (dbt Fundamentals: "Models" - ref()): join trips to zones twice.
--   from {{ "{{ ref('stg_yellow_trips') }}" }} t
--   left join {{ "{{ ref('stg_taxi_zones') }}" }} pu on t.pickup_location_id = pu.location_id
--   left join {{ "{{ ref('stg_taxi_zones') }}" }} do on t.dropoff_location_id = do.location_id
--   add: trip_duration_minutes (datediff), revenue_per_mile (guard divide-by-zero),
--        is_airport_trip (rate_code_id in (2,3) or airport_fee_amount > 0),
--        pickup_borough, dropoff_borough, pickup_zone, dropoff_zone
--   Your week02 (joins) and week06 (date/time) solutions are the starting point.
{{ config(enabled=false) }}

select 1 as trip_id
