:EXPLAIN
-- start template query93.tpl query 52 in stream 0
select /* TPC-DS query93.tpl 0.52 */  ss_customer_sk
            ,sum(act_sales) sumsales
      from (select ss_item_sk
                  ,ss_ticket_number
                  ,ss_customer_sk
                  ,case when sr_return_quantity is not null then (ss_quantity-sr_return_quantity)*ss_sales_price
                                                            else (ss_quantity*ss_sales_price) end act_sales
            from store_sales left outer join store_returns on (sr_item_sk = ss_item_sk
                                                               and sr_ticket_number = ss_ticket_number)
                ,reason
            where sr_reason_sk = r_reason_sk
              and r_reason_desc = 'No service location in my area') t
      group by ss_customer_sk
      order by sumsales, ss_customer_sk
limit 100;

-- end template query93.tpl query 52 in stream 0
