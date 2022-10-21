set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 59 in stream 17 using template query16.tpl and seed 2059506312
select  
   count(distinct cs_order_number) as "order count"
  ,sum(cs_ext_ship_cost) as "total shipping cost"
  ,sum(cs_net_profit) as "total net profit"
from
   catalog_sales cs1
  ,date_dim
  ,customer_address
  ,call_center
where
    d_date between '1999-2-01' and 
           (cast('1999-2-01' as date) + '60 days'::interval)
and cs1.cs_ship_date_sk = d_date_sk
and cs1.cs_ship_addr_sk = ca_address_sk
and ca_state = 'LA'
and cs1.cs_call_center_sk = cc_call_center_sk
and cc_county in ('Mobile County','Jefferson Davis Parish','San Miguel County','Pennington County',
                  'Levy County'
)
and exists (select *
            from catalog_sales cs2
            where cs1.cs_order_number = cs2.cs_order_number
              and cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk)
and not exists(select *
               from catalog_returns cr1
               where cs1.cs_order_number = cr1.cr_order_number)
order by count(distinct cs_order_number)
limit 100;

-- end query 59 in stream 17 using template query16.tpl
