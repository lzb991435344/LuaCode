

local function ttostring(t)
    if not t then
        return "nil"
    end

	if type(t)~="table" then
		return tostring(t)
	end

	local function ser_table(tbl)
		local tmp = {}
		for k,v in pairs(tbl) do
			local key = type(k)=="number" and "["..k.."]" or k
			local tp = type(v)
			if tp=="table" then
				table.insert(tmp, key.."="..ser_table(v))
			else
				if tp=="string" then
					table.insert(tmp, key.."="..string.format("%q",v))
				elseif tp=="boolean" then
					table.insert(tmp, key.."="..tostring(v))
                elseif tp=="function" then
                    --函数不打印
				else
					table.insert(tmp, key.."="..v)
				end
			end
		end
		return "{"..table.concat(tmp,",").."}"
	end

	return ser_table(t)
end

function newdeck()
    local deck = {}
	for i=1,4 do
		for k=2,14 do
			table.insert(deck, i<<4|k)
		end
    end
    return deck
end

local deck = newdeck()
for k, v in pairs(deck) do
    print(k,v)
end


local card = {}
function deck()
    function card.sort(c)
	table.sort(c, function(a,b)
		local ra,sa = a&0xf,a&0xf0
		local rb,sb = b&0xf,b&0xf0
		if ra == rb then
			return sa > sb
		else
			return ra < rb
		end
    end)
end




--[[
1       18
2       19
3       20
4       21
5       22
6       23
7       24
8       25
9       26
10      27
11      28
12      29
13      30
14      34
15      35
16      36
17      37
18      38
19      39
20      40
21      41
22      42
23      43
24      44
25      45
26      46
27      50
28      51
29      52
30      53
31      54
32      55
33      56
34      57
35      58
36      59
37      60
38      61
39      62
40      66
41      67
42      68
43      69
44      70
45      71
46      72
47      73
48      74
49      75
50      76
51      77
52      78

]]--
--print(ttstring(newdeck()))