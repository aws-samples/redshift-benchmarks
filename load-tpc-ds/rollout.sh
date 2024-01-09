#!/bin/bash

set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/functions.sh
source $PWD/tpcds_variables.sh

checks()
{
	count=$(rsql -D ${DSN} -c "select version()" 2> /dev/null | wc -l)
	if [ "${count}" -eq "0" ]; then
		echo "ERROR: Unable to connect to Redshift database.  Check your DSN configuration for rsql."
		exit 1
	fi
	count=$(aws s3 ls s3://${SOURCE_BUCKET}/${SCALE} 2> /dev/null | wc -l)
	if [ "${count}" -eq "0" ]; then
		echo "ERROR: Source bucket is not available for s3://${SOURCE_BUCKET}/${SCALE}"
		exit 1
	fi
	echo "INFO: Checking temp bucket."
	touch ${PWD}/test.txt
	aws s3 cp ${PWD}/test.txt s3://${TEMP_BUCKET}/ > /dev/null
	aws s3 rm s3://${TEMP_BUCKET}/test.txt > /dev/null
	rm -f ${PWD}/test.txt
}
print_info()
{
	echo "INFO: DSN: ${DSN}"
	echo "INFO: SCHEMA_NAME: ${SCHEMA_NAME}"
	echo "INFO: EXPLAIN: ${EXPLAIN}"
	echo "INFO: MULTI_USER_COUNT: ${MULTI_USER_COUNT}"
	echo "INFO: SCALE: ${SCALE}"
	echo "INFO: SOURCE_BUCKET: ${SOURCE_BUCKET}"
	echo "INFO: TEMP_BUCKET: ${TEMP_BUCKET}"

	count=$(rsql -D ${DSN} -t -A -c "select charged_seconds from sys_serverless_usage limit 1" 2> /dev/null | wc -l)
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
