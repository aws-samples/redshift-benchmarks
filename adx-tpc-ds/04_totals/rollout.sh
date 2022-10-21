#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source ${PWD}/../tpcds_variables.sh

logdir="${PWD}/../log"

create_tables()
{	
	filter="redshift"

	for i in $(ls ${PWD}/*.${filter}.*.sql); do
		echo "psql -v ON_ERROR_STOP=1 -a -f ${i}"
		psql -v ON_ERROR_STOP=1 -a -f ${i}
		echo ""
	done
}
load_sql()
{
	SAVEIFS=$IFS
	IFS=$(echo -en "\n\b")

	count="0"
	exec_sql="INSERT INTO tpcds_reports.sql (id, description, tuples, duration) VALUES "
	for i in $(cat ${logdir}/rollout_sql.log); do
		count=$((count+1))
		id=$(echo $i | awk -F '|' '{print $1}')
		description=$(echo $i | awk -F '|' '{print $2}')
		tuples=$(echo $i | awk -F '|' '{print $3}')
		duration=$(echo $i | awk -F '|' '{print $4}')
		if [ "$count" -eq "1" ]; then
			exec_sql+="(${id}, '${description}', ${tuples}, '${duration}')"
		else
			exec_sql+=", (${id}, '${description}', ${tuples}, '${duration}')"
		fi
	done
	psql -c "${exec_sql}"

	IFS=$SAVEIFS
}
load_multisql()
{
	SAVEIFS=$IFS
	IFS=$(echo -en "\n\b")

	count="0"

	exec_sql="INSERT INTO tpcds_reports.multisql (id, description, tuples, duration) VALUES "
	for i in $(cat ${logdir}/rollout_testing_*.log); do
		count=$((count+1))
		id=$(echo $i | awk -F '|' '{print $1}')
		description=$(echo $i | awk -F '|' '{print $2}')
		tuples=$(echo $i | awk -F '|' '{print $3}')
		duration=$(echo $i | awk -F '|' '{print $4}')
		if [ "$count" -eq "1" ]; then
			exec_sql+="(${id}, '${description}', ${tuples}, '${duration}')"
		else
			exec_sql+=", (${id}, '${description}', ${tuples}, '${duration}')"
		fi
	done
	psql -c "${exec_sql}"

	IFS=$SAVEIFS
}
get_totals()
{
	# 1 user details
	psql -P pager=off -c "select split_part(description, '.', 2) as query_id, extract(epoch from duration) + extract(ms from duration)/1000::numeric as sql_seconds from tpcds_reports.sql order by query_id;"

	# 1 user queries
	psql -c "select floor(sub.total_seconds/(3600)) || ' hour(s), ' || 
	floor(sub.total_seconds/60 - floor(sub.total_seconds/(3600))*60) || ' minute(s), ' || 
	sub.total_seconds - (floor(sub.total_seconds/(60))*60) || ' second(s)' as total_queries
	from (
	select sum(extract(epoch from duration) + extract(ms from duration)/1000::numeric) as total_seconds from tpcds_reports.sql
	) as sub;"

	# concurrent totals
	psql -c "select floor(sub.total_seconds/(3600)) || ' hour(s), ' || 
	floor(sub.total_seconds/60 - floor(sub.total_seconds/(3600))*60) || ' minute(s), ' || 
	sub.total_seconds - (floor(sub.total_seconds/(60))*60) || ' second(s)' as total_concurrent_queries
	from (
	select max(sum_duration) as total_seconds from (select split_part(description, '.', 1) as session, sum(extract(epoch from duration)::numeric + extract(ms 
	from duration)::numeric/1000) as sum_duration from tpcds_reports.multisql group by split_part(description, '.', 1) order by split_part(description, '.', 1)) 
	) as sub;"

	# grand total
	psql -c "select floor(sum(sub.total_seconds)/(3600)) || ' hour(s), ' || 
	floor(sum(sub.total_seconds)/60 - floor(sum(sub.total_seconds)/(3600))*60) || ' minute(s), ' || 
	sum(sub.total_seconds) - (floor(sum(sub.total_seconds)/(60))*60) || ' second(s)' as total_time
	from (
	select sum(extract(epoch from duration) + extract(ms from duration)/1000::numeric) as total_seconds from tpcds_reports.sql
	union all
	select max(sum_duration) as total_seconds from (select split_part(description, '.', 1) as session, sum(extract(epoch from duration)::numeric + extract(ms 
	from duration)::numeric/1000) as sum_duration from tpcds_reports.multisql group by split_part(description, '.', 1) order by split_part(description, '.', 1)) 
	) as sub;"
}
create_tables
load_sql
load_multisql
get_totals

echo "INFO: Done!"
