--q07
select tip_amount from trips 
where payment_type = 1
order by tip_amount desc
limit 10;
