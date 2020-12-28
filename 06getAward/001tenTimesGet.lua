


--[[
规则：希望获得一个大约每 10 张卡里出一张橙卡的随机数列，除了每次 random 一个 [0,10) 的整数，判断证书是不是 0 以外，还有一个方法。那就是每次抽到一个橙卡后，都从一个指数分布的随机数列中取一个值出来，作为接下来会抽取到白卡的张数。按这个张数去发放白卡，等计数器减到 0 ，就发一张橙卡给玩家。这个白卡张数的数值范围是 [0, inf) 。

]]

math.randomseed(tostring(os.time()):reverse():sub(1, 6))

local function erand(rate)
    for i = 1, 100 do  -- 100 可以随便写
        --
        --math.random()   [0,1)
        local p = math.floor(math.log(1 - math.random()) * (-rate))
        if p < rate then
            return p
        end
    end
    --return rate - 1
    return rate
end


local function erand2(rate)
    while true do
        local p = math.floor(math.log(1-math.random()) * (-rate))
        if p < rate then
            return p
        end
    end
end

--print(erand(10))
--print(erand2(10))
--print(erand(5))
--print(erand2(5))

--[[
加上了 10 张保底，单张出橙卡的概率就大大增加了，增加到多少呢？大约是 21%。如果你希望保持 10% 左右的投放率，那么保底张数大约应该设置在 23 张左右

]]


local userdata = {commercial = 1000, agricultural = 1000, policy = 1000, military = 1000}
local data = {}
print(userdata.commercial)

if  not userdata then
    print(1)
end
print(next(userdata) == nil)