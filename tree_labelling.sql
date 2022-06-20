-- *Context:* Say you have a table tree with a column of nodes and a column corresponding parent nodes 

-- node   parent	left join
-- 1       2		1 2	null null
-- 2       5		2 5 1 2
-- 3       5		3 5 4 3
-- 4       3		4 3 null null
-- 5       NULL 	5 null 2 5

-- *Task:* Write SQL such that we label each node as a “leaf”, “inner” or “Root” node, such that for the nodes above we get: 

-- node    label  
-- 1       Leaf
-- 2       Inner
-- 3       Inner
-- 4       Leaf
-- 5       Root

-- A solution which works for the above example will receive full credit, although you can receive extra credit for providing a solution that is generalizable to a tree of any depth (not just depth = 2, as is the case in the example above). 

with tree_labels as (
	select a.node as node_a, a.parent as parent_a, b.node as node_b, b.parent as parent_b from node a 
	left join node b 
	on a.node = b.parent
)
select node_a as node,
		case when parent_a is null then 'ROOT',
			when node_b is null and parent_b is null then 'LEAF'
			else 'INNER'
from tree_labels;