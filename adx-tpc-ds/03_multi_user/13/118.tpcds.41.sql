set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 18 in stream 12 using template query41.tpl and seed 1173397210
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 824 and 824+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'misty' or i_color = 'maroon') and 
        (i_units = 'Dozen' or i_units = 'Unknown') and
        (i_size = 'medium' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'pale' or i_color = 'linen') and
        (i_units = 'Dram' or i_units = 'Gross') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'coral' or i_color = 'cyan') and
        (i_units = 'Tbl' or i_units = 'Pallet') and
        (i_size = 'economy' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'tan' or i_color = 'puff') and
        (i_units = 'Ton' or i_units = 'N/A') and
        (i_size = 'medium' or i_size = 'N/A')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'brown' or i_color = 'black') and 
        (i_units = 'Box' or i_units = 'Case') and
        (i_size = 'medium' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'orange' or i_color = 'turquoise') and
        (i_units = 'Gram' or i_units = 'Bunch') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'ghost' or i_color = 'metallic') and
        (i_units = 'Tsp' or i_units = 'Oz') and
        (i_size = 'economy' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'slate' or i_color = 'ivory') and
        (i_units = 'Bundle' or i_units = 'Lb') and
        (i_size = 'medium' or i_size = 'N/A')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 18 in stream 12 using template query41.tpl
