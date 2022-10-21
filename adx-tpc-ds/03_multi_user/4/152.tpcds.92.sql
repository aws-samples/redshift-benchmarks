set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 52 in stream 3 using template query92.tpl and seed 488013383
select  
   sum(ws_ext_discount_amt)  as "Excess Discount Amount" 
from 
    web_sales 
   ,item 
   ,date_dim
where
i_manufact_id = 384
and i_item_sk = ws_item_sk 
and d_date between '1999-01-12' and 
        (cast('1999-01-12' as date) + '90 days'::interval)
and d_date_sk = ws_sold_date_sk 
and ws_ext_discount_amt  
     > ( 
         SELECT 
            1.3 * avg(ws_ext_discount_amt) 
         FROM 
            web_sales 
           ,date_dim
         WHERE 
              ws_item_sk = i_item_sk 
          and d_date between '1999-01-12' and
                             (cast('1999-01-12' as date) + '90 days'::interval)
          and d_date_sk = ws_sold_date_sk 
      ) 
order by sum(ws_ext_discount_amt)
limit 100;

-- end query 52 in stream 3 using template query92.tpl
