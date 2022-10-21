#!/bin/bash
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${PWD}/../functions.sh
source ${PWD}/../tpcds_variables.sh

set -e

if [ "${MULTI_USER_COUNT}" -eq "0" ]; then
	echo "MULTI_USER_COUNT set at 0 so exiting..."
	exit 0
fi

get_psql_count()
{
	psql_count=$(ps -ef | grep psql | grep multi_user | grep -v grep | wc -l)
}

get_file_count()
{
	file_count=$(ls ${PWD}/../log/end_testing* 2> /dev/null | wc -l)
}

rm -f ${PWD}/../log/end_testing_*.log
rm -f ${PWD}/../log/testing*.log
rm -f ${PWD}/../log/rollout_testing_*.log
rm -f ${PWD}/../log/*multi.explain_analyze.log

for i in $(seq 1 ${MULTI_USER_COUNT}); do
	session_log=${PWD}/../log/testing_session_${i}.log
	echo "${PWD}/session_test.sh ${i}"
	${PWD}/session_test.sh ${i} > ${session_log} 2>&1 &
done

sleep 5

get_psql_count
echo "Now executing queries. This make take a while."
echo -ne "Executing queries."
while [ "${psql_count}" -gt "0" ]; do
	echo -ne "."
	sleep 60
	get_psql_count
done
echo "done."
echo ""

get_file_count

if [ "${file_count}" -ne "${MULTI_USER_COUNT}" ]; then
	echo "The number of successfully completed sessions is less than expected!"
	echo "Please review the log files to determine which queries failed."
	exit 1
fi
