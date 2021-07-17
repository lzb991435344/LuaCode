

function newConst( const_table )    --生成常量表功能


    function Const( const_table )
        local mt = {
            __index = function (t, k)
                if type(const_table[k]) == "table" then
                    const_table[k] = newConst(const_table[k])
                end
                return const_table[k]
            end,
            __newindex = function (t, k, v)
                print("*can't update " .. tostring(const_table) .."[" .. tostring(k) .."] = " .. tostring(v))
            end
        }
        return mt
    end




    local t = {}
    setmetatable(t, Const(const_table))
    return t
end

quan = {
    a = {
        [1] = {2}
    }
}
quan.b = quan
t = newConst(quan)
--t.b = 4
print(type(t))
print(quan.b)


for k,v in pairs(quan) do
    print(k,v)
end

--[[
table
table: 0x7fb1cd5066d0
a   table: 0x7fb1cd506c10
b   table: 0x7fb1cd5066d0

]]--

