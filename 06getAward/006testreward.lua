--local t = {id=3,award=2,award_ratio={[1]=0.2,[2]=3000},people={[1]=9,[2]=4,[3]=11,[4]=7,[5]=12}}
---print(t.award_ratio[1])



local  t = {{1,50,},{1.5,20,},{2,10,},{2.5,8,},{3,8,},{3.5,4,},}

local t1 = {}
local t2 = {}

for k,v in pairs(t) do
    table.insert(t1,v[1])
    table.insert(t2, v[2])
end

for k,v in pairs(t2) do
    print(k,v)
end