# Progress Log

| Date (YYYY-MM-DD) | Week | Problems done | Time spent | What I learned | Stuck on / next |
|---|---|---|---|---|---|
| | 01 | | | | |
| | 02 | | | | |
| | 03 | | | | |
| | 04 | | | | |
| | 05 | | | | |
| | 06 | | | | |
| | 07 | | | | |
| | 08 | | | | |

## Notes

## dbt + Snowflake checklist
- [x] venv + dbt installed, `dbt debug` passes on DuckDB
- [x] `stg_yellow_trips` built and tested (worked example)
- [ ] dbt Fundamentals course finished
- [ ] `stg_taxi_zones` done + tests
- [ ] `int_trips_enriched` done
- [ ] `dim_zones`, `fct_trips` done; data-quality choice written down
- [ ] `mart_daily_demand_revenue` done (with 7-day rolling average)
- [ ] All columns documented; lineage screenshot in README
- [ ] Snowflake trial set up, data loaded (`snowflake/setup.sql`)
- [ ] `dbt build --target snowflake` passes
- [ ] Incremental `fct_trips`
- [ ] Snapshot on zones
- [ ] Tableau Public dashboard on the mart
- [ ] Resume Projects line with real row counts
