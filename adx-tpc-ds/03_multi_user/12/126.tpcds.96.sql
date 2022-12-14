set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 26 in stream 11 using template query96.tpl and seed 697056
select  count(*) 
from store_sales
    ,household_demographics 
    ,time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk   
    and ss_hdemo_sk = household_demographics.hd_demo_sk 
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 20
    and time_dim.t_minute >= 30
    and household_demographics.hd_dep_count = 0
    and store.s_store_name = 'ese'
order by count(*)
limit 100;

-- end query 26 in stream 11 using template query96.tpl
