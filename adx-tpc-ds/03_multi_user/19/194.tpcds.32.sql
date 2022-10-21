set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 94 in stream 18 using template query32.tpl and seed 894040143
select  sum(cs_ext_discount_amt)  as "excess discount amount" 
from 
   catalog_sales 
   ,item 
   ,date_dim
where
i_manufact_id = 144
and i_item_sk = cs_item_sk 
and d_date between '1999-03-06' and 
        (cast('1999-03-06' as date) + '90 days'::interval)
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
          and d_date between '1999-03-06' and
                             (cast('1999-03-06' as date) + '90 days'::interval)
          and d_date_sk = cs_sold_date_sk 
      ) 
limit 100;

-- end query 94 in stream 18 using template query32.tpl
