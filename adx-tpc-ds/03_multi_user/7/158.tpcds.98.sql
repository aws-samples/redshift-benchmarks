set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 58 in stream 6 using template query98.tpl and seed 2114518739
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
  	and i_category in ('Music', 'Women', 'Sports')
  	and ss_sold_date_sk = d_date_sk
	and d_date between cast('1998-02-13' as date) 
				and (cast('1998-02-13' as date) + '30 days'::interval)
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

-- end query 58 in stream 6 using template query98.tpl
