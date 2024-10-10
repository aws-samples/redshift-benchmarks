#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${PWD}/../tpch_variables.sh

current_user=$(psql -t -A -v ON_ERROR_STOP=1 -c "select current_user;")

echo "psql -v ON_ERROR_STOP=1 -q -A -t -c \"ALTER USER ${PGUSER} SET search_path=${EXT_SCHEMA},public;\""
psql -v ON_ERROR_STOP=1 -q -A -t -c "ALTER USER ${PGUSER} SET search_path=${EXT_SCHEMA},public;"

