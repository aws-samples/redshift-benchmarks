create table inventory
(
 inv_date_sk int4 not null , 
  inv_item_sk int4 not null ,
  inv_warehouse_sk int4 not null ,
  inv_quantity_on_hand int4
  ,primary key (inv_date_sk, inv_item_sk, inv_warehouse_sk)
) distkey(inv_item_sk) sortkey(inv_date_sk);
