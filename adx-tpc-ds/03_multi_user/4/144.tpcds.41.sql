set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 44 in stream 3 using template query41.tpl and seed 1234820783
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 806 and 806+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'drab' or i_color = 'blush') and 
        (i_units = 'Tsp' or i_units = 'Box') and
        (i_size = 'economy' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'sandy' or i_color = 'medium') and
        (i_units = 'Bundle' or i_units = 'Pallet') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'lemon' or i_color = 'cornflower') and
        (i_units = 'Cup' or i_units = 'Oz') and
        (i_size = 'medium' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'floral' or i_color = 'hot') and
        (i_units = 'Bunch' or i_units = 'Dram') and
        (i_size = 'economy' or i_size = 'petite')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'brown' or i_color = 'plum') and 
        (i_units = 'Case' or i_units = 'Tbl') and
        (i_size = 'economy' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'magenta' or i_color = 'cream') and
        (i_units = 'Ounce' or i_units = 'N/A') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'midnight' or i_color = 'indian') and
        (i_units = 'Gram' or i_units = 'Ton') and
        (i_size = 'medium' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'maroon' or i_color = 'lime') and
        (i_units = 'Carton' or i_units = 'Pound') and
        (i_size = 'economy' or i_size = 'petite')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 44 in stream 3 using template query41.tpl
