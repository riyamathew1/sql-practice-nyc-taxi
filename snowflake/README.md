# Loading the TLC data into Snowflake

## 1. Get the files
You already have them in `data/` (downloaded by `setup/download_data.sh`). To fetch them again:

```bash
# Pattern (verified 2026-11-03): https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_YYYY-MM.parquet
for m in 2026-06 2026-07 2026-08; do
  curl -fLo data/yellow_tripdata_$m.parquet \
    https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_$m.parquet
done
curl -fLo data/taxi_zone_lookup.csv https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv
```
Each month is ~60 MB. TLC publishes with a ~2 month lag: https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

## 2. Create the objects
1. Sign up for a free trial: https://signup.snowflake.com/ (Standard edition, AWS, US East).
2. In Snowsight: **Projects → Worksheets → + SQL Worksheet**.
3. Paste `snowflake/setup.sql`, replace `<YOUR_SNOWFLAKE_USER>`, and run **steps 1–5 only**.

## 3. Upload the files to the stage (Snowsight UI)
1. **Data → Databases → NYC_TAXI → RAW → Stages → TLC_STAGE**.
2. Click **+ Files**, drag in the three `.parquet` files and `taxi_zone_lookup.csv`, click **Upload**
   (the Snowsight upload limit is 250 MB per file — these are well under it).
3. Back in the worksheet, run steps 6–8. Expect ~10.7M trips and 265 zones.

Alternative to the UI (SnowSQL / Snowflake CLI): `PUT file://data/*.parquet @nyc_taxi.raw.tlc_stage;`

## 4. Point dbt at Snowflake
```bash
export SNOWFLAKE_ACCOUNT=xxxxxxx-yyyyyyy     # Snowsight → your name → Account → "Account identifier"
export SNOWFLAKE_USER=...
export SNOWFLAKE_PASSWORD=...                # keep in a gitignored .env, never commit
export SNOWFLAKE_ROLE=TRANSFORMER SNOWFLAKE_WAREHOUSE=TRANSFORMING_WH SNOWFLAKE_DATABASE=NYC_TAXI
cd dbt && dbt debug --target snowflake && dbt build --target snowflake
```
Add the `snowflake:` block from `dbt/profiles.yml.example` to `~/.dbt/profiles.yml` first.
Trial accounts usually require MFA for password logins; if `dbt debug` fails on auth, switch to key-pair auth
(https://docs.getdbt.com/docs/core/connect-data-platform/snowflake-setup#key-pair-authentication).
