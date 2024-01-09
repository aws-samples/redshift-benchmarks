--COPY tpcds_reports.sql FROM :LOGFILE WITH DELIMITER '|';
copy tpcds_reports.sql
from :bucket_path
iam_role default;
