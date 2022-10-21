set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 76 in stream 17 using template query98.tpl and seed 364484876
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
  	and i_category in ('Children', 'Books', 'Electronics')
  	and ss_sold_date_sk = d_date_sk
	and d_date between cast('1998-05-21' as date) 
				and (cast('1998-05-21' as date) + '30 days'::interval)
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

-- end query 76 in stream 17 using template query98.tpl
