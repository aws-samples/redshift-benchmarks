set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 40 in stream 14 using template query41.tpl and seed 1823619017
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 972 and 972+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'olive' or i_color = 'burlywood') and 
        (i_units = 'Box' or i_units = 'N/A') and
        (i_size = 'N/A' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'sandy' or i_color = 'maroon') and
        (i_units = 'Ton' or i_units = 'Unknown') and
        (i_size = 'small' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'lime' or i_color = 'royal') and
        (i_units = 'Pallet' or i_units = 'Bundle') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'misty' or i_color = 'chiffon') and
        (i_units = 'Gross' or i_units = 'Cup') and
        (i_size = 'N/A' or i_size = 'economy')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'linen' or i_color = 'coral') and 
        (i_units = 'Dram' or i_units = 'Bunch') and
        (i_size = 'N/A' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'azure' or i_color = 'bisque') and
        (i_units = 'Carton' or i_units = 'Pound') and
        (i_size = 'small' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'turquoise' or i_color = 'metallic') and
        (i_units = 'Dozen' or i_units = 'Each') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'spring' or i_color = 'smoke') and
        (i_units = 'Oz' or i_units = 'Lb') and
        (i_size = 'N/A' or i_size = 'economy')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 40 in stream 14 using template query41.tpl
