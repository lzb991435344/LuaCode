

local filename = "test3.lua"
local prefix = string.match(filename,  "^([%w_]+).tmx$")

print(prefix) --nil