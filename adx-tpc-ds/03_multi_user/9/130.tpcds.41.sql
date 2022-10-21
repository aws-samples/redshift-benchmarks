set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 30 in stream 8 using template query41.tpl and seed 18704962
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 830 and 830+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'papaya' or i_color = 'firebrick') and 
        (i_units = 'Gram' or i_units = 'Lb') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'navy' or i_color = 'puff') and
        (i_units = 'Carton' or i_units = 'Dram') and
        (i_size = 'small' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'blush' or i_color = 'orchid') and
        (i_units = 'Bundle' or i_units = 'Box') and
        (i_size = 'large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'grey' or i_color = 'royal') and
        (i_units = 'Oz' or i_units = 'Pallet') and
        (i_size = 'extra large' or i_size = 'petite')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'magenta' or i_color = 'slate') and 
        (i_units = 'Dozen' or i_units = 'Pound') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'navajo' or i_color = 'dim') and
        (i_units = 'Tsp' or i_units = 'Each') and
        (i_size = 'small' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'gainsboro' or i_color = 'turquoise') and
        (i_units = 'Ton' or i_units = 'Unknown') and
        (i_size = 'large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'indian' or i_color = 'honeydew') and
        (i_units = 'Case' or i_units = 'Bunch') and
        (i_size = 'extra large' or i_size = 'petite')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 30 in stream 8 using template query41.tpl
