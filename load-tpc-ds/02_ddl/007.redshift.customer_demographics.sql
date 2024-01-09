create table customer_demographics
(
  cd_demo_sk int4 not null ,   
  cd_gender char(1) ,          
  cd_marital_status char(1) ,   
  cd_education_status char(20) , 
  cd_purchase_estimate int4 ,   
  cd_credit_rating char(10) ,   
  cd_dep_count int4 ,             
  cd_dep_employed_count int4 ,    
  cd_dep_college_count int4       
  ,primary key (cd_demo_sk)
)distkey (cd_demo_sk);
