set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 23 in stream 19 using template query41.tpl and seed 1995361894
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 690 and 690+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'bisque' or i_color = 'firebrick') and 
        (i_units = 'Ounce' or i_units = 'Gram') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Women' and
        (i_color = 'seashell' or i_color = 'lavender') and
        (i_units = 'Dram' or i_units = 'Unknown') and
        (i_size = 'N/A' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'orchid' or i_color = 'gainsboro') and
        (i_units = 'Gross' or i_units = 'Tbl') and
        (i_size = 'extra large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'saddle' or i_color = 'magenta') and
        (i_units = 'Carton' or i_units = 'Lb') and
        (i_size = 'large' or i_size = 'small')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'lawn' or i_color = 'dim') and 
        (i_units = 'Case' or i_units = 'Tsp') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Women' and
        (i_color = 'slate' or i_color = 'royal') and
        (i_units = 'Oz' or i_units = 'Ton') and
        (i_size = 'N/A' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'orange' or i_color = 'metallic') and
        (i_units = 'N/A' or i_units = 'Box') and
        (i_size = 'extra large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'thistle' or i_color = 'tomato') and
        (i_units = 'Dozen' or i_units = 'Bunch') and
        (i_size = 'large' or i_size = 'small')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 23 in stream 19 using template query41.tpl
