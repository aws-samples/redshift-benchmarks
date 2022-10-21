set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 90 in stream 13 using template query41.tpl and seed 391934580
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 953 and 953+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'lace' or i_color = 'chartreuse') and 
        (i_units = 'Box' or i_units = 'Unknown') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'bisque' or i_color = 'sky') and
        (i_units = 'Oz' or i_units = 'Lb') and
        (i_size = 'economy' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'violet' or i_color = 'slate') and
        (i_units = 'N/A' or i_units = 'Cup') and
        (i_size = 'small' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'orange' or i_color = 'cream') and
        (i_units = 'Dram' or i_units = 'Bundle') and
        (i_size = 'petite' or i_size = 'extra large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'burlywood' or i_color = 'yellow') and 
        (i_units = 'Gross' or i_units = 'Case') and
        (i_size = 'petite' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'azure' or i_color = 'antique') and
        (i_units = 'Gram' or i_units = 'Pound') and
        (i_size = 'economy' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'steel' or i_color = 'powder') and
        (i_units = 'Carton' or i_units = 'Dozen') and
        (i_size = 'small' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'midnight' or i_color = 'coral') and
        (i_units = 'Ounce' or i_units = 'Tsp') and
        (i_size = 'petite' or i_size = 'extra large')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 90 in stream 13 using template query41.tpl
