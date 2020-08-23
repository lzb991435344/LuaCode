local a = true
local b = false
-- 场景1：
print((a and {"true"})[1])  --true
-- 场景2：语法错误
--print((b and {"true"})[1]) error: attempt to index a boolean value
-- 场景3：
print("a value : " .. (a and {"true"} or {"false"})[1]) --true
print("b value : " .. (b and {"true"} or {"false"})[1])  --false

-- a and b or c
--（1）第二个值为false，总是返回c值
--（2）第二个值为true的情况下，才会按情况返回
--（3）无法确定b都为真的情况下，直接用if - else
print("a value : " .. (a and {"false"} or {"false"})[1]) --false
print("a value : " .. (b and {"false"} or {"false"})[1]) --fasle
--[[ 运行结果：
true
a value : true
b value : false
--]]





