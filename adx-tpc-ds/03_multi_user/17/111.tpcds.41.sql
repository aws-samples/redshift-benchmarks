set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 11 in stream 16 using template query41.tpl and seed 1647207432
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 717 and 717+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'ivory' or i_color = 'gainsboro') and 
        (i_units = 'Gross' or i_units = 'Bunch') and
        (i_size = 'large' or i_size = 'medium')
        ) or
        (i_category = 'Women' and
        (i_color = 'drab' or i_color = 'green') and
        (i_units = 'Cup' or i_units = 'Ton') and
        (i_size = 'petite' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'rosy' or i_color = 'white') and
        (i_units = 'Carton' or i_units = 'Ounce') and
        (i_size = 'economy' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'olive' or i_color = 'peru') and
        (i_units = 'Tsp' or i_units = 'Lb') and
        (i_size = 'large' or i_size = 'medium')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'floral' or i_color = 'light') and 
        (i_units = 'Oz' or i_units = 'Gram') and
        (i_size = 'large' or i_size = 'medium')
        ) or
        (i_category = 'Women' and
        (i_color = 'sandy' or i_color = 'khaki') and
        (i_units = 'Dozen' or i_units = 'Case') and
        (i_size = 'petite' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'tomato' or i_color = 'lemon') and
        (i_units = 'Dram' or i_units = 'Unknown') and
        (i_size = 'economy' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'violet' or i_color = 'hot') and
        (i_units = 'Box' or i_units = 'Pound') and
        (i_size = 'large' or i_size = 'medium')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 11 in stream 16 using template query41.tpl
