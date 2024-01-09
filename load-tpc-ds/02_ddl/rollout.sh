#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${PWD}/../functions.sh
source ${PWD}/../tpcds_variables.sh

step=ddl
init_log ${step}

#Create tables
for i in $(ls ${PWD}/*.sql); do
	id=$(echo ${i} | awk -F '.' '{print $1}')
	table_name=$(echo ${i} | awk -F '.' '{print $3}')
	start_log
	echo "rsql -D ${DSN} -q -a -P pager=off -v ON_ERROR_STOP=1 -v schema_name=${SCHEMA_NAME} -f ${i}"
	rsql -D ${DSN} -q -a -P pager=off -v ON_ERROR_STOP=1 -v schema_name=${SCHEMA_NAME} -f ${i}
	log
done
