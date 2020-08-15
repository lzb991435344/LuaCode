


local t = {
	[1] = 10,
	[2] = 12,
	[3] = 15
 }


--在指定位置插入
print("--------1-------")
table.insert(t, 1, 30)

 for k,v in pairs(t) do
 	print(k,v)
 end

--在指定位置删除
print("--------2-------")
table.remove(t, 2)
 for i,v in ipairs(t) do
 	print(i,v)
 end


--未提供插入位置，则插入末尾
print("--------3-------")
table.insert(t, 40)
 for i,v in ipairs(t) do
 	print(i,v)
 end


--未指定位置的删除,在末尾删除
print("--------4-------")
table.remove(t)
 for i,v in ipairs(t) do
 	print(i,v)
 end



--[[

--------1-------
4	15
1	30
2	10
3	12
--------2-------
1	30
2	12
3	15
--------3-------
1	30
2	12
3	15
4	40
--------4-------
1	30
2	12
3	15

]]



