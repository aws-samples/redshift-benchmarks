set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 69 in stream 8 using template query28.tpl and seed 1091141244
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 33 and 33+10 
             or ss_coupon_amt between 16907 and 16907+1000
             or ss_wholesale_cost between 26 and 26+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 116 and 116+10
          or ss_coupon_amt between 1732 and 1732+1000
          or ss_wholesale_cost between 67 and 67+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 82 and 82+10
          or ss_coupon_amt between 12465 and 12465+1000
          or ss_wholesale_cost between 79 and 79+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 67 and 67+10
          or ss_coupon_amt between 3591 and 3591+1000
          or ss_wholesale_cost between 19 and 19+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 94 and 94+10
          or ss_coupon_amt between 12414 and 12414+1000
          or ss_wholesale_cost between 14 and 14+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 56 and 56+10
          or ss_coupon_amt between 1417 and 1417+1000
          or ss_wholesale_cost between 35 and 35+20)) B6
limit 100;

-- end query 69 in stream 8 using template query28.tpl
