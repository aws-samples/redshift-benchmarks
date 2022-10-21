set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 82 in stream 14 using template query12.tpl and seed 506939235
select  i_item_id
      ,i_item_desc 
      ,i_category 
      ,i_class 
      ,i_current_price
      ,sum(ws_ext_sales_price) as itemrevenue 
      ,sum(ws_ext_sales_price)*100/sum(sum(ws_ext_sales_price)) over
          (partition by i_class) as revenueratio
from	
	web_sales
    	,item 
    	,date_dim
where 
	ws_item_sk = i_item_sk 
  	and i_category in ('Children', 'Jewelry', 'Books')
  	and ws_sold_date_sk = d_date_sk
	and d_date between cast('1998-03-04' as date) 
				and (cast('1998-03-04' as date) + '30 days'::interval)
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
        ,revenueratio
limit 100;

-- end query 82 in stream 14 using template query12.tpl
