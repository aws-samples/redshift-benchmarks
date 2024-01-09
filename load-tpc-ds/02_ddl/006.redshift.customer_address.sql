create table customer_address
(
 ca_address_sk int4 not null ,
  ca_address_id char(16) not null ,
  ca_street_number char(10) ,      
  ca_street_name varchar(60) ,   
  ca_street_type char(15) ,     
  ca_suite_number char(10) ,    
  ca_city varchar(60) ,         
  ca_county varchar(30) ,       
  ca_state char(2) ,            
  ca_zip char(10) ,             
  ca_country varchar(20) ,      
  ca_gmt_offset numeric(5,2) ,  
  ca_location_type char(20)     
  ,primary key (ca_address_sk)
) distkey(ca_address_sk);
