set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 19 in stream 6 using template query32.tpl and seed 1915349018
select  sum(cs_ext_discount_amt)  as "excess discount amount" 
from 
   catalog_sales 
   ,item 
   ,date_dim
where
i_manufact_id = 19
and i_item_sk = cs_item_sk 
and d_date between '1999-03-03' and 
        (cast('1999-03-03' as date) + '90 days'::interval)
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
          and d_date between '1999-03-03' and
                             (cast('1999-03-03' as date) + '90 days'::interval)
          and d_date_sk = cs_sold_date_sk 
      ) 
limit 100;

-- end query 19 in stream 6 using template query32.tpl
