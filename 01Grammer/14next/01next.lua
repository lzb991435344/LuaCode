


local tab = {
	x = 1,
	y = 2,

	[100] = 3,
	[3] = 100
}


--判断表是否为空
local index, value = next(tab)

if index ~= nil then 
	print("index is not nil!, index, value", index, value)
end


--遍历表
 while index ~= nil do
 	print("key,value", index, value)
    index,value = next(tab, index)
 end

--[[
key,value	100	3
key,value	3	100
key,value	y	2
key,value	x	1

]]

local ret = next(tab, 100)
print(ret) --3


local ret = next({}, nil)
print(ret) --nil


--不存在的索引
--local ret = next(tab, 1000)
--print(ret)


