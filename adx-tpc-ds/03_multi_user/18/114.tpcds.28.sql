set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 14 in stream 17 using template query28.tpl and seed 1411736376
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 188 and 188+10 
             or ss_coupon_amt between 12499 and 12499+1000
             or ss_wholesale_cost between 54 and 54+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 161 and 161+10
          or ss_coupon_amt between 15974 and 15974+1000
          or ss_wholesale_cost between 62 and 62+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 25 and 25+10
          or ss_coupon_amt between 4002 and 4002+1000
          or ss_wholesale_cost between 39 and 39+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 128 and 128+10
          or ss_coupon_amt between 10439 and 10439+1000
          or ss_wholesale_cost between 35 and 35+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 29 and 29+10
          or ss_coupon_amt between 1826 and 1826+1000
          or ss_wholesale_cost between 31 and 31+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 154 and 154+10
          or ss_coupon_amt between 2149 and 2149+1000
          or ss_wholesale_cost between 28 and 28+20)) B6
limit 100;

-- end query 14 in stream 17 using template query28.tpl
