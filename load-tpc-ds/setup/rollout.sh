#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${PWD}/../functions.sh
source ${PWD}/../tpcds_variables.sh

default_scale="3000"
default_streams="100"
single_user_dir="04_sql"
multi_user_dir="05_multi_user"
tpcds_query_name="query_0.sql"

get_queries()
{
	#using 3TB queries because the others don't conform 
	curl -s https://raw.githubusercontent.com/awslabs/amazon-redshift-utils/master/src/CloudDataWarehouseBenchmark/Cloud-DWB-Derived-from-TPCDS/3TB/queries/${tpcds_query_name} > ${tpcds_query_name}
}
create_single_query_files()
{
	query_id=1
	file_id=101

	echo "rm -f ${PWD}/../${single_user_dir}/*.sql"
	rm -f ${PWD}/../${single_user_dir}/*.sql

	for i in $(seq 1 99); do
		q=$(printf %02d ${query_id})
		template_filename=query${i}.tpl
		start_position=""
		end_position=""
		for pos in $(grep -n ${template_filename} ${PWD}/${tpcds_query_name} | grep -v "TPC-DS" | awk -F ':' '{print $1}'); do
			if [ "${start_position}" == "" ]; then
				start_position=${pos}
			else
				end_position=${pos}
			fi
		done
		filename=$file_id.tpcds.${q}.sql

		echo "echo \":EXPLAIN\" >> ${PWD}/../${single_user_dir}/${filename}"
		echo ":EXPLAIN" >> ${PWD}/../${single_user_dir}/${filename}
		echo "sed -n \"${start_position}\",\"${end_position}\"p ${PWD}/query_0.sql >> ${PWD}/../${single_user_dir}/${filename}"
		sed -n "${start_position}","${end_position}"p ${PWD}/query_0.sql >> ${PWD}/../${single_user_dir}/${filename}
		query_id=$((query_id + 1))
		file_id=$((file_id + 1))
	done

	echo ""
	echo "INFO: Queries 114, 123, 124, and 139 have 2 queries in each file.  Need to add :EXPLAIN to second query in these files"
	arr=("114.tpcds.14.sql" "123.tpcds.23.sql" "124.tpcds.24.sql" "139.tpcds.39.sql")

	for i in "${arr[@]}"; do
		myfilename=${PWD}/../${single_user_dir}/${i}
		echo "myfilename: ${myfilename}"
		pos=$(grep -n ";" ${myfilename} | awk -F ':' '{print $1}' | head -1)
		pos=$((pos+1))
		echo "pos: ${pos}"
		sed -i ''${pos}'i\'$'\n'':EXPLAIN'$'\n' ${myfilename}

	done
}
create_multi_query_files()
{
	#create each session's directory
	for i in $(seq 1 ${default_streams}); do
		sql_dir="${PWD}/../${multi_user_dir}/${session_id}${i}"
		echo "checking for directory ${sql_dir}"
		if [ ! -d "${sql_dir}" ]; then
			echo "mkdir ${sql_dir}"
			mkdir ${sql_dir}
		fi
		echo "rm -f ${sql_dir}/*.sql"
		rm -f ${sql_dir}/*.sql
	done

	for session_id in $(seq 1 ${default_streams}); do
		#going from 1 base to 0 base
		tpcds_id=$((session_id-1))
		query_id=1

		echo "rm -rf ${PWD}/../${multi_user_dir}/${session_id}/*.sql"
		rm -rf ${PWD}/../${multi_user_dir}/${session_id}/*.sql

		for i in $(shuf -i1-99); do
			q=$(printf %02d ${query_id})
			template_filename=query${i}.tpl
			start_position=""
			end_position=""
			for pos in $(grep -n ${template_filename} ${PWD}/${tpcds_query_name} | grep -v "TPC-DS" | awk -F ':' '{print $1}'); do
				if [ "${start_position}" == "" ]; then
					start_position=${pos}
				else
					end_position=${pos}
				fi
			done

			file_id=$(sed -n "${start_position}","${start_position}"p ${PWD}/${tpcds_query_name} |  awk -F ' ' '{print $4}' | awk -F 'query' '{print $2}' | awk -F '.' '{print $1'})
			filename=${q}.tpcds.${file_id}.sql

			echo "echo \":EXPLAIN\" >> ${PWD}/../${multi_user_dir}/${session_id}/${filename}"
			echo ":EXPLAIN" >> ${PWD}/../${multi_user_dir}/${session_id}/${filename}
			echo "sed -n \"${start_position}\",\"${end_position}\"p ${PWD}/${tpcds_query_name} >> ${PWD}/../${multi_user_dir}/${session_id}/${filename}"
			sed -n "${start_position}","${end_position}"p ${PWD}/${tpcds_query_name} >> ${PWD}/../${multi_user_dir}/${session_id}/${filename}
			query_id=$((query_id + 1))
		done

		echo ""
		echo "INFO: Queries 114, 123, 124, and 139 have 2 queries in each file.  Need to add :EXPLAIN to second query in these files"
		echo ""
		arr=("*.tpcds.14.sql" "*.tpcds.23.sql" "*.tpcds.24.sql" "*.tpcds.39.sql")

		for i in "${arr[@]}"; do
			echo ${i}
			myfilename=${PWD}/../${multi_user_dir}/${session_id}/${i}
			echo "myfilename: ${myfilename}"
			pos=$(grep -n ";" ${myfilename} | awk -F ':' '{print $1}' | head -1)
			pos=$((pos+1))
			echo "pos: ${pos}"
			sed -i ''${pos}'i\'$'\n'':EXPLAIN'$'\n' ${myfilename}
		done
	done
}

get_queries
create_single_query_files
create_multi_query_files
