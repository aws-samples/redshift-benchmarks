set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 21 in stream 16 using template query28.tpl and seed 713190544
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 132 and 132+10 
             or ss_coupon_amt between 3775 and 3775+1000
             or ss_wholesale_cost between 71 and 71+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 45 and 45+10
          or ss_coupon_amt between 16949 and 16949+1000
          or ss_wholesale_cost between 48 and 48+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 44 and 44+10
          or ss_coupon_amt between 9280 and 9280+1000
          or ss_wholesale_cost between 24 and 24+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 56 and 56+10
          or ss_coupon_amt between 4703 and 4703+1000
          or ss_wholesale_cost between 32 and 32+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 120 and 120+10
          or ss_coupon_amt between 2220 and 2220+1000
          or ss_wholesale_cost between 53 and 53+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 12 and 12+10
          or ss_coupon_amt between 3615 and 3615+1000
          or ss_wholesale_cost between 50 and 50+20)) B6
limit 100;

-- end query 21 in stream 16 using template query28.tpl
