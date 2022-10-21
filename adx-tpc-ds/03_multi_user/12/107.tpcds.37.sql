set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 7 in stream 11 using template query37.tpl and seed 1312581447
select  i_item_id
       ,i_item_desc
       ,i_current_price
 from item, inventory, date_dim, catalog_sales
 where i_current_price between 65 and 65 + 30
 and inv_item_sk = i_item_sk
 and d_date_sk=inv_date_sk
 and d_date between cast('2001-04-10' as date) and (cast('2001-04-10' as date) +  '60 days'::interval)
 and i_manufact_id in (871,960,998,831)
 and inv_quantity_on_hand between 100 and 500
 and cs_item_sk = i_item_sk
 group by i_item_id,i_item_desc,i_current_price
 order by i_item_id
 limit 100;

-- end query 7 in stream 11 using template query37.tpl
