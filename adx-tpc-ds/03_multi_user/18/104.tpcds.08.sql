set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 4 in stream 17 using template query8.tpl and seed 1173888546
select  s_store_name
      ,sum(ss_net_profit)
 from store_sales
     ,date_dim
     ,store,
     (select ca_zip
     from (
      SELECT substring(ca_zip,1,5) ca_zip
      FROM customer_address
      WHERE substring(ca_zip,1,5) IN (
                          '83468','18833','49388','99012','38791','38437',
                          '88537','30283','91956','10828','77428',
                          '42572','30520','53280','71681','84418',
                          '89228','18911','91352','70785','39422',
                          '83346','27674','40770','63067','88805',
                          '92957','89740','39114','18567','83961',
                          '70583','49748','35419','10839','57783',
                          '77958','44017','34059','20179','75775',
                          '30386','64956','30594','72549','54723',
                          '56306','75112','76411','28937','85545',
                          '48584','50918','87588','94245','70724',
                          '89398','62617','10721','26026','13484',
                          '27146','70903','72081','55840','49895',
                          '34187','28552','60437','79417','36834',
                          '89862','90611','22753','80378','75345',
                          '86214','37000','20993','54648','48939',
                          '41549','42629','41383','97740','68265',
                          '62499','90000','94290','97790','93025',
                          '71953','49407','13084','39852','50565',
                          '23870','92380','22848','68152','96838',
                          '68895','15215','92428','88538','27979',
                          '67511','96694','20317','55758','85595',
                          '17720','91314','43114','29072','17184',
                          '99587','42738','65322','43352','98650',
                          '15753','77679','14612','86125','57646',
                          '22966','75249','13103','15379','29337',
                          '41786','43599','55844','56044','78112',
                          '57717','32991','15776','69284','71744',
                          '83688','51650','55518','34502','81645',
                          '35629','92806','96963','33827','47243',
                          '86013','95128','91774','98856','52680',
                          '62891','25226','68002','61602','40474',
                          '41973','54758','92932','86358','88162',
                          '36763','72137','44964','22801','97417',
                          '43232','93456','68713','92533','66793',
                          '29800','26548','29875','40512','95194',
                          '58105','27816','24237','77747','86886',
                          '27241','24256','42364','24490','81636',
                          '86277','43025','26042','95167','66895',
                          '94395','87797','45848','38547','60295',
                          '54140','23297','42800','94029','45417',
                          '43725','80700','48219','78458','26902',
                          '96633','30120','52638','29256','51701',
                          '75335','69054','22289','95841','34785',
                          '99857','97524','42688','28522','52642',
                          '45936','39262','93578','68644','98055',
                          '40310','71039','66982','78046','30537',
                          '72593','50826','91189','42883','22697',
                          '49600','40499','31031','19274','60481',
                          '35264','40169','64699','20013','36059',
                          '30946','57243','37311','94763','43971',
                          '72160','50849','96989','76158','31272',
                          '79715','61243','81703','69652','55234',
                          '20148','54528','40818','36325','84803',
                          '87002','66065','42232','34280','19690',
                          '19600','60785','41885','53692','53128',
                          '58060','51296','78616','95287','24261',
                          '89012','81901','94165','37565','20107',
                          '10324','70290','70908','15169','54699',
                          '95497','52633','88675','34700','85536',
                          '99244','76785','28217','92636','13724',
                          '90461','80746','47812','51349','91932',
                          '17040','58807','25994','78855','35527',
                          '42960','71332','58796','20568','70478',
                          '70482','22105','41136','98602','23453',
                          '57669','19640','97993','77780','52128',
                          '45163','14436','21991','31528','72247',
                          '93214','57382','30190','66492','17004',
                          '70662','72723','77210','84414','60470',
                          '20454','59320','17790','43607','50177',
                          '42761','83300','99769','30254','50922',
                          '59371','33253','74274','37249','32889',
                          '36495','37313','26662','31546','30567',
                          '10396','61727','89703','80605','21756',
                          '35129','57424','13752','50366','21112',
                          '98796','52578','63577','37006','52291',
                          '99881','22806','22206','88768','55716',
                          '34777','20245','83241','84970','81867',
                          '62395','22189','24121','78031','73378',
                          '80127','29401','12345','99119')
     intersect
      select ca_zip
      from (SELECT substring(ca_zip,1,5) ca_zip,count(*) cnt
            FROM customer_address, customer
            WHERE ca_address_sk = c_current_addr_sk and
                  c_preferred_cust_flag='Y'
            group by ca_zip
            having count(*) > 10)A1)A2) V1
 where ss_store_sk = s_store_sk
  and ss_sold_date_sk = d_date_sk
  and d_qoy = 2 and d_year = 1999
  and (substring(s_zip,1,2) = substring(V1.ca_zip,1,2))
 group by s_store_name
 order by s_store_name
 limit 100;

-- end query 4 in stream 17 using template query8.tpl
