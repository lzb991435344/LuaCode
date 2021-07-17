local t = {{{506,1,100,},},}

--[[for k,v in pairs(t) do
    if type(v) == "table" then
        for p,q in pairs(v[1]) do
            print(v[1][1])
            break
        end
    end
end]]

--[[for k,v in pairs(t) do
    print(v[1][2])
end]]
--print(t[1][1][1])
--print(t[1][1][2])
--print(t[1][1][3])

local tt = {{a=1,b = 2},{3,4},{5,6}}

--table.remove(tt, 1)
print(#tt)
for i=1,#tt  do
    print(tt[1].a)
end

for k,v in pairs(tt)  do
end


