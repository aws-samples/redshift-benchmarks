:EXPLAIN
-- start template query36.tpl query 21 in stream 0
select /* TPC-DS query36.tpl 0.21 */
    sum(ss_net_profit)/sum(ss_ext_sales_price) as gross_margin
   ,i_category
   ,i_class
   ,grouping(i_category)+grouping(i_class) as lochierarchy
   ,rank() over (
        partition by grouping(i_category)+grouping(i_class),
        case when grouping(i_class) = 0 then i_category end
        order by sum(ss_net_profit)/sum(ss_ext_sales_price) asc) as rank_within_parent
 from
    store_sales
   ,date_dim       d1
   ,item
   ,store
 where
    d1.d_year = 2002
 and d1.d_date_sk = ss_sold_date_sk
 and i_item_sk  = ss_item_sk
 and s_store_sk  = ss_store_sk
 and s_state in ('MN','TN','MI','WV',
                 'NC','GA','TN','OH')
 group by rollup(i_category,i_class)
 order by
   lochierarchy desc
  ,case when grouping(i_category)+grouping(i_class) = 0 then i_category end
  ,rank_within_parent
  limit 100;

-- end template query36.tpl query 21 in stream 0
