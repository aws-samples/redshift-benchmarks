set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 21 in stream 6 using template query28.tpl and seed 616614899
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 105 and 105+10 
             or ss_coupon_amt between 14899 and 14899+1000
             or ss_wholesale_cost between 21 and 21+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 167 and 167+10
          or ss_coupon_amt between 9059 and 9059+1000
          or ss_wholesale_cost between 78 and 78+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 114 and 114+10
          or ss_coupon_amt between 3696 and 3696+1000
          or ss_wholesale_cost between 74 and 74+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 94 and 94+10
          or ss_coupon_amt between 8344 and 8344+1000
          or ss_wholesale_cost between 48 and 48+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 40 and 40+10
          or ss_coupon_amt between 6051 and 6051+1000
          or ss_wholesale_cost between 38 and 38+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 67 and 67+10
          or ss_coupon_amt between 1016 and 1016+1000
          or ss_wholesale_cost between 75 and 75+20)) B6
limit 100;

-- end query 21 in stream 6 using template query28.tpl
