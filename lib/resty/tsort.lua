local setmetatable = setmetatable
local select = select
local ipairs = ipairs
local pairs = pairs
local type = type
local function visit(k, n, m, s)
    local z = m[k]
    if z == 0 then
        return "There is a circular dependency in the graph. It is not possible to derive a topological sort."
    elseif z ~= 1 then
        m[k] = 0
        for _, y in ipairs(n[k]) do
            local err = visit(y, n, m, s)
            if err then
                return err
            end
        end
        m[k] = 1
        s[#s+1] = k
    end
end
local tsort = {}
tsort.__index = tsort
function tsort.new()
    return setmetatable({ n = {} }, tsort)
end
function tsort:add(...)
    local c = select("#", ...)
    local n = self.n
    local p
    if c == 1 then
        p = select(1, ...)
        if type(p) == "table" then
            c = #p
        else
            p = { p }
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
    local n  = self.n
    local s = {}
    local m  = {}
    for k in pairs(n) do
        if m[k] == nil then
            local err = visit(k, n, m, s)
            if err then
                return nil, err
            end
        end
    end
    return s
end
return tsort