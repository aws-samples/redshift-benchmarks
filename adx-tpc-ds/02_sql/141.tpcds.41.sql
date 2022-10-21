set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 62 in stream 0 using template query41.tpl and seed 130522774
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 855 and 855+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'plum' or i_color = 'lavender') and 
        (i_units = 'Pound' or i_units = 'Ounce') and
        (i_size = 'N/A' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'dark' or i_color = 'rose') and
        (i_units = 'Case' or i_units = 'Dram') and
        (i_size = 'economy' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'orchid' or i_color = 'navajo') and
        (i_units = 'Tsp' or i_units = 'Box') and
        (i_size = 'small' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'pale' or i_color = 'black') and
        (i_units = 'N/A' or i_units = 'Oz') and
        (i_size = 'N/A' or i_size = 'petite')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'smoke' or i_color = 'hot') and 
        (i_units = 'Unknown' or i_units = 'Ton') and
        (i_size = 'N/A' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'mint' or i_color = 'puff') and
        (i_units = 'Pallet' or i_units = 'Bundle') and
        (i_size = 'economy' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'goldenrod' or i_color = 'ivory') and
        (i_units = 'Each' or i_units = 'Lb') and
        (i_size = 'small' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'peach' or i_color = 'antique') and
        (i_units = 'Cup' or i_units = 'Gross') and
        (i_size = 'N/A' or i_size = 'petite')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 62 in stream 0 using template query41.tpl
