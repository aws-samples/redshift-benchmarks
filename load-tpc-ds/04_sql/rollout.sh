#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${PWD}/../functions.sh
source ${PWD}/../tpcds_variables.sh

step=sql
init_log ${step}

rm -f ${PWD}/../log/*single.explain_analyze.log

for i in $(ls ${PWD}/*.tpcds.*.sql); do
	id=$(echo ${i} | awk -F '.' '{print $1}')
	table_name=$(echo ${i} | awk -F '.' '{print $3}')
	start_log
	if [ "$EXPLAIN" == "false" ]; then
		echo "rsql -D ${DSN} -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN=\"\" -f ${i} | wc -l"
		tuples=$(rsql -D ${DSN} -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN="" -f ${i} | wc -l; exit ${PIPESTATUS[0]})
	else
		myfilename=$(basename ${i})
		mylogfile=${PWD}/../log/$myfilename.single.explain_analyze.log
		echo "rsql -D ${DSN} -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN=\"EXPLAIN\" -f ${i} > ${mylogfile}"
		rsql -D ${DSN} -A -q -t -P pager=off -v ON_ERROR_STOP=1 -v EXPLAIN="EXPLAIN" -f ${i} > ${mylogfile}
		tuples="0"
	fi
	log ${tuples}
done
