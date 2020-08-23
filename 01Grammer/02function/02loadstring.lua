--loadstring( )函数最典型的用法就是用来执行外部代码，
--该函数的返回值是一个function，如果load失败，则返回nil。



--local f = loadstring("i = i + 1; print(i)")

--上下等价，执行外部代码
--f = function ()
--	i = i + 1
--	print(i)
--end

--global
i = 1
local i = 0

f = loadstring("i = i + 1; print(i)")

g = function ()
	i = i + 1
	print(i)
end

f()  --2 全局的i
g()  --1  局部的i