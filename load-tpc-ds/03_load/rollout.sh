#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${PWD}/../functions.sh
source ${PWD}/../tpcds_variables.sh

step=load
init_log ${step}
start_log
table_name="load"

base_bucket="'s3://${SOURCE_BUCKET}/${SCALE}"
if [ "${SCALE}" == "10GB" ]; then
	GZIP=""
else
	GZIP="GZIP"
fi

rm -f ${PWD}/../log/rollout_${step}_detailed.log

table_count="0"
for i in $(rsql -D ${DSN} -t -A -c "select table_name from information_schema.tables where table_schema = '${SCHEMA_NAME}' order by table_name"); do
	table_count=$((table_count+1))
	echo "Loading $i"
	bucket_path="${base_bucket}/${i}/'"
	rsql -D ${DSN} -f ${PWD}/load.sql -v table_name="${i}" -v bucket_path="${bucket_path}" -v gzip=${GZIP} >> ${PWD}/../log/rollout_${step}_detailed.log 2>&1 &
done
if [ "$table_count" -eq "0" ]; then
	echo "ERROR: No tables found in ${SCHEMA_NAME}."
	exit 1
fi
count=$(ps -ef | grep rsql | grep -v grep | wc -l)
echo -ne "Executing load in parallel"
while [ "$count" -gt "0" ]; do
	echo -ne "."
	sleep 10
	count=$(ps -ef | grep rsql | grep -v grep | wc -l)
done
echo "."

successful_count=$(grep -o successfully ${PWD}/../log/rollout_${step}_detailed.log | wc -l)
if [ "${successful_count}" -ne "${table_count}" ]; then
	echo "ERROR: The number of successfully loaded tables is less than the number of tables."
	echo "Check ${PWD}/../log/rollout_${step}_detailed.log for more details."
	exit 1
else
	echo "INFO: All tables loaded successfully."
fi

log
