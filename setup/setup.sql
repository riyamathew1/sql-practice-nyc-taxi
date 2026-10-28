-- Run from the repo root: duckdb taxi.duckdb < setup/setup.sql
CREATE OR REPLACE VIEW trips AS
  SELECT * FROM read_parquet('data/yellow_tripdata_*.parquet', union_by_name = true);
CREATE OR REPLACE TABLE zones AS
  SELECT * FROM read_csv_auto('data/taxi_zone_lookup.csv', header = true);
SELECT 'trips' AS t, count(*) AS n FROM trips UNION ALL SELECT 'zones', count(*) FROM zones;
