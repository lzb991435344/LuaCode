

local t = {1,2,3,4,5,6,7,8,9}
local tmp = {}

for k,v in pairs(t) do
    if k <=5 then
        table.insert(tmp, v)
    end
end

for k,v in pairs(tmp) do
    print(k,v)
end