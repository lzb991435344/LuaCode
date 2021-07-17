
--[[
1.在表中查找，如果找到，返回该元素，找不到则继续
2.判断该表是否有元表，如果没有元表，返回 nil，有元表则继续。
3.判断元表有没有 __index 方法，如果 __index 方法为 nil，则返回 nil；如果 __index 方法是一个表，则重复 1、2、3；
如果 __index 方法是一个函数，则返回该函数的返回值。
]]



--__index用于访问表
mytable = setmetatable({key = "value"},{
    __index = function()
        if key == key2 then 
            return "66666"
        else
            return nil 
        end
    end
})

--value   66666
print(mytable.key, mytable.key1)