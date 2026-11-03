-- TODO: one row per zone from {{ "{{ ref('stg_taxi_zones') }}" }}.
--   Add is_airport (zone names containing 'Airport') and is_manhattan_core
--   (borough = 'Manhattan' and service_zone = 'Yellow Zone').
{{ config(enabled=false) }}

select 1 as location_id
