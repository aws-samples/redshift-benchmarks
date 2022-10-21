set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 26 in stream 7 using template query20.tpl and seed 696804466
select  i_item_id
       ,i_item_desc 
       ,i_category 
       ,i_class 
       ,i_current_price
       ,sum(cs_ext_sales_price) as itemrevenue 
       ,sum(cs_ext_sales_price)*100/sum(sum(cs_ext_sales_price)) over
           (partition by i_class) as revenueratio
 from	catalog_sales
     ,item 
     ,date_dim
 where cs_item_sk = i_item_sk 
   and i_category in ('Sports', 'Jewelry', 'Men')
   and cs_sold_date_sk = d_date_sk
 and d_date between cast('2000-06-21' as date) 
 				and (cast('2000-06-21' as date) + '30 days'::interval)
 group by i_item_id
         ,i_item_desc 
         ,i_category
         ,i_class
         ,i_current_price
 order by i_category
         ,i_class
         ,i_item_id
         ,i_item_desc
         ,revenueratio
limit 100;

-- end query 26 in stream 7 using template query20.tpl
