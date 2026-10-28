# Week 2: Joins (zones)

Tables: `trips`, `zones`. Save your work in `solutions/week02/`.

1. Show 20 trips with their pickup `Borough` and `Zone` by joining `PULocationID` to `zones.LocationID`.
2. Show each trip's pickup zone AND dropoff zone (join `zones` twice, on `PULocationID` and `DOLocationID`).
3. Which 10 pickup zones have the most trips?
4. How many trips start in Manhattan and end in a different borough?
5. Marketing wants airport trips: count trips whose dropoff zone's `Zone` contains 'Airport'.
6. Which zones in `zones` never appear as a pickup location? (Anti-join.)
7. For each `service_zone`, what is the average `fare_amount` of trips picked up there?
8. Find trips whose `PULocationID` has no match in `zones`, or maps to Borough 'Unknown'/'N/A'. How many are there?
