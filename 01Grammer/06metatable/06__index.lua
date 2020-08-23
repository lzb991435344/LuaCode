


local a = {
    x = 1,
    y = 10
}


local b = {
    x = 3,
    y = 5
}

local t = {

}

t.__add = function (t1, t2)
    return t1.x + t2.x
end
t.__sub = function (t1, t2)
    return t1.y - t2.y
end

--未赋值之前为nil
print(getmetatable(a)) --nil
setmetatable(a, t) 

print(getmetatable(a)) --table地址
print(t)
setmetatable(b, t)



print(a + b) --4
print(a - b) --5

t.__index = {
	z = 5,
}

t.__newIndex = function (t, k, v)
	t.k = v
end

a.z = 6

print(a.z)



















