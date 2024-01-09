create table store_sales
(
ss_sold_date_sk int4 ,            
  ss_sold_time_sk int4 ,     
  ss_item_sk int4 not null ,      
  ss_customer_sk int4 ,           
  ss_cdemo_sk int4 ,              
  ss_hdemo_sk int4 ,         
  ss_addr_sk int4 ,               
  ss_store_sk int4 ,           
  ss_promo_sk int4 ,           
  ss_ticket_number int8 not null,        
  ss_quantity int4 ,           
  ss_wholesale_cost numeric(7,2) ,          
  ss_list_price numeric(7,2) ,              
  ss_sales_price numeric(7,2) ,
  ss_ext_discount_amt numeric(7,2) ,             
  ss_ext_sales_price numeric(7,2) ,              
  ss_ext_wholesale_cost numeric(7,2) ,           
  ss_ext_list_price numeric(7,2) ,               
  ss_ext_tax numeric(7,2) ,                 
  ss_coupon_amt numeric(7,2) , 
  ss_net_paid numeric(7,2) ,   
  ss_net_paid_inc_tax numeric(7,2) ,             
  ss_net_profit numeric(7,2)                     
  ,primary key (ss_item_sk, ss_ticket_number)
) distkey(ss_item_sk) sortkey(ss_sold_date_sk);
