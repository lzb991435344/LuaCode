

--单引号间的一串字符。
--双引号间的一串字符。
--[[ 与 ]]--间的一串字符。



string1 = "Lua"
print("\"字符串 1 是\"",string1)
string2 = 'runoob.com'
print("字符串 2 是",string2)

string3 = [["Lua 教程"]]
print("字符串 3 是",string3)

--[[
"字符串 1 是"	Lua
字符串 2 是	runoob.com
字符串 3 是	"Lua 教程"
]]


str = "I Am YOU"
print(string.upper(str)) --I AM YOU
print(string.lower(str)) --i am you

--[[
string.gsub(mainString,findString,replaceString,num)
在字符串中替换。

mainString 为要操作的字符串， findString 为被替换的字符，replaceString 要替换的字符，
num 替换次数（可以忽略，则全部替换）
]]

print(string.gsub("aaaa","a","z",3)) --zzza	3

print(string.gsub("aaaaaaab", "a", "z")) --zzzzzzzb	7



--[[
string.find (str, substr, [init, [end]]--)
--在一个指定的目标字符串中搜索指定的内容(第三个参数为索引),返回其具体位置。不存在则返回 nil。

--]]

print(string.find("Hello Lua user Lua", "Lua", 1)) -- 7 9

print(string.find("Hello Lua user Lua", "Lua", 9)) -- 16  18



--字符反转
print(string.reverse(" Lua")) --auL


print(string.format("the value is:%d",4)) --the value is:4


string.format("%c", 83)                 -- 输出S
string.format("%+d", 17.0)              -- 输出+17
string.format("%05d", 17)               -- 输出00017
string.format("%o", 17)                 -- 输出21
string.format("%u", 3.14)               -- 输出3
string.format("%x", 13)                 -- 输出d
string.format("%X", 13)                 -- 输出D
string.format("%e", 1000)               -- 输出1.000000e+03
string.format("%E", 1000)               -- 输出1.000000E+03
string.format("%6.3f", 13)              -- 输出13.000
string.format("%q", "One\nTwo")         -- 输出"One\
                                        -- 　　Two"
string.format("%s", "monkey")           -- 输出monkey
string.format("%10s", "monkey")         -- 输出    monkey
string.format("%5.3s", "monkey")        -- 输出  mon




--[[
string.char(arg) 和 string.byte(arg[,int])
char 将整型数字转成字符并连接， byte 转换字符为整数值(可以指定某个字符，默认第一个字符)。

]]

print(string.char(97,98,99,100)) --abcd
print(string.byte("ABCD",4)) --68
print(string.byte("ABCD"))  --65


--字符串的长度
print(string.len("i am you")) --8 包含空格，计算空格的数量


--[[
string.rep(string, n)
返回字符串string的n个拷贝
]]

print(string.rep("abc", 3)) --abcabcabc


print("lua".."code") --luacode




--[[
string.gmatch(str, pattern)
回一个迭代器函数，每一次调用这个函数，返回一个在字符串 str 找到的下一个符合 pattern 描述的子串。
如果参数 pattern 描述的字符串没有找到，迭代函数返回nil。

]]

for word in string.gmatch("Hello Lua user", "%a+") do 
	print(word) 
end

--Hello
--Lua
--user


--string.sub(s, i [, j])

-- 字符串
local sourcestr = "prefix--runoobgoogletaobao--suffix"
print("\n原始字符串", string.format("%q", sourcestr))

-- 截取部分，第1个到第15个
local first_sub = string.sub(sourcestr, 4, 15)
print("\n第一次截取", string.format("%q", first_sub))

-- 取字符串前缀，第1个到第8个
local second_sub = string.sub(sourcestr, 1, 8)
print("\n第二次截取", string.format("%q", second_sub))

-- 截取最后10个
local third_sub = string.sub(sourcestr, -10)
print("\n第三次截取", string.format("%q", third_sub))

-- 索引越界，输出原始字符串
local fourth_sub = string.sub(sourcestr, -100)
print("\n第四次截取", string.format("%q", fourth_sub))


--[[

原始字符串    "prefix--runoobgoogletaobao--suffix"

第一次截取    "fix--runoobg"

第二次截取    "prefix--"

第三次截取    "ao--suffix"

第四次截取    "prefix--runoobgoogletaobao--suffix"


]]



