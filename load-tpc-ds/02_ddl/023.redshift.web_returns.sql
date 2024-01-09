create table web_returns
(
wr_returned_date_sk int4 ,   
  wr_returned_time_sk int4 , 
  wr_item_sk int4 not null , 
  wr_refunded_customer_sk int4 ,
  wr_refunded_cdemo_sk int4 ,   
  wr_refunded_hdemo_sk int4 ,   
  wr_refunded_addr_sk int4 ,    
  wr_returning_customer_sk int4 ,
  wr_returning_cdemo_sk int4 ,   
  wr_returning_hdemo_sk int4 ,  
  wr_returning_addr_sk int4 ,   
  wr_web_page_sk int4 ,         
  wr_reason_sk int4 ,           
  wr_order_number int8 not null,
  wr_return_quantity int4 ,     
  wr_return_amt numeric(7,2) ,  
  wr_return_tax numeric(7,2) ,  
  wr_return_amt_inc_tax numeric(7,2) ,
  wr_fee numeric(7,2) ,         
  wr_return_ship_cost numeric(7,2) ,
  wr_refunded_cash numeric(7,2) ,   
  wr_reversed_charge numeric(7,2) ,  
  wr_account_credit numeric(7,2) ,   
  wr_net_loss numeric(7,2)           
  ,primary key (wr_item_sk, wr_order_number)
) distkey(wr_order_number) sortkey(wr_returned_date_sk);
