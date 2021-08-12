-- tab = {}
-- tab.size = {a = 1}
-- --print(tab.size.a)
-- --tab.size = nil
-- print(tab.size.a)



-- --local str = "uid="..tostring("bell")
-- local  happy_bankrupt_log = "uid="..tostring(uid)..",happyBankruptTime"..
--tostring(happyBankruptTime)..",gameType"..tostring(gameType)..",restGameBeans"
--..tostring(money)..",dayCount"..tostring(dayCount)..",curHappyPlayCount="..tostring(curHappyPlayCount)

-- print(happy_bankrupt_log)


-- local count = 0
-- count = count + 1

-- print(count)



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

local g = {
	szUidCoef = {
		[1001] = 3280,
		[2002] = 1980,
		[3003] = 1780
	}
}


--[[

local t = {
	uid = 1,
	coef = {}
}

for k,v in pairs(g.szUidCoef) do
	table.insert(t.coef,v)
end	

--{coef={[1]=3280,[2]=1980,[3]=1780},uid=1}
]]


local t = {
	uid = 1,
	coef = 2
}

for k,v in pairs(g.szUidCoef) do
	table.insert(t,v)
end	



print(ttostring(t))



