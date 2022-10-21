set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 25 in stream 8 using template query84.tpl and seed 1290293047
select  c_customer_id as customer_id
       , coalesce(c_last_name,'') || ', ' || coalesce(c_first_name,'') as customername
 from customer
     ,customer_address
     ,customer_demographics
     ,household_demographics
     ,income_band
     ,store_returns
 where ca_city	        =  'Walnut Grove'
   and c_current_addr_sk = ca_address_sk
   and ib_lower_bound   >=  38746
   and ib_upper_bound   <=  38746 + 50000
   and ib_income_band_sk = hd_income_band_sk
   and cd_demo_sk = c_current_cdemo_sk
   and hd_demo_sk = c_current_hdemo_sk
   and sr_cdemo_sk = cd_demo_sk
 order by c_customer_id
 limit 100;

-- end query 25 in stream 8 using template query84.tpl
