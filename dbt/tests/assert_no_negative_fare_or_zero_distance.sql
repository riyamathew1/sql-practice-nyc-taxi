-- Singular data-quality test: returns the bad rows. Zero rows = pass.
-- Raw TLC data really contains these, so it is set to warn. Decide in fct_trips
-- whether to filter or flag them, then point this test at fct_trips and make it error.
{{ config(severity='warn') }}

select trip_id, fare_amount, trip_distance_miles
from {{ ref('stg_yellow_trips') }}
where fare_amount < 0
   or trip_distance_miles <= 0
