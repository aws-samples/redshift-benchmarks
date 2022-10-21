set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 93 in stream 5 using template query41.tpl and seed 1208041138
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 742 and 742+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'frosted' or i_color = 'dim') and 
        (i_units = 'Tsp' or i_units = 'Ton') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'hot' or i_color = 'khaki') and
        (i_units = 'Dozen' or i_units = 'Pallet') and
        (i_size = 'large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'saddle' or i_color = 'lawn') and
        (i_units = 'Lb' or i_units = 'Tbl') and
        (i_size = 'N/A' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'cornsilk' or i_color = 'antique') and
        (i_units = 'Ounce' or i_units = 'Box') and
        (i_size = 'extra large' or i_size = 'petite')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'violet' or i_color = 'powder') and 
        (i_units = 'N/A' or i_units = 'Each') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'brown' or i_color = 'tomato') and
        (i_units = 'Gram' or i_units = 'Unknown') and
        (i_size = 'large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'floral' or i_color = 'mint') and
        (i_units = 'Case' or i_units = 'Dram') and
        (i_size = 'N/A' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'orchid' or i_color = 'firebrick') and
        (i_units = 'Oz' or i_units = 'Pound') and
        (i_size = 'extra large' or i_size = 'petite')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 93 in stream 5 using template query41.tpl
