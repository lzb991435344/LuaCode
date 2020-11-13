



local flag = 1
for i = 1,2 do
    local money = 8
    local cur = 7
    if  flag == 1 then
         cur = 3
         money =  money + cur
         print("flag==1",i,money)
         flag = 0
    else
        money =  money + cur
        print("flag==0",i,money)
    end
end
--[[
flag==1 1       11
flag==0 2       15
]]--



--关于table浅拷贝问题
--修改表数据中的值,需要先用临时变量获取表的地址,再对里面的变量赋值
local t ={money = 10}

local temp = t.money

temp = temp + 10


print(temp) --20
print(t.money) --10




local y = t --y获取t表的地址
y.money = y.money + 10

print(t.money) --20




