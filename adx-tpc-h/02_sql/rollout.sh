#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${PWD}/../functions.sh
source ${PWD}/../tpch_variables.sh

step=sql
init_log ${step}

rm -f ${PWD}/../log/*single.explain_analyze.log

for i in $(ls ${PWD}/*.tpch.*.sql); do
	id=$(echo ${i} | awk -F '.' '{print $1}')
	table_name=$(echo ${i} | awk -F '.' '{print $3}')
	start_log
	if [ "$EXPLAIN" == "false" ]; then
		echo "psql -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN=\"\" -f ${i} | wc -l"
		tuples=$(psql -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN="" -f ${i} | wc -l; exit ${PIPESTATUS[0]})
	else
		myfilename=$(basename ${i})
		mylogfile=${PWD}/../log/$myfilename.single.explain_analyze.log
		echo "psql -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN=\"EXPLAIN\" -f ${i} > ${mylogfile}"
		psql -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN="EXPLAIN" -f ${i} > ${mylogfile}
		tuples="0"
	fi
	log ${tuples}
done
