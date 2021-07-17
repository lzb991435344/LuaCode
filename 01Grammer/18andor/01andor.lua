

--Lua中所有的逻辑运算符将false和nil视为假，其他任何东西视为真，0也视为真。
--如果它的第一个操作数为假，就返回第一个操作数；不然返回第二个操作数；
print('a' and {1,2,3}) --table: 0x7ffd54502210    
print(0 and 'b')   --b
print(nil and 233)  --nil
print(233 and nil)  --nil
print(false and 'abcdfg') --false
print('abcdfg' and false) --false


--如果它的第一个操作数为真，就返回第一个操作数，不然返回第二个操作数；
print('a' or {1,2,3})  --a
print(0 or 'b')        --0
print(nil or 233)      --233
print(233 or nil)      --233
print(false or 'abcdfg') --abcdfg
print('abcdfg' or false) --abcdfg


--and连接多个操作数时，表达式的返回值就是从左到右第一个为假的值，若所有操作数值都不为假，则表达式的返回值为最后一个操作数；
print('a' and 'b' and 'c' and 'd' and nil and false and 'e' and 'f')    --nil
print('a' and 'b' and 'c' and false and 'd' and nil and 'e' and 'f')   --false



--or连接多个操作数时，表达式的返回值就是从左到右第一个不为假的值，若所有操作数值都为假，则表达式的返回值为最后一个操作数；
print(nil or 'a' or 'b' or 'c' or 'd'   or false or 'e' or 'f')    --a
print('a' or nil or 'b' or 'c' or false or 'd'   or 'e' or 'f')    --a
print('a' or 'b' or nil or 'c' or false or 'd'   or 'e' or 'f')    --a




--"a and b or c ",这类似于C系语言中的表达式 a ? b : c： max = (a > b) and a or b
local a = 666
local b = 333
local c = true
print((a > b) and a or b)  --666
print((a < b) and a or b)  --333
print((not c) and 'false' or 'true') --true

