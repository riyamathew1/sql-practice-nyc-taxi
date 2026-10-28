# Week 7: Cleaning messy data

Tables: `trips`, `zones`. Save your work in `solutions/week07/`.

1. Count NULLs in `passenger_count`, `RatecodeID`, `congestion_surcharge`, and `Airport_fee`. Is there a pattern by `payment_type`?
2. How many trips have a negative `fare_amount` or `total_amount`? What `payment_type` do they have?
3. Find trips with `trip_distance` = 0 but `fare_amount` > 0. What might they be?
4. Define outliers in `trip_distance` using the IQR (1.5x rule). How many trips are outliers?
5. Check whether `total_amount` matches the sum of its components (`fare_amount`, `extra`, `mta_tax`, `tip_amount`, `tolls_amount`, `improvement_surcharge`, `congestion_surcharge`, `Airport_fee`, `cbd_congestion_fee`) within $0.01. How many don't?
6. Find `passenger_count` = 0 or > 6. Decide on a cleaning rule and justify it.
7. Find exact duplicate rows across all columns.
8. Create a view `clean_trips` applying your rules. Then compare the average fare before vs. after cleaning.
