

--对test中的键值作比较

local test = {
    a = 1,
    f = 9,
    d = 2,
    c = 8,
    e = 5
}

local key_test = {

}

--将key键插入新表
for i in pairs(test) do
    table.insert(key_test, i)
end


--定义函数进行大小值的比较
table.sort(key_test, function (a, b)
	return a > b
end)

--table.sort(key_test, function(a, b)
--	return a < b
--end)


for i, v in pairs(key_test) do
    --print(v, test[i])
    print(i, key_test[i])
end

--[[
1	f
2	e
3	d
4	c
5	a
]]






