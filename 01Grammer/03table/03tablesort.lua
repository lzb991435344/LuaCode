a = {}
lines ={
  luaH_set = 10,
  luaH_get = 24,
  luaH_present = 48,
}

--将key作为value存到a中
for n in  pairs(lines)  do
   a[#a + 1] = n
end

table.sort(a)
for  i,n in ipairs(a)  do
    print(i, n)
end

--[[
1	luaH_get
2	luaH_present
3	luaH_set
]]



--按照字母顺序打印函数
function pairsByKeys( t, f)
	local a = {}
	for n in pairs(t) do
		a[#a + 1] = n
	end

	table.sort( a, f)

	local i = 0
	return function()
		i = i + 1
		return a[i], t[a[i]]
	end
end


for name, line in pairsByKeys(lines) do
	print(name, line)
end

--[[

luaH_get	24
luaH_present	48
luaH_set	10

]]--











