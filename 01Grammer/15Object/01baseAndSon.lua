

local _class = {}


function class(super)
    local class_type = {
        ctor = ctor,
        super = super,
        --new = function(...)  end
    }

    --class_type.ctor = false
    --class_type.super = super
    class_type.new = function(...)
    local object = {}
    
    do
        local create

        create = function(c, ...)
            if c.super then
                create(c.super, ...)
            end

            if c.ctor then
                c.ctor(obj, ...)
            end
        end

        create(class_type, ...)
    end

    setmetatable(obj, {__index = _class[class_type]})
    return obj
end


local vtbl = {

}


 _class[class_type] = vtbl
 
 setmetatable(class_type, {__newindex =
    function(t, k, v)
        vtbl[k] = v
    end
 })
 
 if super then
        setmetatable(vtbl, {__index =
        function(t, k)
            local ret = _class[super][k]

            vtbl[k] = ret

            return ret
        end
        })
 end
 
    return class_type

end

base_type = class()


function base_type:ctor(x)
    print("base_type ctor")
    self.x = x
end

function base_type:print_x()
    print(self.x)
end

function base_type:hello()
    print("hello base_type")
end


--定义一个子类
son_type = class(base_type)


--构造函数
function son_type:ctor()
    print("son_type ctor")
end

--重载
function son_type:hello()
    print("hello_type")
end

t = son_type.new(6)
t:print_x()
t:hello()










