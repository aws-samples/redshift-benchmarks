#!/bin/bash
set -e

count=$(alias | grep -w grep | wc -l)
if [ "$count" -gt "0" ]; then
	unalias grep
fi
count=$(alias | grep -w ls | wc -l)
if [ "$count" -gt "0" ]; then
	unalias ls
fi

LOCAL_PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

init_log()
{
	logfile=rollout_${1}.log
	rm -f ${LOCAL_PWD}/log/${logfile}
}
start_log()
{
	T="$(date +%s%N)"
}
log()
{
	#duration
	T="$(($(date +%s%N)-T))"
	# seconds
	S="$((T/1000000000))"
	# milliseconds
	M="$((T/1000000))"

	#this is done for steps that don't have id values
	if [ "${id}" == "" ]; then
		id="1"
	else
		id=$(basename ${i} | awk -F '.' '{print $1}')
	fi

	tuples=${1}
	if [ "${tuples}" == "" ]; then
		tuples="0"
	fi

	printf "${id}|${schema_name}.${table_name}|${tuples}|1970-01-01 %02d:%02d:%02d.%03d\n" "$((S/3600%24))" "$((S/60%60))" "$((S%60))" "${M}" >> $LOCAL_PWD/log/${logfile}
}
end_step()
{
	local logfile=end_$1.log
	touch $LOCAL_PWD/log/$logfile
}
