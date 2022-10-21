set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 51 in stream 17 using template query41.tpl and seed 1942641741
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 694 and 694+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'olive' or i_color = 'cyan') and 
        (i_units = 'Ounce' or i_units = 'Cup') and
        (i_size = 'petite' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'snow' or i_color = 'deep') and
        (i_units = 'Each' or i_units = 'Pallet') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'floral' or i_color = 'midnight') and
        (i_units = 'Carton' or i_units = 'Unknown') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'lemon' or i_color = 'rose') and
        (i_units = 'Lb' or i_units = 'Gram') and
        (i_size = 'petite' or i_size = 'economy')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'mint' or i_color = 'tomato') and 
        (i_units = 'Tsp' or i_units = 'Bundle') and
        (i_size = 'petite' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'thistle' or i_color = 'forest') and
        (i_units = 'Pound' or i_units = 'Oz') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'powder' or i_color = 'black') and
        (i_units = 'Dozen' or i_units = 'Box') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'maroon' or i_color = 'orchid') and
        (i_units = 'Gross' or i_units = 'Tbl') and
        (i_size = 'petite' or i_size = 'economy')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 51 in stream 17 using template query41.tpl
