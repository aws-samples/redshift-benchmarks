create table item
(
i_item_sk int4 not null,                     
  i_item_id char(16) not null ,      
  i_rec_start_date date,             
  i_rec_end_date date,               
  i_item_desc varchar(200) ,         
  i_current_price numeric(7,2),      
  i_wholesale_cost numeric(7,2),     
  i_brand_id int4,                   
  i_brand char(50) ,                 
  i_class_id int4,                   
  i_class char(50) ,                 
  i_category_id int4,                
  i_category char(50) ,              
  i_manufact_id int4,                
  i_manufact char(50) ,              
  i_size char(20) ,                  
  i_formulation char(20) ,           
  i_color char(20) ,            
  i_units char(10),             
  i_container char(10),         
  i_manager_id int4,            
  i_product_name char(50)       
  ,primary key (i_item_sk)
) distkey(i_item_sk) sortkey(i_category);
