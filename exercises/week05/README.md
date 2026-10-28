# Week 5: Window functions

Tables: `trips`, `zones`. Save your work in `solutions/week05/`.

1. Rank pickup zones by trip count within each `Borough` (RANK / DENSE_RANK).
2. For each day, daily revenue and a 7-day rolling average of `total_amount`.
3. Running total of trips per day across the dataset.
4. For each pickup zone, the top 3 trips by `tip_amount` (ROW_NUMBER + filter).
5. Day-over-day change in trip count (LAG).
6. Each trip's `fare_amount` vs. its pickup zone average: the difference and its percentile within the zone (PERCENT_RANK).
7. Assign each pickup zone to a revenue quartile (NTILE(4)).
8. For each `VendorID`, the time gap between consecutive pickups in a single zone of your choice.
