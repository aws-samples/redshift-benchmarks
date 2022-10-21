set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 5 in stream 8 using template query37.tpl and seed 1808510959
select  i_item_id
       ,i_item_desc
       ,i_current_price
 from item, inventory, date_dim, catalog_sales
 where i_current_price between 27 and 27 + 30
 and inv_item_sk = i_item_sk
 and d_date_sk=inv_date_sk
 and d_date between cast('2001-07-20' as date) and (cast('2001-07-20' as date) +  '60 days'::interval)
 and i_manufact_id in (811,675,881,988)
 and inv_quantity_on_hand between 100 and 500
 and cs_item_sk = i_item_sk
 group by i_item_id,i_item_desc,i_current_price
 order by i_item_id
 limit 100;

-- end query 5 in stream 8 using template query37.tpl
