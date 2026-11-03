-- TODO (dbt Fundamentals: "Models"): build this staging model, then delete the config line.
--   1. select from {{ "{{ source('tlc', 'taxi_zones') }}" }}
--   2. rename: LocationID -> location_id, Borough -> borough, Zone -> zone_name,
--      service_zone -> service_zone
--   3. cast location_id to integer; treat 'N/A' / 'Unknown' boroughs as null
{{ config(enabled=false) }}

select 1 as location_id
