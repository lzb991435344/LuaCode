

--将两个表之间相关联

--相关api
--(1)setmetatable(table,metatable): 对指定 table 设置元表(metatable)，
--如果元表(metatable)中存在 __metatable 键值，setmetatable 会失败。

--(2)getmetatable(table): 返回对象的元表(metatable)。
--[[

mytable = {}                          -- 普通表
mymetatable = {}                      -- 元表
setmetatable(mytable,mymetatable)     -- 把 mymetatable 设为 mytable 的元表

--等价于
mytable = setmetatable({},{})

getmetatable(mytable)                 -- 返回mymetatable
]]



--当你通过键来访问 table 的时候，如果这个键没有值，那么Lua就会寻找该table的metatable
--（假定有metatable）中的__index 键。如果__index包含一个表格，Lua会在表格中查找相应的键。

--__index 用于对表的查找

--variable

local other = {
	foo = 3
}

local t = setmetatable({}, {__index = other})
print(t.foo)



--function
--如果__index包含一个函数的话，Lua就会调用那个函数，table和键会作为参数传递给函数。

--__index 元方法查看表中元素是否存在，如果不存在，返回结果为 nil；如果存在则由 __index 
--返回结果。


--1.在表中查找，如果找到，返回该元素，找不到则继续
--2.判断该表是否有元表，如果没有元表，返回 nil，有元表则继续。
--3.判断元表有没有 __index 方法，如果 __index 方法为 nil，则返回 nil；
--如果 __index 方法是一个表，则重复 1、2、3；如果 __index 方法是一个函数，则返回该函数的
--返回值。
mytable = setmetatable({key1 = "value1"},{
	 __index = function(mytable, key)

	 if key == "key2" then 
	 	return "metatable value"
	 else
	 	return nil
	 end

	end
})

--等价于
mytable = setmetatable({key1 = "value1"}, { __index = { key2 = "metatablevalue" } })
print(mytable.key1, mytable.key2)



--3
--value1	metatable value
print(mytable.key1, mytable.key2)









