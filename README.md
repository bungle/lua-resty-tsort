# lua-resty-tsort

Performs a topological sort on input data.


# Synopsis

```lua
local dump = require "pl.pretty".dump
local tsort = require "resty.tsort"

local graph = tsort.new()

graph:add('a', 'b')
graph:add('b', 'c')
graph:add('0', 'a')

dump(graph:sort())

-- Output:
-- {
--   "0",
--   "a",
--   "b",
--   "c"
-- }

graph:add('1', '2', '3', 'a');

dump(graph:sort())

-- Output:
-- {
--   "0",
--   "1",
--   "2",
--   "3",
--   "a",
--   "b",
--   "c"
-- }

graph:add{'1', '1.5'};
graph:add{'1.5', 'a'};

dump(graph:sort())

-- Output:
-- {
--   "0",
--   "1",
--   "2",
--   "3",
--   "1.5",
--   "a",
--   "b",
--   "c"
-- }

graph:add('first', 'second');
graph:add('second', 'third', 'first');

dump(graph:sort())

-- Output:
-- Error: There is a circular dependency in the graph. It is not possible to derive a topological sort.
```
