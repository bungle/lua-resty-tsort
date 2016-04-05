# lua-resty-tsort

Performs a topological sort on input data.


# Synopsis

```lua
local dump  = require "pl.pretty".dump
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

local sorted, err = graph:sort())

-- Returns:
-- sorter = nil, err = "There is a circular dependency in the graph. It is not possible to derive a topological sort."
```

## License

`lua-resty-tsort` uses two clause BSD license.

```
Copyright (c) 2016, Aapo Talvensaari
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
