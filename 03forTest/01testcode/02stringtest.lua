

local version = "5.1.3"
local pos = string.find(version, "%.")

print(pos) --2


local bigVersion = tonumber(string.sub(version, 1, pos - 1)) or 3
print(bigVersion) --5


local tmpStr = string.sub(version, pos + 1, string.len(version))
print(tmpStr)  --1.3

local tmpPos = string.find(tmpStr, "%.")
print(tmpPos) --2

local smallVersion = tonumber(string.sub(tmpStr, 1, pos - 1))
print(smallVersion) --1