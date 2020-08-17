local a = 10

while a < 15 do
	print(a)
	a = a + 1
end

print("----------")
local b = 10

repeat 
	print(b)
	b = b + 1

until(b > 15)


--[[
10
11
12
13
14
----------
10
11
12
13
14
15


]]