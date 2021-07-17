




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

print(mytable.key, mytable.key1)