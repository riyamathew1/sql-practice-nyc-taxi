# Week 6: Date and time

Tables: `trips`, `zones`. Save your work in `solutions/week06/`.

1. Trips per hour of day from `tpep_pickup_datetime`. What is the peak hour?
2. Trip duration in minutes (`tpep_dropoff_datetime` - `tpep_pickup_datetime`): the average by hour of day.
3. Weekday vs. weekend: average `fare_amount` and `tip_amount`.
4. Average speed (mph) by hour, using `trip_distance` and duration. Exclude zero-duration trips.
5. Trips per calendar month. Are there pickups dated outside the months you downloaded? How many?
6. Which day of week has the most late-night (midnight-4 AM) pickups from Manhattan?
7. Bucket trips into 15-minute pickup windows (date_trunc / time_bucket) for a single day and find the busiest window.
8. Find trips where dropoff is before pickup, or duration exceeds 24 hours.
