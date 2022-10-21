set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 45 in stream 11 using template query41.tpl and seed 1073384520
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 831 and 831+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'linen' or i_color = 'tomato') and 
        (i_units = 'Unknown' or i_units = 'Carton') and
        (i_size = 'petite' or i_size = 'medium')
        ) or
        (i_category = 'Women' and
        (i_color = 'goldenrod' or i_color = 'ghost') and
        (i_units = 'Tsp' or i_units = 'Tbl') and
        (i_size = 'N/A' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'chartreuse' or i_color = 'lawn') and
        (i_units = 'Dozen' or i_units = 'Box') and
        (i_size = 'extra large' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'navajo' or i_color = 'red') and
        (i_units = 'N/A' or i_units = 'Each') and
        (i_size = 'petite' or i_size = 'medium')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'aquamarine' or i_color = 'pale') and 
        (i_units = 'Pallet' or i_units = 'Case') and
        (i_size = 'petite' or i_size = 'medium')
        ) or
        (i_category = 'Women' and
        (i_color = 'seashell' or i_color = 'gainsboro') and
        (i_units = 'Bunch' or i_units = 'Gross') and
        (i_size = 'N/A' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'smoke' or i_color = 'forest') and
        (i_units = 'Cup' or i_units = 'Gram') and
        (i_size = 'extra large' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'blush' or i_color = 'lime') and
        (i_units = 'Lb' or i_units = 'Oz') and
        (i_size = 'petite' or i_size = 'medium')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 45 in stream 11 using template query41.tpl
