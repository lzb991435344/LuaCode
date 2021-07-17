local t = {
    score = {a = {11,22,33},b = {55,66,77},c = {88, 99, 12}},
    test = {4,5,6},
    lua =  {7,8,9}
}

for k, v in pairs(t.lua) do
    print(t.lua[k])
end

 print(t.score.a[1])


 for k,v in pairs(t) do
    print(k,v)
 end

 --[[

7
8
9
11
score   table: 0x7f978a407520
test    table: 0x7f978a407ef0
lua     table: 0x7f978a407f60

 ]]--