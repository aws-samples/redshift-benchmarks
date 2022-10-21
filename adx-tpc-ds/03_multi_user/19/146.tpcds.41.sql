set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 46 in stream 18 using template query41.tpl and seed 1262838003
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 878 and 878+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'pink' or i_color = 'royal') and 
        (i_units = 'Bunch' or i_units = 'Pallet') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'maroon' or i_color = 'metallic') and
        (i_units = 'Gross' or i_units = 'Tbl') and
        (i_size = 'extra large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'grey' or i_color = 'plum') and
        (i_units = 'Dram' or i_units = 'Carton') and
        (i_size = 'small' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'khaki' or i_color = 'olive') and
        (i_units = 'Ton' or i_units = 'Bundle') and
        (i_size = 'large' or i_size = 'N/A')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'sky' or i_color = 'firebrick') and 
        (i_units = 'Oz' or i_units = 'Dozen') and
        (i_size = 'large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'lawn' or i_color = 'chocolate') and
        (i_units = 'Gram' or i_units = 'Box') and
        (i_size = 'extra large' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'light' or i_color = 'aquamarine') and
        (i_units = 'Lb' or i_units = 'Case') and
        (i_size = 'small' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'frosted' or i_color = 'puff') and
        (i_units = 'Pound' or i_units = 'N/A') and
        (i_size = 'large' or i_size = 'N/A')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 46 in stream 18 using template query41.tpl
