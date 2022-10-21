set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 1 in stream 9 using template query15.tpl and seed 875168091
select  ca_zip
       ,sum(cs_sales_price)
 from catalog_sales
     ,customer
     ,customer_address
     ,date_dim
 where cs_bill_customer_sk = c_customer_sk
 	and c_current_addr_sk = ca_address_sk 
 	and ( substring(ca_zip,1,5) in ('85669', '86197','88274','83405','86475',
                                   '85392', '85460', '80348', '81792')
 	      or ca_state in ('CA','WA','GA')
 	      or cs_sales_price > 500)
 	and cs_sold_date_sk = d_date_sk
 	and d_qoy = 1 and d_year = 1999
 group by ca_zip
 order by ca_zip
 limit 100;

-- end query 1 in stream 9 using template query15.tpl
