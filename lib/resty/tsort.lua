local setmetatable = setmetatable
local assert = assert
local select = select
local ipairs = ipairs
local pairs = pairs
local type = type
local function visit(k, n, m, s)
    assert(m[k] ~= "temp", "There is a circular dependency in the graph. It is not possible to derive a topological sort.")
    if m[k] ~= nil then return end
    m[k] = "temp"
    for _, y in ipairs(n[k]) do
        visit(y, n, m, s)
    end
    m[k] = "perm"
    s[#s+1] = k
end
local tsort = {}
tsort.__index = tsort
function tsort.new()
    return setmetatable({ nodes = {} }, tsort)
end
function tsort:add(...)
    local c = select("#", ...)
    local n = self.nodes
    local p
    if c == 1 then
        local a = select(1, ...)
        if type(a) == "table" then
            p = a
            c = #p
        else
            p = { a }
        end
    else
        p = { ... }
    end
    for _, i in ipairs(p) do
        if n[i] == nil then
            n[i] = {}
        end
    end
    for i=2, c, 1 do
        local f = p[i]
        local t = p[i-1]
        local o = n[f]
        o[#o+1] = t
    end
    return self
end
function tsort:sort()
    local s = {}
    local m  = {}
    local n  = self.nodes
    for k in pairs(n) do
        if m[k] == nil then
            visit(k, n, m, s)
        end
    end
    return s
end
return tsort