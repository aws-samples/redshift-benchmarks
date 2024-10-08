set enable_result_cache_for_session = off;
:EXPLAIN

select /* TPC-H Q4 */
	o_orderpriority,
	count(*) as order_count
from
	orders
where
	o_orderdate >= date '1993-07-01'
	and o_orderdate < dateadd(month, 3, cast('1993-07-01' as date)) 
	and exists (
		select
			*
		from
			lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority;
