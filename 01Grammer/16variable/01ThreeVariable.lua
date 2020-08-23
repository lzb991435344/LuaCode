
local var_false = false

local var_true = true

-- 场景1：
local a = 2
local b = 1
print('a > b and a or b : ' .. (a > b and a or b))  --2 取a的值
print('a > b and false or b : ' .. (a > b and var_false or b)) --1 取b的值
--print('a > b and true or b : ' .. (a > b and var_true or b))  语法错误
print('(a > b and {a} or {b})[1] : ' .. (a > b and {a} or {b})[1])  --2  取a的值
print()

-- 场景2：
a = 3
b = 3
print('a > b and a or b : ' .. (a > b and a or b)) --3 取b的值
print('a > b and false or b : ' .. (a > b and var_false or b)) --3
print('a > b and true or b : ' .. (a > b and var_true or b))  --3
print('(a > b and {a} or {b})[1] : ' .. (a > b and {a} or {b})[1]) --3
print()

-- 场景3：
a = 4
b = 5
print('a > b and a or b : ' .. (a > b and a or b)) --5
print('a > b and false or b : ' .. (a > b and var_false or b)) --5
print('a > b and true or b : ' .. (a > b and var_true or b)) --5
print('(a > b and {a} or {b})[1] : ' .. (a > b and {a} or {b})[1]) --5
print()

-- 运行结果：
--[[
a > b and a or b : 2
a > b and false or b : 1
(a > b and {a} or {b})[1] : 2

a > b and a or b : 3
a > b and false or b : 3
a > b and true or b : 3
(a > b and {a} or {b})[1] : 3

a > b and a or b : 5
a > b and false or b : 5
a > b and true or b : 5
(a > b and {a} or {b})[1] : 5
--]]