--copy :table_name from :bucket_path iam_role default REGION 'us-east-2' GZIP ACCEPTINVCHARS;
copy :table_name from :bucket_path iam_role default :gzip DELIMITER '|' EMPTYASNULL REGION 'us-east-1';

