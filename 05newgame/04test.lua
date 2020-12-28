



local count = 0

local function rotate(probability, threshold)
    local  res = false;

    count = count + 1
    if count % threshold == 0 then
        res = true
    else
        res = math.random() <= probability
    end
    if res then
        count = 0
    end
    return res
end

print(rotate(0.1, 5))


local function test()
    return 1,2
end
local _,b = test()
print(b)

local currentAffairsID1 = {[1]={[1]=1040,[2]=1041,[3]=1027,[4]=20,[5]=21}}

print(currentAffairsID1[1][1])
