create table store_returns
(
sr_returned_date_sk int4 ,    
  sr_return_time_sk int4 ,    
  sr_item_sk int4 not null ,  
  sr_customer_sk int4 ,       
  sr_cdemo_sk int4 ,          
  sr_hdemo_sk int4 ,          
  sr_addr_sk int4 ,           
  sr_store_sk int4 ,          
  sr_reason_sk int4 ,         
  sr_ticket_number int8 not null,               
  sr_return_quantity int4 ,   
  sr_return_amt numeric(7,2) ,
  sr_return_tax numeric(7,2) ,
  sr_return_amt_inc_tax numeric(7,2) ,          
  sr_fee numeric(7,2) ,       
  sr_return_ship_cost numeric(7,2) ,            
  sr_refunded_cash numeric(7,2) ,               
  sr_reversed_charge numeric(7,2) ,             
  sr_store_credit numeric(7,2) ,                
  sr_net_loss numeric(7,2)                      
  ,primary key (sr_item_sk, sr_ticket_number)
) distkey(sr_item_sk) sortkey(sr_returned_date_sk);
