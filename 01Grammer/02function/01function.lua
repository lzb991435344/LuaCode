
local t = {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4
}


function values(t)
	local i = 0
	--返回一个函数
	return function()
		i = i + 1
		return t[i]
	end
end

--function: 0x7fc5ccc068c0
print(values(t))

--function
local iter = values(t)

while true do
	local ele = iter()
	if ele == nil then 
		break
	end
	print(ele)
end


function func()
	return function func()
		return 2
	end
end

--[[
function: 0x7fe2314066f0
1
2
3
4

]]--



