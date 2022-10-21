set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 20 in stream 3 using template query96.tpl and seed 2022523795
select  count(*) 
from store_sales
    ,household_demographics 
    ,time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk   
    and ss_hdemo_sk = household_demographics.hd_demo_sk 
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 8
    and time_dim.t_minute >= 30
    and household_demographics.hd_dep_count = 3
    and store.s_store_name = 'ese'
order by count(*)
limit 100;

-- end query 20 in stream 3 using template query96.tpl
