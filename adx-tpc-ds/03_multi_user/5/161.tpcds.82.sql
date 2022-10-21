set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 61 in stream 4 using template query82.tpl and seed 1065844463
select  i_item_id
       ,i_item_desc
       ,i_current_price
 from item, inventory, date_dim, store_sales
 where i_current_price between 47 and 47+30
 and inv_item_sk = i_item_sk
 and d_date_sk=inv_date_sk
 and d_date between cast('2000-05-17' as date) and (cast('2000-05-17' as date) +  '60 days'::interval)
 and i_manufact_id in (448,911,959,887)
 and inv_quantity_on_hand between 100 and 500
 and ss_item_sk = i_item_sk
 group by i_item_id,i_item_desc,i_current_price
 order by i_item_id
 limit 100;

-- end query 61 in stream 4 using template query82.tpl
