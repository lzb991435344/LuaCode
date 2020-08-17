
--[[
1.random()：返回0到1之间的一个伪随机数 

2.random(n)：返回1到n之间的伪随机整数

3.random(m, n)：返回m到n之间的伪随机整数


]]



--随机返回 [1, 5]之间的数字
local r = math.random(1, 5)

print(r)
print(os.time())

print("-----randomseed-----")
math.randomseed(os.time())

for i = 1, 5 do
	print(math.random(5))
end


print("-----seed-----")

--将返回的时间戳，低位换成高位，并取高7位
math.randomseed(tostring(os.time()):reverse():sub(1, 7))

for i = 1, 5 do
	print(math.random(5))
end

--[[
4
-----randomseed-----
3
5
2
1
2
-----seed-----
2
3
1
2
3

]]









