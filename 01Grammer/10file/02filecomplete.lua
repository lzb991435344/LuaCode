

--完全模式可以同时处理多个文件

-- 以只读方式打开文件
file = io.open("test", "r")

-- 输出文件第一行
print(file:read())

-- 关闭打开的文件
file:close()

-- 以附加的方式打开只写文件
file = io.open("test", "a")

-- 在文件最后一行添加 Lua 注释
file:write("--test")

-- 关闭打开的文件
file:close()


--[[

file:seek(optional whence, optional offset): 设置和获取当前文件位置,
成功则返回最终的文件位置(按字节),失败则返回nil加错误信息。参数 whence 值可以是:

"set": 从文件头开始
"cur": 从当前位置开始[默认]
"end": 从文件尾开始
offset:默认为0
不带参数file:seek()则返回当前位置,file:seek("set")则定位到文件头,file:seek("end")则定位到文件尾并返回文件大小


file:flush(): 向文件写入缓冲中的所有数据

io.lines(optional file name): 打开指定的文件filename为读模式并返回一个迭代函数,每次调用将获得文件中的一行内容,
当到文件尾时，将返回nil,并自动关闭文件。
若不带参数时io.lines() <=> io.input():lines(); 读取默认输入设备的内容，但结束时不关闭文件

]]


for line in io.lines("test") do
	print(line)
end


file = io.open("test", "r")
file:seek("end", -8)
print(file:read("*a"))

file:close()





