# Learning plan: dbt Fundamentals → this repo

Course: https://learn.getdbt.com/courses/dbt-fundamentals. The course uses Jaffle Shop; after each module, repeat it here on the taxi data.

| Course module | Do it in this repo | Done when |
|---|---|---|
| Who is an analytics engineer | Read `models/staging/stg_yellow_trips.sql`, note what is staging vs. business logic | You can explain raw → staging → marts |
| Set up dbt | `dbt debug` on `dev_duckdb` (already works); later `--target snowflake` | All checks passed |
| Models | Finish `stg_taxi_zones.sql` (remove `enabled=false`) | `dbt run -s stg_taxi_zones` |
| Models (`ref`, DAG) | Finish `int_trips_enriched.sql`, `dim_zones.sql` | `dbt build -s +int_trips_enriched` |
| Sources | Read `sources.yml`; add `freshness:` to `yellow_trips` | `dbt source freshness` |
| Tests | Add tests for `stg_taxi_zones`; uncomment the `relationships` test; turn the singular test on `fct_trips` to error | `dbt test` with no errors |
| Documentation | Add `description:` to every column; `dbt docs generate && dbt docs serve` | Lineage graph screenshot in README |
| Deployment | Run the full project on Snowflake (`snowflake/README.md`) | `dbt build --target snowflake` green |
| After the course | Incremental `fct_trips` (TODO in file); snapshot (`snapshots/README.md`); Tableau dashboard on `mart_daily_demand_revenue` | Resume project line |

## Your SQL exercises → dbt layers

| Exercise week | Topic | Where it goes in dbt |
|---|---|---|
| 01 | Basics and filtering | Staging: `where` filters, column selection (`stg_yellow_trips`) |
| 02 | Joins (zones) | Intermediate: `int_trips_enriched` (pickup/dropoff zone joins) |
| 03 | Aggregation | Marts: `mart_daily_demand_revenue` |
| 04 | CTEs and subqueries | Every model: dbt style is import CTEs → logic CTEs → final select |
| 05 | Window functions | Marts: 7-day rolling averages in `mart_daily_demand_revenue` |
| 06 | Date and time | Intermediate: trip duration, pickup date/hour |
| 07 | Cleaning messy data | Staging casts + tests (`schema.yml`, `tests/assert_no_negative_fare_or_zero_distance.sql`) |
| 08 | Query performance | Materializations: view vs table vs incremental (`fct_trips`) |

Keep writing standalone answers in `solutions/` for interview practice; copy the best ones into models.
