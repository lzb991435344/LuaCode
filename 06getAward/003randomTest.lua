local cfg = {{1,25,},{2,15,},{3,7,},{4,3,},{5,15,},{6,7,},{7,3,},{8,15,},{9,7,},{10,3,},}


local  sum = 0
for k,v in pairs(cfg) do
    sum = sum + v[2]
end

math.randomseed(tostring(os.time()):reverse():sub(1, 7))
local ran = math.random(1,sum)
local total = 0

for k,v in pairs(cfg) do
    total = total + v[2]
    if total >= ran then
        print(total)
        print(k)
        break
    end
end
