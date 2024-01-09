--COPY tpcds_reports.load FROM :LOGFILE WITH DELIMITER '|';
copy tpcds_reports.load
from :bucket_path
iam_role default;
