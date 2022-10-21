set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 6 in stream 4 using template query32.tpl and seed 1728936517
select  sum(cs_ext_discount_amt)  as "excess discount amount" 
from 
   catalog_sales 
   ,item 
   ,date_dim
where
i_manufact_id = 518
and i_item_sk = cs_item_sk 
and d_date between '2001-02-01' and 
        (cast('2001-02-01' as date) + '90 days'::interval)
and d_date_sk = cs_sold_date_sk 
and cs_ext_discount_amt  
     > ( 
         select 
            1.3 * avg(cs_ext_discount_amt) 
         from 
            catalog_sales 
           ,date_dim
         where 
              cs_item_sk = i_item_sk 
          and d_date between '2001-02-01' and
                             (cast('2001-02-01' as date) + '90 days'::interval)
          and d_date_sk = cs_sold_date_sk 
      ) 
limit 100;

-- end query 6 in stream 4 using template query32.tpl
