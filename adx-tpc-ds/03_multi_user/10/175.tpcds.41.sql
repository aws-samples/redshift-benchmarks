set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 75 in stream 9 using template query41.tpl and seed 363896135
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 819 and 819+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'coral' or i_color = 'slate') and 
        (i_units = 'Bundle' or i_units = 'Bunch') and
        (i_size = 'medium' or i_size = 'large')
        ) or
        (i_category = 'Women' and
        (i_color = 'steel' or i_color = 'orange') and
        (i_units = 'Dram' or i_units = 'Box') and
        (i_size = 'N/A' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'almond' or i_color = 'salmon') and
        (i_units = 'Dozen' or i_units = 'Ounce') and
        (i_size = 'extra large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'bisque' or i_color = 'tan') and
        (i_units = 'Unknown' or i_units = 'Pallet') and
        (i_size = 'medium' or i_size = 'large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'pale' or i_color = 'dark') and 
        (i_units = 'Cup' or i_units = 'Case') and
        (i_size = 'medium' or i_size = 'large')
        ) or
        (i_category = 'Women' and
        (i_color = 'midnight' or i_color = 'olive') and
        (i_units = 'Carton' or i_units = 'Oz') and
        (i_size = 'N/A' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'gainsboro' or i_color = 'brown') and
        (i_units = 'Gram' or i_units = 'Tbl') and
        (i_size = 'extra large' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'white' or i_color = 'navajo') and
        (i_units = 'N/A' or i_units = 'Ton') and
        (i_size = 'medium' or i_size = 'large')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 75 in stream 9 using template query41.tpl
