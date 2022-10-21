set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 3 in stream 10 using template query41.tpl and seed 1018594743
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 858 and 858+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'brown' or i_color = 'hot') and 
        (i_units = 'Oz' or i_units = 'Ton') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'lime' or i_color = 'wheat') and
        (i_units = 'Each' or i_units = 'Case') and
        (i_size = 'economy' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'midnight' or i_color = 'grey') and
        (i_units = 'Bundle' or i_units = 'Gram') and
        (i_size = 'petite' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'saddle' or i_color = 'dodger') and
        (i_units = 'Ounce' or i_units = 'Gross') and
        (i_size = 'extra large' or i_size = 'N/A')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'cyan' or i_color = 'medium') and 
        (i_units = 'Lb' or i_units = 'Cup') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'violet' or i_color = 'cream') and
        (i_units = 'N/A' or i_units = 'Dozen') and
        (i_size = 'economy' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'tan' or i_color = 'sandy') and
        (i_units = 'Pound' or i_units = 'Box') and
        (i_size = 'petite' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'sienna' or i_color = 'chocolate') and
        (i_units = 'Unknown' or i_units = 'Dram') and
        (i_size = 'extra large' or i_size = 'N/A')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 3 in stream 10 using template query41.tpl
