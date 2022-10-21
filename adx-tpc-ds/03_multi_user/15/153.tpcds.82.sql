set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 53 in stream 14 using template query82.tpl and seed 790787444
select  i_item_id
       ,i_item_desc
       ,i_current_price
 from item, inventory, date_dim, store_sales
 where i_current_price between 83 and 83+30
 and inv_item_sk = i_item_sk
 and d_date_sk=inv_date_sk
 and d_date between cast('2002-05-06' as date) and (cast('2002-05-06' as date) +  '60 days'::interval)
 and i_manufact_id in (199,6,833,700)
 and inv_quantity_on_hand between 100 and 500
 and ss_item_sk = i_item_sk
 group by i_item_id,i_item_desc,i_current_price
 order by i_item_id
 limit 100;

-- end query 53 in stream 14 using template query82.tpl
