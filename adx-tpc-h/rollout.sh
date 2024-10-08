#!/bin/bash

set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/functions.sh
source $PWD/tpch_variables.sh

checks()
{
	echo "INFO: Checking Redshift"
	if [[ "${PGHOST}" == "" || "${PGPORT}" == "" || "${PGUSER}" == "" || "${PGDATABASE}" == "" ]]; then
		echo "ERROR: Unable to determine Redshift cluster information."
		echo "Be sure to set the following variables in your bashrc file:"
		echo "  PGHOST"
		echo "  PGPORT"
		echo "  PGUSER"
		echo "  PGDATABASE"
		exit 1
	fi
	count=$(psql -t -A -c "select version()" 2> /dev/null | wc -l)
	if [ "${count}" -eq "0" ]; then
		echo "ERROR: Unable to connect to Redshift database.  Check your PG variables in your bashrc file."
		exit 1
	fi
	echo "INFO: Checking External Schema."
	count=$(psql -t -A -c "select count(*) from pg_namespace where nspname = '${EXT_SCHEMA}'")
	if [ "${count}" -eq "0" ]; then
		echo "ERROR: External Schema ${EXT_SCHEMA} not found."
		exit 1
	fi
}
print_info()
{
	echo "INFO: PGHOST: ${PGHOST}"
	echo "INFO: PGPORT: ${PGPORT}"
	echo "INFO: PGUSER: ${PGUSER}"
	echo "INFO: PGDATABASE: ${PGDATABASE}"
	echo "INFO: EXPLAIN: ${EXPLAIN}"
	echo "INFO: MULTI_USER_COUNT: ${MULTI_USER_COUNT}"
	echo "INFO: EXT_SCHEMA: ${EXT_SCHEMA}"

	count=$(psql -t -A -c "select count(*) from pg_class c join pg_namespace n on c.relnamespace = n.oid where c.relname = 'sys_serverless_usage' and n.nspname = 'pg_catalog'")
	if [ "${count}" -eq "0" ]; then
		echo "INFO: Redshift Provisioned Cluster"
	else
		echo "INFO: Redshift Serverless Endpoint"
	fi
}

checks
print_info
for i in $(ls -d ${PWD}/0*); do
	echo "${i}/rollout.sh"
	${i}/rollout.sh
done
