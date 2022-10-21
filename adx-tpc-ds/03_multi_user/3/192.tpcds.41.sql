set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 92 in stream 2 using template query41.tpl and seed 2028140884
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 794 and 794+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'navajo' or i_color = 'plum') and 
        (i_units = 'Pallet' or i_units = 'Pound') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'tan' or i_color = 'misty') and
        (i_units = 'Oz' or i_units = 'Dram') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'orange' or i_color = 'floral') and
        (i_units = 'Gross' or i_units = 'Tbl') and
        (i_size = 'medium' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'dodger' or i_color = 'lavender') and
        (i_units = 'Cup' or i_units = 'N/A') and
        (i_size = 'petite' or i_size = 'extra large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'slate' or i_color = 'chiffon') and 
        (i_units = 'Box' or i_units = 'Ounce') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'mint' or i_color = 'grey') and
        (i_units = 'Ton' or i_units = 'Tsp') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'gainsboro' or i_color = 'linen') and
        (i_units = 'Lb' or i_units = 'Gram') and
        (i_size = 'medium' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'saddle' or i_color = 'sienna') and
        (i_units = 'Each' or i_units = 'Unknown') and
        (i_size = 'petite' or i_size = 'extra large')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 92 in stream 2 using template query41.tpl
