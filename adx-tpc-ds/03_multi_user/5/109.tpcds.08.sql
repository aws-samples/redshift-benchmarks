set enable_result_cache_for_session = off;
:EXPLAIN
-- start query 9 in stream 4 using template query8.tpl and seed 1179316212
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
                          '55268','31301','12434','42458','61058','63112',
                          '36281','86861','11402','93425','76321',
                          '11512','72984','82521','76581','90055',
                          '36886','25284','81721','68546','92163',
                          '72746','75150','87552','71464','69296',
                          '65012','68461','77934','89315','45933',
                          '76165','10004','89880','54491','54421',
                          '85759','86692','92853','75582','93985',
                          '18404','43909','89780','67870','55017',
                          '84649','65606','16495','31628','92192',
                          '45371','87520','27805','64146','30678',
                          '87364','20451','57538','75608','79570',
                          '75468','37143','34274','26495','87930',
                          '75225','90037','43399','61288','42048',
                          '91153','26390','63011','15170','78498',
                          '21316','67620','83790','79495','68572',
                          '79540','23277','86995','29104','60444',
                          '61928','55654','56014','28066','44656',
                          '90899','63009','91012','35755','29433',
                          '40152','59366','20188','75231','34073',
                          '21711','25667','57201','91744','61348',
                          '70383','43623','72839','53173','94630',
                          '78124','11642','47188','57088','82926',
                          '97689','83802','24548','57681','14596',
                          '61714','34564','28791','11611','33725',
                          '61031','25298','15458','39156','13747',
                          '95545','31492','13933','48241','17588',
                          '23100','49796','77062','39603','87746',
                          '45198','61576','52150','68323','49633',
                          '77549','58715','79445','68965','96824',
                          '27530','92477','98457','64719','79288',
                          '38983','24350','39686','86728','63713',
                          '75871','52380','75701','38973','10225',
                          '94602','80500','70675','99027','89322',
                          '87157','60016','12107','11567','52102',
                          '82934','59011','67421','78728','72759',
                          '97772','80501','24082','15938','80840',
                          '81656','49349','43709','53647','42537',
                          '48479','77590','73232','97360','17956',
                          '36745','82122','90585','72491','39347',
                          '20468','10271','62013','99238','96235',
                          '87031','97409','58004','31315','80037',
                          '20524','23059','61028','48996','22204',
                          '80596','82228','74029','88819','54536',
                          '92855','16727','40804','42211','59233',
                          '52203','19240','30325','14762','16468',
                          '10406','19440','19861','80537','69853',
                          '30322','45967','50754','74714','76967',
                          '38901','55117','10557','54265','46426',
                          '43598','58842','97869','54256','94579',
                          '43280','74017','28627','27402','76922',
                          '21539','51728','98261','44366','94365',
                          '83371','18347','46766','64237','30837',
                          '37743','63769','21550','12581','39163',
                          '94011','34296','26849','51599','53756',
                          '13797','66600','83360','66076','75629',
                          '44908','71263','54043','27080','39794',
                          '22412','46485','35128','17178','60661',
                          '19228','33461','76293','29888','60012',
                          '76543','55120','32425','68752','97141',
                          '63435','77265','50503','35901','64049',
                          '78187','37976','98138','94187','70306',
                          '84398','99846','83190','15761','33289',
                          '89063','54499','90592','78596','89414',
                          '53535','86092','62108','19996','13627',
                          '53630','69647','17594','14234','56890',
                          '44417','14551','77028','43714','77591',
                          '42188','41846','75427','14356','79775',
                          '32945','87358','30960','27316','53916',
                          '92012','94492','98607','45273','76380',
                          '49092','59555','66690','75605','60509',
                          '64123','52743','43435','67963','64458',
                          '47293','10154','35385','74769','47301',
                          '68093','59872','60046','93410','28071',
                          '82655','56034','21312','83137','13637',
                          '87147','32602','33880','91504','77783',
                          '48590','67719','82189','38866','22093',
                          '87849','52325','69180','35874','34432',
                          '99132','81944','68246','57468','88033',
                          '14486','59472','33940','95063')
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
  and d_qoy = 2 and d_year = 2000
  and (substring(s_zip,1,2) = substring(V1.ca_zip,1,2))
 group by s_store_name
 order by s_store_name
 limit 100;

-- end query 9 in stream 4 using template query8.tpl
