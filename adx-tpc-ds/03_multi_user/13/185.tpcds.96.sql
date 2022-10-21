set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 85 in stream 12 using template query96.tpl and seed 1312323156
select  count(*) 
from store_sales
    ,household_demographics 
    ,time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk   
    and ss_hdemo_sk = household_demographics.hd_demo_sk 
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 20
    and time_dim.t_minute >= 30
    and household_demographics.hd_dep_count = 8
    and store.s_store_name = 'ese'
order by count(*)
limit 100;

-- end query 85 in stream 12 using template query96.tpl
