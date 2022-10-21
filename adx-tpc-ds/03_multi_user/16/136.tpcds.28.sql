set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 36 in stream 15 using template query28.tpl and seed 1913295813
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 25 and 25+10 
             or ss_coupon_amt between 4385 and 4385+1000
             or ss_wholesale_cost between 55 and 55+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 154 and 154+10
          or ss_coupon_amt between 782 and 782+1000
          or ss_wholesale_cost between 70 and 70+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 60 and 60+10
          or ss_coupon_amt between 2968 and 2968+1000
          or ss_wholesale_cost between 34 and 34+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 39 and 39+10
          or ss_coupon_amt between 2202 and 2202+1000
          or ss_wholesale_cost between 39 and 39+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 145 and 145+10
          or ss_coupon_amt between 2594 and 2594+1000
          or ss_wholesale_cost between 51 and 51+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 102 and 102+10
          or ss_coupon_amt between 8584 and 8584+1000
          or ss_wholesale_cost between 54 and 54+20)) B6
limit 100;

-- end query 36 in stream 15 using template query28.tpl
