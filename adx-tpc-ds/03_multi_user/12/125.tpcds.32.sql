set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 25 in stream 11 using template query32.tpl and seed 1382337658
select  sum(cs_ext_discount_amt)  as "excess discount amount" 
from 
   catalog_sales 
   ,item 
   ,date_dim
where
i_manufact_id = 659
and i_item_sk = cs_item_sk 
and d_date between '2002-03-30' and 
        (cast('2002-03-30' as date) + '90 days'::interval)
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
          and d_date between '2002-03-30' and
                             (cast('2002-03-30' as date) + '90 days'::interval)
          and d_date_sk = cs_sold_date_sk 
      ) 
limit 100;

-- end query 25 in stream 11 using template query32.tpl
