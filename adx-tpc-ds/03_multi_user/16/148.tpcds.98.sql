set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 48 in stream 15 using template query98.tpl and seed 1114939640
select i_item_id
      ,i_item_desc 
      ,i_category 
      ,i_class 
      ,i_current_price
      ,sum(ss_ext_sales_price) as itemrevenue 
      ,sum(ss_ext_sales_price)*100/sum(sum(ss_ext_sales_price)) over
          (partition by i_class) as revenueratio
from	
	store_sales
    	,item 
    	,date_dim
where 
	ss_item_sk = i_item_sk 
  	and i_category in ('Children', 'Sports', 'Electronics')
  	and ss_sold_date_sk = d_date_sk
	and d_date between cast('2001-02-08' as date) 
				and (cast('2001-02-08' as date) + '30 days'::interval)
group by 
	i_item_id
        ,i_item_desc 
        ,i_category
        ,i_class
        ,i_current_price
order by 
	i_category
        ,i_class
        ,i_item_id
        ,i_item_desc
        ,revenueratio;

-- end query 48 in stream 15 using template query98.tpl
