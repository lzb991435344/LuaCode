--[[
local cardList = {}

for i = 14, 15  do
	local tmpCard = {value = i, color = 0}
	--尾部插入
	table.insert(cardList, tmpCard)
end


for k,v in pairs(cardList) do
	if type(v) == "table" then 
		for p,q in pairs(v) do
			print(p, q)
		end
	end
end


color	0
value	14

color	0
value	15
]]


--初始化卡组
--initCard
local function initCard()
	local cardList = {}

	for i = 14, 15 do
		local tmpCard = {value = i, color = 0}

		table.insert(cardList, tmpCard)
	end


	for i = 1, 4 do
		for j = 1, 13 do
			local tmpCard = {value = j, color = i}
			table.insert(cardList, tmpCard)
		end
	end

	return cardList
end



--洗牌
local function shuffleCards(cardList)
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	local shuffleTime = math.random(300, 450)
	print("shuffleTime", shuffleTime)

	for i = 1, shuffleTime do
		local tmpCard = {}
		card1 = math.random(1, 54)
		card2 = math.random(1,54)

		while card1 == card2 do
			card2 = math.random(1, 54)
		end

		--print("card", card1, card2)

		tmpCard = cardList[card1]
		cardList[card1] = cardList[card2]
		cardList[card2] = tmpCard
	end
	return cardList
end


local function dealCard(cardList)
	local players = {}

	for i = 1, 5 do
		for j = 1, 6 do
			if not players[j] then
				players[j] = {}
			end

			--从cardList中直接从尾部删除
			local tmpCard = table.remove(cardList)
			table.insert(players[j], tmpCard)
		end
	end
	return players
end


local cardList = initCard()
cardList = shuffleCards(cardList)
local players = dealCard(cardList)


for k,v in ipairs(players) do
	print(string.format("玩家的手牌是：", k))

	for k1, v1 in ipairs(v) do
		print(v1.value, v1.color)
	end
end

--[[
shuffleTime	304
玩家的手牌是：
13	1
3	1
9	3
3	2
14	0
玩家的手牌是：
8	3
12	3
4	2
2	2
11	3
玩家的手牌是：
10	3
1	2
13	3
8	1
11	4
玩家的手牌是：
4	3
11	1
12	2
7	1
1	3
玩家的手牌是：
1	1
5	1
6	4
12	1
4	1
玩家的手牌是：
9	2
2	4
11	2
9	4
13	4



]]




