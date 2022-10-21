set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 52 in stream 6 using template query41.tpl and seed 73447062
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 988 and 988+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'pale' or i_color = 'olive') and 
        (i_units = 'Dozen' or i_units = 'N/A') and
        (i_size = 'economy' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'orange' or i_color = 'snow') and
        (i_units = 'Carton' or i_units = 'Tbl') and
        (i_size = 'petite' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'khaki' or i_color = 'spring') and
        (i_units = 'Case' or i_units = 'Oz') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'grey' or i_color = 'powder') and
        (i_units = 'Lb' or i_units = 'Each') and
        (i_size = 'economy' or i_size = 'extra large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'floral' or i_color = 'sienna') and 
        (i_units = 'Cup' or i_units = 'Box') and
        (i_size = 'economy' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'blush' or i_color = 'gainsboro') and
        (i_units = 'Bundle' or i_units = 'Dram') and
        (i_size = 'petite' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'linen' or i_color = 'navy') and
        (i_units = 'Pallet' or i_units = 'Ton') and
        (i_size = 'large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'cream' or i_color = 'misty') and
        (i_units = 'Tsp' or i_units = 'Unknown') and
        (i_size = 'economy' or i_size = 'extra large')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 52 in stream 6 using template query41.tpl
