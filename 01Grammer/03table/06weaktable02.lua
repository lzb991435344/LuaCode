

--[[
  memoize函数，备忘录技术
 1.记录下函数的运行结果，当使用同样的参数再调用函数时，复用之前
 的结果

 2.确保某类对象的唯一性
]]--

--例子1
local results = {}

--修改之后添加
setmetatable(results, {__mode = "v"})
--相同的效果
setmetatable(results, {__mode = "kv"})

--loadstring( )函数最典型的用法就是用来执行外部代码，
--该函数的返回值是一个function，如果load失败，则返回nil。

function mem_loadstring(s)
    local res = results[s]
    if nill == res then --是否被记录过
        res = assert(loadstring(s))  --重新计算结果
        results[s] = res     --存下备后用
    end
    return res
end

--存在的问题：tables results会累计服务器收到的命令，累计消耗
--服务器的内存，使用弱引用来消除


--例子2：复用相同颜色的table

function createRGB( r, g, b )
	return {red = r, green = g, blue = b}
end

local result = {}
setmetatable(result, {__mode = "v"})
function createRGB(r, g, b)
	local key = r .. "-" .. g .. "-".. b
	local color = result[key]
	if nill == color then 
       color = {red = r, green = g, blue = b}
       result[key] = color
	end
	return color
end


