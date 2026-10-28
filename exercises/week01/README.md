# Week 1: Basics and filtering

Tables: `trips`, `zones`. Save your work in `solutions/week01/`.

1. Ops wants a quick look: return 20 trips with `tpep_pickup_datetime`, `trip_distance`, and `total_amount`, sorted by newest pickup.
2. How many trips are in the dataset in total?
3. Finance asks: how many trips were paid in cash (`payment_type` = 2)?
4. List trips longer than 30 miles (`trip_distance`) with a `total_amount` under $20. These look suspicious.
5. How many trips carried 5 or more passengers (`passenger_count`)?
6. Which distinct `RatecodeID` values appear? Order them.
7. Find the 10 highest `tip_amount` values on credit-card trips (`payment_type` = 1).
8. How many trips went to or from JFK under the JFK rate (`RatecodeID` = 2)?
9. Count trips where `store_and_fwd_flag` = 'Y'. What does this flag mean?
