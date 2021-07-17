
local t3 = {
	[1] = 3,
	[2] = 4,
	[3] = 5,
	[6] = 9
}



local t1 = {
	[1] = 1,
	[2] = 2,
	[3] = {
		[1] = 4,
		[2] = 5
	}
}

--浅拷贝
local t2 = t3
print("------1--low copy------")
for k,v in pairs(t3) do
	print(k,v)
end


--表中有表时，浅拷贝不完全，需要实现深拷贝
print("------2---------")
local t4 = t1
for k,v in pairs(t4) do
	print(k,v)
end


t = {
    a = 1,

    b = 2,

    c = {
        x = 1,

        y = 2,

        z = 3,
    }

}

print("------3---------")
function table.deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end


print("value a ="..t.a)
print("value x ="..t.c.x)

--t[t.c] = t
local t4 = table.deepcopy(t)
--print(t4[t4.c])
--for k,v in pairs(t) do
--	print(k,v)
--end

print("t4 value a ="..t4.a)
print("t4 value x ="..t4.c.x)

local t5 = t
print("t5 value a ="..t5.a)
print("t5 value x ="..t5.c.x)

--[[
------3---------
value a =1
value x =1
t4 value a =1
t4 value x =1
t5 value a =1
t5 value x =1

]]--










