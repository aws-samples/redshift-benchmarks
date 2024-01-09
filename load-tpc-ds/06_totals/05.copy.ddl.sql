--COPY tpcds_reports.ddl FROM :LOGFILE WITH DELIMITER '|';
copy tpcds_reports.ddl
from :bucket_path
iam_role default;
