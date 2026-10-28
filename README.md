# SQL Practice: NYC Taxi Data

The goal is to practice SQL on real NYC TLC yellow taxi trip data with [DuckDB](https://duckdb.org), across 8 weekly themes.

## How to run
1. Install DuckDB: `pip install duckdb` (Python), or the CLI from https://duckdb.org/docs/installation (`brew install duckdb` on macOS).
2. Download data (1-3 of the latest published months, default 3):
   `bash setup/download_data.sh 3` (or pin an end month: `bash setup/download_data.sh 2 2026-07`)
   Python alternative: `python setup/download_data.py 3`
3. Build the database from the repo root: `duckdb taxi.duckdb < setup/setup.sql`
4. Open `exercises/weekNN/README.md`, write your queries in `solutions/weekNN/`, and log your progress in `PROGRESS.md`.

## Tables
- `trips`: a view over the parquet files. Key columns: `VendorID, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count, trip_distance, RatecodeID, store_and_fwd_flag, PULocationID, DOLocationID, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, total_amount, congestion_surcharge, Airport_fee, cbd_congestion_fee, request_source` (the newest columns vary by month; `union_by_name` handles that).
- `zones`: `LocationID, Borough, Zone, service_zone`.

Data dictionary: https://www.nyc.gov/assets/tlc/downloads/pdf/data_dictionary_trip_records_yellow.pdf
Codes: payment_type 1=Credit card, 2=Cash, 3=No charge, 4=Dispute, 0/5/6=Flex/Unknown/Voided; RatecodeID 1=Standard, 2=JFK, 3=Newark, 4=Nassau/Westchester, 5=Negotiated, 6=Group, 99=Unknown.

Data files are gitignored. Re-run the download script on a new machine.
