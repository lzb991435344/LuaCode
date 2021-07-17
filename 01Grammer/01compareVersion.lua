

function mysplit(string, split)
    local list = {

    }
    --local split = "."

    local pos = 1
    if string.find("", split, 1) then
        error("split matches empty string!")
    end

    
    while true do
        local first, last = string.find(string, split, pos)
        print("first, last is:", first, last)
        print("pos:", pos)

        if first then
            table.insert(list, string.sub(string, pos, first - 1))
            
            pos = last + 1
            print("pos:", pos)
        else
            table.insert(list, string.sub(string, pos))
            break   
        end
    end

    return list
end

local function compareVersion(version1, version2)

	local needUpdate = false
end	

function Split(s, sp)
    local res = {}

    local temp = s
    local len = 0
    while true do
        len = string.find(temp, sp)
        if len ~= nil then
            local result = string.sub(temp, 1, len-1)
            temp = string.sub(temp, len+1)
            table.insert(res, result)
        else
            table.insert(res, temp)
            break
        end
    end

    return res
end


local string = "121.45.6.8"

local pattern = "/."

local t = mysplit(string, pattern)

print(#t)

for i = 1,#t do
	print(t[i])
end	

--local t = string.gmatch(string, "%a+")
--local t = mysplit(string, pattern)

--for k,v in pairs(t) do
--	print(k,v)
--end
--local a,b = string.gsub(string, ".", "*",4)

--print(a)
--print(b)


--[[
local t = 1
local len = "abc"

print( t << 8)
print(string.len(len))

]]









