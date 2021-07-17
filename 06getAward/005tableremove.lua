local t = {[1]={shieldUid=10000302,name="tom"},[2]={shieldUid=10000303,name="siri"},[3]={shieldUid=10000304,name="mary"}}
local uid = 10000304

for k,v in pairs(t) do
    if uid == v.shieldUid then
        table.remove( t, k)
        break
    end
end


for k,v in pairs(t) do
    for p,q in pairs(v) do
        print(p,q)
    end
end

local str1 = "abcABC43"
local str5 = ""
local str2 = "abcde@!QWER"

local str3 = "AbcdFR"
local str = string.upper(str2)
string.upper(str3)
print(str)
print(str3)

local flag = false
local len = string.len(str2)
for i = 1,len  do
    if str3[i] == str[i] then
        --print(str[i])
        flag = true
    end
end

print(flag)

print(str1 == str2)