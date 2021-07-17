
local t1 = {
	[1] = 'a',
	[2] = 'b',
	[3] = 'c',
	[5] = 'd',
	[6] = 'e'
}

print("-------1-------")
for i,v in ipairs(t1) do
	print(i,v)
end

print("-------2-------")

for k,v in pairs(t1) do
	print(k,v)
end

print("-------3-------")


for _,v in pairs(t1) do
	print(k,v)
end


--[[
-------1-------
1	a
2	b
3	c
-------2-------
1	a
2	b
3	c
5	d
6	e
-------3-------
nil	a
nil	b
nil	c
nil	d
nil	e
]]


print("-------4-------")
local t = {

	[1] = 3,
	[2] = 4,
	[4] = {
		[1] = 8,
		[2] = 9,
		[5] = 7
	}

}

--表中有表的遍历
for k,v in pairs(t) do
	if type(v) == "table" then
		for i,j in pairs(v) do
			print(i,j)
		end
	else
		print(k, v)
	end
end

--pairs ipairs
print("-------5-------")

for k,v in pairs(t) do
	if type(v) == "table" then
		for i,j in ipairs(v) do
			print(i,j)
		end
	else
		print(k, v)
	end
end


--ipairs,ipairs
print("-------6-------")
for k,v in ipairs(t) do
	if type(v) == "table" then
		for i,j in ipairs(v) do
			print(i,j)
		end
	else
		print(k, v)
	end
end


--[[
-------4-------
1	8
2	9
5	7
1	3
2	4
-------5-------
1	8
2	9
1	3
2	4
-------6-------
1	3
2	4
]]

local iterator

function allwords()
	local state = {line = io.read(),pos = 1}
    return iterator.state
end

function iterator(state)
   while state.line do
       local s,e = string.find(state.line, "%w+",state.pos)
       if s then
          state.pos = e + 1
          return string.sub(state.line, s, e)
        else
        state.line = io.read()
        state.pos = 1
       end
    end
    return nil 
end






















