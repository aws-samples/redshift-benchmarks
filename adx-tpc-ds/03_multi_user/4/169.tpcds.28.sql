set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 69 in stream 3 using template query28.tpl and seed 1314447904
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 19 and 19+10 
             or ss_coupon_amt between 16559 and 16559+1000
             or ss_wholesale_cost between 46 and 46+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 42 and 42+10
          or ss_coupon_amt between 6846 and 6846+1000
          or ss_wholesale_cost between 72 and 72+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 88 and 88+10
          or ss_coupon_amt between 11315 and 11315+1000
          or ss_wholesale_cost between 38 and 38+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 20 and 20+10
          or ss_coupon_amt between 15563 and 15563+1000
          or ss_wholesale_cost between 55 and 55+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 120 and 120+10
          or ss_coupon_amt between 5784 and 5784+1000
          or ss_wholesale_cost between 74 and 74+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 51 and 51+10
          or ss_coupon_amt between 17342 and 17342+1000
          or ss_wholesale_cost between 53 and 53+20)) B6
limit 100;

-- end query 69 in stream 3 using template query28.tpl
