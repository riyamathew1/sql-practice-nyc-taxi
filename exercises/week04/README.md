# Week 4: CTEs and subqueries

Tables: `trips`, `zones`. Save your work in `solutions/week04/`.

1. Using a CTE, find pickup zones whose average `fare_amount` is above the overall average.
2. Find trips whose `total_amount` is more than 3x the average for their pickup zone (correlated subquery or CTE).
3. For each pickup borough, which single dropoff zone is most popular?
4. Top 5 pickup zones by revenue; then, for only those zones, the split of `payment_type`.
5. What share of trips start in a zone that appears in the top 10 dropoff zones? (IN subquery.)
6. Build a CTE pipeline: clean trips, then per-zone totals, then rank by tip rate. Return the top 10.
7. Which `VendorID` has a higher average `trip_distance` on JFK-rate trips (`RatecodeID` = 2)? Use a scalar subquery for comparison.
