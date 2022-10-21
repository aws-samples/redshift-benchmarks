set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 4 in stream 4 using template query41.tpl and seed 18311092
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 902 and 902+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'lawn' or i_color = 'orange') and 
        (i_units = 'Case' or i_units = 'Dram') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'snow' or i_color = 'green') and
        (i_units = 'Pound' or i_units = 'Box') and
        (i_size = 'economy' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'chiffon' or i_color = 'midnight') and
        (i_units = 'Gram' or i_units = 'Lb') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'lace' or i_color = 'mint') and
        (i_units = 'Pallet' or i_units = 'Ton') and
        (i_size = 'petite' or i_size = 'extra large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'tan' or i_color = 'navajo') and 
        (i_units = 'Carton' or i_units = 'Bundle') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'yellow' or i_color = 'slate') and
        (i_units = 'Tsp' or i_units = 'Dozen') and
        (i_size = 'economy' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'bisque' or i_color = 'forest') and
        (i_units = 'Ounce' or i_units = 'Unknown') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'royal' or i_color = 'khaki') and
        (i_units = 'N/A' or i_units = 'Tbl') and
        (i_size = 'petite' or i_size = 'extra large')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 4 in stream 4 using template query41.tpl
