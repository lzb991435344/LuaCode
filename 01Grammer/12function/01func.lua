


function max( a, b)
	local result

	if a > b then 
		result = a
	else
		result = b
	end

	return result
end


print(max(2,7)) --7




--函数作为参数进行传递
myprint = function (param)
	print(param)
end


function add(a, b, functionP)
	local result = a + b
	functionP(result)
end

myprint(10)  --10
add(2, 5, myprint)  --7



--多返回值

local s, e = string.find("www.baidu.com", "baidu")

print(s, e)



--返回表中最大值和下标索引
local function maxandindex(a) 
	local mi = 1
	local m = a[mi]
	for i, val in ipairs(a) do
		if val > m then 
			mi = i
			m = val
		end
	end
	return m, mi
end

local a = {8, 3, 7, 23, 1}
print(maxandindex(a))



--可变参数

function add(...)  
local s = 0  
  for i, v in ipairs{...} do   --> {...} 表示一个由所有变长参数构成的数组  
    s = s + v  
  end  
  return s  
end  
print(add(3,4,5,6,7))  --->25




--获取可变参数的长度

--select('#', …) 返回可变参数的长度
--select(n, …) 用于返回 n 到 select('#',…) 的参数


function average(...)
   result = 0
   local arg={...}    --> arg 为一个表，局部变量
   for i,v in ipairs(arg) do
      result = result + v
   end
   print("总共传入 " .. #arg .. " 个数")
   return result/#arg
end

print("平均值为",average(10,5,3,4,5,6))




function average1(...)
   result = 0
   local arg={...}
   for i,v in ipairs(arg) do
      result = result + v
   end
   print("总共传入 " .. select("#",...) .. " 个数")
   return result/select("#",...)
end

print("平均值为",average1(10,5,3,4,5,6))


function fwrite(fmt, ...)  ---> 固定的参数fmt
    return io.write(string.format(fmt, ...))    
end

fwrite("runoob\n")       --->fmt = "runoob", 没有变长参数。  
fwrite("%d%d\n", 1, 2)   --->fmt = "%d%d", 变长参数为 1 和 2




--在一个块中处理数据
do  
    function foo(...)  
        for i = 1, select('#', ...) do  -->获取参数总数
            local arg = select(i, ...); -->读取参数
            print("arg", arg);  
        end  
    end  
 
    foo(1, 2, 3, 4);  
end


--[[
arg    1
arg    2
arg    3
arg    4

]]






