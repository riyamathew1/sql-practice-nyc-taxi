-- One-time Snowflake setup for the nyc_taxi dbt project.
-- Run in a Snowsight SQL worksheet as ACCOUNTADMIN (trial accounts have it).
-- Replace <YOUR_SNOWFLAKE_USER> below with your login name.

use role accountadmin;

-- 1. Warehouse: extra-small, suspends after 60 s idle to save trial credits
create warehouse if not exists transforming_wh
  warehouse_size = 'XSMALL'
  auto_suspend = 60
  auto_resume = true
  initially_suspended = true;

-- 2. Database and schemas
create database if not exists nyc_taxi;
create schema if not exists nyc_taxi.raw;        -- loaded files land here
create schema if not exists nyc_taxi.analytics;  -- dbt builds here (plus staging/intermediate/marts)

-- 3. Role for dbt
create role if not exists transformer;
grant usage on warehouse transforming_wh to role transformer;
grant usage, create schema on database nyc_taxi to role transformer;
grant all on schema nyc_taxi.raw to role transformer;
grant all on schema nyc_taxi.analytics to role transformer;
grant all on all tables in schema nyc_taxi.raw to role transformer;
grant all on future tables in schema nyc_taxi.raw to role transformer;
grant role transformer to user <YOUR_SNOWFLAKE_USER>;

use warehouse transforming_wh;
use schema nyc_taxi.raw;

-- 4. File formats and an internal stage for the uploaded files
create file format if not exists parquet_format
  type = parquet
  use_logical_type = true;   -- read TLC timestamps as timestamps, not integers

create file format if not exists csv_format
  type = csv
  skip_header = 1
  field_optionally_enclosed_by = '"';

create stage if not exists tlc_stage
  comment = 'Upload yellow_tripdata_YYYY-MM.parquet and taxi_zone_lookup.csv here';

-- 5. Raw tables (columns match the TLC yellow trip Parquet files, 2025+ schema)
create table if not exists yellow_trips (
  vendorid               integer,
  tpep_pickup_datetime   timestamp_ntz,
  tpep_dropoff_datetime  timestamp_ntz,
  passenger_count        bigint,
  trip_distance          double,
  ratecodeid             bigint,
  store_and_fwd_flag     varchar,
  pulocationid           integer,
  dolocationid           integer,
  payment_type           bigint,
  fare_amount            double,
  extra                  double,
  mta_tax                double,
  tip_amount             double,
  tolls_amount           double,
  improvement_surcharge  double,
  total_amount           double,
  congestion_surcharge   double,
  airport_fee            double,
  cbd_congestion_fee     double,
  request_source         varchar,
  _source_file           varchar,
  _loaded_at             timestamp_ntz default current_timestamp()
);

create table if not exists taxi_zones (
  locationid    integer,
  borough       varchar,
  zone          varchar,
  service_zone  varchar
);

-- 6. Check the uploads are there (see snowflake/README.md)
list @tlc_stage;

-- 7. Load. Re-running is safe: COPY INTO skips files it has already loaded.
copy into yellow_trips
  from @tlc_stage
  pattern = '.*yellow_tripdata_.*[.]parquet'
  file_format = (format_name = 'parquet_format')
  match_by_column_name = case_insensitive
  include_metadata = (_source_file = metadata$filename)
  on_error = 'abort_statement';

copy into taxi_zones
  from @tlc_stage
  files = ('taxi_zone_lookup.csv')
  file_format = (format_name = 'csv_format');

-- 8. Sanity checks (expect ~10.7M trips for Jun-Aug 2026 and 265 zones)
select _source_file, count(*) as trips from yellow_trips group by 1 order by 1;
select count(*) as zones from taxi_zones;
