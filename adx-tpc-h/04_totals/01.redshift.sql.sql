CREATE TABLE IF NOT EXISTS tpcds_reports.sql
(id int, description varchar, tuples bigint, duration timestamp, create_ts timestamp default current_timestamp);
