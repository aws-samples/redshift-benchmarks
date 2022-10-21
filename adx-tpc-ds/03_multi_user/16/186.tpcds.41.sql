set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 86 in stream 15 using template query41.tpl and seed 66962854
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 809 and 809+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'blush' or i_color = 'rose') and 
        (i_units = 'Gram' or i_units = 'Carton') and
        (i_size = 'economy' or i_size = 'large')
        ) or
        (i_category = 'Women' and
        (i_color = 'gainsboro' or i_color = 'orchid') and
        (i_units = 'Tsp' or i_units = 'Pallet') and
        (i_size = 'extra large' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'ivory' or i_color = 'dark') and
        (i_units = 'Box' or i_units = 'Cup') and
        (i_size = 'N/A' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'lace' or i_color = 'purple') and
        (i_units = 'Dozen' or i_units = 'Case') and
        (i_size = 'economy' or i_size = 'large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'grey' or i_color = 'papaya') and 
        (i_units = 'Gross' or i_units = 'Dram') and
        (i_size = 'economy' or i_size = 'large')
        ) or
        (i_category = 'Women' and
        (i_color = 'sky' or i_color = 'mint') and
        (i_units = 'Oz' or i_units = 'Ounce') and
        (i_size = 'extra large' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'aquamarine' or i_color = 'frosted') and
        (i_units = 'Bundle' or i_units = 'N/A') and
        (i_size = 'N/A' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'ghost' or i_color = 'antique') and
        (i_units = 'Unknown' or i_units = 'Tbl') and
        (i_size = 'economy' or i_size = 'large')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 86 in stream 15 using template query41.tpl
