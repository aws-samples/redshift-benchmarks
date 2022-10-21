set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 36 in stream 0 using template query28.tpl and seed 2078057434
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 32 and 32+10 
             or ss_coupon_amt between 650 and 650+1000
             or ss_wholesale_cost between 67 and 67+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 10 and 10+10
          or ss_coupon_amt between 14779 and 14779+1000
          or ss_wholesale_cost between 22 and 22+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 93 and 93+10
          or ss_coupon_amt between 17930 and 17930+1000
          or ss_wholesale_cost between 6 and 6+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 125 and 125+10
          or ss_coupon_amt between 13175 and 13175+1000
          or ss_wholesale_cost between 9 and 9+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 68 and 68+10
          or ss_coupon_amt between 3077 and 3077+1000
          or ss_wholesale_cost between 48 and 48+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 85 and 85+10
          or ss_coupon_amt between 6794 and 6794+1000
          or ss_wholesale_cost between 1 and 1+20)) B6
limit 100;

-- end query 36 in stream 0 using template query28.tpl
