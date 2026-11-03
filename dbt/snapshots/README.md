# Snapshots (TODO, after the dbt Fundamentals course)

Snapshots track how rows change over time (SCD type 2). TLC zones rarely change, so practice by:
1. Create `snapshots/zones_snapshot.yml` with `strategy: check`, `unique_key: location_id`,
   `check_cols: all`, selecting from `ref('stg_taxi_zones')` (dbt 1.9+ YAML snapshots).
2. Run `dbt snapshot`, edit a zone name in a copy of the lookup, rerun, and query
   `dbt_valid_from` / `dbt_valid_to`.
