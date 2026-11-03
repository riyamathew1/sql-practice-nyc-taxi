-- TODO: one row per pickup_date x pickup_borough from {{ "{{ ref('fct_trips') }}" }}.
--   Columns: trips, total_revenue, avg_fare, avg_tip_pct, avg_trip_minutes, airport_trips.
--   Add a 7-day rolling average of trips (window function - reuse your week05 solutions).
--   This is the table your Tableau dashboard reads.
{{ config(enabled=false) }}

select 1 as pickup_date
