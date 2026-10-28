# Week 8: Query performance

Tables: `trips`, `zones`. Save your work in `solutions/week08/`.

1. Run EXPLAIN on a `SELECT count(*) FROM trips`. What operators do you see?
2. Compare EXPLAIN ANALYZE for `SELECT *` vs. `SELECT fare_amount` from `trips` with LIMIT. Why does column projection matter for parquet?
3. Filter on `tpep_pickup_datetime` for a single day. Does EXPLAIN show the filter pushed into the parquet scan?
4. Query a single file directly with `read_parquet('data/yellow_tripdata_YYYY-MM.parquet')` vs. the glob view. Compare timings (`.timer on`).
5. Use `parquet_metadata('data/...')` to inspect row groups and min/max stats for `tpep_pickup_datetime`. How does that enable pruning?
6. Materialize `trips` into a DuckDB table. Re-time a heavy aggregation (zone pair counts) on the view vs. the table.
7. Rewrite a correlated subquery from Week 4 as a join or window and compare EXPLAIN ANALYZE.
8. Write a partitioned parquet export by month (COPY ... PARTITION_BY) and test a query that only touches one partition.
