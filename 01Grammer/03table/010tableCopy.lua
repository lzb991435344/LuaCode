
local function ttostring(t)
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

local t = {
	1,
	{1,2,3}
}

--[[for k,v in pairs(t) do
	if type(v) == "table" then
		for i,j in pairs(v) do
			print(i,j)
		end
	else
		print(k,v)
	end
end]]
print(ttostring(t))

--实现深拷贝表数据
local function Tcopy(c)
	local t = {}
	for k,v in pairs(c) do
		if type(v) == "table" then
			t[k] = Tcopy(v)
		else
			t[k] = v		
		end
	end
	return t
end




local new = Tcopy(t)

--for k,v in pairs(new)  do
--	print(k,v)
--end

print(ttostring(new))
