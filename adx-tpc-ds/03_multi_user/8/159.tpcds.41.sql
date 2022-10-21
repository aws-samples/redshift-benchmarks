set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 59 in stream 7 using template query41.tpl and seed 690193802
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 806 and 806+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'lavender' or i_color = 'cornsilk') and 
        (i_units = 'Carton' or i_units = 'Gram') and
        (i_size = 'small' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'navajo' or i_color = 'puff') and
        (i_units = 'Pallet' or i_units = 'Lb') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'powder' or i_color = 'dodger') and
        (i_units = 'Oz' or i_units = 'Dozen') and
        (i_size = 'extra large' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'aquamarine' or i_color = 'medium') and
        (i_units = 'Each' or i_units = 'Ounce') and
        (i_size = 'small' or i_size = 'economy')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'grey' or i_color = 'blue') and 
        (i_units = 'Bundle' or i_units = 'Tsp') and
        (i_size = 'small' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'firebrick' or i_color = 'lime') and
        (i_units = 'Cup' or i_units = 'Dram') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'cream' or i_color = 'sky') and
        (i_units = 'Box' or i_units = 'Ton') and
        (i_size = 'extra large' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'linen' or i_color = 'sienna') and
        (i_units = 'Tbl' or i_units = 'N/A') and
        (i_size = 'small' or i_size = 'economy')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 59 in stream 7 using template query41.tpl
