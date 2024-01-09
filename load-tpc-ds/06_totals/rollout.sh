#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source ${PWD}/../tpcds_variables.sh

logdir="${PWD}/../log"

get_temp_dir()
{	
	#creates a unique directory in the temp bucket
	temp_dir=$(date +%s)
}
create_tables()
{	
	filter="redshift"

	for i in $(ls ${PWD}/*.${filter}.*.sql); do
		echo "rsql -D ${DSN} -v ON_ERROR_STOP=1 -a -f ${i}"
		rsql -D ${DSN} -v ON_ERROR_STOP=1 -a -f ${i}
		echo ""
	done
}
load_data()
{
	base_bucket="s3://${TEMP_BUCKET}/${temp_dir}/single/"
	arr=("rollout_ddl.log" "rollout_load.log" "rollout_sql.log")
	for i in "${arr[@]}"; do
		echo "aws s3 cp ${logdir}/${i} ${base_bucket}"
		aws s3 cp ${logdir}/${i} ${base_bucket}
	done

	for i in $(ls ${PWD}/*.copy.*.sql); do
		short_i=$(basename $i)
		id=$(echo ${short_i} | awk -F '.' '{print $1}')
		tablename=$(echo ${short_i} | awk -F '.' '{print $3}')
		echo "tablename: ${tablename}"
		bucket_path="'${base_bucket}rollout_${tablename}.log'"

		echo "Loading ${tablename}"
		rsql -D ${DSN} -v ON_ERROR_STOP=1 -f ${i} -v bucket_path="${bucket_path}"
	done
}
load_multisql_data()
{
	base_bucket="s3://${TEMP_BUCKET}/${temp_dir}/multi/"
	for i in $(seq 1 ${MULTI_USER_COUNT}); do
		logfile="rollout_testing_${i}.log"
		echo "aws s3 cp ${logdir}/${logfile} ${base_bucket}"
		aws s3 cp ${logdir}/${logfile} ${base_bucket}
	done

	for i in $(ls ${PWD}/*.multicopy.*.sql); do
		short_i=$(basename ${i})
		id=$(echo ${short_i} | awk -F '.' '{print $1}')
		tablename=$(echo ${short_i} | awk -F '.' '{print $3}')
		echo "tablename: ${tablename}"
		bucket_path="'${base_bucket}'"

		echo "Loading ${tablename}"
		rsql -D ${DSN} -f ${i} -v bucket_path="${bucket_path}"
	done
}
get_totals()
{
	# 1 user details
	rsql -D ${DSN} -P pager=off -c "select split_part(description, '.', 2) as query_id, extract(epoch from duration) + extract(ms from duration)/1000::numeric as sql_seconds from tpcds_reports.sql order by query_id;"

	# load
	rsql -D ${DSN} -c "select floor(sub.total_seconds/(3600)) || ' hour(s), ' || 
	floor(sub.total_seconds/60 - floor(sub.total_seconds/(3600))*60) || ' minute(s), ' || 
	sub.total_seconds - (floor(sub.total_seconds/(60))*60) || ' second(s)' as total_load
	from (
	select extract(epoch from duration) + extract(ms from duration)/1000::numeric as total_seconds from tpcds_reports.load
	) as sub;"

	# 1 user queries
	rsql -D ${DSN} -c "select floor(sub.total_seconds/(3600)) || ' hour(s), ' || 
	floor(sub.total_seconds/60 - floor(sub.total_seconds/(3600))*60) || ' minute(s), ' || 
	sub.total_seconds - (floor(sub.total_seconds/(60))*60) || ' second(s)' as total_queries
	from (
	select sum(extract(epoch from duration) + extract(ms from duration)/1000::numeric) as total_seconds from tpcds_reports.sql
	) as sub;"

	# concurrent totals
	rsql -D ${DSN} -c "select floor(sub.total_seconds/(3600)) || ' hour(s), ' || 
	floor(sub.total_seconds/60 - floor(sub.total_seconds/(3600))*60) || ' minute(s), ' || 
	sub.total_seconds - (floor(sub.total_seconds/(60))*60) || ' second(s)' as total_concurrent_queries
	from (
	select max(sum_duration) as total_seconds from (select split_part(description, '.', 1) as session, sum(extract(epoch from duration)::numeric + extract(ms 
	from duration)::numeric/1000) as sum_duration from tpcds_reports.multisql group by split_part(description, '.', 1) order by split_part(description, '.', 1)) 
	) as sub;"

	# grand total
	rsql -D ${DSN} -c "select floor(sum(sub.total_seconds)/(3600)) || ' hour(s), ' || 
	floor(sum(sub.total_seconds)/60 - floor(sum(sub.total_seconds)/(3600))*60) || ' minute(s), ' || 
	sum(sub.total_seconds) - (floor(sum(sub.total_seconds)/(60))*60) || ' second(s)' as total_time
	from (
	select extract(epoch from duration) + extract(ms from duration)/1000::numeric as total_seconds from tpcds_reports.load
	union all
	select sum(extract(epoch from duration) + extract(ms from duration)/1000::numeric) as total_seconds from tpcds_reports.sql
	union all
	select max(sum_duration) as total_seconds from (select split_part(description, '.', 1) as session, sum(extract(epoch from duration)::numeric + extract(ms 
        from duration)::numeric/1000) as sum_duration from tpcds_reports.multisql group by split_part(description, '.', 1) order by split_part(description, '.', 1)) 
	) as sub;"
}
cleanup()
{
	aws s3 rm "s3://${TEMP_BUCKET}/${temp_dir}/" --recursive
}
get_temp_dir
create_tables
load_data
load_multisql_data
get_totals
cleanup

echo "INFO: Done!"
