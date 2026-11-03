-- TODO: one row per valid trip, selected from {{ "{{ ref('int_trips_enriched') }}" }}.
--   Drop rows that fail data quality (negative fare, zero distance, dropoff before pickup)
--   - or keep them with an is_valid flag. Write down which choice you made and why.
--
-- TODO (incremental, after the "Materializations" lesson):
--   change to {{ "{{ config(materialized='incremental', unique_key='trip_id') }}" }} and add
--     {{ "{% if is_incremental() %}" }} where pickup_at > (select max(pickup_at) from {{ "{{ this }}" }}) {{ "{% endif %}" }}
--   Load a new month of parquet, run `dbt run -s fct_trips`, and check only new rows are added.
{{ config(enabled=false) }}

select 1 as trip_id
