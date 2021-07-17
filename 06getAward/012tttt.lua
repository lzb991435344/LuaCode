local t = {{2,10,},{3,16,},{4,3,},{5,1,},{6,16,},{7,3,},{8,1,},{9,16,},{10,3,},{11,1,},}

local sum = 0
for k,v in pairs(t) do
        sum  = sum + v[2]
end

print(sum)