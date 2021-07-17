

local t = {}
local t1 = {1, 2, 3}
local t2 = {4,5,6}



table.insert(t,t1)
table.insert(t,t2)

for k,v in pairs(t) do
    print(k,v)
end
print(#t)