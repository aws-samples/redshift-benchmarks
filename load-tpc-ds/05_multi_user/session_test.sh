#!/bin/bash

set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source $PWD/../tpcds_variables.sh

session_id=${1}

if [ "${session_id}" == "" ]; then
	echo "Error: you must provide the session id"
	echo "Example: ./session_test.sh 1"
	exit 1
fi

step=testing_${session_id}
init_log ${step}

sql_dir=${PWD}/${session_id}
tuples="0"
for i in $(ls ${sql_dir}/*.sql); do

	id=$(basename ${i} | awk -F '.' '{print $1}')
	schema_name=${session_id}
	table_name=$(basename ${i} | awk -F '.' '{print $3}')

	start_log
	if [ "${EXPLAIN}" == "false" ]; then
		echo "rsql -D ${DSN} -v ON_ERROR_STOP=1 -A -q -t -P pager=off -v EXPLAIN="" -f ${i} | wc -l"
		tuples=$(rsql -D ${DSN} -v ON_ERROR_STOP=1 -A -q -t -P pager=off -v EXPLAIN="" -f ${i} | wc -l; exit ${PIPESTATUS[0]})
	else
		myfilename=$(basename ${i})
		mylogfile="${PWD}/../log/${session_id}.${myfilename}.multi.explain_analyze.log"
		echo "rsql -D ${DSN} -v ON_ERROR_STOP=1 -A -q -t -P pager=off -v EXPLAIN=\"EXPLAIN\" -f ${i}"
		rsql -D ${DSN} -v ON_ERROR_STOP=1 -A -q -t -P pager=off -v EXPLAIN="EXPLAIN" -f ${i} > ${mylogfile}
		tuples="0"
	fi
	log ${tuples}
done

end_step ${step}
