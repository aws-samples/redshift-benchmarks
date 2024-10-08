set enable_result_cache_for_session = off;
:EXPLAIN

select /* TPC-H Q6 */
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date '1994-01-01'
	and l_shipdate < dateadd(year, 1, cast('1994-01-01' as date)) 
	and l_discount between .06 - 0.01 and .06 + 0.01
	and l_quantity < 24;
