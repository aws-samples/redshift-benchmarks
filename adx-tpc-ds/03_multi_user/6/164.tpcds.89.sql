set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 64 in stream 5 using template query89.tpl and seed 1846910161
select  *
from(
select i_category, i_class, i_brand,
       s_store_name, s_company_name,
       d_moy,
       sum(ss_sales_price) sum_sales,
       avg(sum(ss_sales_price)) over
         (partition by i_category, i_brand, s_store_name, s_company_name)
         avg_monthly_sales
from item, store_sales, date_dim, store
where ss_item_sk = i_item_sk and
      ss_sold_date_sk = d_date_sk and
      ss_store_sk = s_store_sk and
      d_year in (1999) and
        ((i_category in ('Sports','Jewelry','Children') and
          i_class in ('basketball','mens watch','infants')
         )
      or (i_category in ('Women','Music','Shoes') and
          i_class in ('swimwear','country','kids') 
        ))
group by i_category, i_class, i_brand,
         s_store_name, s_company_name, d_moy) tmp1
where case when (avg_monthly_sales <> 0) then (abs(sum_sales - avg_monthly_sales) / avg_monthly_sales) else null end > 0.1
order by sum_sales - avg_monthly_sales, s_store_name
limit 100;

-- end query 64 in stream 5 using template query89.tpl
