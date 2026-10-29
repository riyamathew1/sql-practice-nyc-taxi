--q01
Select tpep_pickup_datetime, trip_distance, total_amount from trips
order by tpep_pickup_datetime desc
limit 20;
