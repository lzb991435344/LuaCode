





function ttostring(t)
    if not t then
        return "nil"
    end

	if type(t)~="table" then
		return tostring(t)
	end

	local function ser_table(tbl)
		local tmp = {}
		for k,v in pairs(tbl) do
			local key = type(k)=="number" and "["..k.."]" or k
			local tp = type(v)
			if tp=="table" then
				table.insert(tmp, key.."="..ser_table(v))
			else
				if tp=="string" then
					table.insert(tmp, key.."="..string.format("%q",v))
				elseif tp=="boolean" then
					table.insert(tmp, key.."="..tostring(v))
                elseif tp=="function" then
                    --函数不打印
				else
					table.insert(tmp, key.."="..v)
				end
			end
		end
		return "{"..table.concat(tmp,",").."}"
	end

	return ser_table(t)
end

--[[
local t = {
	{type = 0,
	count = 0,
	reward = {}},
	{type = 0,
	count = 0,
	reward = {}
	}
}

local tmp = {}
local t2 = {coin=3000,floor=0,id=1,count=4,coin_type=0}
table.insert(tmp, t2)
t[1].type = 1
t[1].count = 4
t[1].reward = tmp


local tmp = {}
local t1 = {coin=3300,floor=0,id=1,count=4,coin_type=0}
table.insert(tmp, t1)
t[2].type = 1
t[2].count = 4
t[2].reward = tmp
]]

local t = {
	type = 0,
	count = 0,
	--reward1 = {}
	--reward2 = {}
}

local tmp = {}
local t2 = {coin=3000,floor=0,id=1,count=4,coin_type=0}
table.insert(t, t2)
t.type = 1
t.count = 4
--t.reward = tmp


local tmp = {}
local t1 = {coin=3300,floor=0,id=1,count=4,coin_type=0}
table.insert(t, t1)
--t.reward = tmp


print(ttostring(t))



print(os.date("%Y%m%d"))


local a = nil
local b = false

if a == b then
	print("yes")
else
	print("no")
end






