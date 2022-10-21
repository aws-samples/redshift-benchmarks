set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 24 in stream 1 using template query41.tpl and seed 949636891
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 891 and 891+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'dark' or i_color = 'firebrick') and 
        (i_units = 'Ounce' or i_units = 'Each') and
        (i_size = 'petite' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'sandy' or i_color = 'turquoise') and
        (i_units = 'Bunch' or i_units = 'Dozen') and
        (i_size = 'medium' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'blanched' or i_color = 'cyan') and
        (i_units = 'Case' or i_units = 'Oz') and
        (i_size = 'extra large' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'lime' or i_color = 'tan') and
        (i_units = 'Pallet' or i_units = 'Dram') and
        (i_size = 'petite' or i_size = 'N/A')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'coral' or i_color = 'spring') and 
        (i_units = 'Carton' or i_units = 'Gram') and
        (i_size = 'petite' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'salmon' or i_color = 'lavender') and
        (i_units = 'Tbl' or i_units = 'Lb') and
        (i_size = 'medium' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'green' or i_color = 'chocolate') and
        (i_units = 'Ton' or i_units = 'Cup') and
        (i_size = 'extra large' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'khaki' or i_color = 'red') and
        (i_units = 'Gross' or i_units = 'Unknown') and
        (i_size = 'petite' or i_size = 'N/A')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 24 in stream 1 using template query41.tpl
