set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 63 in stream 19 using template query37.tpl and seed 1129303678
select  i_item_id
       ,i_item_desc
       ,i_current_price
 from item, inventory, date_dim, catalog_sales
 where i_current_price between 42 and 42 + 30
 and inv_item_sk = i_item_sk
 and d_date_sk=inv_date_sk
 and d_date between cast('2002-05-31' as date) and (cast('2002-05-31' as date) +  '60 days'::interval)
 and i_manufact_id in (864,777,820,869)
 and inv_quantity_on_hand between 100 and 500
 and cs_item_sk = i_item_sk
 group by i_item_id,i_item_desc,i_current_price
 order by i_item_id
 limit 100;

-- end query 63 in stream 19 using template query37.tpl
